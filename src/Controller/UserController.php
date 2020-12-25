<?php


namespace App\Controller;


use App\Entity\Schoolclass;
use App\Entity\User;
use App\Form\ChangePasswordType;
use App\Form\UserType;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Symfony\Component\Form\FormError;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

/* see https://symfony.com/doc/4.4/controller/upload_file */

class UserController extends BaseController
{
    private  UserPasswordEncoderInterface $passwordEncoder;

    public function __construct(UserPasswordEncoderInterface $passwordEncoder){

        $this->passwordEncoder = $passwordEncoder;


    }
    /**
     * @Route("/admin/pupil/new", name="admin_new_user")
     * @param Request $request
     * @return Response
     */
    public function newAction(Request $request):Response
    {
        $user = new User();
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid())
        {

            /** @var UploadedFile $imgFile */
            $imgFile = $form->get('photofile')->getData();
            if ($imgFile) {

                $originalFilename = pathinfo($imgFile->getClientOriginalName(), PATHINFO_FILENAME);
                $newFilename = substr(md5($originalFilename),10).uniqid() . '.' . $imgFile->guessExtension();
                $user->setPhoto($newFilename);
            }

            $user->setPassword($this->encode($user->getPassword()));
            $user->setRoles(["ROLE_PUPIL"]);
            try {

                $entityManager = $this->getDoctrine()->getManager();
                $entityManager->persist($user);
                $entityManager->flush();
                if (isset($newFilename)) {
                    try {
                        $dir = $this->getParameter('app.image_directory');
                        $imgFile->move($dir, $newFilename);
                    } catch (FileException $e) {
                        echo "file could not be moved" . $e->getMessage();
                        die();
                    }
                }
                $this->addFlash("message", "nieuwe gebruiker {$user->getFullName()} succesvol toegevoegd");
                $path = $this->getUserString();
                return $this->redirectToRoute($path."_home");
            }
            catch(UniqueConstraintViolationException $e){


                $form->get('email')->addError(new FormError("emailadres {$user->getEmail()} is helaas al in gebruik. Kies een ander"));
                return $this->render('admin/new-user.html.twig', [
                    'form' => $form->createView(),
                    'classes'=>$this->getClasses(),
                ]);
            }
        }

        return $this->render('admin/new-user.html.twig', [
            'form' => $form->createView(),
            'classes'=>$this->getClasses(),
        ]);

    }



    private function encode($plainPassword):string{
        $user = new User();
        return $this->passwordEncoder->encodePassword($user, $plainPassword);
    }

    /**
     * @Route("admin/pupil/delete/{id}", name="admin_delete_pupil", requirements={"id"="\d+"})
     * @param int $id
     * @return Response
     */
    public function deleteUserAction(int $id):Response{
        $user = $this->getDoctrine()->getRepository(User::class)->find($id);
        $classId = $user->getSchoolclass()->getId();
        $photoName = $user->getPhotoFileName();
        $entityManager = $this->getDoctrine()->getManager();
        $entityManager->remove($user);
        $entityManager->flush();
        $dir = $this->getParameter('app.image_directory');
        if(!empty($photoName)){
            $file = $dir.'/'.$photoName;
            if(file_exists($file)) {

                unlink($file);
            }
        }
        $this->addFlash('message',"leerling {$user->getFullName()} verwijderd");
        $path = $this->getUserString();
        return $this->redirectToRoute("{$path}_home");


    }


    private function changePasswordAction(Request $request):Response
    {
        $form = $this->createForm(ChangePasswordType::class);
        $form->handleRequest($request);
        $path = $this->getUserString();
        if($form->isSubmitted()&&$form->isValid())
        {
            $old = $form->get('password')->getData();
            $new = $form->get('new_password')->getData();
            $user = $this->getUser();
            $old_encoded = $this->encode($old);
            $user->setPassword($this->encode($new));
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($user);
            $entityManager->flush();
            $this->addFlash('message','wachtwoord succesvol gewijzigd');
            return $this->redirectToRoute("{$path}_home");
        }


        return $this->render("$path/new_password.html.twig", [
            'form' => $form->createView(),
            'classes'=>$this->getClasses(),
        ]);

    }
    /**
     * @Route ("admin/new_password", name="admin_new_password")
     * @param Request $request
     * @return Response
     */
    public function changeAdminPasswordAction(Request $request):Response{
        return $this->changePasswordAction($request);
    }

    /**
     * @Route ("pupil/new_password", name="pupil_new_password")
     * @param Request $request
     * @return Response
     */
    public function changePupilPasswordAction(Request $request):Response{
        return $this->changePasswordAction($request);
    }

    private function getSchoolclassAction(int $id):Response{
        $class = $this->getDoctrine()->getRepository(Schoolclass::class)->find($id);

        $path = $this->getUserString();
        return $this->render("$path/showclass.html.twig",['classes'=>$this->getClasses(),'class'=>$class]);
    }

    /**
     * @Route("/pupil/class/{id}", name="pupil_get_class", requirements={"id"="\d+"})
     * @param int $id
     * @return Response
     */
    public function getClassForPupilAction(int $id):Response
    {
        return $this->getSchoolclassAction($id);
    }

    /**
     * @Route("/admin/class/{id}", name="admin_get_class", requirements={"id"="\d+"})
     * @param int $id
     * @return Response
     */
    public function getClassForAdminAction(int $id):Response{
        return $this->getSchoolclassAction($id);
    }
    private function getUserString():string{
        if($this->isGranted('ROLE_PRINCIPAL')){
            return 'principal';
        }
        if($this->isGranted('ROLE_ADMIN')){
            return 'admin';
        }
        if($this->isGranted('ROLE_PUPIL')){
            return 'pupil';
        }
        return 'visitor';

    }

    private function getClasslessPupilsAction():array{
        $classless = $this->getDoctrine()->getRepository(User::class)->findClasslessPupils();
        var_dump($classless);
            die();
    }
}
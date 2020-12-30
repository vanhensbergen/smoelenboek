<?php


namespace App\Controller;


use App\Entity\Schoolclass;
use App\Entity\User;
use App\Form\SchoolclassType;
use App\Form\UserType;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Symfony\Component\Form\FormError;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AdministratorController extends BaseController
{

    /**
     * @Route("/admin", name="admin_home")
     */
    public function defaultAction():Response{
        $classless = $this->getDoctrine()->getRepository(User::class)->findClasslessPupils();
        return $this->render('admin/default.html.twig',
            [   'classes'=>$this->getClasses() ,
                'pupils'=>$classless,
                'header'=>'ONGEPLAATSTE LEERLINGEN',
            ]);
    }


    /**
     * @Route("/admin/pupil/new", name="admin_new_pupil")
     * @param Request $request
     * @return Response
     */
    public function newPupilAction(Request $request):Response
    {
        $user = new User();
        $form = $this->createForm(UserType::class, $user);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid())
        {

            /** @var UploadedFile $imgFile */
            $imgFile = $form->get('photofile')->getData();
            $class = $form->get('schoolclass')->getData();
            $class_id = empty($class)?null:$class->getId();
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
                if(empty($class_id)){
                    return $this->redirectToRoute($path."_home");
                }
                return $this->redirectToRoute($path."_get_class",['id'=>$class_id]);
            }
            catch(UniqueConstraintViolationException $e)
            {
                $form->get('email')->addError(new FormError("emailadres {$user->getEmail()} is helaas al in gebruik. Kies een ander"));
                return $this->render('admin/new-user.html.twig', [
                    'header'=>'gegevens van een nieuwe leerling',
                    'form' => $form->createView(),
                    'classes'=>$this->getClasses(),
                ]);
            }
        }

        return $this->render('admin/new-user.html.twig', [
            'header'=>'gegevens van een nieuwe leerling',
            'form' => $form->createView(),
            'classes'=>$this->getClasses(),
        ]);

    }

    /**
     * @Route("/admin/pupil/update/{id}", name="admin_update_pupil", requirements={"id"="\d+"})
     * @param int $id
     * @param Request $request
     * @return Response
     */
    public function updatePupilAction(int $id, Request $request):Response{
        $user = $this->getDoctrine()->getRepository(User::class)->find($id);
        if(empty($user))
        {
            $this->addFlash('message','de te wijzigen gebruiker bestaat niet!');
            return $this->redirectToRoute('admin_home');
        }
        $form = $this->createForm(UserType::class, $user);
        $form->remove('password');
        $form->handleRequest($request);
        $old_photo = $user->getPhotoFileName();
        if($form->isSubmitted()&&$form->isValid())
        {
            /** @var UploadedFile $imgFile */
            $imgFile = $form->get('photofile')->getData();
            $class = $form->get('schoolclass')->getData();
            $class_id = empty($class)?null:$class->getId();
            if ($imgFile) {

                $originalFilename = pathinfo($imgFile->getClientOriginalName(), PATHINFO_FILENAME);
                $newFilename = substr(md5($originalFilename),10).uniqid() . '.' . $imgFile->guessExtension();
                $user->setPhoto($newFilename);
            }
            $user->setRoles(["ROLE_PUPIL"]);
            try {

                $entityManager = $this->getDoctrine()->getManager();
                $entityManager->persist($user);
                $entityManager->flush();
                $dir = $this->getParameter('app.image_directory');
                if (isset($newFilename)) {
                    try {

                        $imgFile->move($dir, $newFilename);
                    } catch (FileException $e) {
                        echo "file could not be moved{$e->getMessage()}";
                        die();
                    }
                    if(!empty($old_photo)){
                        $file = $dir.'/'.$old_photo;
                        if(file_exists($file)) {

                            unlink($file);
                        }
                    }
                }

                $this->addFlash("message", "gebruiker {$user->getFullName()} succesvol gewijzigd");
                $path = $this->getUserString();
                if(empty($class_id)){
                    return $this->redirectToRoute($path."_home");
                }
                return $this->redirectToRoute($path."_get_class",['id'=>$class_id]);
            }
            catch(UniqueConstraintViolationException $e){
                $form->get('email')->addError(new FormError("emailadres {$user->getEmail()} is helaas al in gebruik. Kies een ander"));
            }
        }
        return $this->render('admin/new-user.html.twig', [
            'header'=>'wijzig de gegevens van deze leerling',
            'photo'=>$user->getPhoto(),
            'form' => $form->createView(),
            'classes'=>$this->getClasses(),
        ]);
    }


    /**
     * @Route("admin/pupil/delete/{id}", name="admin_delete_pupil", requirements={"id"="\d+"})
     * @param int $id
     * @return Response
     */
    public function deleteUserAction(int $id):Response{
        $user = $this->getDoctrine()->getRepository(User::class)->find($id);
        $class = $user->getSchoolclass();

        $class_id = empty($class)?null:$class->getId();
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
        if(empty($class_id)){
            return $this->redirectToRoute($path.'_home');
        }
        return $this->redirectToRoute("{$path}_get_class",['id'=>$class_id]);
    }

    /**
     * @Route("admin/reset/{id}", name="admin_reset", requirements={"id"="\d+"})
     * @param int $id
     * @return Response
     */
    public function adminResetPasswordAction(int $id):Response{
        //insert constraint as to user types allowed
        return $this->resetPasswordAction($id);
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
     * @Route("/admin/class/{id}", name="admin_get_class", requirements={"id"="\d+"})
     * @param int $id
     * @return Response
     */
    public function getClassForAdminAction(int $id):Response{
        return $this->getSchoolclassAction($id);
    }


    /**
     * @Route("/admin/search", name="admin_search")
     * @param Request $request
     * @return Response
     */
    public function searchForAdminAction(Request  $request):Response{
        return $this->searchAction($request);
    }

    /**
     * @Route("admin/class/new", name="admin_new_class")
     * @param Request $request
     * @return Response
     */
    public function addSchoolclassAction(Request $request):Response{
        $schoolclass = new Schoolclass();
        $form= $this->createForm(SchoolclassType::class,$schoolclass);
        $form->handleRequest($request);
        if($form->isSubmitted()&&$form->isValid())
        {
            try
            {
                $em = $this->getDoctrine()->getManager();
                $em->persist($schoolclass);
                $em->flush();
                $this->addFlash('message',"klas {$schoolclass->getName()} succesvol aangemaakt");
                return $this->redirectToRoute('admin_home');
            }
            catch(UniqueConstraintViolationException $e)
            {
                $form->get('name')->addError(new FormError("klassenaam {$schoolclass->getName()} is helaas al in gebruik. Kies een ander"));
            }
        }
        return $this->render('admin/new_class.html.twig', [
            'form' => $form->createView(),
            'classes'=>$this->getClasses(),
        ]);

    }
}
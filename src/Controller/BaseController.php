<?php


namespace App\Controller {


    use App\Entity\Schoolclass;
    use App\Entity\User;
    use App\Form\ChangePasswordType;
    use App\Form\UserType;
    use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
    use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
    use Symfony\Component\Form\FormError;
    use Symfony\Component\HttpFoundation\File\Exception\FileException;
    use Symfony\Component\HttpFoundation\File\UploadedFile;
    use Symfony\Component\HttpFoundation\Request;
    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

    abstract class BaseController extends AbstractController
    {

        protected UserPasswordEncoderInterface $passwordEncoder;

        public function __construct(UserPasswordEncoderInterface $passwordEncoder){

            $this->passwordEncoder = $passwordEncoder;

        }

        /**
         * geeft de klassen als een array van objecten van het type Schoolclass terug
         *
         * @return array
         */
        protected function getClasses():array{
            $classes = $this->getDoctrine()->getRepository(Schoolclass::class)->findAll();
            usort($classes , fn($a,$b)=>$a->getName() <=>$b->getName());
            return $classes;
        }

        /**
         * beschrijft de afhandeling in abstracte termen van een actie die het wachtwoord reset naar qwerty.
         * Veronderstelt dat er een home directory (admin_home, pupil_home etc) is.
         * @param int $id
         * @return Response
         */
        protected function resetPasswordAction(int $id):Response{
            $user = $this->getDoctrine()->getRepository(User::class)->find($id);
            $path = $this->getAuthorisationString();
            if(empty($user)){
                $this->addFlash('message','deze gebruiker bestaat niet in de database!');
                return $this->redirectToRoute("{$path}_home");
            }
            $user->setPassword($this->encode('qwerty'));
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($user);
            $entityManager->flush();
            $this->addFlash('message',"wachtwoord van {$user->getFullname()} is gereset naar 'qwerty'.");
            return $this->redirectToRoute("{$path}_home");
        }

        /**
         * geeft de string die als pad verwijst naar de specifieke gebruiker: admin. pupil, visitor, teacher
         * @return string de userstring één van visitor, pupil, teacher, admin of principal
         */
        protected function getAuthorisationString():string{
            if($this->isGranted('ROLE_PRINCIPAL')){
                return 'principal';
            }
            if($this->isGranted('ROLE_ADMIN')){
                return 'admin';
            }
            if($this->isGranted('ROLE_TEACHER')){
                return 'teacher';
            }
            if($this->isGranted('ROLE_PUPIL')){
                return 'pupil';
            }
            return 'visitor';

        }

        /**
         * @param int $id
         * @return Response
         */
        protected function getSchoolclassAction(int $id):Response{
            $class = $this->getDoctrine()->getRepository(Schoolclass::class)->find($id);
            $path = $this->getAuthorisationString();
            return $this->render("$path/showclass.html.twig",['classes'=>$this->getClasses(),'class'=>$class]);
        }

        /**
         * de methode maakt een hash van het plain pwachtwoord dat in de database bewaard wordt
         *
         * @param string $plainPassword het door de gebruiker ingevoerde plain wachtwoord
         * @return string het volgens het door symfony ingestelde algoritme hashed wachtwoord
         */
        protected function encode(string $plainPassword):string{
            $user = new User();
            return $this->passwordEncoder->encodePassword($user, $plainPassword);
        }


        /**
         * @param Request $request
         * @return Response
         */
        protected function changePasswordAction(Request $request):Response
        {
            $form = $this->createForm(ChangePasswordType::class);
            $form->handleRequest($request);
            $path = $this->getAuthorisationString();
            if($form->isSubmitted()&&$form->isValid())
            {
                $new = $form->get('new_password')->getData();
                $user = $this->getUser();
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
         * @param Request $request
         * @param $role
         * @return Response
         */
        protected function searchAction(Request  $request, $role):Response{
            $searchValue = $request->get('search');
            $results = $this->getDoctrine()->getRepository(User::class)->findLike($searchValue,$role);
            $path = $this->getAuthorisationString();
            return $this->render($path.'/search.html.twig',
                [   'classes'=>$this->getClasses() ,
                    'pupils'=>$results,
                    'searchvalue'=>$searchValue,
                ]);
        }

        protected function findNextInClass(User $student ):?User{
            $class = $student->getSchoolclass();
            $students = $class->getUsers();
            $index = $students->indexOf($student);
            return $students->get($index+1);
        }
        protected function findPreviousInClass(User $student ):?User{
            $class = $student->getSchoolclass();
            $students = $class->getUsers();
            $index = $students->indexOf($student);
            return $students->get($index-1);
        }

        protected function addUser(Request $request, bool $isPupil=true)
        {
            $user = new User();
            $path = $this->getAuthorisationString();
            $header = $isPupil ? 'gegevens van een nieuwe leerling' : 'gegevens van een nieuwe schoolgebruiker';
            $form = $this->createForm(UserType::class, $user);
            if ($isPupil) $form->remove('roles');
            $form->handleRequest($request);
            if ($form->isSubmitted() && $form->isValid()) {
                /** @var UploadedFile $imgFile */
                $imgFile = $form->get('photofile')->getData();
                if ($imgFile) {

                    $originalFilename = pathinfo($imgFile->getClientOriginalName(), PATHINFO_FILENAME);
                    $newFilename = substr(md5($originalFilename), 10) . uniqid() . '.' . $imgFile->guessExtension();
                    $user->setPhoto($newFilename);
                }
                try
                {
                    if (isset($newFilename)) {
                        $dir = $this->getParameter('app.image_directory');
                        $imgFile->move($dir, $newFilename);
                    }
                    //als je hier voorbij bent is alles gelukt dus opslaan in db
                    if ($isPupil) $user->setRoles(["ROLE_PUPIL"]);
                    $user->setPassword($this->encode($user->getPassword()));
                    $entityManager = $this->getDoctrine()->getManager();
                    $entityManager->persist($user);
                    $entityManager->flush();
                    $this->addFlash("message", "nieuwe gebruiker {$user->getFullName()} succesvol toegevoegd");
                    $class = $user->getSchoolclass();
                    if (empty($class)) {
                        return $this->redirectToRoute($path . "_home");
                    }
                    return $this->redirectToRoute($path . "_get_class", ['id' => $class->getId()]);
                } catch (UniqueConstraintViolationException $e) {
                    $form->get('email')->addError(new FormError("emailadres {$user->getEmail()} is helaas al in gebruik. Kies een ander"));
                }
                catch (FileException $e) {
                    $form->get('photofile')->addError(new FormError("Helaas is de foto niet opgeslagen op de server, probeer nog eens"));
                }
            }
            return $this->render("$path/new-user.html.twig", [
                'header'=>$header,
                'form' => $form->createView(),
                'classes'=>$this->getClasses(),
            ]);
        }

        /**
         * @param Request $request
         * @param int $id
         * @return Response
         */
        protected function updateUser(Request $request, int $id):Response
        {
            $user = $this->getDoctrine()->getRepository(User::class)->find($id);
            $auth_path = $this->getAuthorisationString();
            if (empty($user)) {
                $this->addFlash('message', 'de te wijzigen gebruiker bestaat niet!');
                return $this->redirectToRoute($auth_path . '_home');
            }
            $form = $this->createForm(UserType::class, $user);
            if(!$this->isGranted('ROLE_PRINCIPAL')){
                $form->remove('roles');
            }
            $form->remove('password');//password kan je enkel resetten
            $form->handleRequest($request);
            if ($form->isSubmitted() && $form->isValid()) {
                /** @var UploadedFile $imgFile */
                $imgFile = $form->get('photofile')->getData();
                try {
                    if ($imgFile) {
                        $originalFilename = pathinfo($imgFile->getClientOriginalName(), PATHINFO_FILENAME);
                        $newFilename = substr(md5($originalFilename), 10) . uniqid() . '.' . $imgFile->guessExtension();
                        $old_photo = $user->getPhotoFileName();
                        $user->setPhoto($newFilename);
                        $dir = $this->getParameter('app.image_directory');
                        $imgFile->move($dir, $newFilename);
                        if (!empty($old_photo)) {
                            $file = $dir . '/' . $old_photo;
                            if (file_exists($file)) {
                                unlink($file);
                            }
                        }
                    }
                    //je bent alle catch van foto opslaan voorbij gekomen. nu kan je proberen om  op te slaan die user!
                    //mogelijk nog problemen als email niet uniek is. Dartoe catch 2
                    $class = $user->getSchoolclass();
                    $class_id = empty($class) ? null : $class->getId();
                    $entityManager = $this->getDoctrine()->getManager();
                    $entityManager->persist($user);
                    $entityManager->flush();
                    $this->addFlash("message", "gebruiker {$user->getFullName()} succesvol gewijzigd");
                    if (empty($class_id)) {
                        return $this->redirectToRoute($auth_path . "_home");
                    }
                    return $this->redirectToRoute($auth_path . "_get_class", ['id' => $class_id]);
                } catch (UniqueConstraintViolationException $e) {
                    $form->get('email')->addError(new FormError("emailadres {$user->getEmail()} is helaas al in gebruik. Kies een ander"));
                } catch (FileException $e) {
                    $form->get('photofile')->addError(new FormError("de foto is helaas niet opgelagen; oude foto behouden"));
                }
            }
            return $this->render($auth_path . '/new-user.html.twig', [
                'header' => 'wijzig de gegevens van deze user',
                'photo' => $user->getPhoto(),
                'form' => $form->createView(),
                'classes' => $this->getClasses(),
            ]);
        }
    }
}
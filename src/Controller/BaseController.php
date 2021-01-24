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
         * @param User $user
         * @return Response
         */
        protected function resetPasswordAction(User $user):Response{
            $authorization_path = $this->getAuthorisationString();
            $user->setPassword($this->encode('qwerty'));
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($user);
            $entityManager->flush();
            $this->addFlash('message',"wachtwoord van {$user->getFullname()} is gereset naar 'qwerty'.");
            return $this->redirectToRoute("{$authorization_path}_home");
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
                    'users'=>$results,
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
        /**
         * @param int $id
         * @return User|null
         */
        protected function findUserFromId(int $id):?User
        {
            return $this->getDoctrine()->getRepository(User::class)->find($id);
        }

    }
}
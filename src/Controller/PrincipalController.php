<?php


namespace App\Controller {

    use App\Entity\User;
    use App\Form\ChangeMottoFormType;
    use Symfony\Component\HttpFoundation\Request;
    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Routing\Annotation\Route;

    final class PrincipalController extends SuperBaseController
    {
        /**
         * @Route ("principal/motto" , name="principal_motto")
         * @param Request $request
         * @return Response
         */
        public function handleMottoChange(Request $request):Response{
            $user = $this->getUser();
            $form = $this->createForm(ChangeMottoFormType::class ,$user, [
                'action' => $this->generateUrl('principal_motto'),
                'method' => 'POST',
            ]);
            $form->handleRequest($request);
            if($form->isSubmitted()&&$form->isValid()){
                $em=$this->getDoctrine()->getManager();
                $em->persist($user);
                $em->flush();
            }
            return $this->redirectToRoute("principal_home");

        }


        /**
         * @Route("/principal" , name="principal_home")
         * @param Request $request
         * @return Response
         */
        public function defaultAction(Request $request):Response{
            $teachers = $this->getDoctrine()->getRepository(User::class)->findTeachers();
            $classes = $this->getClasses();
            $user = $this->getUser();
            $form = $this->createForm(ChangeMottoFormType::class ,$user);
            $form->handleRequest($request);
            if($form->isSubmitted()&&$form->isValid()){
                $em=$this->getDoctrine()->getManager();
                $em->persist($user);
                $em->flush();
            }
            return $this->render('principal/default.html.twig',
                [
                    'classes' => $classes,
                    'motto_form'=>$form->createView()
                ]);
        }

        /**
         * @Route("/principal/teachers" , name="principal_teachers")
         */
        public function showTeachersAction():Response{
            return $this->defaultAction();
        }

        /**
         * @Route("/principal/admins" , name="principal_admins")
         */
        public function showAdminsAction():Response{
            $admins = $this->getDoctrine()->getRepository(User::class)->findAdministrators();
            $classes = $this->getClasses();
            return $this->render('principal/default.html.twig',
                ['users' => $admins,
                    'classes' => $classes,
                    'type'=>'ADMINISTRATIE'
                ]);
        }
        /**
         * @Route("principal/classless" , name="principal_classless")
         */
        public function showClasslessAction():Response{
            $pupils = $this->getDoctrine()->getRepository(User::class)->findClasslessPupils();
            return $this->show($pupils,'ONGEPLAATSTE LEERLINGEN');
        }

        /**
         * @Route("/principal/user/update/{id}" ,  name="principal_update_user", requirements={"id"="\d+"})
         * @param Request $request
         * @param int $id
         * @return Response
         */
        public function principalUpdateUserAction(Request $request, int $id):Response{
            $user = $this->findFromId(User::class,$id);
            if (empty($user)) {
                $this->addFlash('message', 'de te wijzigen gebruiker bestaat niet!');
                return $this->redirectToRoute('principal_home');
            }
            return $this->updateUser($request,$user);
        }

        /**
         * @Route("/principal/user/reset/{id}",  name="principal_reset_user", requirements={"id"="\d+"})
         * @param Request $request
         * @param int $id
         * @return Response
         */
        public function principalResetUserAction(Request $request, int $id):Response{
            $user = $this->findFromId(User::class,$id);
            if(empty($user)){
                $this->addFlash('message','deze gebruiker bestaat niet in de database!');
                return $this->redirectToRoute("principal_home");
            }
            return $this->resetPasswordAction($user);
        }

        /**
         * @Route("/principal/user/delete/{id}",  name="principal_delete_user", requirements={"id"="\d+"})
         * @param int $id
         * @return Response
         */
        public function principalDeleteUserAction(int $id):Response{
            $user = $this->findFromId(User::class,$id);
            if(empty($user)){
                $this->addFlash('message','de te verwijderen gebruiker bestaat niet; niets veranderd in de database!');
                return $this->redirectToRoute("principal_home");
            }
            if($user->isTeacher()) {
                $mentorClass = $user->getMentorclass();
                if ($mentorClass !== null) {
                    $mentorClassName = $mentorClass->getName();
                    $mentorClassId = $mentorClass->getId();
                    $this->addFlash("message", "deze docent is mentor van $mentorClassName. Geef eerst de klas een andere mentor, daarna kan deze docent pas verwijderd worden");
                    return $this->redirectToRoute('principal_get_class',['id'=>$mentorClassId]);
                }
            }
            return $this->deleteUser($user);
        }
        /**
         * @Route("/principal/class/{id}", name="principal_get_class", requirements={"id"="\d+"})
         * @param int $id
         * @return Response
         */
        public function getClassForAdminAction(int $id):Response{
            return $this->getSchoolclassAction($id);
        }

        /**
         * @Route("principal/new/{type}", name="principle_add_user", requirements={"type"="pupil|personel"})
         * @param Request $request
         * @param string $type
         * @return Response
         */
        public function createNewUserAction(Request $request,string $type):Response{
            switch($type){
                case "personel":
                case "pupil":
                    return $this->addUser($request);
                default:
                    $this->addFlash('message','niet knoeien op de urlbalk svp');
                   return  $this->redirectToRoute('principal_home');
            }
        }



    }
}
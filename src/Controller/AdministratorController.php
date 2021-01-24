<?php


namespace App\Controller {


    use App\Entity\Schoolclass;
    use App\Entity\User;
    use App\Form\ChangeMentorFormType;
    use App\Form\SchoolclassType;
    use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
    use Symfony\Component\Form\FormError;
    use Symfony\Component\HttpFoundation\Request;
    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Routing\Annotation\Route;

    final class AdministratorController extends SuperBaseController
    {

        /**
         * @Route("/admin", name="admin_home")
         * @return Response
         */
        public function defaultAction():Response{
            $classless = $this->getDoctrine()->getRepository(User::class)->findClasslessPupils();
            return $this->render('admin/default.html.twig',
                [   'classes'=>$this->getClasses() ,
                    'users'=>$classless,
                    'header'=>'ONGEPLAATSTE LEERLINGEN',
                ]);
        }

        /**
         * @Route("/admin/mentor/change/class/{class_id}", name="admin_change_mentor")
         * @param Request $request
         * @param int $class_id
         * @return Response
         */
        public function changeMentorAction(Request $request, int $class_id):Response{
            $class1 = $this->findFromId(Schoolclass::class,$class_id);
            if($class1===null){
                $this->addFlash('message','de klas waarvan je de mentor wil wijzigen bestaat niet');
                return $this->redirectToRoute("admin_home");
            }
            $form = $this->createForm(ChangeMentorFormType::class);
            $form->handleRequest($request);
                if($form->isSubmitted()&&$form->isValid()){
                    $class_id = $class1->getId();
                    $newMentor = $form->getData()['newmentor'];
                    $swapMentor = $form->getData()['swapmentor'];
                    $mentor = $newMentor??$swapMentor;
                    if($mentor === $class1->getMentor())
                    {
                        $form->get('swapmentor')->addError(
                            new FormError("je mag niet swappen met jezelf; kies iemand anders uit de opties"));
                        return $this->render('admin/changementor.html.twig',
                            [   'classes'=>$this->getClasses(),
                                'class'=>$class1,
                                'form'=>$form->createView()]);
                    }
                    $em = $this->getDoctrine()->getManager();
                    if($mentor===$swapMentor){
                        $class2 = $this->getDoctrine()->getRepository(Schoolclass::class)->findMentorClass($swapMentor);
                        $class2->setMentor($this->getUser());//nodig als dummymentor.
                        $mentorForclass2 = $class1->getMentor();
                        $em->persist($class2);
                        $em->flush();
                        $class1->setMentor($mentor);
                        $class2->setMentor($mentorForclass2);
                        $em->persist($class1);
                        $em->persist($class2);
                        $em->flush();
                        $this->addFlash('message', 'beide mentoren zijn succesvol van klas gewisseld!');
                    }
                    else{
                        $class1->setMentor($newMentor);
                        $em->persist($class1);
                        $em->flush();
                        $this->addFlash('message', 'de klas heeft een nieuwe mentor');
                    }

                    return $this->redirectToRoute('admin_get_class',['id'=>$class_id]);

                }
            return $this->render('admin/changementor.html.twig',
                [   'classes'=>$this->getClasses(),
                    'class'=>$class1,
                    'form'=>$form->createView()]);
        }
        /**
         * @Route("/admin/pupil/new", name="admin_new_pupil")
         * @param Request $request
         * @return Response
         */
        public function newPupilAction(Request $request):Response{
            return $this->addUser($request);
        }


        /**
         * @Route("/admin/pupil/update/{id}", name="admin_update_pupil", requirements={"id"="\d+"})
         * @param int $id
         * @param Request $request
         * @return Response
         */
        public function updatePupilAction(Request $request,int $id):Response{
            $user = $this->findFromId(User::class,$id);
            if (empty($user)) {
                $this->addFlash('message', 'de te wijzigen gebruiker bestaat niet!');
                return $this->redirectToRoute( 'admin_home');
            }
            if(!$user->isPupil()){
                $this->addFlash('message', 'je hebt niet het recht deze gebruiker te wijzigen');
                return $this->redirectToRoute('admin_home');
            }
            return $this->updateUser($request,$user);
        }


        /**
         * @Route("admin/pupil/delete/{id}", name="admin_delete_pupil", requirements={"id"="\d+"})
         * @param int $id
         * @return Response
         */
        public function deleteUserAction(int $id):Response{
            $user = $this->findFromId(User::class,$id);
            if(empty($user)){
                $this->addFlash('message','de te verwijderen gebruiker bestaat niet; niets veranderd in de database!');
                return $this->redirectToRoute("admin_home");
            }
            if(!$user->isPupil()) {
                $this->addFlash('message', 'je hebt niet het recht deze gebruiker te wijzigen');
                return $this->redirectToRoute('admin_home');
            }
            return $this->deleteUser($user);
        }

        /**
         * @Route("admin/reset/{id}", name="admin_reset", requirements={"id"="\d+"})
         * @param int $id
         * @return Response
         */
        public function adminResetPasswordAction(int $id):Response{
            $user = $this->findFromId(User::class,$id);
            if(empty($user)){
                $this->addFlash('message','deze gebruiker bestaat niet in de database!');
                return $this->redirectToRoute("admin_home");
            }

            if(!$user->isPupil()){
                $this->addFlash('message','deze gebruiker mag je niet resetten');
                return $this->redirectToRoute("admin_home");
            }
            return $this->resetPasswordAction($user);
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
            return $this->searchAction($request,'ROLE_PUPIL');
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
}
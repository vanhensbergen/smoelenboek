<?php
namespace App\Controller {

    use App\Entity\StudentRemark;
    use App\Entity\User;
    use App\Form\StudentRemarkType;
    use Symfony\Component\HttpFoundation\File\UploadedFile;
    use Symfony\Component\HttpFoundation\Request;
    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Routing\Annotation\Route;

    final class TeacherController extends BaseController
    {
        /**
         * @Route("/teacher" , name="teacher_home")
         * @return Response
         */
        public function defaultAction():Response{
            $myClass = $this->getUser()->getMentorclass();
            $classes = $this->getClasses();
            return $this->render('teacher/default.html.twig',[
                'class'=>$myClass,
                'classes'=>$classes,
            ]);
        }

        /**
         * @Route("/teacher/search", name="teacher_search")
         * @param Request $request
         * @return Response
         */
        public function searchForTeacherAction(Request  $request):Response{
            return $this->searchAction($request,'ROLE_PUPIL');
        }

        /**
         * @Route("/teacher/class/{id}", name="teacher_get_class", requirements={"id"="\d+"})
         * @param int $id
         * @return Response
         */
        public function getClassForTeacherAction(int $id):Response
        {
            return $this->getSchoolclassAction($id);
        }

        /**
         * @Route("/teacher/motto", name="teacher_motto")
         * @param Request $request
         * @return Response
         */
        public function mottoAction(Request $request):Response{
            $newMotto = $request->get("motto");
            /** @var User $user*/
            $user = $this->getUser();
            $user->setMotto($newMotto);
            $em  = $this->getDoctrine()->getManager();
            $em->persist($user);
            $em->flush();
            return $this->redirectToRoute('teacher_home');
        }

        /**
         * @Route("teacher/new_password", name="teacher_new_password")
         * @param Request $request
         * @return Response
         */
        public function changeTeacherPasswordAction(Request $request):Response{
            return $this->changePasswordAction($request);
        }

        /**
         * @Route("teacher/remarks/{student_id}" , name="teacher_get_remarks" ,requirements={"student_id"="\d+"})
         * @param int $student_id
         * @return Response
         */
        public function getStudentRemarksForTeacherAction(int $student_id):Response{
            return $this->showStudentRemarks($student_id);

        }



        /**
         * @Route("teacher/remarks/new/{student_id}", name="teacher_new_remark", requirements={"student_id"="\d+"})
         * @param Request $request
         * @param int $student_id
         * @return Response
         */
        public function addStudentRemarkByTeacher(Request $request, int $student_id):Response
        {
            $remark = new StudentRemark();
            $form = $this->createForm(StudentRemarkType::class,$remark);
            $form->handleRequest($request);
            $extraData = ['new_form'=>$form->createView()];
            if ($form->isSubmitted() && $form->isValid())
            {
                $student = $this->findFromId(User::class,$student_id);
                $remark->setStudent($student);
                $remark->setAuthor($this->getUser());
                $today = new \DateTime("NOW");
                $remark->setCreated($today);
                $remark->setBlocked(false);
                $em= $this->getDoctrine()->getManager();
                $em->persist($remark);
                $em->flush();
                return $this->redirectToRoute("teacher_get_remarks",['student_id'=>$student_id]);
            }
            return $this->showStudentRemarks($student_id, $extraData);
        }
        /**
         * @Route("teacher/resetpassword/{id}", name="teacher_reset_mentor_student", requirements={"id"="\d+"})
         */
        public function resetMentorStudentAction(int $id):Response{
            $user = $this->findFromId(User::class,$id);
            if(empty($user)){
                $this->addFlash('message','deze gebruiker bestaat niet in de database!');
                return $this->redirectToRoute("teacher_home");
            }
            if(!$user->isPupil()){
                $this->addFlash('message','deze gebruiker mag je niet resetten');
                return $this->redirectToRoute("teacher_home");
            }
            $class = $user->getSchoolclass();
            $mentor = empty($class)?null:$class->getMentor();
            if(!empty($mentor)&&$mentor===$this->getUser()){
                return $this->resetPasswordAction($user);
            }
            $this->addFlash('message', "je bent geen mentor van de leerling, reset niet toegestaan");
            return $this->redirectToRoute('teacher_home');

        }

        /**
         * @Route("teacher/remarks/update/{id}", name="teacher_update_remark", requirements={"id"="\d+"})
         * @param Request $request
         * @param $id
         * @return Response
         */
        public function updateStudentRemarkByTeacherAction(Request $request, $id):Response
        {
            $remark = $this->findFromId(StudentRemark::class,$id);
            if($remark===null){
                $this->addFlash('message',"de opmerking die je wilt wijzigen bestaat niet");
                return $this->redirectToRoute('teacher_home');
            }
            $author = $remark->getAuthor();
            if($author!==$this->getUser()){
                $this->addFlash('message',"bewerking niet toegestaan: je bent niet de ateur dat is {$author->getFullname()}");
                return $this->redirectToRoute('teacher_home');
            }
            $student_id = $remark->getStudent()->getId();
            $form = $this->createForm(StudentRemarkType::class, $remark);
            $form->handleRequest($request);
            $extraData = ['update_form' => $form->createView(), 'update_remark' => $remark];
            if ($form->isSubmitted() && $form->isValid()) {
                $em = $this->getDoctrine()->getManager();
                $em->persist($form->getData());
                $em->flush();
                return $this->redirectToRoute("teacher_get_remarks", ['student_id' => $student_id]);
            }
            return $this->showStudentRemarks( $student_id, $extraData);
        }

        /**
         * @Route("teacher/remarks/delete/{id}", name="teacher_delete_remark", requirements={"id"="\d+"})
         * @param int $id
         * @return Response
         */
        public function deleteStudentRemarkByTeacherAction(int $id):Response
        {
            $remark = $this->findFromId(StudentRemark::class,$id);
            $student_id = $remark->getStudent()->getId();
            $author = $remark->getAuthor();
            if($author===$this->getUser())
            {
                $em = $this->getDoctrine()->getManager();
                $em->remove($remark);
                $em->flush();
            }
            return $this->redirectToRoute("teacher_get_remarks", ['student_id' => $student_id]);
        }


    }
}
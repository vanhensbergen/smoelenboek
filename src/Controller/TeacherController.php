<?php


namespace App\Controller;


use App\Entity\StudentRemark;
use App\Entity\User;
use App\Form\StudentRemarkType;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class TeacherController extends BaseController
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
        return $this->searchAction($request);
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
        return $this->studentRemarksViewForTeacher($student_id);

    }

    private function studentRemarksViewForTeacher(int $student_id, array $form_data=[]):Response{
        $student = $this->getDoctrine()->getRepository(User::class)->find($student_id);
        $remarks = $student->getRemarksForStudent();
        $classes = $this->getClasses();
        $form_data = array_merge($form_data, [
            'student'=>$student,
            'remarks'=>$remarks,
            'classes'=>$classes,
        ]);
        return $this->render('teacher/student-details.html.twig',$form_data);
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
            //['action'=>$this->generateUrl('teacher_new_remark',['student_id'=>$student_id])]);
        $form->handleRequest($request);
        $extraData = ['new_form'=>$form->createView()];
        if ($form->isSubmitted() && $form->isValid())
        {
            $student = $this->getDoctrine()->getRepository(User::class)->find($student_id);
            $remark->setStudent($student);
            $remark->setAuthor($this->getUser());
            $today = new \DateTime("NOW");
            $remark->setCreated($today);
            $em= $this->getDoctrine()->getManager();
            $em->persist($remark);
            $em->flush();
            return $this->redirectToRoute("teacher_get_remarks",['student_id'=>$student_id]);
        }
       return $this->studentRemarksViewForTeacher($student_id, $extraData);
    }

    /**
     * @Route("teacher/remarks/update/{id}", name="teacher_update_remark", requirements={"id"="\d+"})
     * @param Request $request
     * @param $id
     * @return Response
     */
    public function updateStudentByTeacherAction(Request $request, $id):Response{
        $remark = $this->getDoctrine()->getRepository(StudentRemark::class)->find($id);
        //$route = $this->generateUrl('teacher_update_remark',['id'=>$id]);
        $student_id = $remark->getStudent()->getId();
        $form = $this->createForm(StudentRemarkType::class,$remark);
        $form->handleRequest($request);
        $extraData = ['update_form'=>$form->createView(),'update_remark'=>$remark];
        if($form->isSubmitted()&&$form->isValid()){
            $em = $this->getDoctrine()->getManager();
            $em->persist($form->getData());
            $em->flush();
            return $this->redirectToRoute("teacher_get_remarks",['student_id'=>$student_id]);
        }
        return $this->getStudentRemarksForTeacherAction($request,$student_id,$extraData);



    }
}
<?php


namespace App\Controller;


use App\Entity\User;
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
            //$myClass = $this->getMentorClass();
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

}
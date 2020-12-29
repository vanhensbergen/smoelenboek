<?php


namespace App\Controller;


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

}
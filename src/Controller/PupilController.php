<?php


namespace App\Controller;


use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PupilController extends BaseController
{

    /**
     * @Route("/pupil", name="pupil_home")
     */
    public function defaultAction():Response
    {
        $class = $this->getUser()->getSchoolclass();

        return $this->render('pupil/showclass.html.twig',
            [ 'class'=>$class, 'classes'=>$this->getClasses()]);
    }
}
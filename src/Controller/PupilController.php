<?php


namespace App\Controller;


use Symfony\Component\HttpFoundation\Request;
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

    /**
     * @Route ("pupil/new_password", name="pupil_new_password")
     * @param Request $request
     * @return Response
     */
    public function changePupilPasswordAction(Request $request):Response{
        return $this->changePasswordAction($request);
    }

    /**
     * @Route("/pupil/class/{id}", name="pupil_get_class", requirements={"id"="\d+"})
     * @param int $id
     * @return Response
     */
    public function getClassForPupilAction(int $id):Response
    {
        return $this->getSchoolclassAction($id);
    }

    /**
     * @Route("/pupil/search", name="pupil_search")
     * @param Request $request
     * @return Response
     */
    public function searchForTeacherAction(Request  $request):Response{
        return $this->searchAction($request);
    }
}
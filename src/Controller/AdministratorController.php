<?php


namespace App\Controller;


use App\Entity\Schoolclass;
use App\Entity\User;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AdministratorController extends BaseController
{
    public function __construct(){


    }

    /**
     * @Route("/admin", name="admin_home")
     */
    public function defaultAction():Response{
        $classless = $this->getDoctrine()->getRepository(User::class)->findClasslessPupils();
        return $this->render('admin/default.html.twig',
            [   'classes'=>$this->getClasses() ,
                'pupils'=>$classless,
                'header'=>'ONGEPLAATSTE LEERLINGEN',
            ]);
    }
}
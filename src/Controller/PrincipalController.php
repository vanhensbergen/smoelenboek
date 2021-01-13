<?php


namespace App\Controller {


    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Routing\Annotation\Route;

    class PrincipalController extends BaseController
    {
        /**
         * @Route("/principal" , name="principal_home")
         */
        public function defaultAction():Response{

        }

    }
}
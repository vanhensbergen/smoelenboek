<?php


namespace App\Controller {


    use App\Entity\User;
    use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Routing\Annotation\Route;

    class DefaultController extends AbstractController
    {
        /**
         * @Route("/", name="visitor_home")
         */
        public function defaultAction():Response{
            $principal=$this->getDoctrine()->getRepository(User::class)->findPrincipal();
            $teachers = $this->getDoctrine()->getRepository(User::class)->findTeachers();
            $administrators = $this->getDoctrine()->getRepository(User::class)->findAdministrators();
            return $this->render('visitor/default.html.twig',
                [  'principal'=>$principal, 'teachers'=>$teachers,'administrators'=>$administrators]);
        }
    }
}
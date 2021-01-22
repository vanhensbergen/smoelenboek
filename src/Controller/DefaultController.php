<?php


namespace App\Controller {


    use App\Entity\User;
    use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
    use Symfony\Component\HttpFoundation\Response;
    use Symfony\Component\Routing\Annotation\Route;
    use Symfony\Component\Security\Http\Authentication\AuthenticationUtils;

    class DefaultController extends AbstractController
    {
        /**
         * @Route("/", name="visitor_home")
         * @param AuthenticationUtils $authenticationUtils
         * @return Response
         */
        public function defaultAction(AuthenticationUtils $authenticationUtils):Response{
            $principal=$this->getDoctrine()->getRepository(User::class)->findPrincipal();
            $teachers = $this->getDoctrine()->getRepository(User::class)->findTeachers();
            $administrators = $this->getDoctrine()->getRepository(User::class)->findAdministrators();
            $error = $authenticationUtils->getLastAuthenticationError();
            $lastUsername = $authenticationUtils->getLastUsername();
            return $this->render('visitor/default.html.twig', [
                                            'principal'=>$principal,
                                            'teachers'=>$teachers,
                                            'administrators'=>$administrators,
                                            'last_username' => $lastUsername,
                                            'error' => $error]);
        }



        /**
         * @Route("/logout", name="app_logout")
         */
        public function logout()
        {
            throw new \LogicException('This method can be blank - it will be intercepted by the logout key on your firewall.');
        }
    }
}
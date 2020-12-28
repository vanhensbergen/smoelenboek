<?php


namespace App\Controller;


use App\Entity\Schoolclass;
use App\Entity\User;
use App\Form\ChangePasswordType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

abstract class BaseController extends AbstractController
{

    protected UserPasswordEncoderInterface $passwordEncoder;

    public function __construct(UserPasswordEncoderInterface $passwordEncoder){

        $this->passwordEncoder = $passwordEncoder;
    }

    /**
     * @return array
     */
    protected function getClasses():array{
        return $this->getDoctrine()->getRepository(Schoolclass::class)->findAll();
    }

    protected function resetPasswordAction(int $id):Response{
        $user = $this->getDoctrine()->getRepository(User::class)->find($id);
        $path = $this->getUserString();
        if(empty($user)){
            $this->addFlash('message','deze gebruiker bestaat niet in de database!');
            return $this->redirectToRoute("{$path}_home");
        }
        $user->setPassword($this->encode('qwerty'));
        $entityManager = $this->getDoctrine()->getManager();
        $entityManager->persist($user);
        $entityManager->flush();
        $this->addFlash('message',"wachtwoord van {$user->getFullname()} is gereset naar 'qwerty'.");
        return $this->redirectToRoute("{$path}_home");
    }

    protected function getUserString():string{
        if($this->isGranted('ROLE_PRINCIPAL')){
            return 'principal';
        }
        if($this->isGranted('ROLE_ADMIN')){
            return 'admin';
        }
        if($this->isGranted('ROLE_PUPIL')){
            return 'pupil';
        }
        return 'visitor';

    }

    /**
     * @param int $id
     * @return Response
     */
    protected function getSchoolclassAction(int $id):Response{
        $class = $this->getDoctrine()->getRepository(Schoolclass::class)->find($id);
        $path = $this->getUserString();
        return $this->render("$path/showclass.html.twig",['classes'=>$this->getClasses(),'class'=>$class]);
    }

    protected function encode($plainPassword):string{
        $user = new User();
        return $this->passwordEncoder->encodePassword($user, $plainPassword);
    }


    /**
     * @param Request $request
     * @return Response
     */
    protected function changePasswordAction(Request $request):Response
    {
        $form = $this->createForm(ChangePasswordType::class);
        $form->handleRequest($request);
        $path = $this->getUserString();
        if($form->isSubmitted()&&$form->isValid())
        {
            $new = $form->get('new_password')->getData();
            $user = $this->getUser();
            $user->setPassword($this->encode($new));
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($user);
            $entityManager->flush();
            $this->addFlash('message','wachtwoord succesvol gewijzigd');
            return $this->redirectToRoute("{$path}_home");
        }
        return $this->render("$path/new_password.html.twig", [
            'form' => $form->createView(),
            'classes'=>$this->getClasses(),
        ]);

    }


}
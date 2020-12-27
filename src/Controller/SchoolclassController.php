<?php


namespace App\Controller;



use App\Entity\Schoolclass;
use App\Form\SchoolclassType;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Symfony\Component\Form\FormError;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class SchoolclassController extends BaseController
{
    /**
     * @Route("admin/class/new", name="admin_new_class")
     * @param Request $request
     * @return Response
     */
    public function addSchoolclassAction(Request $request):Response{
        $schoolclass = new Schoolclass();
        $form= $this->createForm(SchoolclassType::class,$schoolclass);
        $form->handleRequest($request);
        if($form->isSubmitted()&&$form->isValid())
        {
            try
            {
                $em = $this->getDoctrine()->getManager();
                $em->persist($schoolclass);
                $em->flush();
                $this->addFlash('message',"klas {$schoolclass->getName()} succesvol aangemaakt");
                return $this->redirectToRoute('admin_home');
            }
            catch(UniqueConstraintViolationException $e)
            {
                $form->get('name')->addError(new FormError("klassenaam {$schoolclass->getName()} is helaas al in gebruik. Kies een ander"));
            }
        }
        return $this->render('admin/new_class.html.twig', [
            'form' => $form->createView(),
            'classes'=>$this->getClasses(),
        ]);

    }
}
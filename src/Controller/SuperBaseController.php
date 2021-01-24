<?php


namespace App\Controller;


use App\Entity\User;
use App\Form\UserType;
use Doctrine\DBAL\Exception\UniqueConstraintViolationException;
use Symfony\Component\Form\FormError;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class SuperBaseController extends BaseController
{
    protected function addUser(Request $request)
    {
        $user = new User();
        $author = $this->getAuthorisationString();
        $header = $author==='admin' ? 'gegevens van een nieuwe leerling' : 'gegevens van een nieuwe schoolgebruiker';
        $form = $this->createForm(UserType::class, $user);
        if ($author==='admin') $form->remove('roles');
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            /** @var UploadedFile $imgFile */
            $imgFile = $form->get('photofile')->getData();
            if ($imgFile) {

                $originalFilename = pathinfo($imgFile->getClientOriginalName(), PATHINFO_FILENAME);
                $newFilename = substr(md5($originalFilename), 10) . uniqid() . '.' . $imgFile->guessExtension();
                $user->setPhoto($newFilename);
            }
            try
            {
                if (isset($newFilename)) {
                    $dir = $this->getParameter('app.image_directory');
                    $imgFile->move($dir, $newFilename);
                }
                //als je hier voorbij bent is alles gelukt dus opslaan in db
                if ($author==='admin') $user->setRoles(["ROLE_PUPIL"]);
                $user->setPassword($this->encode($user->getPassword()));
                $entityManager = $this->getDoctrine()->getManager();
                $entityManager->persist($user);
                $entityManager->flush();
                $this->addFlash("message", "nieuwe gebruiker {$user->getFullName()} succesvol toegevoegd");
                $class = $user->getSchoolclass();
                if (empty($class)) {
                    return $this->redirectToRoute($author . "_home");
                }
                return $this->redirectToRoute($author . "_get_class", ['id' => $class->getId()]);
            } catch (UniqueConstraintViolationException $e) {
                $form->get('email')->addError(new FormError("emailadres {$user->getEmail()} is helaas al in gebruik. Kies een ander"));
            }
            catch (FileException $e) {
                $form->get('photofile')->addError(new FormError("Helaas is de foto niet opgeslagen op de server, probeer nog eens"));
            }
        }
        return $this->render("$author/new-user.html.twig", [
            'header'=>$header,
            'form' => $form->createView(),
            'classes'=>$this->getClasses(),
        ]);
    }

    /**
     * @param Request $request
     * @param User $user
     * @return Response
     */
    protected function updateUser(Request $request, User $user):Response
    {
        $auth_path = $this->getAuthorisationString();
        $form = $this->createForm(UserType::class, $user);
        if(!$this->isGranted('ROLE_PRINCIPAL')){
            $form->remove('roles');
        }
        $form->remove('password');//password kan je enkel resetten
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $isMentorOfOld = $user->getMentorclass()!==null;
            $isTeacherOfNew = $user->isTeacher();
            if($isMentorOfOld&&!$isTeacherOfNew){
                $className = $user->getMentorclass()->getName();
                $this->addFlash('message',"verandering van rol is niet toegestaan. Dit teamlid is mentor van $className en de rol van docent is daartoe vereist");
            }
            else {
                /** @var UploadedFile $imgFile */
                $imgFile = $form->get('photofile')->getData();
                try {
                    if ($imgFile) {
                        $originalFilename = pathinfo($imgFile->getClientOriginalName(), PATHINFO_FILENAME);
                        $newFilename = substr(md5($originalFilename), 10) . uniqid() . '.' . $imgFile->guessExtension();
                        $old_photo = $user->getPhotoFileName();
                        $user->setPhoto($newFilename);
                        $dir = $this->getParameter('app.image_directory');
                        $imgFile->move($dir, $newFilename);
                        if (!empty($old_photo)) {
                            $file = $dir . '/' . $old_photo;
                            if (file_exists($file)) {
                                unlink($file);
                            }
                        }
                    }
                    //je bent alle catch van foto opslaan voorbij gekomen. nu kan je proberen om  op te slaan die user!
                    //mogelijk nog problemen als email niet uniek is. Daartoe catch 2
                    $class = $user->getSchoolclass();
                    $class_id = empty($class) ? null : $class->getId();
                    $entityManager = $this->getDoctrine()->getManager();
                    $entityManager->persist($user);
                    $entityManager->flush();
                    $this->addFlash("message", "gebruiker {$user->getFullName()} succesvol gewijzigd");
                    if (empty($class_id)) {
                        return $this->redirectToRoute($auth_path . "_home");
                    }
                    return $this->redirectToRoute($auth_path . "_get_class", ['id' => $class_id]);
                } catch (UniqueConstraintViolationException $e) {
                    $form->get('email')->addError(new FormError("emailadres {$user->getEmail()} is helaas al in gebruik. Kies een ander"));
                } catch (FileException $e) {
                    $form->get('photofile')->addError(new FormError("de foto is helaas niet opgelagen; oude foto behouden"));
                }
            }
        }
        return $this->render($auth_path . '/new-user.html.twig', [
            'header' => 'wijzig de gegevens van deze user',
            'photo' => $user->getPhoto(),
            'form' => $form->createView(),
            'classes' => $this->getClasses(),
        ]);
    }

    /**
     * @param User $user
     * @return Response
     * methode verondersteld het bestaan van een aantal routes zoals: admin_home of principal_home
     * of admin_get_class principal_get_class voor de 2 rollen.
     * alle controle vooraf moet gedaan zijn, controle op rolwijziging mentordocent en admin die docent verwijderd..etc
     */
    public function deleteUser(User $user):Response{

        $user_path = $this->getAuthorisationString();
        $class = $user->getSchoolclass();
        $class_id = empty($class)?null:$class->getId();
        $photoName = $user->getPhotoFileName();
        $entityManager = $this->getDoctrine()->getManager();
        $entityManager->remove($user);
        $entityManager->flush();
        $dir = $this->getParameter('app.image_directory');
        if(!empty($photoName)){
            $file = $dir.'/'.$photoName;
            if(file_exists($file)) {

                unlink($file);
            }
        }
        $this->addFlash('message',"{$user->getFullName()} verwijderd");

        if(empty($class_id)){
            return $this->redirectToRoute("{$user_path}_home");
        }
        return $this->redirectToRoute("{$user_path}_get_class",['id'=>$class_id]);
    }
}
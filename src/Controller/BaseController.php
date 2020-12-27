<?php


namespace App\Controller;


use App\Entity\Schoolclass;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;

abstract class BaseController extends AbstractController
{

    protected function getClasses():array{
        return $this->getDoctrine()->getRepository(Schoolclass::class)->findAll();
    }

}
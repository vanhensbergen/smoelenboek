<?php


namespace App\Controller;


use App\Entity\Schoolclass;

abstract class BaseController extends \Symfony\Bundle\FrameworkBundle\Controller\AbstractController
{

    protected function getClasses():array{
        return $this->getDoctrine()->getRepository(Schoolclass::class)->findAll();
    }

}
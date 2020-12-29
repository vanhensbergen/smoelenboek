<?php

namespace App\Form;

use App\Entity\Schoolclass;
use App\Entity\User;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class SchoolclassType extends AbstractType
{

    public function buildForm(FormBuilderInterface $builder, array $options)
    {

        $builder
            ->add('name',TextType::class,
                ['label'=>'kies een unieke naam voor de klas'])
            ->add('description',TextareaType::class,
                ['label'=>'geef een omschrijving van de klas'])
            ->add('mentor', EntityType::class,
                [   'class'=>User::class,
                    'query_builder'=>function(EntityRepository $ur){
                        return  $ur->createQueryBuilder('u')
                            //Select * From users u LEFT JOIN schoolclasses s ON u.id = s.mentor_id WHERE u.roles="[\"ROLE_TEACHER\"]" AND s.mentor_id IS NULL
                                ->leftJoin(Schoolclass::class,'s', Join::WITH,
                                's.mentor = u')
                            ->where('u.roles LIKE :roles')
                            ->andWhere('s.mentor IS NULL')
                            ->setParameter('roles', '%"ROLE_TEACHER"%')
                            ->orderBy('u.lastname','ASC');
                    },
                    'choice_value'=>function(?User $u){
                        return $u?$u->getId():null;
                    },
                    'choice_label'=>function(?User $u){
                        return $u?$u->getFullname():null;
                    },
                    'placeholder'=>'----------',
                    'required'=>true,
                    'label'=>'Kies een beschikbare docent als mentor voor de nieuwe klas'
                ]
            )
            ->add('save',SubmitType::class)

        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => Schoolclass::class,
        ]);
    }
}

<?php


namespace App\Form;


use App\Entity\Schoolclass;
use App\Entity\User;
use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\Form\Exception\TransformationFailedException;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormEvent;
use Symfony\Component\Form\FormEvents;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ChangeMentorFormType extends \Symfony\Component\Form\AbstractType implements EventSubscriberInterface
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {

        $builder
            ->add('newmentor', EntityType::class,
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
                    'placeholder'=>'kies voor een docent zonder mentorklas',
                    'required'=>false,
                    'label'=>'Kies een docent als mentor voor  deze klas; de huidige docent is mentor af.'
                ]
            )
            ->add('swapmentor', EntityType::class,
                [   'class'=>User::class,
                    'query_builder'=>function(EntityRepository $ur){
                        return  $ur->createQueryBuilder('u')
                            //Select * From users u LEFT JOIN schoolclasses s ON u.id = s.mentor_id WHERE u.roles="[\"ROLE_TEACHER\"]" AND s.mentor_id IS NULL
                            ->leftJoin(Schoolclass::class,'s', Join::WITH,
                                's.mentor = u')
                            ->where('u.roles LIKE :roles')
                            ->andWhere('s.mentor IS NOT NULL')
                            ->setParameter('roles', '%"ROLE_TEACHER"%')
                            ->orderBy('u.lastname','ASC');
                    },
                    'choice_value'=>function(?User $u){
                        return $u?$u->getId():null;
                    },
                    'choice_label'=>function(?User $u){
                        return $u?$u->getFullname():null;
                    },
                    'placeholder'=>'wissel met een mentor van een andere klas',
                    'required'=>false,
                    'label'=>'swap mentoren de huidige mentor en de gekozen mentor ruilen klas'
                ]
            )
            ->add('save',SubmitType::class)
        ;
        $builder->addEventSubscriber($this);
    }

    public function ensureOneFieldIsSubmitted(FormEvent $event)
    {
        $submittedData = $event->getData();
        if (empty($submittedData['newmentor']) && empty($submittedData['swapmentor'])) {
            throw new TransformationFailedException(
                'either first or second must be set',
                0, // code
                null, // previous
                'Je moet wel een keus maken voor optie 1: een andere docent als mentor of optie 2: twee mentoren swappen',
            );
        }
    }


    public static function getSubscribedEvents():array
    {
        return [FormEvents::PRE_SUBMIT=>'ensureOneFieldIsSubmitted'];
    }


}
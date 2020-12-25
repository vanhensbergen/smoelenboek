<?php


namespace App\Form;


use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Security\Core\Validator\Constraints\UserPassword;

class ChangePasswordType extends \Symfony\Component\Form\AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        parent::buildForm($builder, $options);
        $builder->add('password',
                    PasswordType::class,
                    [   "required"=>true,
                        'label'=>"oude wachtwoord",
                        'constraints' => new UserPassword(['message'=>'Oude wachtwoord klopt niet']),
                        'attr'=>['placeholder'=>'vul je huidige wachtwoord in, voor accordering',],
                    ])
        ->add('new_password',RepeatedType::class,
                [   'type'=>PasswordType::class,
                    'invalid_message'=>'niet beide nieuwe wachtwoorden hetzelfde',
                    'options' => ['attr' => ['class' => 'password-field']],
                    'required' => true,
                    'first_options'  => ['label' => 'nieuw wachtwoord','attr'=>['placeholder'=>'vul je nieuwe wachtwoord in']],
                    'second_options' => ['label' => 'herhaal nieuw wachtwoord', 'attr'=>['placeholder'=>'vul je nieuwe wachtwoord nogmaals in']],
                ])
            ->add('save', SubmitType::class);

    }

}
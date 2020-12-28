<?php


namespace App\Form;


use App\Entity\Schoolclass;
use App\Entity\User;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\ResetType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\File;
use Symfony\Component\Form\Extension\Core\Type\FileType;


class UserType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('firstname',TextType::class,['label'=>'voornaam','attr'=>['placeholder'=>'vul een voornaam in']])
            ->add('prefix',TextType::class,['label'=>'tussenvoegsel(s)','required'=>false,'attr'=>['placeholder'=>'vul eventueel tussenvoegsels in']])
            ->add('lastname', TextType::class,['label'=>'achternaam','attr'=>['placeholder'=>'vul een achternaam in']])
            ->add('email', EmailType::class,['label'=>'emailadres','attr'=>['placeholder'=>'vul verplicht een (uniek) emailadres in']])
            ->add('password',TextType::class,['label'=>'wachtwoord','attr'=>['placeholder'=>'kies een wachtwoord voor de gebruiker']])
            ->add('schoolclass',EntityType::class,['class'=>Schoolclass::class,
                            'choice_label' => 'name',
                'placeholder' => 'klas optioneel',
                'required'=>false])
            ->add('photofile',FileType::class,

                [
                    'label'=>'foto voor user',
                    'mapped'=>false,
                    'required'=>false,
                    'constraints'=>[
                                    new File([
                                                    'maxSize'=>'1024k',
                                                    'mimeTypes'=>[
                                                                'image/jpeg',
                                                                'image/png',
                                                                ],
                                                    'mimeTypesMessage'=>'kies voor een png of jpg imagefile',
                                            ])
                ],

            ])
        ->add('save', SubmitType::class);
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(['data_class'=>User::class]);
    }


}
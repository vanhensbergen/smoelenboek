<?php

namespace App\Repository;

use App\Entity\User;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Symfony\Component\Security\Core\Exception\UnsupportedUserException;
use Symfony\Component\Security\Core\User\PasswordUpgraderInterface;
use Symfony\Component\Security\Core\User\UserInterface;

/**
 * @method User|null find($id, $lockMode = null, $lockVersion = null)
 * @method User|null findOneBy(array $criteria, array $orderBy = null)
 * @method User[]    findAll()
 * @method User[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UserRepository extends ServiceEntityRepository implements PasswordUpgraderInterface
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, User::class);
    }

    public function findLike(string $value,$role):array{
        $qb = $this->createQueryBuilder('u');
          $qb->where('u.firstname LIKE :val')
              ->orWhere('u.prefix LIKE :val')
              ->orWhere('u.lastname LIKE :val')
              ->andWhere('u.roles LIKE :role')
              ->setParameter('val', '%' . $value . '%')
              ->setParameter('role','%"'.$role.'"%')
              ->orderBy('u.lastname','ASC');

        return $qb->getQuery()->execute();
    }
    /**
     * Used to upgrade (rehash) the user's password automatically over time.
     */
    public function upgradePassword(UserInterface $user, string $newEncodedPassword): void
    {
        if (!$user instanceof User) {
            throw new UnsupportedUserException(sprintf('Instances of "%s" are not supported.', \get_class($user)));
        }

        $user->setPassword($newEncodedPassword);
        $this->_em->persist($user);
        $this->_em->flush();
    }

    public function findAdministrators():array{
        return $this->findByRole('ROLE_ADMIN');
    }
    public function findPrincipal():?User{
      return $this->findByRole('ROLE_PRINCIPAL')[0];
    }
    public function findTeachers():array{
        return $this->findByRole('ROLE_TEACHER');
    }
    private function findByRole($role,$order='ASC'):array
    {
        $qb = $this->createQueryBuilder('u');
        $qb->where('u.roles LIKE :roles')
            ->setParameter('roles', '%"' . $role . '"%')
            ->orderBy('u.lastname',$order);
        return $qb->getQuery()->execute();
    }

    /**
     * @return array
     */
    public function findClasslessPupils():array{
        $db = $this->createQueryBuilder('u');
        $db->where('u.schoolclass is NULL')
            ->andWhere('u.roles LIKE :roles')
            ->setParameter('roles', '%"' . 'ROLE_PUPIL' . '"%')
            ->orderBy('u.lastname','ASC');
        return $db->getQuery()->execute();
    }
    /*
    public function findOneBySomeField($value): ?User
    {
        return $this->createQueryBuilder('u')
            ->andWhere('u.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */

    ///**
    //  * @return User[] Returns an array of User objects
    //   */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('u')
            ->andWhere('u.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('u.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */
}

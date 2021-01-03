<?php

namespace App\Repository;

use App\Entity\StudentRemark;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method StudentRemark|null find($id, $lockMode = null, $lockVersion = null)
 * @method StudentRemark|null findOneBy(array $criteria, array $orderBy = null)
 * @method StudentRemark[]    findAll()
 * @method StudentRemark[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StudentRemarkRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StudentRemark::class);
    }

    // /**
    //  * @return StudentRemark[] Returns an array of StudentRemark objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('s')
            ->andWhere('s.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('s.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?StudentRemark
    {
        return $this->createQueryBuilder('s')
            ->andWhere('s.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}

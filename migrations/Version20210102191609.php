<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20210102191609 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE studentremarks (id INT AUTO_INCREMENT NOT NULL, author_id INT NOT NULL, student_id INT NOT NULL, title VARCHAR(255) NOT NULL, content LONGTEXT NOT NULL, created DATE NOT NULL, INDEX IDX_33EFB2D8F675F31B (author_id), INDEX IDX_33EFB2D8CB944F1A (student_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE studentremarks ADD CONSTRAINT FK_33EFB2D8F675F31B FOREIGN KEY (author_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE studentremarks ADD CONSTRAINT FK_33EFB2D8CB944F1A FOREIGN KEY (student_id) REFERENCES users (id)');
        $this->addSql('DROP TABLE student_remark');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE student_remark (id INT AUTO_INCREMENT NOT NULL, author_id INT NOT NULL, student_id INT NOT NULL, title VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_unicode_ci`, content LONGTEXT CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_unicode_ci`, created DATE NOT NULL, INDEX IDX_6FFC00B9CB944F1A (student_id), INDEX IDX_6FFC00B9F675F31B (author_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE `utf8_unicode_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('ALTER TABLE student_remark ADD CONSTRAINT FK_6FFC00B9CB944F1A FOREIGN KEY (student_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE student_remark ADD CONSTRAINT FK_6FFC00B9F675F31B FOREIGN KEY (author_id) REFERENCES users (id)');
        $this->addSql('DROP TABLE studentremarks');
    }
}

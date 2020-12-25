<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20201211141559 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE schoolclasses (id INT AUTO_INCREMENT NOT NULL, mentor_id INT DEFAULT NULL, name VARCHAR(10) NOT NULL, description LONGTEXT NOT NULL, INDEX IDX_6629A8ADB403044 (mentor_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE users (id INT AUTO_INCREMENT NOT NULL, schoolclass_id INT DEFAULT NULL, email VARCHAR(180) NOT NULL, roles LONGTEXT NOT NULL COMMENT \'(DC2Type:json)\', password VARCHAR(255) NOT NULL, firstname VARCHAR(50) NOT NULL, prefix VARCHAR(20) DEFAULT NULL, lastname VARCHAR(50) NOT NULL, photo VARCHAR(50) DEFAULT NULL, UNIQUE INDEX UNIQ_1483A5E9E7927C74 (email), INDEX IDX_1483A5E9C67D8F5 (schoolclass_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE schoolclasses ADD CONSTRAINT FK_6629A8ADB403044 FOREIGN KEY (mentor_id) REFERENCES users (id)');
        $this->addSql('ALTER TABLE users ADD CONSTRAINT FK_1483A5E9C67D8F5 FOREIGN KEY (schoolclass_id) REFERENCES schoolclasses (id)');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE users DROP FOREIGN KEY FK_1483A5E9C67D8F5');
        $this->addSql('ALTER TABLE schoolclasses DROP FOREIGN KEY FK_6629A8ADB403044');
        $this->addSql('DROP TABLE schoolclasses');
        $this->addSql('DROP TABLE users');
    }
}

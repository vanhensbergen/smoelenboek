<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20201229212504 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE schoolclasses DROP FOREIGN KEY FK_6629A8ADB403044');
        $this->addSql('DROP INDEX IDX_6629A8ADB403044 ON schoolclasses');
        $this->addSql('ALTER TABLE schoolclasses DROP mentor_id');
        $this->addSql('ALTER TABLE users ADD mentorclass_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE users ADD CONSTRAINT FK_1483A5E97431148 FOREIGN KEY (mentorclass_id) REFERENCES schoolclasses (id)');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_1483A5E97431148 ON users (mentorclass_id)');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE schoolclasses ADD mentor_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE schoolclasses ADD CONSTRAINT FK_6629A8ADB403044 FOREIGN KEY (mentor_id) REFERENCES users (id)');
        $this->addSql('CREATE INDEX IDX_6629A8ADB403044 ON schoolclasses (mentor_id)');
        $this->addSql('ALTER TABLE users DROP FOREIGN KEY FK_1483A5E97431148');
        $this->addSql('DROP INDEX UNIQ_1483A5E97431148 ON users');
        $this->addSql('ALTER TABLE users DROP mentorclass_id');
    }
}

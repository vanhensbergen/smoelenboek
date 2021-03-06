-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 04 feb 2021 om 13:48
-- Serverversie: 10.4.14-MariaDB
-- PHP-versie: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smoelenboek`
--
DROP DATABASE IF EXISTS `smoelenboek`;
CREATE DATABASE IF NOT EXISTS `smoelenboek` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `smoelenboek`;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20201211141559', '2020-12-11 15:16:54', 387),
('DoctrineMigrations\\Version20201211142937', '2020-12-11 15:30:13', 67),
('DoctrineMigrations\\Version20201227144254', '2020-12-27 15:43:38', 98),
('DoctrineMigrations\\Version20201229212504', '2020-12-29 22:25:37', 317),
('DoctrineMigrations\\Version20201229213339', '2020-12-29 22:34:21', 267),
('DoctrineMigrations\\Version20210102190129', '2021-01-02 20:02:00', 326),
('DoctrineMigrations\\Version20210102191123', '2021-01-02 20:11:31', 47),
('DoctrineMigrations\\Version20210102191609', '2021-01-02 20:16:20', 357),
('DoctrineMigrations\\Version20210204084338', '2021-02-04 09:44:35', 872),
('DoctrineMigrations\\Version20210204091144', '2021-02-04 10:12:04', 48);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `schoolclasses`
--

CREATE TABLE `schoolclasses` (
  `id` int(11) NOT NULL,
  `name` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `mentor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `schoolclasses`
--

INSERT INTO `schoolclasses` (`id`, `name`, `description`, `mentor_id`) VALUES
(1, 'AO_2J', 'leerjaar 2 van de opleiding. Er is sprake van een klas zonder differentiatie.D methode boeken werken conform het havo/vwo. Leerlingen die het niveau niet aankunnen kunnen worden gedetermineerd als mavo-theoretische leerweg en krijgen les op hun gedetermineerde niveau.', 1),
(2, 'AO_3K', 'Deze klas behoort tot leerjaar 3 van de opleiding. Programmeren op client-server niveau met talen als PHP, ES6 en opmaaktalen als CSS en HML.\r\nFrameworks zoals symfony staan centraal.\r\nDe student heeft kennis van SQL en kan een database ontwerpen.', 9),
(3, 'AO_3G', 'Dit is de derde klas van de opleiding, hier worden leerlingen klaargestoomd voor un examens en voor de stage.\r\nZe beheersen hier de full client-server stack', 6),
(4, 'AO_P3', 'De derde klas van de opleiding AO. De groep studenten is zojuist terug van stage en bereidt zich voor op de laatste 2 examens K2 en K3', 8),
(9, 'IB_2J', 'De tweede klas van de 3 jarige opleiding netwerkbeheerder', 7),
(14, 'IB_3Q', 'de tweede klas BOL 3 systembeheer', 124),
(15, 'AO_1Z', 'de eerste klas. Er wordt gewerkt aan de basisconcepten van programmeren en ontwerpen in de talen es6  en C#. Views worden opgebouwd in xaml, css en html5', 131),
(16, 'IB_1A', 'Dit is de kopklas BOL2 leerjaar 1. Zij zijn doende een startkwalificatie te behalen in de ICT beheer', 4);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `studentremarks`
--

CREATE TABLE `studentremarks` (
  `id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` date NOT NULL,
  `blocked` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `studentremarks`
--

INSERT INTO `studentremarks` (`id`, `author_id`, `student_id`, `title`, `content`, `created`, `blocked`) VALUES
(1, 6, 10, 'afwezigheid door rookverslaving', 'Giotje is erg vaak afwezig tijdens de les. Daarop bevraagd zegt dat hij even is gaan roken.\r\nDat kan echt niet! Hij wil dat niet inzien. Afgesproken is dat hij hiermee ophoudt en zijn roken beperkt tot de pauzes. Er is voldoende tijd om te roken dan.', '2021-01-02', 1),
(2, 8, 10, 'storend gedrag in de les programmeren.', 'Gio is erg vervelend in de les. Hij is constant aan het praten. Als hij iemand met programmeren helpt dan is het meestal van de wal in de sloot. De code die hij dan intypt wordt door de leerling zelden begrepen en is meestal een bron van verdere problemen. Gio wil niet luisteren daar mee op te houden.', '2021-01-02', 0),
(3, 6, 10, 'positieve verandering in gedrag', 'Gio is helaas niet gestopt met roken. Hij beperkt roken nu echter tot de pauzes. Dat is een aanzienlijke verbetering. Hij moet nog wel leren wat starttijd en eindtijd is van de pauze. Hij wil nog al eens te vroeg vertrekken en/of te laat terugkomen in de les.', '2021-01-03', 0),
(4, 6, 69, 'afwezigheid gemeld door ouders', 'De ouders van Raïsa hebben gemaild dat zij door ziekte niet zonder hun dochter huis kunnen.  Zij zal hen moeten verzorgen voor de duur van deze ziekte. Het betreft de moeder; zij is momenteel in het ziekenhuis en kot volgende week pas weer thuis. Ook dan zal Raïsa thuis nog nodig zijn.', '2021-01-03', 0),
(5, 1, 67, 'afwezigheid te vaak', 'Marcel is erg vaak een hele dag afwezig. Hij meldt na daarop aangesproken te zijn dat hij zelfstandig woont en soms moet werken om inkomsten te genereren om van te leven. Werken gaat niet altijd buiten schooltijden. Hij is overigens een leerling met goede kwaliteiten. Hij bezit veel kennis op programmeergebied.', '2021-01-03', 0),
(6, 6, 37, 'aandacht svp voor Asperger', 'Patrick is hoogst intelligent. Is zijn loopbaan begonnen op het vwo. Hij is als een spons. Hij zuigt op wat je zegt. Verwacht geen communicatie, daar op aandringen veroorzaakt stress bij Patrick. Doe dat dus niet.', '2021-01-03', 0),
(7, 6, 74, 'hoofdpijnklachten', 'Willen de collega\'s rekening houden met he gegeven dat Rashad veel last heeft van migraine achtige hoofdpijnklachten.', '2021-01-04', 0),
(8, 6, 136, 'verspreid dit niet!!', 'Daisy  is aanzienlijk ouder dan de andere studenten. Ze is zwanger verschijnt daardoor minder op school en zal waarschijnlijk de opleiding stoppen. De situatiethuis met Barney als vader helpt ook niet.', '2021-01-04', 0),
(10, 6, 89, 'hulp mijdend gedrag', 'Jacob kan het allemaal niet bijbenen. Het niveau waarop hij moet werken zit ver boven zijn capaciteiten. Hij hoort eigenlijk BOL3 te doen. Hij wil dan ook geen ondersteuning accepteren. Hij begint wel lichtelijk agressief gedrag te vertonen. Dat baat zorgen', '2021-01-06', 0),
(11, 6, 112, 'hinderlijk niet serieus gedrag', 'Jordy is een paar jaartjes ouder dan zijn klasgenoten en probeert excessief vrolijk gedrag te vertonen. Accepteer dat niet, wijs hem erop dat zijn gedrag storend werkt', '2021-01-06', 0),
(13, 8, 93, 'Gedrag in de klas', 'Ian heeft een positive invloed op zijn omgeving. Hij poogt bewust hulpvaardig te zijn. Probeert kennis bij te brengen bij zijn mede studenten en draagt bij aan een positief studieklimaat. Gesprekken met hem hebben geholpen.', '2021-01-08', 0),
(14, 6, 80, 'In vertrouwen medegedeeld', 'Socrates ondervindt grote druk van Giovanni le Grand. Hij wordt gedurende de pauzes en in de klas getreiterd. Laatst is zijn wachtwoord voor zijn PC gewijzigd. Het pesten is subtiel maar laakbaar. Houd voorlopig een oogje in het zeil, s.v.p en informeer me bij plaaggedrag Gio.', '2021-01-10', 0),
(15, 6, 77, 'punt van aandacht collega\'s!', 'Rashid heeft de overstap gemaakt vanaf BOL3 naar de opleiding AO. Hij heeft grote moeite om mee te komen. Hij is niet gewend om zelf na te denken. Veelal heeft hij geleerd na te doen. Dat kan niet bij AO. Geef hem extra aandacht met accent op leerstrategieën. Hij is van goede wil.', '2021-01-18', 0),
(16, 6, 145, 'thuissituatie: scheiding ouders', 'Na een onrustige periode met veel ruzie thuis, hebben de ouders besloten te gaan scheiden. De vader van Romano is vertrokken.Dit geeft rust, Romano hoeft niet mer te kiezen tussen ouders en voelt minder druk om de toestand thuis te pacificeren. Hou een positief oogje op hem.', '2021-01-18', 0),
(17, 6, 58, 'heet gebakerd gedrag', 'Stephan heeft kwaliteiten als programmeur, hij is echter niet benaderbaar. Elk gesprek om inhoudelijk te komen tot verbetering van coderingsstijl brengt het risico van emotionele uitbarstingen met zich mee. De enige persoon die Stephan kan temperen is Danny. Wellicht raadzaam om met Stephan een traject van conflictbeheersing in te gaan.', '2021-01-25', 0),
(18, 6, 15, 'afwezigheid bij rekenles veelvuldig', 'Samir skipt met grote regelmaat de rekenles. Daar op aangesproken zegt hij dat rekenen makkelijk is.\r\nHij zal ook rekenen in context moeten kunnen. Dat is nog maar de vraag. Wil iedereen Samir wijzen op zijn verantwoordelijkheid dat ook te kunnen.', '2021-02-04', 0);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `schoolclass_id` int(11) DEFAULT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `motto` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `users`
--

INSERT INTO `users` (`id`, `schoolclass_id`, `email`, `roles`, `password`, `firstname`, `prefix`, `lastname`, `photo`, `motto`) VALUES
(1, NULL, 'm.van.der.linden@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$TThUQ2Y5cy5Ody5Bc1hrLg$4vi1yV7mVOst2xP+fnVafxtu4xha4PmTL8fepT5F29I', 'Marcel', 'van der', 'Linden', NULL, 'Over 5 weken begint de stage-periode. Maak je project af en lever in.'),
(3, NULL, 's.bliemert@svjit.nl', '[\"ROLE_PRINCIPAL\"]', '$argon2id$v=19$m=65536,t=4,p=1$OXA3Ym5LNDg1L0tmUFVCZA$WoJhkHD43IiF9GFwl06ySVp/9Miu4KJ5SRb1DnNQQ4E', 'Sebastiaan', NULL, 'Bliemert', 's.bliemert.jpg', 'Ik ben de directeur van SVJIT en ik heet u van harte welkom op onze opleiding voor enthousiaste jonge en gemotiveerde programmeurs.<br/> \r\nOnze docenten gaan voor kwaliteit; onze studenten ook!\r\n<p style=\"font-size:1.5em\">Ik heet u welkom!</p>'),
(4, NULL, 'b.van.halem@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$cG9JYkRIblhBcjBjazIwTg$mMzdfUZThewJHeU/KX3q1SjnQft7fhrd47oZ41zau8I', 'Bart', 'van', 'Halem', 'BHalem.jpg', NULL),
(5, NULL, 'r.van.rossum@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$WUZ5a1gwN1NsOWRvWWZkQQ$4v7BsUYl8D5WvpB6x+fADQpQR/GmkoYMyxJsP2kCSDI', 'Roel', 'van', 'Rossum', 'ROssem.jpg', NULL),
(6, NULL, 'a.van.hensbergen@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$MGtuc0NyVGM5MVlnRm91MQ$8zu9PUQBJQblhaAHO22DdP1e9xDUq1YEHMlA/xv94l4', 'Anton', 'van', 'Hensbergen', '1368653662.jpg', 'Beste leerlingen, jullie zullen 25 februari het examen K2 moeten gaan doen. Ik verwacht dat jullie allemaal een korte zwakte en sterkte analyse in de database plaatsen, maximaal 300 woorden. Deze analyse zal ik gebruiken in het mentorgesprek van komende week. We zullen dan samen afspraken vastleggen die de kans op succes voor K2 vergroten. Ga nu je analyse invullen. Ik zie je binnenkort; jouw analyse is nodig voor het gesprek! Wees eerlijk en zet concrete zaken neer. Het gaat om jouw toekomst!'),
(7, NULL, 'w.stolk@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$UnI2TExFS1JYc01sZFJjeQ$nbzwyRPlC/7oYf+ANshoeVgmga2R2FuooAL/sHeP5+g', 'Wim', NULL, 'Stolk', 'Stolk.jpg', NULL),
(8, NULL, 'h.kool@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$NU55UjVRYjAucDlQVmdvSQ$D3z+XFAOZ/khXlWRpqIjQjfC/j3lS480ADF/4HXenqU', 'Hanneke', NULL, 'Kool', 'hanneke.png', 'Nog even doorzetten. Het examen k2 komt er aan. Ga er voor...  Ik wil graag een laatste update/analyse van je eigen sterke en zwakke punten. Zet die analyse in de database. Kunnen we ons aankomend mentorgesprek mee nemen. Dit klinkt vrijwillig ... maar je analyse plaatsen is verplicht!  '),
(9, NULL, 's.bechoe@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZnYxY3Q1cWtRL1VYVUZPbw$rf8LEJrn/JmVEtn3E1yfLKrVPI1IuF61O8Ff8C7TkNg', 'Saphna', NULL, 'Bechoe', 's.bechoe.png', NULL),
(10, 2, 'g.le.grand@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$WGpxcmhWUy9DbmJ5d1lGQg$Di8gyQglIWqj/bKoss8CIcCI799OQ6D41clCGk/p9jA', 'Gio', 'le', 'Grand', 'gio.le.grand.png', NULL),
(11, NULL, 'c.bertels@svjit.nl', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$Z3RlSzFBQXRkYVNSQVoxRQ$fimoE+FMfyssPk0Gq9oI5u7kQMcv7DSKtZmgCSHUaOY', 'Carinda', NULL, 'Bertels', 'c.bertels.jpg', NULL),
(12, NULL, 'a.valk@svjit.nl', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$Z2dtZnVpMUwvWGxSY3FpWQ$19ViLKRlMeNk4UXz9+lAdd8lEyWzCyT3JFw4S7M0xHA', 'Angelita', NULL, 'Valk', 'a.valk.jpg', NULL),
(13, 2, 'j.de.wolf@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZHdqdzlDWWx0SVFVcVdsWg$rP9UFJLXNLhvQeZH/M9ZDyuL69IMzkPl6F0PefOA/BI', 'Jon', 'de', 'Wolf', 'jon.de.wolf.png', NULL),
(14, 2, 'o.dokes@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$MTRYWG1mZXVlNG9meDdGQw$XRbsf3A2dVkcH+G7IQIe+qj4Uew6L+TLvxBxeVSeaoE', 'Okkes', NULL, 'Dokes', 'okkes.dokes.png', NULL),
(15, 2, 's.alieev@sjivt.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Qmc5MUlsZjAzdTI2b09PSg$VycVof+YUMfz0meIRn3dTALrLmDEjMaMz80lePjU97A', 'Samir', NULL, 'Alieev', 'samir alieev.jpg', NULL),
(16, 2, 'r.chandoe@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$dVpqTjc2T1hFbmVTZmRObg$mRQCHzKqcnnvY5eOWrGH83T/P+XXNFRTBcsAQaOFMjA', 'Rahiem', NULL, 'Chandoe', 'rahiem.chandoe.png', NULL),
(17, 2, 'a.damaran@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$dnVlLllqczBiWGZCUmVtOA$jtg6jAZ2G6fkDyLCeea1x4aCPIVntBwAkLY7bviJcCY', 'Armando', NULL, 'Damaran', 'armando damaran.png', NULL),
(18, 2, 'b.de.neve@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$REtyQ0Fjc0VLcE4xV29Hag$GQajhL5r298eI0qKWISpaHSv0Jaj3pVel02PohZ7Fr8', 'Boris', 'de', 'Neve', 'boris de neve.png', NULL),
(19, 2, 'e.van.de.kaai@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$N0wveWtYbXZ4ZzV4b29sRw$fG5DcXN4La3ws+FzbQtSeas8SdKP1tEFTbs+Ovnv134', 'Erik', 'van de', 'Kaai', 'erik van de kaai.png', NULL),
(20, 2, 'j.haaring@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZVhJcnpHSUJMTWpGN2dIbQ$/MRPc1AzXvQGvWogeMEJa0rwW2ifeEAtBR8EN5io1Dc', 'Joey', NULL, 'Haaring', 'bbfef3b0f8a0bf97e295c15fdf70e7ba001.png', NULL),
(21, 2, 'm.barut@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$L2c2ejlscHRJRFpUNDdrNw$5hJ9VEFeD8/K1kEiiSbIEd6gxMV3J+mJP06RR7Ravds', 'MIkail', NULL, 'Barut', '207dce166f042562b98c7a5fdf716ad7146.jpeg', NULL),
(22, 2, 'm.ashikali@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$M05LTklzQ0U4UjlVb3JqUg$+nSrN1iY4aA5Qi/O1pHxT0/7oJkdP/0m7p3+T+SmSRg', 'MIchaël', NULL, 'Ashikali', '7b0ae3b8418e32ade56c005fdf7303241b6.jpeg', NULL),
(23, 2, 'n.unal@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Vi9EN3BaTURxRGdhaFUxTw$JNL7fWGHhRjGVyRMzZ/tXLYr6nfK/wktm4meLs59NqU', 'Nejati', NULL, 'Unal', 'ece73ee7ab17950ff9c16a5fe097e999887.png', NULL),
(24, 2, 'r.benoit@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$a21sRGprQ1lFMVk1ODNONw$RNcEQe9d4l0/CNKVd03IJHRf9cZ7+lwD/UxXLHSgmMo', 'Roy', NULL, 'Benoit', 'daa3bdc650e5eb69623a605fe0997fd9a1e.png', NULL),
(25, 2, 'j.tiebosch@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$RU1SS1VxTXVBNHAwUi5Mcg$6NJ176vmqzepH4F0qacJkb1HZwTNHT57BzDJF5qIYgo', 'Jeremy', NULL, 'Tiebosch', '424dc0ffb1c3ae492b8d115fe0a2015931c.png', NULL),
(26, 2, 'e.sjamshudinov@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$NnFOb1U4cHgxdnRpc1dFVQ$++WRoTvHeDL0Rq9lOzex1xbuOXLnXYOaADNTSPDqHcI', 'Eljor', NULL, 'Sjamshudinov', '1df15bbf69eb354205b7765fe0a4b8f246d.png', NULL),
(27, 2, 'l.van.spronsen@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$c3hteUEzTGM4Sy5kTjVUaw$ALtY1wrMtREjW8IAxa7Da5aA6QiejJJBsaI2bN27E8M', 'Leroy', 'van', 'Spronsen', '16decd275dd855c9ceb2db5fe0a4f9ead3b.png', NULL),
(28, 2, 'm.van.vliet@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$SDZNYVVobEhyTjVjaHoxdQ$ZoC1had10pp2T/WNzpOiwtH0iB7n0HBtUJUmrYvO3l4', 'Marien', 'van', 'Vliet', '128c579e26c0d20588331d5fe0a541844ba.png', NULL),
(29, 2, 'n.willemse@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$dmw0M2NrUkxpeW9DUjdaRw$7DMWRmpX6jni1L1YIm1ufFiIoyDY6kRRsy4Yqg0vtSY', 'Nick', NULL, 'Willemse', '7a8bfe7de0251ca1b40d605fe0a5f66c91a.png', NULL),
(31, 2, 'r.roesmal@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$WWFvQkNqSXpxUkpNcGxyNw$9iKhN3Vjs3S0yYyjB+7WI9Zn7zlSFlHu2laZTzkyyjE', 'Roy', NULL, 'Roesmal', '320e33aa14517446a357165fe0a67b8d141.png', NULL),
(32, 2, 'r.spaans@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Qk51TU5TVmNwWUVZby8zZw$jSHPAu3ZXUtok4zo/m3KBM4tnnoPOVFhFKVI7SquGqU', 'Robert', NULL, 'Spaans', 'a91d46a2904ee2a82db5435fe0a6d36ba9d.png', NULL),
(33, 2, 'n.van.rijn@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$bFZFWUR1REFxQ1BaTTVrYQ$mj2kaVMJQsU7EdWKIaMnWlzoMgVxOlavEfw1raIhbR8', 'Nigel', 'van', 'Rijn', 'dec6908fddc93a2cd6207d5fe0aa3a80bdd.png', NULL),
(35, 2, 'd.nieuwmans@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Vk1HNlR3TEltMlJWTFNJag$TO4+JWxHeENMy5GAjEKnIjSfOgREsuj+60oHz1qc1b4', 'Danny', NULL, 'Nieuwmans', '39a4575dc4e201c1888dd65fe0bac5a4139.png', NULL),
(37, 2, 'p.van.der.kraan@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$LjlvN3ZpdndDd3N2UG9BSA$x1k3nTnTlh1f4p8+/t1I3SxI+XE7WbRMZh0Rk4p/lOQ', 'Patrick', 'van der', 'Kraan', '27902e30bf4b08bfcf22135fe0c0c342d5c.png', NULL),
(57, 2, 'k.van.houdts@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Y3paLjJrcXQvUVdUdk1ZSg$MD0/P95NkGA4R51Vn28lwGqjr/ltjY2ownJlOjbl/Rs', 'Kevin', 'van', 'Houdts', '298582e34f5a5403b8ea6d5fe0da858211e.png', NULL),
(58, 2, 's.van.leeuwen@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$UXFMOGRXc0hTYUtmalN4UA$qFufpvC0xpq/prjHO3Otk63uOdyVTNLNjIwOABJURT0', 'Stephan', 'van', 'Leeuwen', '55474abc8b1d6ffd89c2f65fe0db356797e.png', NULL),
(59, 2, 'r.schokker@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Y0gxbXpFbGhYYTM4dC5ESg$dxJd9CTd+k2vAO5KQIr0KM6o1qAT4NIvsR+k7yu0cZg', 'Rickardo', NULL, 'Schokker', '07252be30aca434786e3fe5fe0db879db03.png', NULL),
(61, 2, 's.willemszgeeroms@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZzB3T2s5bEc2bUJpSVpJSw$ME2BNYjvSb4L9ONKuc1hkXSpPs+pcA4eX3XvkAYiF/Q', 'Stefano', NULL, 'Willemsz Geeroms', '17fed65973031f75c1b84d5fe0dd4f220c5.png', NULL),
(62, 1, 'g.enache@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ay5mQkZDMG5MMW9JNjdFbw$PDwoJgMusNQT3y+qH6lpaGhefJb588pLleUUdKsrOSY', 'Georgette', NULL, 'Enache', '6e2781abe2e8f4c928951b5fe0f100cff45.png', NULL),
(63, 1, 'j.van.wijnhoven@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZTF4YmlsRkgveE5hQUdlUg$f0cBVCh2qbVIh/FP+fCjY2v78sN4ekIrXjiHejoe2Os', 'Jimmy', 'van', 'Wijnhoven', '62df4e2812a316d8ab38c55fe9fad23c239.png', NULL),
(64, 1, 'l.van.ham@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$cFVyeWhxb0pqMVg1a1MybQ$3L6TvKifh9HZS0MHtMBMN7v3Uz3JEhhrQPLZJniguhA', 'Levi', 'van', 'Ham', '9e555d334f667a342fe6355fe0f169e4e69.png', NULL),
(66, 1, 'l.van.der.toorn@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$MTY0V0tkYzNKRHU0ejZwSQ$gOuFCiDOh2aQphLH9Cq+G2IWxmTCWQJIBZ8dke6CqB8', 'Luuk', 'van der', 'Toorn', '35005562481008ea2658b05fe0f1c1db493.png', NULL),
(67, 1, 'm.guth@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$V1Zucm9pUGtvREUwTW1TRQ$FPdlEPy8kAypxw4JiHJXPY/B1JtgRpTj9lM3g2RN4dk', 'Marcel', NULL, 'Guth', 'd272659125899f58a0c3705fe0f31ff20aa.png', NULL),
(68, 1, 's.christ@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$U3pOLm40THUwa3ROa2VNNg$OA9rlBWhpUK6O8XM0lEkGhxZQE8J2yVAA0C2JilmpuM', 'Stan', NULL, 'Christ', 'be542c925c81dd0e47852d5fe0f3653f548.png', NULL),
(69, 1, 'r.barsatie@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$NkJYLnE5V1llOUVRRnpZRQ$D6kRsvZJQBq8cXM7kzQ7aBdh57xRH9QU53Gc0Xo3/MM', 'Raïsa', NULL, 'Barsatie', '3e025b788ffcb2d550a3725fe0f48a3792f.png', NULL),
(70, 1, 'v.badal@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$T1p5NG1BTUJUeWNKdEVKUA$Y5lNhvk8oY7Q+H/6dFGx7sFTcoOuH9qDcHLxlE74kUI', 'Viren', NULL, 'Badal', '55b88bc2d094848776f0055fe0f4bb38829.png', NULL),
(73, 1, 'c.cakmak@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZnBFWkJPenBHWHN2ZzFNaA$38ZqnYYp93H+5OJhEE+QIr2RMCOZRTWT+UvTmtjDSIE', 'Cem', NULL, 'Çakmak', '7be825f5bafe69c0060f9d5fe39da4ebf00.png', NULL),
(74, 1, 'r.sahangoekhan@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$QlU3T3gwY1hpTFE0OEhQWQ$aN35XCqNlI9FQroAD+uSQKSp5UPTAaOW9aE4OpvjUBo', 'Rashad', NULL, 'Sahangoe Khan', '1aea4b5c6b0af93b1475955fe39e786320a.jpeg', NULL),
(75, 3, 'j.de.wit@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$d0RWVEJoRjVvRWlaeElnaA$qAXhYcJjqbBV1r7behkSB0KJRsQPdO6wuka/tGvv82A', 'Joey', 'de', 'Wit', '1dd3c879dd970dbb8f83225fe3cf0a5340e.jpeg', NULL),
(77, 3, 'r.mamudu@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$NG9ybW9VMDhvczJqRmhNcw$dxnrHMk9sQGlM/ZBFp5QYAuuoU8TsObPfAeO2yBxMCA', 'Rashid', NULL, 'Mamudu', '73f02b4b6de85cf2b0470d5fe3cf7d069b4.png', NULL),
(78, 3, 'r.den.heijer@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$TDFxbWd4LlNLQUQya1JDVg$hs7mbLLMWf4l5ltltIJTIfS1/JF+2MW33gLl0F24yuk', 'Robbin', 'den', 'Heijer', 'd8719233a38d1f444b82875fe3d5e05c23b.jpeg', NULL),
(79, 1, 's.paassen@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$VFo3N01ubzlDUmRCZHBNNA$46j8FeDQay5oW6k0zl2ClPUvKCsNHgAGhZngbdHohqw', 'Sibren', 'van', 'Paassen', '8e58627d5da477fac86b3c5fe3d61819e72.jpeg', NULL),
(80, 3, 's.cotomatey@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$bkpBWWlnazRTSWduMGRYZQ$kzerxdd3ECkJ1we1k3bdn+blH933LwTwAd4eTPfcy+8', 'Socrates', NULL, 'Coto Matey', 'ac5d62b054f91e7edc02985fe3d67fd27c7.jpeg', NULL),
(82, 3, 'e.besic@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$VXpybUZRZEp3YmhRUzBKNQ$5iGhCexseJ4dbdWMK7O20LkbhwZy2VWePaeEiufbuBQ', 'Edo', NULL, 'Bešic', '21d373cade4e832627b4f65fe5fd218eba3.jpeg', NULL),
(83, 3, 'm.v.d.burgh@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$UFVTMlk0b2J3U3R3cURQLw$5ZJq2P+SmLpUcR226iM4JA3+ih3Ncj17+Od1O/9KsZI', 'Mark', 'van den', 'Burgh', '05b9033196ba818f7a872b5fe5fe7079111.jpeg', NULL),
(84, 3, 'a.kurnaz@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$cTJVVk1ZMXlHeS5xVVBsSQ$bzedLoOtpKIFrgf5LYIojnMy38LXbacl9GTHnmSZtD8', 'Abdul', NULL, 'Kurnaz', '69000262e398418be022455fe60077b7995.jpeg', NULL),
(86, 4, 'n.lahmidi@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZkxQS1VJS3hpWmJ4OUhuNA$YcWuBe6ZaKK3Cd1IYMmGMJlqVl2jufMCrTE76vGUBSY', 'Nassiem', NULL, 'Lahmidi', '2c1e3124cffd67d48194685fe63c3121d2a.png', NULL),
(87, 3, 't.sahin@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$S2xCTnhLZExyUUVqN1lPZA$KGmjXKhBRjwtMp+0BsG5lI+Sr3Bjpkq5dJ6zRrZ+zMQ', 'Taner', NULL, 'Sahin', '6aaf53ee9a8096fa6c11525fe74594ef9ae.png', NULL),
(88, 4, 'a.efe@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$NnpSZ3EvWm5qZC4zNC5TTg$iDDV+X81kGu6Xq9NM+DXOn/L/RX7HmKabRwdalldK40', 'Ariyan', NULL, 'Efe', '4207fdc7c9628927c4836a5fe7494b67216.png', NULL),
(89, 4, 'j.farhaoui@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$eUFwU2ZuT1lXeVpXZ0JLTg$+UgnWp8QZdQXwdgV4/TX+VgC2MD8ddoobdDz8l5ug4Y', 'Jacob', NULL, 'Farhaoui', '6072f535a6a98e652565765fe8af4fc905a.png', NULL),
(90, 4, 'b.al-assbahi@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$T1BaQ3BjUTcyUG9JT1pxag$sODq/AeUmL6THn1/9uTzRbME5IehcLyVndCSxlB8vCk', 'Boraida', NULL, 'Al-Assbahi', '61cbc3d74eb2dd9b2ce4ba5fe74b1ea85f2.jpeg', NULL),
(91, 4, 'j.zeeman@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$YzVac0VsSWExWjZHWVYuaA$Y4BUSGluznlC1UmhSptkvNm08kyJEqOJNIulFN4sAqo', 'Jesra', NULL, 'Zeeman', 'c53717605fa27b50b689db5fe74cdd1d31c.png', NULL),
(92, NULL, 'n.taal@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$MDQ1VW1iUS82a3REMmE0UA$eMspDVVd6LLJSKpfepYEqGCtWNVPg7nFEtjgWyZm+/0', 'Nathan', NULL, 'Taal', '6804db930fcf3c28f4de975fe74d587b24b.png', NULL),
(93, 4, 'i.gerrebrandts@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$RGFiQVZuSkRENzdBMFJXeg$IaFbO45z7Wako1a+Fh8OOYGsTIJmSQzTZeWjb7ZxWnM', 'Ian', NULL, 'Gerrebrandts', '649c2e3a5ec704579213035fe74d941388a.png', NULL),
(94, 4, 'r.sachetramlal@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$UHF4ZUhYVHNjNjhEMVFxWA$bMG/Qt8JTQweWhpGDK4JAfUMX9n9RtB0jyCQw+30qU8', 'Ruchir', NULL, 'Sachet Ramlal', 'b318cfa118894c34f82b885fe8812a1ecf0.png', NULL),
(95, NULL, 'r.jainandan-jha@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$eXdMWWJzM3lBTy91U1VmNQ$0xnD7Pi6rGY3eGbAEHI8lZhsua415Y/f7ppx0sQGa9g', 'Ryan', NULL, 'Jainandan-Jha', 'dd2f64b9fb935f4a8c0d7d5fe8850113893.png', NULL),
(96, 4, 'j.vojczekhovskiy@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Q1pGZXhUSFM1Zjk0NDJHSg$EDzRg887iDhCVorwqu0nKj4VK9qzBuqE5DGjsWItC9A', 'Julie', NULL, 'Vojczekhovskiy', '8392a9a3e2c4b24c9552ff5fe885bbc257d.png', NULL),
(97, NULL, 'o.laghmouchi@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$M3FzSWxjVDB2Qnp4Wll1Rw$B8PTUO8uZ0NZ9rvSVnO5yQgFtHUjIrOTKbFTvmdi8Ms', 'Oussama', NULL, 'Laghmouchi', '5de3ee8d8c75483265e2ba5fe8872745653.png', NULL),
(98, 4, 't.chi@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$SWs3V3dpcXN1TG1sMzkuRA$QTw4KmVmtULb674eoGskWRVAc1Mc05Eql22PGBkU0s0', 'Teng', NULL, 'Chi', 'c07b0532406b19d8821ba55fe8878605b7f.jpeg', NULL),
(99, 4, 'c.van.dam@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$YVNKSTVya2xuaTRhYnU0RQ$8spnZ1WPkpLEcYE5L/f0yCv5z8PcFr/GAC9tIBb79Rs', 'Chaddy', 'van', 'Dam', 'd770610e2e2c00108f0bbe5fe898373ae01.png', NULL),
(100, 16, 'j.lo-a-foe@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$T05HNk54UkZXVEI2aVhNMw$WIYthDKcZaiPU31mlvjofwmO7DBcUbsQsKS4s+jlL4c', 'Jeffrey', NULL, 'Lo-a-Foe', 'ed9946f4f0740d53e80f885fe898c71669a.png', NULL),
(101, NULL, 'j.van.den.bos@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$aDdSNHFjYUFTVmUyYUpZdw$39qniStjP5AfCH8uDpTw8YDheU+cJDKT3X9hppi+/VY', 'Jeffrey', 'van den', 'Bos', '8ab564a789e58f1b576ab65fe8992ff2333.jpeg', NULL),
(102, 14, 'j.uilhoorn@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ODdQcWFRWE5ISEhBLlhTLw$i5qm/OKoqyQwZwyUVztv0nrjM9lvy9QDAWllmJND/eY', 'Jeroen', NULL, 'Uilhoorn', 'c90625c7655ef566536fa85fe89993c970b.jpeg', NULL),
(105, NULL, 'j.den.brabander@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$WXBRcnFjSTJOVEFUQnY2Tg$Cz6qufFbd9CaWsV+6tjaNHGAkWVjO69Q6R4oFbGwYtA', 'Joey', 'den', 'Brabander', 'a3eedea0964c33219bf7975fe89b148dd6f.jpeg', NULL),
(106, 16, 'k.ruinaard@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$bEhPNzdydjVlazNTTGxmRA$NZMUyJuZsEpl2ubmQz9RR95AsL11CENh87JRUnSZuHY', 'Kevin', NULL, 'Ruinaard', '2dd4aca3941d162a557f235fe89b6f312b7.png', NULL),
(107, 16, 'z.ulusal@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$OXBOUHpaVmxXQklMaFpVYw$IZJnrTcM98+jHkWxzdkaS9WZF1OC1qwT7nET6FY5qko', 'Zafer', NULL, 'Ulusal', '06c1d8c687d789891b72725fe89bb63a4d2.png', NULL),
(108, 9, 'c.bayat@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$TGxjMzZ4cjhzbHFlN1pHZA$wlDaWLbjTFQBs8XLdoIaDjQDp3MKCZG3mmqEiS3gsVQ', 'Canberk', NULL, 'Bayat', 'abf1e97fe0099cab136bc05fe9c5174363c.jpeg', NULL),
(110, 9, 'd.de.jager@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$U0VIS2Z2SGlxMjFHRVpELg$Y2Cho2LubPNfxR4FDDlS3vQ8dElCsY1e1n3oMG63nHc', 'Djeysin', 'de', 'Jager', 'bcada47c764dd9050f3b1e5fe9c5eb27578.jpeg', NULL),
(111, 9, 'j.marain@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$N21WSWNMZUZOVE5sWXFCZw$rtzD3jAOfifzqDcvWyY6BxKR12Ypr+nNWQ1Dc57qVII', 'Jermaine', NULL, 'Marapin', '1ce2a90c7b78da5da8d27d5fe9c65f8853d.jpeg', NULL),
(112, 9, 'j.spitters@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$SHVqNmtBbkpha0R5TXRjUg$GTrHOQGi7IIFOdFRY0G85swr0ibfT3gfU/f+OdB2O0E', 'Jordy', NULL, 'Spitters', 'f9534732f45c325ad3defb5fe9c6cd44e2f.jpeg', NULL),
(113, 14, 'j.van.dam@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$dzdzazBYMDF3aW9iVk95Tw$jWgr1TZLCpmJAseoYG69rZLQq6Ko2nIzvt1dQv7Y0Fg', 'Joeri', 'van', 'Dam', 'fafc8ad37d84952bd0e3205fe9d011b94e8.jpeg', NULL),
(114, 9, 'j.roos@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$MFJGckR3cFlZc2doYnhPQw$BygGeKtuWtB0/WNgZT9bdtldLO+ZN20iBmCGr2B0kxk', 'Joey', NULL, 'Roos', '55e82bb454aaee095a59405fe9f3f100af3.jpeg', NULL),
(115, 9, 'm.vlaardingerbroek@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$STk1TVJEcVNRdDhLaDI1Ug$vfRF9wOsrvyHVeKWUw1V5pF8DU+wlcgdBVXSXYj4OCI', 'Maxim', NULL, 'Vlaardingerbroek', 'd1b4efae11385cda0aadf25fe9f777dc465.png', NULL),
(117, 9, 'm_van_der_linden@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$cTNqajE1RkZYc2NDMWlNdg$4hieb3T8PaJEBVczG2NmVLqqtGCl/WpoGNkVnHVHOYQ', 'Michael', 'van der', 'Linden', '376c10382d23de982a56465fe9f8fa64e7e.jpeg', NULL),
(118, 3, 's.kleinmoedig@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Mm1DUEhwM2ZYTXlXem1JZg$16zFm28kinOVZGA31mhB2xR2mnD0Dg/36Q+BfqdUmUw', 'Sigmar', NULL, 'Kleinmoedig', '543656105492e5dc664a9d5fe9fd7aa3252.png', NULL),
(119, 3, 'j.van.der.kleij@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$UVcuelFCdnJ1SXJWLzl3cw$D+Ol7kciIz/BkyTTkzJbJ8zlFfP5qI6GMCVx9wPcSFc', 'Jaco', 'van der', 'Kleij', 'eff2950fdc14aa196967ea5fe9fe4730084.png', NULL),
(120, 9, 's.chote@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ODJtTzVOdFMxUElaZ28xTg$Pwtxe3AzDEjZtOnveWovZ9uktxde5R4RyXFFhrerRqY', 'Shaheed', NULL, 'Choté', 'c4e87f5d55487fb34e59fe5fea328638f4c.jpeg', NULL),
(121, 1, 'h.taskirmaz@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$T0dWSXJvM0taOVFtYUxDMA$9BGTdfdfMUudcJI0lIMC2pLnwuQWx3GvJfX3PERcswE', 'Hakan', NULL, 'Taskirmaz', 'f35aacf16aa980886aeb635fea3605e140c.png', NULL),
(122, 2, 'h.van.holsteijn@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$UUcvU0VyYjFISUVGOGFteg$wDdb7jq4MSXbKOdVtAtBrKKvqrKplG3o7UuwAYojwqM', 'Huub', 'van', 'Holsteijn', '7914a96488431d19fe34745fea3650e3398.png', NULL),
(123, 2, 'v.van.ruijven@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$aDhPV2NuUWhvazF3YXB3dA$m53vuvcVteM1LvPqSPftJWF49X5yjQlhNxZbj19ZkfU', 'Vincent', 'van', 'Ruijven', 'e24938f4a8532eee37fdaf5fea36b41b29f.png', NULL),
(124, NULL, 'm.rotteveel@sjvit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$dEVQZEtPVzEyNEczclVDTQ$f+w8eGJ1qm+2/OfRVW5jkpqNdqV3X1arkvZcRsMjY/Y', 'Martijn', NULL, 'Rotteveel', 'rotteveel.jpg', NULL),
(125, 9, 't.verbraeken@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$OVNqZlMxZ0xxejZaa1UxUw$enVS8o1CGZSXmb2utqMuHoEqeKhayjctPs8mxTRq4is', 'Thomas', NULL, 'Verbraeken', '052fca4e77424b5603fde65fea467c95eb8.jpeg', NULL),
(126, 9, 'n.sewpal@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$dlNBOVl5RVBnNmVFdk56bA$2Pyp4XpaEi63NctmTDt/Qyxsun/SVObymFF3kxLjkJE', 'Nishad', NULL, 'Sewpal', '39cd89e3359f085502a6935fea484c94cd2.png', NULL),
(127, 14, 'm.van.der.kooij@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$RzdMc0YuMk9YbVJnUU9KWA$o9tnuEBIlromK2GougO9QL08ilcNxfWVZq05+iQE7XU', 'Mike', 'van der', 'Kooij', '6f02581773ca4350fb05b65fea5a4647a11.jpeg', NULL),
(128, 14, 'm.heesterman@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ck5ZWXZCSS5nZHlndjMzeA$9c9/m78eWEaFWZ3VVo3oUliZjotXXnF87bHh25zz9Aw', 'Mitchel', NULL, 'Heesterman', '22fe3bd6acfbc2de3917dd5fea5a89a7b15.jpeg', NULL),
(129, 14, 't.schouten@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$RVNMcnNqZzVTWUhNZFIyNw$UvcMxU54N2zNSCiB5M2i8ph7J0iH3opfN6rtwT6skpE', 'Teun', NULL, 'Schouten', '535646ec213c6ea24d015d5fea5afee2488.png', NULL),
(130, 14, 'm.berkhuysen@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$TW0vaGJ4M296QjVCQnJ0SA$ojnclVf+1JTAFHTJUB7nY7uIC9FvIiGpCyTnr/bDX3E', 'Mike', NULL, 'Berkhuysen', 'faca23d229bc1aec06d88f5fea5b559d4c7.jpeg', NULL),
(131, NULL, 'r.springer@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$amliSlFIWFZPSnBLVzJYdw$c1BosKruRGQftXiPBFLNmwY86Rd8mJZxDiwn2Qzk0wE', 'Roy', NULL, 'Springer', 'roy.jpg', NULL),
(132, 15, 'p.van.dijk@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$VVNGZHBnRzVPREhtcFRtZw$ghCkfHYURnlKJVwfoUhTdE1BSEfgRvvVtH56PagG5cY', 'Patrick', 'van', 'Dijk', '236f1a9fdba407df3bc2fc5fed0b0ae9788.png', NULL),
(133, 15, 'm.bruens@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$eXhZVGRsMmMyRFRmSXJ5eQ$W72VXtarUnN4vL0I0E2s+9wgW6rBw4MYaJWVMOAKiJI', 'Melvin', NULL, 'Bruens', '967f15cdbd0515a5944acb5fed0b4924cf3.png', NULL),
(134, 15, 'm.fakkel@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$N0NHSm1PQzhaU1lBODZJdw$q+4aZkWEjqM6lKtob24W0Db4GlXUZamzG0MaK/OlPcM', 'Michael', NULL, 'Fakkel', '1b654817b4fc9d18bdbaa45fed0ba71c15d.png', NULL),
(135, 15, 'r.voorthuizen@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$SFQuVmVQeWNFS3BVS1BXRA$T0r/v2P3zMERLnsucyrTqhTXWiOOwcDAL7NJJ/Drm5w', 'Rashaad', NULL, 'Voorthuizen', '03a022409544aa35fb68ac5fed0c19e0795.png', NULL),
(136, 4, 'd.van.barneveld@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$MURtQUM0Tm1BMjZ6UVlZUA$xEXCPOMPD8tOX8BDW5ULEfPguSZ+P1oTKtpGodMNhSQ', 'Daisy', 'van', 'Barneveld', 'ec5689f3586cc615a0ce965fed0d120d5bd.png', NULL),
(137, 15, 'r.kertosari@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$NEZtNkZsZEsvME5VdDlWMQ$puMzb2qHp/j/HduCuyUbSGjg8ZN/je5aV1irPi1R/Mw', 'Ray', NULL, 'Kertosari', '61a9d3bee9dca8bf4d02c25fed0e80a13c1.png', NULL),
(138, 15, 'm.herman@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$d3h1SWxuYUVwOGc0YldhNw$e0mP91JMxzbhRvOK2vLgCK/qh2OP16XfiP/TZY8+VQw', 'Michel', NULL, 'Herman', '131b16b30ff9a009b72aba5fed0eb765594.png', NULL),
(140, 16, 'a.tromp@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$T0FzcGJEQVpPSHVBeEczcw$Ix1f9cx+P2Buqk1/bO0BuCPbAcgxIkY5seC/l21e6UA', 'Ashley', NULL, 'Tromp', 'b16eae3f64ff94468098185ffc5b88eb0d4.jpeg', NULL),
(141, 16, 'a.girgin@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$QkRYZWFSSkU0L1c2c2cxQg$jhTLxaQo/5N06tem+kT/MP9SjuTlQhGEV+6hXEIygaQ', 'Aydin', NULL, 'Girgin', '40998b7fefe07f3942f04a5ffc5bd9a1adc.jpeg', NULL),
(142, 16, 'c.sala@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Li5SbkFaVEpvOW1PR1FLLw$Itf91LT18S6QDuhhbsSGKRFvl3GO55FgBisPolUp40c', 'Cheriff', NULL, 'Sala', '981da8512971097fa9bc7c5ffc5c0ac239b.jpeg', NULL),
(143, 16, 'e.jarakji@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$SzJ5MW4ua0NjOXhWN2g1bA$x73xjS78uO2OszGwOopg32ljdH4XKCdY5K1Ln31r8PY', 'Ebraheem', NULL, 'Jarakji', '28bec94c9490f99cb932975ffc5c5b4647c.jpeg', NULL),
(144, 16, 'e.hunady@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$UTNpeUVESkE4R0R4U082bg$GTFUxVqRzssFeBPkQlxJurbWgTLMgDJKcSQW+Lz73Ks', 'Emil', NULL, 'Hunady', '5545ae7689c784deb975b85ffc5c981057a.png', NULL),
(145, 15, 'r.sommer@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$UnFRZ0lzdE9Qa0pISHlGcg$Uc5uxsYunqreFij95fbIl6JU4k08j+ebHTgO7VGWpU8', 'Romano', NULL, 'Sommer', 'd581e1e1b173b26e830ad75ffc5cf3d58e8.jpeg', NULL),
(146, NULL, 'p.thong@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$T2FRVU5GS1ZYWkt0bDc3cg$Wis2OUcDGQ2DincLGRPaBrBdBYHGzhH07DNSRJP98js', 'Pascal', NULL, 'Thong', 'pascal thong.jpg', NULL),
(147, NULL, 'j.de.jong@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZmNsUExaVXNhQnpDOUp0aw$9PBLp8D3t1emrJB/PvkT+jCS56XoLwvAgJXX2wDiaUE', 'Jeen', 'de', 'Jong', 'jeen de jong.jpg', NULL),
(150, 14, 't.van.elck@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$MEtZOG14RzZOQXVFc2hjcA$KXfB8uCm8b7fZZ8aisEPESHEPA5fJScJvxrPyxRFl80', 'Tim', 'van', 'Elck', '3f85c3e0f51db42a4a70176000b07e1b923.jpeg', NULL),
(151, 16, 't.van.der.scheer@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$eWFZUktid3BVZEpNTGt5Nw$2Uao6ZajuhLEQxkgtLHNEWAr1zpNpG6jbooVZ+uCH5o', 'Tim', 'van der', 'Scheer', 'dd0c6dc60a227d561dff546000b51b52b40.jpeg', NULL),
(153, NULL, 'a.hermans@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$dFA0U3lpT2tvMTN0UllONA$wzKeh62yS1XhFWJ29BkpqWhTWlhcmr+56eOF32RRWJ0', 'Axel', NULL, 'Hermans', '736b8eb6128dba4e69217b60020fbd04392.png', NULL),
(154, NULL, 'm.de.kok@svjit.nl', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$aUI3NXNNYkVwdTJLaWJXSQ$0odZ1wX6p3NVfBBU1WnV0KySm/LDuLUzlE6qWnfuleI', 'Marianne', 'de', 'Kok', 'aa105aeab1acde2019b125600321c2803f6.jpeg', NULL),
(155, NULL, 'm.zondervan@svjit.nl', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$UHJXWkNxeXV2N1dvTmx0cA$ZrKXk61FHUNqCPdi18AbOUur+loVxzu1xrjDfXAyQgo', 'Marcel', NULL, 'Zondervan', '5d816a45cae554c788e75460037595b530b.jpeg', NULL),
(156, NULL, 'a.stephan@svjit.nl', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$dWNpSmVob082T2NvaU5icw$i/l2yENX6cqwpSVXHOG7VqrI57kbf2N/Z+kCO+fUo3k', 'Ans', NULL, 'Stephan', 'e309b19d0345927ac81bea60042dc4c33e4.png', NULL),
(157, NULL, 'k.klaver@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$dWRRNlpyM01MNDFwVHNtVw$eJL2Zc14sBh8GB5f42ac4m99a9Gqu5DORmXoC+1Nu1c', 'Kelvin', NULL, 'Klaver', '0e470fba6864d60d138630600437c8749cf.jpeg', NULL),
(158, 15, 'l.witkamp@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$TFRuZ2JPM0duWjNsZmhrMg$3o12dH4QFiJXQTGu3w9V4VhBU+X73ueoOAx1ByBS2Eo', 'Leroy', NULL, 'Witkamp', 'af20da75869ad860c03bd96004385713443.jpeg', NULL),
(162, NULL, 'p.zwinkels@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$bGlBaUk1QjIwbTJUSllhLw$AUZI12VQKpR7O/smiGCz2rQfaMn9+4BuG1c01a5Bp0o', 'Pim', NULL, 'Zwinkels', '3d1ae0820f0b1fd51fa5126004ad51eced3.jpeg', NULL),
(163, 16, 'a.terlouw@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Wnp6QkxKQTlnVmhLVmFMOA$BH0F9SXnwyHMn+ZSGrW5siefHoXSu86FyIBlrvufwnk', 'Arjen', NULL, 'Terlouw', '631fd6ef9d5e37297ef1126004b00e8ae4a.jpeg', NULL),
(164, NULL, 'j.kubicna@svjit.nl', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$eHEzRUpEbjNNOS94U1Z2bg$WDuCOeOGIVKVZ7yoSvL/KrNG3rs6NoXA4aSc5/OAgc4', 'Jana', NULL, 'Kubicna', '0833316d1daa255e206a36600c92ef72f01.jpeg', NULL),
(165, NULL, 'b.alleblas@svjit.nl', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$NGMyL3ZzR3h4L0g5ektiaw$k++P8OrLAlzQMiGQaSsxL0YvVlRIO5jMnhUmvyHFTMY', 'Bianca', NULL, 'Alleblas', '11d7d5825fcead8e6f752d600deec98d357.jpeg', NULL),
(166, NULL, 'r.baouch@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$Nmh3cmxCV05hWHdNQ0pvSg$7lBIvpdlE2umhPkMzwFPsyjKFelv7PpgtUeo4yCch7o', 'Rachid', NULL, 'Baouch', '8ef4c0473a89ac86fc0fc660185d0a6a7cd.jpeg', NULL);

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexen voor tabel `schoolclasses`
--
ALTER TABLE `schoolclasses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_6629A8A5E237E06` (`name`),
  ADD UNIQUE KEY `UNIQ_6629A8ADB403044` (`mentor_id`);

--
-- Indexen voor tabel `studentremarks`
--
ALTER TABLE `studentremarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_33EFB2D8F675F31B` (`author_id`),
  ADD KEY `IDX_33EFB2D8CB944F1A` (`student_id`);

--
-- Indexen voor tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_1483A5E9E7927C74` (`email`),
  ADD KEY `IDX_1483A5E9C67D8F5` (`schoolclass_id`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `schoolclasses`
--
ALTER TABLE `schoolclasses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT voor een tabel `studentremarks`
--
ALTER TABLE `studentremarks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT voor een tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=167;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `schoolclasses`
--
ALTER TABLE `schoolclasses`
  ADD CONSTRAINT `FK_6629A8ADB403044` FOREIGN KEY (`mentor_id`) REFERENCES `users` (`id`);

--
-- Beperkingen voor tabel `studentremarks`
--
ALTER TABLE `studentremarks`
  ADD CONSTRAINT `FK_33EFB2D8CB944F1A` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_33EFB2D8F675F31B` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`);

--
-- Beperkingen voor tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_1483A5E9C67D8F5` FOREIGN KEY (`schoolclass_id`) REFERENCES `schoolclasses` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

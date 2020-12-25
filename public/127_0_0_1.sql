-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 25 dec 2020 om 23:41
-- Serverversie: 10.4.16-MariaDB
-- PHP-versie: 7.4.12

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
('DoctrineMigrations\\Version20201211142937', '2020-12-11 15:30:13', 67);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `schoolclasses`
--

CREATE TABLE `schoolclasses` (
  `id` int(11) NOT NULL,
  `mentor_id` int(11) DEFAULT NULL,
  `name` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `schoolclasses`
--

INSERT INTO `schoolclasses` (`id`, `mentor_id`, `name`, `description`) VALUES
(1, 1, 'AO_2J', 'leerjaar 2 van de opleiding. Er is sprake van een klas zonder differentiatie.D methode boeken werken conform het havo/vwo. Leerlingen die het niveau niet aankunnen kunnen worden gedetermineerd als mavo-theoretische leerweg en krijgen les op hun gedetermineerde niveau.'),
(2, 9, 'AO_3K', 'Deze klas behoort tot leerjaar 3 van de opleiding. Programmeren op client-server niveau met talen als PHP, ES6 en opmaaktalen als CSS en HML.\r\nFrameworks zoals symfony staan centraal.\r\nDe student heeft kennis van SQL en kan een database ontwerpen.'),
(3, 6, 'AO_3G', 'Dit is de derde klas van de opleiding, hier worden leerlingen klaargestoomd voor un examens en voor de stage.\r\nZe beheersen hier de full client-server stack'),
(4, 8, 'AO_P3', 'De derde klas van de opleiding AO. De groep studenten is zojuist terug van stage en bereidt zich voor op de laatste 2 examens K2 en K3');

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
  `photo` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `users`
--

INSERT INTO `users` (`id`, `schoolclass_id`, `email`, `roles`, `password`, `firstname`, `prefix`, `lastname`, `photo`) VALUES
(1, NULL, 'm.van.der.linden@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$TThUQ2Y5cy5Ody5Bc1hrLg$4vi1yV7mVOst2xP+fnVafxtu4xha4PmTL8fepT5F29I', 'Marcel', 'van der', 'Linden', NULL),
(3, NULL, 's.bliemert@svjit.nl', '[\"ROLE_PRINCIPAL\"]', '$argon2id$v=19$m=65536,t=4,p=1$dEpFMURMNVA3NUhhWHVTVA$Qo8BrIUa49/f7N3asMp68xPh+NdLURMqFyBX/CcZTr0', 'Sebastiaan', NULL, 'Bliemert', 's.bliemert.jpg'),
(4, NULL, 'b.van.halem@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$cG9JYkRIblhBcjBjazIwTg$mMzdfUZThewJHeU/KX3q1SjnQft7fhrd47oZ41zau8I', 'Bart', 'van', 'Halem', 'BHalem.jpg'),
(5, NULL, 'r.van.rossum@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$WUZ5a1gwN1NsOWRvWWZkQQ$4v7BsUYl8D5WvpB6x+fADQpQR/GmkoYMyxJsP2kCSDI', 'Roel', 'van', 'Rossum', 'ROssem.jpg'),
(6, NULL, 'a.van.hensbergen@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$RlNPWFJZclVSUTlsLlVlVg$8XFovftdwXUZuflevgh+9yr6+/h+njyr+ZqNsxlKV78', 'Anton', 'van', 'Hensbergen', '1368653662.jpg'),
(7, NULL, 'w.stolk@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$UnI2TExFS1JYc01sZFJjeQ$nbzwyRPlC/7oYf+ANshoeVgmga2R2FuooAL/sHeP5+g', 'Wim', NULL, 'Stolk', 'Stolk.jpg'),
(8, NULL, 'h.kool@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$Z3F3WDh4WG83VzBGeWVRag$iKovsFF4w8eM06I2AHPDl0lgwDqBp1JFOJ8Gjbc4Rcw', 'Hanneke', NULL, 'Kool', 'hanneke.png'),
(9, NULL, 's.bechoe@svjit.nl', '[\"ROLE_TEACHER\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZnYxY3Q1cWtRL1VYVUZPbw$rf8LEJrn/JmVEtn3E1yfLKrVPI1IuF61O8Ff8C7TkNg', 'Saphna', NULL, 'Bechoe', 's.bechoe.png'),
(10, 2, 'g.le.grand@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$bnFIRnQ0TlloWC8wYnlXeQ$vo/Xt76/vOWw/dgc4dgerqBPfhkCEqj2kTqSl/Hg+1g', 'Gio', 'le', 'Grand', 'gio.le.grand.png'),
(11, NULL, 'c.bertels@svjit.nl', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$TjNhL0NkcFZaZFAvL3VkeQ$kG0GwY4oiWcfhSq+8YS1IxkKhhBeAwLffkTSSoh7s/s', 'Carinda', NULL, 'Bertels', 'c.bertels.jpg'),
(12, NULL, 'a.valk@svjit.nl', '[\"ROLE_ADMIN\"]', '$argon2id$v=19$m=65536,t=4,p=1$Z2dtZnVpMUwvWGxSY3FpWQ$19ViLKRlMeNk4UXz9+lAdd8lEyWzCyT3JFw4S7M0xHA', 'Angelita', NULL, 'Valk', 'a.valk.jpg'),
(13, 2, 'j.de.wolf@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZHdqdzlDWWx0SVFVcVdsWg$rP9UFJLXNLhvQeZH/M9ZDyuL69IMzkPl6F0PefOA/BI', 'Jon', 'de', 'Wolf', 'jon.de.wolf.png'),
(14, 2, 'o.dokes@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$MTRYWG1mZXVlNG9meDdGQw$XRbsf3A2dVkcH+G7IQIe+qj4Uew6L+TLvxBxeVSeaoE', 'Okkes', NULL, 'Dokes', 'okkes.dokes.png'),
(15, 2, 's.alieev@sjivt.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Qmc5MUlsZjAzdTI2b09PSg$VycVof+YUMfz0meIRn3dTALrLmDEjMaMz80lePjU97A', 'Samir', NULL, 'Alieev', 'samir alieev.jpg'),
(16, 2, 'r.chandoe@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$dVpqTjc2T1hFbmVTZmRObg$mRQCHzKqcnnvY5eOWrGH83T/P+XXNFRTBcsAQaOFMjA', 'Rahiem', NULL, 'Chandoe', 'rahiem.chandoe.png'),
(17, 2, 'a.damaran@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$dnVlLllqczBiWGZCUmVtOA$jtg6jAZ2G6fkDyLCeea1x4aCPIVntBwAkLY7bviJcCY', 'Armando', NULL, 'Damaran', 'armando damaran.png'),
(18, 2, 'b.de.neve@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$REtyQ0Fjc0VLcE4xV29Hag$GQajhL5r298eI0qKWISpaHSv0Jaj3pVel02PohZ7Fr8', 'Boris', 'de', 'Neve', 'boris de neve.png'),
(19, 2, 'e.van.de.kaai@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$N0wveWtYbXZ4ZzV4b29sRw$fG5DcXN4La3ws+FzbQtSeas8SdKP1tEFTbs+Ovnv134', 'Erik', 'van de', 'Kaai', 'erik van de kaai.png'),
(20, 2, 'j.haaring@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZVhJcnpHSUJMTWpGN2dIbQ$/MRPc1AzXvQGvWogeMEJa0rwW2ifeEAtBR8EN5io1Dc', 'Joey', NULL, 'Haaring', 'bbfef3b0f8a0bf97e295c15fdf70e7ba001.png'),
(21, 2, 'm.barut@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$L2c2ejlscHRJRFpUNDdrNw$5hJ9VEFeD8/K1kEiiSbIEd6gxMV3J+mJP06RR7Ravds', 'MIkail', NULL, 'Barut', '207dce166f042562b98c7a5fdf716ad7146.jpeg'),
(22, 2, 'm.ashikali@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$M05LTklzQ0U4UjlVb3JqUg$+nSrN1iY4aA5Qi/O1pHxT0/7oJkdP/0m7p3+T+SmSRg', 'MIchaël', NULL, 'Ashikali', '7b0ae3b8418e32ade56c005fdf7303241b6.jpeg'),
(23, 2, 'n.unal@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Vi9EN3BaTURxRGdhaFUxTw$JNL7fWGHhRjGVyRMzZ/tXLYr6nfK/wktm4meLs59NqU', 'Nejati', NULL, 'Unal', 'ece73ee7ab17950ff9c16a5fe097e999887.png'),
(24, 2, 'r.benoit@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$a21sRGprQ1lFMVk1ODNONw$RNcEQe9d4l0/CNKVd03IJHRf9cZ7+lwD/UxXLHSgmMo', 'Roy', NULL, 'Benoit', 'daa3bdc650e5eb69623a605fe0997fd9a1e.png'),
(25, 2, 'j.tiebosch@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$RU1SS1VxTXVBNHAwUi5Mcg$6NJ176vmqzepH4F0qacJkb1HZwTNHT57BzDJF5qIYgo', 'Jeremy', NULL, 'Tiebosch', '424dc0ffb1c3ae492b8d115fe0a2015931c.png'),
(26, 2, 'e.sjamshudinov@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$NnFOb1U4cHgxdnRpc1dFVQ$++WRoTvHeDL0Rq9lOzex1xbuOXLnXYOaADNTSPDqHcI', 'Eljor', NULL, 'Sjamshudinov', '1df15bbf69eb354205b7765fe0a4b8f246d.png'),
(27, 2, 'l.van.spronsen@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$c3hteUEzTGM4Sy5kTjVUaw$ALtY1wrMtREjW8IAxa7Da5aA6QiejJJBsaI2bN27E8M', 'Leroy', 'van', 'Spronsen', '16decd275dd855c9ceb2db5fe0a4f9ead3b.png'),
(28, 2, 'm.van.vliet@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$SDZNYVVobEhyTjVjaHoxdQ$ZoC1had10pp2T/WNzpOiwtH0iB7n0HBtUJUmrYvO3l4', 'Marien', 'van', 'Vliet', '128c579e26c0d20588331d5fe0a541844ba.png'),
(29, 2, 'n.willemse@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$dmw0M2NrUkxpeW9DUjdaRw$7DMWRmpX6jni1L1YIm1ufFiIoyDY6kRRsy4Yqg0vtSY', 'Nick', NULL, 'Willemse', '7a8bfe7de0251ca1b40d605fe0a5f66c91a.png'),
(31, 2, 'r.roesmal@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$WWFvQkNqSXpxUkpNcGxyNw$9iKhN3Vjs3S0yYyjB+7WI9Zn7zlSFlHu2laZTzkyyjE', 'Roy', NULL, 'Roesmal', '320e33aa14517446a357165fe0a67b8d141.png'),
(32, 2, 'r.spaans@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Qk51TU5TVmNwWUVZby8zZw$jSHPAu3ZXUtok4zo/m3KBM4tnnoPOVFhFKVI7SquGqU', 'Robert', NULL, 'Spaans', 'a91d46a2904ee2a82db5435fe0a6d36ba9d.png'),
(33, 2, 'n.van.rijn@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$bFZFWUR1REFxQ1BaTTVrYQ$mj2kaVMJQsU7EdWKIaMnWlzoMgVxOlavEfw1raIhbR8', 'Nigel', 'van', 'Rijn', 'dec6908fddc93a2cd6207d5fe0aa3a80bdd.png'),
(35, 2, 'd.nieuwmans@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Vk1HNlR3TEltMlJWTFNJag$TO4+JWxHeENMy5GAjEKnIjSfOgREsuj+60oHz1qc1b4', 'Danny', NULL, 'Nieuwmans', '39a4575dc4e201c1888dd65fe0bac5a4139.png'),
(37, 2, 'p.van.der.kraan@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$LjlvN3ZpdndDd3N2UG9BSA$x1k3nTnTlh1f4p8+/t1I3SxI+XE7WbRMZh0Rk4p/lOQ', 'Patrick', 'van der', 'Kraan', '27902e30bf4b08bfcf22135fe0c0c342d5c.png'),
(57, 2, 'k.van.houdts@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Y3paLjJrcXQvUVdUdk1ZSg$MD0/P95NkGA4R51Vn28lwGqjr/ltjY2ownJlOjbl/Rs', 'Kevin', 'van', 'Houdts', '298582e34f5a5403b8ea6d5fe0da858211e.png'),
(58, 2, 's.van.leeuwen@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$UXFMOGRXc0hTYUtmalN4UA$qFufpvC0xpq/prjHO3Otk63uOdyVTNLNjIwOABJURT0', 'Stephan', 'van', 'Leeuwen', '55474abc8b1d6ffd89c2f65fe0db356797e.png'),
(59, 2, 'r.schokker@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$Y0gxbXpFbGhYYTM4dC5ESg$dxJd9CTd+k2vAO5KQIr0KM6o1qAT4NIvsR+k7yu0cZg', 'Rickardo', NULL, 'Schokker', '07252be30aca434786e3fe5fe0db879db03.png'),
(61, 2, 's.willemszgeeroms@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZzB3T2s5bEc2bUJpSVpJSw$ME2BNYjvSb4L9ONKuc1hkXSpPs+pcA4eX3XvkAYiF/Q', 'Stefano', NULL, 'Willemsz Geeroms', '17fed65973031f75c1b84d5fe0dd4f220c5.png'),
(62, 1, 'g.enache@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ay5mQkZDMG5MMW9JNjdFbw$PDwoJgMusNQT3y+qH6lpaGhefJb588pLleUUdKsrOSY', 'Georgette', NULL, 'Enache', '6e2781abe2e8f4c928951b5fe0f100cff45.png'),
(63, 1, 'j.wijnhoven@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZTF4YmlsRkgveE5hQUdlUg$f0cBVCh2qbVIh/FP+fCjY2v78sN4ekIrXjiHejoe2Os', 'JImy', NULL, 'Wijnhoven', '073acf82367de7175ca46c5fe0f13bdabc1.png'),
(64, 1, 'l.van.ham@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$cFVyeWhxb0pqMVg1a1MybQ$3L6TvKifh9HZS0MHtMBMN7v3Uz3JEhhrQPLZJniguhA', 'Levi', 'van', 'Ham', '9e555d334f667a342fe6355fe0f169e4e69.png'),
(66, 1, 'l.van.der.toorn@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$MTY0V0tkYzNKRHU0ejZwSQ$gOuFCiDOh2aQphLH9Cq+G2IWxmTCWQJIBZ8dke6CqB8', 'Luuk', 'van der', 'Toorn', '35005562481008ea2658b05fe0f1c1db493.png'),
(67, 1, 'm.guth@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$V1Zucm9pUGtvREUwTW1TRQ$FPdlEPy8kAypxw4JiHJXPY/B1JtgRpTj9lM3g2RN4dk', 'Marcel', NULL, 'Guth', 'd272659125899f58a0c3705fe0f31ff20aa.png'),
(68, 1, 's.christ@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$U3pOLm40THUwa3ROa2VNNg$OA9rlBWhpUK6O8XM0lEkGhxZQE8J2yVAA0C2JilmpuM', 'Stan', NULL, 'Christ', 'be542c925c81dd0e47852d5fe0f3653f548.png'),
(69, 1, 'r.barsatie@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$NkJYLnE5V1llOUVRRnpZRQ$D6kRsvZJQBq8cXM7kzQ7aBdh57xRH9QU53Gc0Xo3/MM', 'Raïsa', NULL, 'Barsatie', '3e025b788ffcb2d550a3725fe0f48a3792f.png'),
(70, 1, 'v.badal@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$T1p5NG1BTUJUeWNKdEVKUA$Y5lNhvk8oY7Q+H/6dFGx7sFTcoOuH9qDcHLxlE74kUI', 'Viren', NULL, 'Badal', '55b88bc2d094848776f0055fe0f4bb38829.png'),
(73, 1, 'c.cakmak@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZnBFWkJPenBHWHN2ZzFNaA$38ZqnYYp93H+5OJhEE+QIr2RMCOZRTWT+UvTmtjDSIE', 'Cem', NULL, 'Çakmak', '7be825f5bafe69c0060f9d5fe39da4ebf00.png'),
(74, 1, 'r.sahangoekhan@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$QlU3T3gwY1hpTFE0OEhQWQ$aN35XCqNlI9FQroAD+uSQKSp5UPTAaOW9aE4OpvjUBo', 'Rashad', NULL, 'Sahangoe Khan', '1aea4b5c6b0af93b1475955fe39e786320a.jpeg'),
(75, 3, 'j.de.wit@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$d0RWVEJoRjVvRWlaeElnaA$qAXhYcJjqbBV1r7behkSB0KJRsQPdO6wuka/tGvv82A', 'Joey', 'de', 'Wit', '1dd3c879dd970dbb8f83225fe3cf0a5340e.jpeg'),
(77, 3, 'r.mamudu@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$NG9ybW9VMDhvczJqRmhNcw$dxnrHMk9sQGlM/ZBFp5QYAuuoU8TsObPfAeO2yBxMCA', 'Rashid', NULL, 'Mamudu', '73f02b4b6de85cf2b0470d5fe3cf7d069b4.png'),
(78, 3, 'r.den.heijer@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$TDFxbWd4LlNLQUQya1JDVg$hs7mbLLMWf4l5ltltIJTIfS1/JF+2MW33gLl0F24yuk', 'Robbin', 'den', 'Heijer', 'd8719233a38d1f444b82875fe3d5e05c23b.jpeg'),
(79, 1, 's.paassen@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$VFo3N01ubzlDUmRCZHBNNA$46j8FeDQay5oW6k0zl2ClPUvKCsNHgAGhZngbdHohqw', 'Sibren', 'van', 'Paassen', '8e58627d5da477fac86b3c5fe3d61819e72.jpeg'),
(80, 3, 's.cotomatey@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$bkpBWWlnazRTSWduMGRYZQ$kzerxdd3ECkJ1we1k3bdn+blH933LwTwAd4eTPfcy+8', 'Socrates', NULL, 'Coto Matey', 'ac5d62b054f91e7edc02985fe3d67fd27c7.jpeg'),
(81, 3, 't.sahin@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$R0NCL1BsTFh5aUVSYUZlQg$KmyGEVLiYGZ4gYtPaCE9cMNwBWzoUl9qfbzHNHVJcww', 'Taner', NULL, 'Sahin', '6aaf53ee9a8096fa6c11525fe48a87b9a84.png'),
(82, 3, 'e.besic@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$VXpybUZRZEp3YmhRUzBKNQ$5iGhCexseJ4dbdWMK7O20LkbhwZy2VWePaeEiufbuBQ', 'Edo', NULL, 'Bešic', '21d373cade4e832627b4f65fe5fd218eba3.jpeg'),
(83, 3, 'm.v.d.burgh@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$UFVTMlk0b2J3U3R3cURQLw$5ZJq2P+SmLpUcR226iM4JA3+ih3Ncj17+Od1O/9KsZI', 'Mark', 'van den', 'Burgh', '05b9033196ba818f7a872b5fe5fe7079111.jpeg'),
(84, 3, 'a.kurnaz@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$cTJVVk1ZMXlHeS5xVVBsSQ$bzedLoOtpKIFrgf5LYIojnMy38LXbacl9GTHnmSZtD8', 'Abdul', NULL, 'Kurnaz', '69000262e398418be022455fe60077b7995.jpeg'),
(86, NULL, 'n.lahmidi@svjit.nl', '[\"ROLE_PUPIL\"]', '$argon2id$v=19$m=65536,t=4,p=1$ZkxQS1VJS3hpWmJ4OUhuNA$YcWuBe6ZaKK3Cd1IYMmGMJlqVl2jufMCrTE76vGUBSY', 'Nassiem', NULL, 'Lahmidi', '2c1e3124cffd67d48194685fe63c3121d2a.png');

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
  ADD KEY `IDX_6629A8ADB403044` (`mentor_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT voor een tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `schoolclasses`
--
ALTER TABLE `schoolclasses`
  ADD CONSTRAINT `FK_6629A8ADB403044` FOREIGN KEY (`mentor_id`) REFERENCES `users` (`id`);

--
-- Beperkingen voor tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_1483A5E9C67D8F5` FOREIGN KEY (`schoolclass_id`) REFERENCES `schoolclasses` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

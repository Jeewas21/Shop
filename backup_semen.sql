-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.6.38 - MySQL Community Server (GPL)
-- Операционная система:         Win32
-- HeidiSQL Версия:              9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных semion
CREATE DATABASE IF NOT EXISTS `semion` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `semion`;

-- Дамп структуры для таблица semion.Orders
CREATE TABLE IF NOT EXISTS `Orders` (
  `code_order` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `state_order` char(20) NOT NULL,
  `sum_order` float NOT NULL,
  `confirm_order` int(11) NOT NULL,
  PRIMARY KEY (`code_order`),
  KEY `FK_Relationship_1` (`id_user`),
  CONSTRAINT `FK_Relationship_1` FOREIGN KEY (`id_user`) REFERENCES `Users` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы semion.Orders: ~15 rows (приблизительно)
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` (`code_order`, `id_user`, `state_order`, `sum_order`, `confirm_order`) VALUES
	(1, 1, 'отправлен', 100, 1),
	(2, 1, 'новый', 100, 1),
	(3, 1, 'новый', 100, 1),
	(4, 1, 'новый', 100, 1),
	(5, 1, 'отправлен', 100, 0),
	(6, 1, 'новый', 100, 0),
	(7, 1, 'новый', 100, 0),
	(8, 1, 'новый', 100, 0),
	(9, 1, 'новый', 300, 0),
	(10, 1, 'новый', 300, 0),
	(11, 1, 'новый', 400, 0),
	(12, 1, 'новый', 300, 0),
	(13, 1, 'новый', 300, 0),
	(14, 1, 'новый', 2000, 0),
	(15, 1, 'новый', 1400, 1);
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;

-- Дамп структуры для таблица semion.Products
CREATE TABLE IF NOT EXISTS `Products` (
  `articul` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `product_price` float NOT NULL,
  `agregat_name` varchar(100) NOT NULL,
  PRIMARY KEY (`articul`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы semion.Products: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
INSERT INTO `Products` (`articul`, `product_name`, `product_price`, `agregat_name`) VALUES
	(1, 'шайба', 100, 'крышка головки цилиндров'),
	(2, 'шайба_2', 100, 'крышка головки цилиндров');
/*!40000 ALTER TABLE `Products` ENABLE KEYS */;

-- Дамп структуры для таблица semion.product_lists
CREATE TABLE IF NOT EXISTS `product_lists` (
  `code_order` int(11) NOT NULL,
  `articul` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`code_order`,`articul`),
  KEY `FK_Relationship_3` (`articul`),
  CONSTRAINT `FK_Relationship_2` FOREIGN KEY (`code_order`) REFERENCES `Orders` (`code_order`),
  CONSTRAINT `FK_Relationship_3` FOREIGN KEY (`articul`) REFERENCES `Products` (`articul`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Дамп данных таблицы semion.product_lists: ~17 rows (приблизительно)
/*!40000 ALTER TABLE `product_lists` DISABLE KEYS */;
INSERT INTO `product_lists` (`code_order`, `articul`, `count`) VALUES
	(1, 1, 5),
	(2, 1, 5),
	(3, 1, 5),
	(4, 1, 5),
	(5, 1, 5),
	(6, 1, 5),
	(7, 1, 5),
	(8, 1, 5),
	(9, 1, 3),
	(10, 1, 3),
	(11, 1, 4),
	(12, 1, 3),
	(13, 1, 3),
	(14, 1, 10),
	(14, 2, 10),
	(15, 1, 9),
	(15, 2, 5);
/*!40000 ALTER TABLE `product_lists` ENABLE KEYS */;

-- Дамп структуры для таблица semion.Users
CREATE TABLE IF NOT EXISTS `Users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `type` char(10) NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Дамп данных таблицы semion.Users: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` (`id_user`, `first_name`, `last_name`, `type`, `login`, `password`) VALUES
	(1, 'test', 'user', 'client', '123', '123'),
	(2, 'test2', 'test2', 'admin', 'test2', '123');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

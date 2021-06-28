-- --------------------------------------------------------
-- Хост:                         localhost
-- Версия сервера:               5.7.24 - MySQL Community Server (GPL)
-- Операционная система:         Win64
-- HeidiSQL Версия:              10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Дамп структуры базы данных goodone
CREATE DATABASE IF NOT EXISTS `goodone` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `goodone`;

-- Дамп структуры для таблица goodone.material
CREATE TABLE IF NOT EXISTS `material` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `material_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы goodone.material: ~4 rows (приблизительно)
DELETE FROM `material`;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` (`id`, `material_name`) VALUES
	(1, 'mato'),
	(2, 'tugma'),
	(3, 'ip'),
	(4, 'zamok');
/*!40000 ALTER TABLE `material` ENABLE KEYS */;

-- Дамп структуры для таблица goodone.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы goodone.migrations: ~4 rows (приблизительно)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2021_06_25_122828_create_product', 1),
	(2, '2021_06_25_122859_create_material', 1),
	(3, '2021_06_25_122925_create_product_material', 1),
	(4, '2021_06_25_122946_create_ware_houses', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Дамп структуры для таблица goodone.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы goodone.product: ~2 rows (приблизительно)
DELETE FROM `product`;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`id`, `product_name`) VALUES
	(1, 'Ko\'ylak'),
	(2, 'Shim');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;

-- Дамп структуры для таблица goodone.product_material
CREATE TABLE IF NOT EXISTS `product_material` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  `quantity` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы goodone.product_material: ~6 rows (приблизительно)
DELETE FROM `product_material`;
/*!40000 ALTER TABLE `product_material` DISABLE KEYS */;
INSERT INTO `product_material` (`id`, `product_id`, `material_id`, `quantity`) VALUES
	(1, 1, 1, 0.8),
	(2, 1, 2, 5),
	(3, 1, 3, 10),
	(4, 2, 1, 1.4),
	(5, 2, 3, 10),
	(6, 2, 4, 1);
/*!40000 ALTER TABLE `product_material` ENABLE KEYS */;

-- Дамп структуры для таблица goodone.warehouses
CREATE TABLE IF NOT EXISTS `warehouses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `material_id` int(11) NOT NULL,
  `remainder` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Дамп данных таблицы goodone.warehouses: ~6 rows (приблизительно)
DELETE FROM `warehouses`;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
INSERT INTO `warehouses` (`id`, `material_id`, `remainder`, `price`) VALUES
	(1, 1, 12, 1500),
	(2, 1, 200, 1600),
	(3, 3, 40, 500),
	(4, 3, 300, 550),
	(5, 2, 500, 300),
	(6, 4, 1000, 2000);
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

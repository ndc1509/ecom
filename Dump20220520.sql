-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: bookstr
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_account`
--

DROP TABLE IF EXISTS `account_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_account` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(50) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superadmin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_account`
--

LOCK TABLES `account_account` WRITE;
/*!40000 ALTER TABLE `account_account` DISABLE KEYS */;
INSERT INTO `account_account` VALUES (4,'pbkdf2_sha256$320000$QnhuI1twtf3rA4dAszVVT0$0d2UUS0gCDyNigqlqeLszQ0UP8LXEydhSKjTNsFtHbk=','john','doe','rai94144','rai94144@xcoxc.com','+84326216290','2022-05-19 16:57:54.374297','2022-05-20 10:46:42.669859',0,0,1,0),(5,'pbkdf2_sha256$320000$jIUePvPJgLTZ6ELQaNnc7V$96h7W/bQOf4SqQ4KWNCnQGArOkyT2sXhNU1zvvUHRUs=','Cuong','Nguyen','ndc1509','nguyendinhcuonga12@gmail.com','','2022-05-20 09:02:59.101657','2022-05-20 09:03:32.488004',1,1,1,1);
/*!40000 ALTER TABLE `account_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add author',6,'add_author'),(22,'Can change author',6,'change_author'),(23,'Can delete author',6,'delete_author'),(24,'Can view author',6,'view_author'),(25,'Can add brand',7,'add_brand'),(26,'Can change brand',7,'change_brand'),(27,'Can delete brand',7,'delete_brand'),(28,'Can view brand',7,'view_brand'),(29,'Can add Category',8,'add_category'),(30,'Can change Category',8,'change_category'),(31,'Can delete Category',8,'delete_category'),(32,'Can view Category',8,'view_category'),(33,'Can add product',9,'add_product'),(34,'Can change product',9,'change_product'),(35,'Can delete product',9,'delete_product'),(36,'Can view product',9,'view_product'),(37,'Can add product image',10,'add_productimage'),(38,'Can change product image',10,'change_productimage'),(39,'Can delete product image',10,'delete_productimage'),(40,'Can view product image',10,'view_productimage'),(41,'Can add smartphone',11,'add_smartphone'),(42,'Can change smartphone',11,'change_smartphone'),(43,'Can delete smartphone',11,'delete_smartphone'),(44,'Can view smartphone',11,'view_smartphone'),(45,'Can add laptop',12,'add_laptop'),(46,'Can change laptop',12,'change_laptop'),(47,'Can delete laptop',12,'delete_laptop'),(48,'Can view laptop',12,'view_laptop'),(49,'Can add book',13,'add_book'),(50,'Can change book',13,'change_book'),(51,'Can delete book',13,'delete_book'),(52,'Can view book',13,'view_book'),(53,'Can add account',14,'add_account'),(54,'Can change account',14,'change_account'),(55,'Can delete account',14,'delete_account'),(56,'Can view account',14,'view_account'),(57,'Can add cart',15,'add_cart'),(58,'Can change cart',15,'change_cart'),(59,'Can delete cart',15,'delete_cart'),(60,'Can view cart',15,'view_cart'),(61,'Can add shipment',16,'add_shipment'),(62,'Can change shipment',16,'change_shipment'),(63,'Can delete shipment',16,'delete_shipment'),(64,'Can view shipment',16,'view_shipment'),(65,'Can add product item',17,'add_productitem'),(66,'Can change product item',17,'change_productitem'),(67,'Can delete product item',17,'delete_productitem'),(68,'Can view product item',17,'view_productitem'),(69,'Can add payment',18,'add_payment'),(70,'Can change payment',18,'change_payment'),(71,'Can delete payment',18,'delete_payment'),(72,'Can view payment',18,'view_payment'),(73,'Can add order',19,'add_order'),(74,'Can change order',19,'change_order'),(75,'Can delete order',19,'delete_order'),(76,'Can view order',19,'view_order'),(77,'Can add review rating',20,'add_reviewrating'),(78,'Can change review rating',20,'change_reviewrating'),(79,'Can delete review rating',20,'delete_reviewrating'),(80,'Can view review rating',20,'view_reviewrating');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_account_account_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2022-05-20 09:04:53.407494','1','S??ch ti???ng Vi???t',1,'[{\"added\": {}}]',8,5),(2,'2022-05-20 09:05:11.001572','2','S??ch kinh t???',1,'[{\"added\": {}}]',8,5),(3,'2022-05-20 09:12:11.052598','2','Paulo Coelho',1,'[{\"added\": {}}]',6,5),(4,'2022-05-20 09:12:57.221581','3','S??ch v??n h???c',1,'[{\"added\": {}}]',8,5),(5,'2022-05-20 09:15:33.306789','3','Mario Puzo',1,'[{\"added\": {}}]',6,5),(6,'2022-05-20 10:06:55.565041','4','Laptop',1,'[{\"added\": {}}]',8,5),(7,'2022-05-20 10:07:10.305885','5','Lenovo',1,'[{\"added\": {}}]',8,5),(8,'2022-05-20 10:07:19.622265','6','HP',1,'[{\"added\": {}}]',8,5);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (14,'account','account'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(6,'items','author'),(13,'items','book'),(7,'items','brand'),(8,'items','category'),(12,'items','laptop'),(9,'items','product'),(10,'items','productimage'),(11,'items','smartphone'),(5,'sessions','session'),(15,'store','cart'),(19,'store','order'),(18,'store','payment'),(17,'store','productitem'),(20,'store','reviewrating'),(16,'store','shipment');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'account','0001_initial','2022-05-19 16:49:14.172843'),(2,'contenttypes','0001_initial','2022-05-19 16:49:14.254746'),(3,'admin','0001_initial','2022-05-19 16:49:14.524647'),(4,'admin','0002_logentry_remove_auto_add','2022-05-19 16:49:14.533647'),(5,'admin','0003_logentry_add_action_flag_choices','2022-05-19 16:49:14.541822'),(6,'contenttypes','0002_remove_content_type_name','2022-05-19 16:49:14.834295'),(7,'auth','0001_initial','2022-05-19 16:49:15.382573'),(8,'auth','0002_alter_permission_name_max_length','2022-05-19 16:49:15.485248'),(9,'auth','0003_alter_user_email_max_length','2022-05-19 16:49:15.495264'),(10,'auth','0004_alter_user_username_opts','2022-05-19 16:49:15.505165'),(11,'auth','0005_alter_user_last_login_null','2022-05-19 16:49:15.514892'),(12,'auth','0006_require_contenttypes_0002','2022-05-19 16:49:15.522891'),(13,'auth','0007_alter_validators_add_error_messages','2022-05-19 16:49:15.532353'),(14,'auth','0008_alter_user_username_max_length','2022-05-19 16:49:15.540993'),(15,'auth','0009_alter_user_last_name_max_length','2022-05-19 16:49:15.550993'),(16,'auth','0010_alter_group_name_max_length','2022-05-19 16:49:15.574540'),(17,'auth','0011_update_proxy_permissions','2022-05-19 16:49:15.585541'),(18,'auth','0012_alter_user_first_name_max_length','2022-05-19 16:49:15.594217'),(19,'items','0001_initial','2022-05-19 16:49:17.446255'),(20,'sessions','0001_initial','2022-05-19 16:49:17.540209'),(21,'store','0001_initial','2022-05-19 16:49:20.335634'),(22,'store','0002_alter_payment_status_alter_shipment_status_and_more','2022-05-20 09:21:31.283118'),(23,'store','0003_productitem_user_alter_payment_status_and_more','2022-05-20 10:46:15.643156');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0x48b1wc9ojkvvaj6vh4lrho5f2yg19b','.eJxVjMsOwiAURP-FtSE8L-DSfb-BcHlI1dCktCvjv0uTLnQ5Z87Mm_iwb9XvPa9-TuRKFLn8MgzxmdtRpEdo94XGpW3rjPRQ6Nl2Oi0pv26n-3dQQ69jDS5FqwR3ghVTpEJtYnTGjcAHlkVaBMOZlaidUBkKA1BJgRUZrXbk8wW_bDat:1ns09a:0V1r29RkI3RMQuRf1wjaWzP284Weubeg9hO6In-_ZpA','2022-06-03 10:46:42.685859'),('uo3qpnqmryqtypubx6skfpv5fkycp0wo','e30:1ns083:PysXd483Ee8VL6DdpHkCEWWP6zIN4DOaWtSrG7f1PY4','2022-06-03 10:45:07.323347');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_author`
--

DROP TABLE IF EXISTS `items_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_author` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_author`
--

LOCK TABLES `items_author` WRITE;
/*!40000 ALTER TABLE `items_author` DISABLE KEYS */;
INSERT INTO `items_author` VALUES (1,'Jodi Glickman'),(2,'Paulo Coelho'),(3,'Mario Puzo');
/*!40000 ALTER TABLE `items_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_book`
--

DROP TABLE IF EXISTS `items_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_book` (
  `product_ptr_id` bigint NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `publication_date` int DEFAULT NULL,
  `numbers_of_pages` int NOT NULL,
  `author_id` bigint DEFAULT NULL,
  PRIMARY KEY (`product_ptr_id`),
  KEY `items_book_author_id_f075a352_fk_items_author_id` (`author_id`),
  CONSTRAINT `items_book_author_id_f075a352_fk_items_author_id` FOREIGN KEY (`author_id`) REFERENCES `items_author` (`id`),
  CONSTRAINT `items_book_product_ptr_id_8b445138_fk_items_product_id` FOREIGN KEY (`product_ptr_id`) REFERENCES `items_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_book`
--

LOCK TABLES `items_book` WRITE;
/*!40000 ALTER TABLE `items_book` DISABLE KEYS */;
INSERT INTO `items_book` VALUES (1,'Zenbooks',2021,0,1),(2,'Nh?? Nam',2020,0,2),(3,'C??ng Ty C??? Ph???n V??n H??a ????ng A',2020,0,3);
/*!40000 ALTER TABLE `items_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_brand`
--

DROP TABLE IF EXISTS `items_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_brand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `origin` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_brand`
--

LOCK TABLES `items_brand` WRITE;
/*!40000 ALTER TABLE `items_brand` DISABLE KEYS */;
INSERT INTO `items_brand` VALUES (1,'Lenovo','Trung qu???c'),(2,'Hp','m???');
/*!40000 ALTER TABLE `items_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_category`
--

DROP TABLE IF EXISTS `items_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `items_category_parent_id_ae80dfd3_fk_items_category_id` (`parent_id`),
  CONSTRAINT `items_category_parent_id_ae80dfd3_fk_items_category_id` FOREIGN KEY (`parent_id`) REFERENCES `items_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_category`
--

LOCK TABLES `items_category` WRITE;
/*!40000 ALTER TABLE `items_category` DISABLE KEYS */;
INSERT INTO `items_category` VALUES (1,'S??ch ti???ng Vi???t','sach-tieng-viet',NULL),(2,'S??ch kinh t???','sach-kinh-te',1),(3,'S??ch v??n h???c','sach-van-hoc',1),(4,'Laptop','laptop',NULL),(5,'Lenovo','lenovo',4),(6,'HP','hp',4);
/*!40000 ALTER TABLE `items_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_laptop`
--

DROP TABLE IF EXISTS `items_laptop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_laptop` (
  `product_ptr_id` bigint NOT NULL,
  `ram` varchar(100) NOT NULL,
  `vga` varchar(100) NOT NULL,
  `cpu` varchar(100) NOT NULL,
  `screen` varchar(100) NOT NULL,
  `storage` varchar(100) NOT NULL,
  `battery` varchar(100) NOT NULL,
  `os` varchar(100) NOT NULL,
  `brand_id` bigint NOT NULL,
  PRIMARY KEY (`product_ptr_id`),
  KEY `items_laptop_brand_id_a5ee977c_fk_items_brand_id` (`brand_id`),
  CONSTRAINT `items_laptop_brand_id_a5ee977c_fk_items_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `items_brand` (`id`),
  CONSTRAINT `items_laptop_product_ptr_id_314cf043_fk_items_product_id` FOREIGN KEY (`product_ptr_id`) REFERENCES `items_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_laptop`
--

LOCK TABLES `items_laptop` WRITE;
/*!40000 ALTER TABLE `items_laptop` DISABLE KEYS */;
INSERT INTO `items_laptop` VALUES (4,'16gb','Intel UHD Graphics','i5','14\'inch','500gb ssd','65wh','windows 10',1),(5,'16gb','Intel UHD Graphics','i5 11th gen','13.3\'inch','500gb ssd','65wh','windows 10',1),(6,'16gb','Intel UHD Graphics','i5 11th gen','13.3\'inch','500gb ssd','65wh','windows 10',2);
/*!40000 ALTER TABLE `items_laptop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_product`
--

DROP TABLE IF EXISTS `items_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `stock` int NOT NULL,
  `sold` int NOT NULL,
  `status` varchar(2) DEFAULT NULL,
  `slug` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `items_product_category_id_38b90e4d_fk_items_category_id` (`category_id`),
  KEY `items_product_slug_ff2aa378` (`slug`),
  CONSTRAINT `items_product_category_id_38b90e4d_fk_items_category_id` FOREIGN KEY (`category_id`) REFERENCES `items_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_product`
--

LOCK TABLES `items_product` WRITE;
/*!40000 ALTER TABLE `items_product` DISABLE KEYS */;
INSERT INTO `items_product` VALUES (1,'Vua c??ng s???',82800,10,0,'C','vua-cong-so','Vua C??ng S???\r\n\r\nTrong m??i tr?????ng c??ng s???, ng?????i th??ng minh nh???t, l??m vi???c ch??m ch??? nh???t hay gi???i chuy??n m??n nh???t ch??a ch???c ???? th??nh c??ng. M?? ??i???u ki???n ti??n quy???t ????? th??nh c??ng ch??nh l?? bi???t c??ch giao ti???p hi???u qu???.\r\n\r\n???Vua??? c??ng s??? trang b??? cho b???n nh???ng chi??u th???c ????n gi???n c?? th??? ??p d???ng v??o m???i t??nh hu???ng t???i n??i l??m vi???c: truy???n ?????t ?? t?????ng, y??u c???u ph???n h???i v?? s??? gi??p ?????, ???ng ????p khi r??i v??o t??nh hu???ng kh?? x??????\r\n\r\nNh???ng chi???n l?????c giao ti???p trong cu???n s??ch n??y s??? gi??p b???n g???t h??i k???t qu??? t???i ??u trong c??ng vi???c, ?????ng th???i gi??nh ???????c s??? t??n tr???ng, tin t?????ng v?? ????nh gi?? cao t??? ?????ng nghi???p l???n c???p tr??n.',2),(2,'Nh?? Gi??? Kim',51350,10,0,'C','nha-gia-kim','S?? l?????c v??? t??c ph???m\r\n\r\nT???t c??? nh???ng tr???i nghi???m trong chuy???n phi??u du theo ??u???i v???n m???nh c???a m??nh ???? gi??p Santiago th???u hi???u ???????c ?? ngh??a s??u xa nh???t c???a h???nh ph??c, h??a h???p v???i v?? tr??? v?? con ng?????i.\r\n\r\nTi???u thuy???t Nh?? gi??? kim c???a Paulo Coelho nh?? m???t c??u chuy???n c??? t??ch gi???n d???, nh??n ??i, gi??u ch???t th??, th???m ?????m nh???ng minh tri???t huy???n b?? c???a ph????ng ????ng. Trong l???n xu???t b???n ?????u ti??n t???i Brazil v??o n??m 1988, s??ch ch??? b??n ???????c 900 b???n. Nh??ng, v???i s??? ph???n ?????c bi???t c???a cu???n s??ch d??nh cho to??n nh??n lo???i, v?????t ra ngo??i bi??n gi???i qu???c gia, Nh?? gi??? kim ???? l??m rung ?????ng h??ng tri???u t??m h???n, tr??? th??nh m???t trong nh???ng cu???n s??ch b??n ch???y nh???t m???i th???i ?????i, v?? c?? th??? l??m thay ?????i cu???c ?????i ng?????i ?????c.\r\n\r\n???Nh??ng nh?? luy???n kim ??an kh??ng quan t??m m???y ?????n nh???ng ??i???u ???y. ??ng ???? t???ng th???y nhi???u ng?????i ?????n r???i ??i, trong khi ???c ?????o v?? sa m???c v???n l?? ???c ?????o v?? sa m???c. ??ng ???? th???y vua ch??a v?? k??? ??n xin ??i qua bi???n c??t n??y, c??i bi???n c??t th?????ng xuy??n thay h??nh ?????i d???ng v?? gi?? th???i nh??ng v???n m??i m??i l?? bi???n c??t m?? ??ng ???? bi???t t??? thu??? nh???. Tuy v???y, t??? ????y l??ng m??nh, ??ng kh??ng th??? kh??ng c???m th???y vui tr?????c h???nh ph??c c???a m???i ng?????i l??? kh??ch, sau bao ng??y ch??? c?? c??t v??ng v???i tr???i xanh nay ???????c th???y ch?? l?? xanh t????i hi???n ra tr?????c m???t. ???C?? th??? Th?????ng ????? t???o ra sa m???c ch??? ????? cho con ng?????i bi???t qu?? tr???ng c??y ch?? l??,??? ??ng ngh??.???',3),(3,'B??? Gi??',75000,10,0,'C','bo-gia','Th??? gi???i ng???m ???????c ph???n ??nh trong ti???u thuy???t B??? Gi?? l?? s??? g???p g??? gi???a m???t b??n l?? ?? ch?? c????ng c?????ng v?? n???n t???ng gia t???c ch???t ch??? theo truy???n th???ng mafia x??? Sicily v???i m???t b??n l?? x?? h???i M??? nh???p nh???ng ??en tr???ng, m???nh ?????t m??u m??? cho nh???ng c?? h???i l??m ??n b???t ch??nh h???a h???n nh???ng m??n l???i k???ch x??. Trong th??? gi???i ???y, h??nh t?????ng B??? Gi?? ???????c t??c gi??? d??y c??ng kh???c h???a ???? tr??? th??nh b???c ch??n dung b???t h??? trong l??ng ng?????i ?????c. T??? m???t k??? nh???p c?? tay tr???ng ?????n ??ng tr??m t???t ?????nh quy???n uy, Don Vito Corleone l?? con r???n h??? mang th??m tr???m, nguy hi???m khi???n k??? th?? ph???i ki???ng n???, e d??, nh??ng c??ng ???????c b???n b??, th??n quy???n xem nh?? m???t ?????ng to??n n??ng ?????y ngh??a kh??. Nh??n v???t trung t??m ???y ?????ng th???i c??ng l?? hi???n th??n c???a m???t pho tri???t l?? r???t ????????i??? ???????c nh??o n???n t??? v???n s???ng c???a h??ng ch???c n??m l??n l???n gi???a ch???n giang h??? bao phen v??o sinh ra t???, v?? th??? m?? c?? ?? ki???n cho r???ng ???B??? Gi?? l?? s??? t???ng h??a c???a m???i hi???u bi???t. B??? Gi?? l?? ????p ??n cho m???i c??u h???i???.\r\n\r\nV???i c???u t??? ho??n h???o, c???t truy???n kh??ng thi???u nh???ng pha h??nh ?????ng gay c???n, t??nh ti???t b???t ng??? v?? kh??ng kh?? k??nh ?????ch ?????n ngh???t th???, B??? Gi?? x???ng ????ng l?? ?????nh cao trong s??? nghi???p v??n ch????ng c???a Mario Puzo. V?? nh?? m???t c?? duy??n ?????c bi???t, ngay t??? n??m 1971-1972, B??? Gi?? ???? ?????n v???i b???n ?????c trong n?????c qua phong c??ch chuy???n ng??? h??o s???ng, ?????m ch???t giang h??? c???a d???ch gi??? Ng???c Th??? Lang.',3),(4,'Thinkpad t14 i5 1135G7',24000000,10,0,'C','t14-i5-11th','ok',5),(5,'thinkpad x13 gen2',20000000,10,0,'C','x13-g2','123',5),(6,'Hp elitebook 840 g8',24000000,10,0,'C','elitebook-g8','123',6);
/*!40000 ALTER TABLE `items_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_productimage`
--

DROP TABLE IF EXISTS `items_productimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_productimage` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `items_productimage_product_id_39474ef4_fk_items_product_id` (`product_id`),
  CONSTRAINT `items_productimage_product_id_39474ef4_fk_items_product_id` FOREIGN KEY (`product_id`) REFERENCES `items_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_productimage`
--

LOCK TABLES `items_productimage` WRITE;
/*!40000 ALTER TABLE `items_productimage` DISABLE KEYS */;
INSERT INTO `items_productimage` VALUES (1,'/media/c11af7910ba834212387255234e865d0.jpg.webp',1),(2,'/media/aa81d0a534b45706ae1eee1e344e80d9.jpg.webp',2),(3,'/media/acaa4cc4384ee100984e4293d15165c6.jpg.webp',3),(4,'/media/ThinkPad_T14_Gen_2_Mac24h_dyui-wh.jpg',4),(5,'/media/ThinkPad_T14_Gen_2_Mac24h_dyui-wh.jpg',5),(6,'/media/elitebook.jpg',6);
/*!40000 ALTER TABLE `items_productimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_smartphone`
--

DROP TABLE IF EXISTS `items_smartphone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_smartphone` (
  `product_ptr_id` bigint NOT NULL,
  `cpu` varchar(100) NOT NULL,
  `ram` varchar(100) NOT NULL,
  `rom` varchar(100) NOT NULL,
  `camera` varchar(100) NOT NULL,
  `display` varchar(100) NOT NULL,
  `battery` varchar(100) NOT NULL,
  `os` varchar(100) NOT NULL,
  `brand_id` bigint NOT NULL,
  PRIMARY KEY (`product_ptr_id`),
  KEY `items_smartphone_brand_id_bd767c9b_fk_items_brand_id` (`brand_id`),
  CONSTRAINT `items_smartphone_brand_id_bd767c9b_fk_items_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `items_brand` (`id`),
  CONSTRAINT `items_smartphone_product_ptr_id_db34cf8f_fk_items_product_id` FOREIGN KEY (`product_ptr_id`) REFERENCES `items_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_smartphone`
--

LOCK TABLES `items_smartphone` WRITE;
/*!40000 ALTER TABLE `items_smartphone` DISABLE KEYS */;
/*!40000 ALTER TABLE `items_smartphone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_cart`
--

DROP TABLE IF EXISTS `store_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cart_id` varchar(250) NOT NULL,
  `date_added` datetime(6) NOT NULL,
  `is_checked_out` tinyint(1) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `store_cart_user_id_99e99107_fk_account_account_id` (`user_id`),
  CONSTRAINT `store_cart_user_id_99e99107_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_cart`
--

LOCK TABLES `store_cart` WRITE;
/*!40000 ALTER TABLE `store_cart` DISABLE KEYS */;
INSERT INTO `store_cart` VALUES (1,'3u7u3myoguwwdsgxj4yrfmvm656a5jzu','2022-05-19 16:59:39.383759',0,NULL),(2,'','2022-05-19 16:59:39.389760',0,4),(3,'z9xu1a14n0z6fzp1zbf4a73ebrmqaezc','2022-05-20 10:18:48.129945',0,NULL),(4,'','2022-05-20 10:18:48.140945',0,5),(5,'uo3qpnqmryqtypubx6skfpv5fkycp0wo','2022-05-20 10:45:07.341344',0,NULL),(6,'0x48b1wc9ojkvvaj6vh4lrho5f2yg19b','2022-05-20 10:46:42.676859',0,NULL);
/*!40000 ALTER TABLE `store_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_order`
--

DROP TABLE IF EXISTS `store_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` varchar(20) NOT NULL,
  `order_note` varchar(100) NOT NULL,
  `order_total` double NOT NULL,
  `status` varchar(10) NOT NULL,
  `tax` double NOT NULL,
  `ip` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `cart_id` bigint DEFAULT NULL,
  `payment_id` bigint DEFAULT NULL,
  `shipment_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `store_order_cart_id_3150a667_fk_store_cart_id` (`cart_id`),
  KEY `store_order_payment_id_49852fdc_fk_store_payment_id` (`payment_id`),
  KEY `store_order_shipment_id_1067329c_fk_store_shipment_id` (`shipment_id`),
  KEY `store_order_user_id_ae5f7a5f_fk_account_account_id` (`user_id`),
  CONSTRAINT `store_order_cart_id_3150a667_fk_store_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `store_cart` (`id`),
  CONSTRAINT `store_order_payment_id_49852fdc_fk_store_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `store_payment` (`id`),
  CONSTRAINT `store_order_shipment_id_1067329c_fk_store_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `store_shipment` (`id`),
  CONSTRAINT `store_order_user_id_ae5f7a5f_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_order`
--

LOCK TABLES `store_order` WRITE;
/*!40000 ALTER TABLE `store_order` DISABLE KEYS */;
INSERT INTO `store_order` VALUES (1,'200520221','123',26400000,'New',10,'127.0.0.1','2022-05-20 10:22:51.343811','2022-05-20 10:22:51.356232',4,NULL,1,5),(2,'200520222','123',26400000,'New',10,'127.0.0.1','2022-05-20 10:23:09.360074','2022-05-20 10:23:09.368074',4,NULL,2,5),(3,'200520223','123',26400000,'New',10,'127.0.0.1','2022-05-20 10:25:12.246071','2022-05-20 10:25:12.252067',4,NULL,3,5),(4,'200520224','123',26400000,'New',10,'127.0.0.1','2022-05-20 10:30:39.194929','2022-05-20 10:30:39.206928',4,NULL,4,5),(5,'200520225','123',26400000,'New',10,'127.0.0.1','2022-05-20 10:33:02.880883','2022-05-20 10:33:02.887274',4,NULL,5,5),(6,'200520226','',91080,'New',10,'127.0.0.1','2022-05-20 10:34:54.117180','2022-05-20 10:34:54.126182',4,NULL,6,5),(7,'200520227','',91080,'Completed',10,'127.0.0.1','2022-05-20 10:35:53.279729','2022-05-20 10:35:53.294094',4,NULL,7,5),(8,'200520228','',91080,'New',10,'127.0.0.1','2022-05-20 10:46:53.458629','2022-05-20 10:46:53.480551',2,NULL,8,4);
/*!40000 ALTER TABLE `store_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_payment`
--

DROP TABLE IF EXISTS `store_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(100) NOT NULL,
  `payment_method` varchar(100) NOT NULL,
  `amount` double NOT NULL,
  `status` varchar(10) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `store_payment_user_id_5edbc869_fk_account_account_id` (`user_id`),
  CONSTRAINT `store_payment_user_id_5edbc869_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_payment`
--

LOCK TABLES `store_payment` WRITE;
/*!40000 ALTER TABLE `store_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_productitem`
--

DROP TABLE IF EXISTS `store_productitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_productitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `cart_id` bigint DEFAULT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `store_productitem_cart_id_35df35cd_fk_store_cart_id` (`cart_id`),
  KEY `store_productitem_product_id_5792a8a9_fk_items_product_id` (`product_id`),
  KEY `store_productitem_user_id_58762aa2_fk_account_account_id` (`user_id`),
  CONSTRAINT `store_productitem_cart_id_35df35cd_fk_store_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `store_cart` (`id`),
  CONSTRAINT `store_productitem_product_id_5792a8a9_fk_items_product_id` FOREIGN KEY (`product_id`) REFERENCES `items_product` (`id`),
  CONSTRAINT `store_productitem_user_id_58762aa2_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_productitem`
--

LOCK TABLES `store_productitem` WRITE;
/*!40000 ALTER TABLE `store_productitem` DISABLE KEYS */;
INSERT INTO `store_productitem` VALUES (1,1,0,4,4,NULL),(2,1,1,4,1,NULL),(3,1,1,2,1,4);
/*!40000 ALTER TABLE `store_productitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_reviewrating`
--

DROP TABLE IF EXISTS `store_reviewrating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_reviewrating` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subject` varchar(100) NOT NULL,
  `review` longtext NOT NULL,
  `rating` double NOT NULL,
  `ip` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `store_reviewrating_product_id_2e1974d6_fk_items_product_id` (`product_id`),
  KEY `store_reviewrating_user_id_da0ed849_fk_account_account_id` (`user_id`),
  CONSTRAINT `store_reviewrating_product_id_2e1974d6_fk_items_product_id` FOREIGN KEY (`product_id`) REFERENCES `items_product` (`id`),
  CONSTRAINT `store_reviewrating_user_id_da0ed849_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_reviewrating`
--

LOCK TABLES `store_reviewrating` WRITE;
/*!40000 ALTER TABLE `store_reviewrating` DISABLE KEYS */;
INSERT INTO `store_reviewrating` VALUES (1,'hay','123',3.5,'127.0.0.1',1,'2022-05-20 10:47:11.759686','2022-05-20 10:47:11.759686',1,4);
/*!40000 ALTER TABLE `store_reviewrating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_shipment`
--

DROP TABLE IF EXISTS `store_shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_shipment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `shipment_method` varchar(100) DEFAULT NULL,
  `address_line_1` varchar(100) NOT NULL,
  `address_line_2` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `fee` double NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_shipment`
--

LOCK TABLES `store_shipment` WRITE;
/*!40000 ALTER TABLE `store_shipment` DISABLE KEYS */;
INSERT INTO `store_shipment` VALUES (1,NULL,'42 Hang Voi','','Ha Noi','Vietnam',0,'Pending'),(2,NULL,'42 Hang Voi','','Ha Noi','Vietnam',0,'Pending'),(3,NULL,'42 Hang Voi','','Ha Noi','Vietnam',0,'Pending'),(4,NULL,'42 Hang Voi','','Ha Noi','Vietnam',0,'Pending'),(5,NULL,'42 Hang Voi','','Ha Noi','Vietnam',0,'Pending'),(6,NULL,'42 Hang Voi','','Ha Noi','Vietnam',0,'Pending'),(7,NULL,'42 Hang Voi','','Ha Noi','Vietnam',0,'Pending'),(8,NULL,'42 Hang Voi','','Ha Noi','Vietnam',0,'Pending');
/*!40000 ALTER TABLE `store_shipment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-20 17:51:36

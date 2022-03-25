-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: bookstr
-- ------------------------------------------------------
-- Server version	8.0.26

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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add item',7,'add_item'),(26,'Can change item',7,'change_item'),(27,'Can delete item',7,'delete_item'),(28,'Can view item',7,'view_item'),(29,'Can add book category',8,'add_bookcategory'),(30,'Can change book category',8,'change_bookcategory'),(31,'Can delete book category',8,'delete_bookcategory'),(32,'Can view book category',8,'view_bookcategory'),(33,'Can add smartphone brand',9,'add_smartphonebrand'),(34,'Can change smartphone brand',9,'change_smartphonebrand'),(35,'Can delete smartphone brand',9,'delete_smartphonebrand'),(36,'Can view smartphone brand',9,'view_smartphonebrand'),(37,'Can add author',10,'add_author'),(38,'Can change author',10,'change_author'),(39,'Can delete author',10,'delete_author'),(40,'Can view author',10,'view_author'),(41,'Can add laptop brand',11,'add_laptopbrand'),(42,'Can change laptop brand',11,'change_laptopbrand'),(43,'Can delete laptop brand',11,'delete_laptopbrand'),(44,'Can view laptop brand',11,'view_laptopbrand'),(45,'Can add product',12,'add_product'),(46,'Can change product',12,'change_product'),(47,'Can delete product',12,'delete_product'),(48,'Can view product',12,'view_product'),(49,'Can add product image',13,'add_productimage'),(50,'Can change product image',13,'change_productimage'),(51,'Can delete product image',13,'delete_productimage'),(52,'Can view product image',13,'view_productimage'),(53,'Can add laptop',14,'add_laptop'),(54,'Can change laptop',14,'change_laptop'),(55,'Can delete laptop',14,'delete_laptop'),(56,'Can view laptop',14,'view_laptop'),(57,'Can add smartphone',15,'add_smartphone'),(58,'Can change smartphone',15,'change_smartphone'),(59,'Can delete smartphone',15,'delete_smartphone'),(60,'Can view smartphone',15,'view_smartphone'),(61,'Can add book',16,'add_book'),(62,'Can change book',16,'change_book'),(63,'Can delete book',16,'delete_book'),(64,'Can view book',16,'view_book');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (2,'pbkdf2_sha256$320000$rHZnbbmzFVhLMESsElHCGA$99Lbt9gB56Oi9YJRUUwnXKOyNsc8/G2FEBrGQ8e/6s0=','2022-03-24 07:12:07.426777',1,'admin','','','',1,1,'2022-03-24 07:11:56.696313');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
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
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2022-03-24 07:12:57.437361','1','cuong',2,'[{\"changed\": {\"fields\": [\"Superuser status\"]}}]',4,2),(2,'2022-03-24 07:13:07.505686','1','cuong',3,'',4,2),(3,'2022-03-24 15:04:06.997273','1','Sách tiếng việt',1,'[{\"added\": {}}]',8,2),(4,'2022-03-24 15:04:22.515486','2','Sách văn học',1,'[{\"added\": {}}]',8,2),(5,'2022-03-24 15:04:35.747160','3','Sách kinh tế',1,'[{\"added\": {}}]',8,2),(6,'2022-03-24 15:04:35.800019','4','Sách kinh tế',1,'[{\"added\": {}}]',8,2),(7,'2022-03-24 15:04:40.856804','3','Sách kinh tế',3,'',8,2),(8,'2022-03-24 15:04:57.358389','5','Sách thiếu nhi',1,'[{\"added\": {}}]',8,2),(9,'2022-03-24 15:05:10.236724','1','Sách tiếng Việt',2,'[{\"changed\": {\"fields\": [\"Name\"]}}]',8,2),(10,'2022-03-24 15:05:45.513292','2','Sách văn học',2,'[]',8,2),(11,'2022-03-24 15:05:57.865957','6','Tiểu thuyết',1,'[{\"added\": {}}]',8,2),(12,'2022-03-24 15:06:14.817131','7','Thơ',1,'[{\"added\": {}}]',8,2),(13,'2022-03-24 15:06:37.139208','8','Sách khởi nghiệp',1,'[{\"added\": {}}]',8,2),(14,'2022-03-24 15:06:53.653780','9','Sách kinh tế học',1,'[{\"added\": {}}]',8,2),(15,'2022-03-24 15:14:58.884288','1','Antoine De Saint-Exupéry',1,'[{\"added\": {}}]',10,2),(16,'2022-03-24 15:15:01.554531','1','Hoàng Tử Bé',1,'[{\"added\": {}}]',16,2),(17,'2022-03-24 15:16:07.129442','2','Chuyến Thư Miền Nam',1,'[{\"added\": {}}]',16,2),(18,'2022-03-24 15:16:14.500154','1','Hoàng Tử Bé',2,'[{\"changed\": {\"fields\": [\"Category\"]}}]',16,2),(19,'2022-03-25 04:09:47.981597','10','Sách giáo khoa',1,'[{\"added\": {}}]',8,2),(20,'2022-03-25 04:29:11.238884','4','Toán 11',3,'',16,2),(21,'2022-03-25 04:31:26.666075','7','Toán 12',3,'',16,2),(22,'2022-03-25 08:13:34.754230','8','Hoàng Tử Bé',1,'[{\"added\": {}}]',16,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(10,'items','author'),(16,'items','book'),(8,'items','bookcategory'),(7,'items','item'),(14,'items','laptop'),(11,'items','laptopbrand'),(12,'items','product'),(13,'items','productimage'),(15,'items','smartphone'),(9,'items','smartphonebrand'),(6,'sessions','session');
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-03-11 08:14:36.834484'),(2,'auth','0001_initial','2022-03-11 08:14:38.073282'),(3,'admin','0001_initial','2022-03-11 08:14:38.461245'),(4,'admin','0002_logentry_remove_auto_add','2022-03-11 08:14:38.472240'),(5,'admin','0003_logentry_add_action_flag_choices','2022-03-11 08:14:38.483214'),(6,'contenttypes','0002_remove_content_type_name','2022-03-11 08:14:38.616829'),(7,'auth','0002_alter_permission_name_max_length','2022-03-11 08:14:38.708583'),(8,'auth','0003_alter_user_email_max_length','2022-03-11 08:14:38.740498'),(9,'auth','0004_alter_user_username_opts','2022-03-11 08:14:38.751468'),(10,'auth','0005_alter_user_last_login_null','2022-03-11 08:14:38.964898'),(11,'auth','0006_require_contenttypes_0002','2022-03-11 08:14:38.968887'),(12,'auth','0007_alter_validators_add_error_messages','2022-03-11 08:14:38.980878'),(13,'auth','0008_alter_user_username_max_length','2022-03-11 08:14:39.074146'),(14,'auth','0009_alter_user_last_name_max_length','2022-03-11 08:14:39.260620'),(15,'auth','0010_alter_group_name_max_length','2022-03-11 08:14:39.289778'),(16,'auth','0011_update_proxy_permissions','2022-03-11 08:14:39.303721'),(17,'auth','0012_alter_user_first_name_max_length','2022-03-11 08:14:39.392164'),(18,'items','0001_initial','2022-03-11 08:14:39.429070'),(19,'items','0002_alter_item_id','2022-03-11 08:14:39.503866'),(20,'items','0003_item_author_item_create_at_item_description_and_more','2022-03-11 08:14:39.763455'),(21,'items','0004_alter_item_table','2022-03-11 08:14:39.790382'),(22,'sessions','0001_initial','2022-03-11 08:14:40.034732'),(23,'items','0005_author_bookcategory_laptopbrand_product_productimage_and_more','2022-03-23 16:20:34.283307'),(24,'items','0006_book_category','2022-03-24 10:14:29.429167'),(25,'items','0007_alter_bookcategory_options_alter_bookcategory_parent','2022-03-24 15:44:41.946752'),(26,'items','0008_alter_product_sold_alter_product_stock','2022-03-24 16:41:46.409001'),(27,'items','0009_alter_book_publication_date','2022-03-24 17:06:41.088399'),(28,'items','0010_alter_book_numbers_of_pages_alter_product_status','2022-03-25 04:17:58.828021');
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
INSERT INTO `django_session` VALUES ('7t3qn82593924k14rm2fbdkdy6jdusfx','.eJxVjDkOwjAUBe_iGlnxFseU9JzB-ptxADlSlgpxd4iUAto3M--lMmxrzdsicx5ZnZVVp98NgR7SdsB3aLdJ09TWeUS9K_qgi75OLM_L4f4dVFjqt3ZdXxgKWTbsEluwWEIQIG_EhU6ITSKKIfoSU2_cEDkiSkLxNHQY1PsDCgs4xA:1nXHdf:q_QJozaFy5OatwE0pS0cT_BUNmVsojPue8VQ0orqm2A','2022-04-07 07:12:07.438745');
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_author`
--

LOCK TABLES `items_author` WRITE;
/*!40000 ALTER TABLE `items_author` DISABLE KEYS */;
INSERT INTO `items_author` VALUES (1,'Antoine De Saint-Exupéry'),(21,'Tô Hoài'),(25,'NXB Giáo dục');
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
  `category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`product_ptr_id`),
  KEY `items_book_author_id_f075a352_fk_items_author_id` (`author_id`),
  KEY `items_book_category_id_247d4651_fk_items_bookcategory_id` (`category_id`),
  CONSTRAINT `items_book_author_id_f075a352_fk_items_author_id` FOREIGN KEY (`author_id`) REFERENCES `items_author` (`id`),
  CONSTRAINT `items_book_category_id_247d4651_fk_items_bookcategory_id` FOREIGN KEY (`category_id`) REFERENCES `items_bookcategory` (`id`),
  CONSTRAINT `items_book_product_ptr_id_8b445138_fk_items_product_id` FOREIGN KEY (`product_ptr_id`) REFERENCES `items_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_book`
--

LOCK TABLES `items_book` WRITE;
/*!40000 ALTER TABLE `items_book` DISABLE KEYS */;
INSERT INTO `items_book` VALUES (2,'Nhã Nam',2022,999,1,5),(3,'Giáo dục',2020,0,25,10),(5,'Giáo dục',2020,0,25,10),(8,'Nhã Nam',2020,0,1,5);
/*!40000 ALTER TABLE `items_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_bookcategory`
--

DROP TABLE IF EXISTS `items_bookcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_bookcategory` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `items_bookcategory_parent_id_6704045a_fk_items_bookcategory_id` (`parent_id`),
  CONSTRAINT `items_bookcategory_parent_id_6704045a_fk_items_bookcategory_id` FOREIGN KEY (`parent_id`) REFERENCES `items_bookcategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_bookcategory`
--

LOCK TABLES `items_bookcategory` WRITE;
/*!40000 ALTER TABLE `items_bookcategory` DISABLE KEYS */;
INSERT INTO `items_bookcategory` VALUES (1,'Sách tiếng Việt',NULL),(2,'Sách văn học',1),(4,'Sách kinh tế',1),(5,'Sách thiếu nhi',1),(6,'Tiểu thuyết',2),(7,'Thơ',2),(8,'Sách khởi nghiệp',4),(9,'Sách kinh tế học',4),(10,'Sách giáo khoa',1);
/*!40000 ALTER TABLE `items_bookcategory` ENABLE KEYS */;
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
  KEY `items_laptop_brand_id_a5ee977c_fk_items_laptopbrand_id` (`brand_id`),
  CONSTRAINT `items_laptop_brand_id_a5ee977c_fk_items_laptopbrand_id` FOREIGN KEY (`brand_id`) REFERENCES `items_laptopbrand` (`id`),
  CONSTRAINT `items_laptop_product_ptr_id_314cf043_fk_items_product_id` FOREIGN KEY (`product_ptr_id`) REFERENCES `items_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_laptop`
--

LOCK TABLES `items_laptop` WRITE;
/*!40000 ALTER TABLE `items_laptop` DISABLE KEYS */;
/*!40000 ALTER TABLE `items_laptop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_laptopbrand`
--

DROP TABLE IF EXISTS `items_laptopbrand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_laptopbrand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `origin` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_laptopbrand`
--

LOCK TABLES `items_laptopbrand` WRITE;
/*!40000 ALTER TABLE `items_laptopbrand` DISABLE KEYS */;
/*!40000 ALTER TABLE `items_laptopbrand` ENABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `items_product_slug_ff2aa378` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_product`
--

LOCK TABLES `items_product` WRITE;
/*!40000 ALTER TABLE `items_product` DISABLE KEYS */;
INSERT INTO `items_product` VALUES (2,'Chuyến Thư Miền Nam',49000,1,0,'C','chuyen-thu-mien-nam','       da chinh sua lan 7'),(3,'Toán 10',10000,0,0,'CH','toan-10','avc'),(5,'Toán 11',10000,0,0,'H','toan-11','abc'),(8,'Hoàng Tử Bé',50000,0,0,'C','hoang-tu-be','123');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_productimage`
--

LOCK TABLES `items_productimage` WRITE;
/*!40000 ALTER TABLE `items_productimage` DISABLE KEYS */;
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
  KEY `items_smartphone_brand_id_bd767c9b_fk_items_smartphonebrand_id` (`brand_id`),
  CONSTRAINT `items_smartphone_brand_id_bd767c9b_fk_items_smartphonebrand_id` FOREIGN KEY (`brand_id`) REFERENCES `items_smartphonebrand` (`id`),
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
-- Table structure for table `items_smartphonebrand`
--

DROP TABLE IF EXISTS `items_smartphonebrand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items_smartphonebrand` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `origin` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_smartphonebrand`
--

LOCK TABLES `items_smartphonebrand` WRITE;
/*!40000 ALTER TABLE `items_smartphonebrand` DISABLE KEYS */;
/*!40000 ALTER TABLE `items_smartphonebrand` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-25 16:47:02

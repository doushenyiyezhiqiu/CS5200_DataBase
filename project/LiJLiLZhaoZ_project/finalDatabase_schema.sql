CREATE DATABASE  IF NOT EXISTS `project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `project`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: project
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
-- Table structure for table `college`
--

DROP TABLE IF EXISTS `college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'cascading delete student',
  `college` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`college`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college`
--

LOCK TABLES `college` WRITE;
/*!40000 ALTER TABLE `college` DISABLE KEYS */;
INSERT INTO `college` VALUES (60,'College of Engineering'),(59,'Khoury College of Computer Sciences');
/*!40000 ALTER TABLE `college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `colleges` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `teachname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `cname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `star` int DEFAULT '0',
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  KEY `co` (`colleges`) USING BTREE,
  KEY `bo_1` (`teachname`) USING BTREE,
  KEY `cname` (`cname`) USING BTREE,
  KEY `tem` (`id`) USING BTREE,
  CONSTRAINT `bo_1` FOREIGN KEY (`teachname`) REFERENCES `teacher` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `co` FOREIGN KEY (`colleges`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tem` FOREIGN KEY (`id`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('Khoury College of Computer Sciences','Alex','Computer System',1,'12021591'),('Khoury College of Computer Sciences','Alex','Database',1,'12021591'),('Khoury College of Computer Sciences','Alex','Data Visualization',2,'12021591'),('Khoury College of Computer Sciences','Alex','Data Mining',1,'12021591'),('Khoury College of Computer Sciences','Alex','Computer Security',3,'12021591');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_syllabus`
--

DROP TABLE IF EXISTS `course_syllabus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_syllabus` (
  `course_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `syllabus_content` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`course_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_syllabus`
--

LOCK TABLES `course_syllabus` WRITE;
/*!40000 ALTER TABLE `course_syllabus` DISABLE KEYS */;
INSERT INTO `course_syllabus` VALUES ('Computer System','score>=90:A;80<=score<90,B;60<=score<80,C;score<60:D');
/*!40000 ALTER TABLE `course_syllabus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major`
--

DROP TABLE IF EXISTS `major`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `major` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `college` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'College',
  `proname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Major name',
  PRIMARY KEY (`proname`) USING BTREE,
  UNIQUE KEY `id_name` (`id`) USING BTREE COMMENT 'unique',
  KEY `co_1` (`college`) USING BTREE,
  CONSTRAINT `co_1` FOREIGN KEY (`college`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major`
--

LOCK TABLES `major` WRITE;
/*!40000 ALTER TABLE `major` DISABLE KEYS */;
INSERT INTO `major` VALUES (33,'Khoury College of Computer Sciences','Computer Science'),(34,'College of Engineering','Electrical and Computer Engineering');
/*!40000 ALTER TABLE `major` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optcous`
--

DROP TABLE IF EXISTS `optcous`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `optcous` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'CRN',
  `college` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'College',
  `teanum` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'teacher id',
  `teacher` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'teacher',
  `coursname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'course name',
  `clstime` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'time',
  `numpeo` int DEFAULT '0' COMMENT 'student number',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `co_3` (`college`) USING BTREE,
  KEY `t_1` (`teacher`) USING BTREE,
  KEY `t_2` (`coursname`) USING BTREE,
  KEY `t_4` (`teanum`) USING BTREE,
  CONSTRAINT `co_3` FOREIGN KEY (`college`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_1` FOREIGN KEY (`teacher`) REFERENCES `teacher` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_2` FOREIGN KEY (`coursname`) REFERENCES `course` (`cname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_4` FOREIGN KEY (`teanum`) REFERENCES `teacher` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12021544 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optcous`
--

LOCK TABLES `optcous` WRITE;
/*!40000 ALTER TABLE `optcous` DISABLE KEYS */;
INSERT INTO `optcous` VALUES (12021541,'Khoury College of Computer Sciences','12021591','Alex','Computer System','morning',1),(12021542,'Khoury College of Computer Sciences','12021591','Alex','Database','morning',1),(12021543,'Khoury College of Computer Sciences','12021591','Alex','Data Mining','morning',0);
/*!40000 ALTER TABLE `optcous` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studengcours`
--

DROP TABLE IF EXISTS `studengcours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studengcours` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'SN',
  `college` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'college',
  `pro` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '0' COMMENT 'major',
  `optcouse` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'course name',
  `count` int DEFAULT NULL COMMENT 'score',
  `stunum` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'student id',
  `cousid` int DEFAULT NULL COMMENT 'course ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `stu_s` (`stunum`) USING BTREE,
  KEY `cou_s` (`cousid`) USING BTREE,
  KEY `co_4` (`college`) USING BTREE,
  KEY `t_5` (`optcouse`) USING BTREE,
  KEY `t_6` (`pro`) USING BTREE,
  CONSTRAINT `co_4` FOREIGN KEY (`college`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cou_s` FOREIGN KEY (`cousid`) REFERENCES `optcous` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stu_s` FOREIGN KEY (`stunum`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_5` FOREIGN KEY (`optcouse`) REFERENCES `course` (`cname`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_6` FOREIGN KEY (`pro`) REFERENCES `student` (`peojob`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studengcours`
--

LOCK TABLES `studengcours` WRITE;
/*!40000 ALTER TABLE `studengcours` DISABLE KEYS */;
INSERT INTO `studengcours` VALUES (171,'Khoury College of Computer Sciences','Computer Science','Computer System',98,'2021592',12021541),(172,'Khoury College of Computer Sciences','Computer Science','Database',99,'2021592',12021542);
/*!40000 ALTER TABLE `studengcours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `oncollege` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `peojob` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sex` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `inyear` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `co_5` (`oncollege`) USING BTREE,
  KEY `peojob` (`peojob`) USING BTREE,
  CONSTRAINT `co_5` FOREIGN KEY (`oncollege`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `q_8` FOREIGN KEY (`peojob`) REFERENCES `major` (`proname`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('2021592','Jack','Khoury College of Computer Sciences','Computer Science','Male','2021'),('2021593','Victor','College of Engineering','Electrical and Computer Engineering','Male','2021');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `demos` BEFORE DELETE ON `student` FOR EACH ROW BEGIN

delete from users where account=old.id;


end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `student_reviews`
--

DROP TABLE IF EXISTS `student_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_reviews` (
  `student_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `course_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `review_content` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`student_id`,`course_name`) USING BTREE,
  CONSTRAINT `student_reviews_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_reviews`
--

LOCK TABLES `student_reviews` WRITE;
/*!40000 ALTER TABLE `student_reviews` DISABLE KEYS */;
INSERT INTO `student_reviews` VALUES ('2021592','Computer System','Good');
/*!40000 ALTER TABLE `student_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `oncollege` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `edu` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sex` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `inyear` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `co_6` (`oncollege`) USING BTREE,
  KEY `name` (`name`) USING BTREE,
  CONSTRAINT `co_6` FOREIGN KEY (`oncollege`) REFERENCES `college` (`college`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES ('12021591','Alex','Khoury College of Computer Sciences','Doctor','Male','2021'),('12021592','Tony','College of Engineering','Doctor','Male','2022');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `demo` BEFORE DELETE ON `teacher` FOR EACH ROW BEGIN

delete from users where account=old.id;


end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `teachers_to_students`
--

DROP TABLE IF EXISTS `teachers_to_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers_to_students` (
  `student_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `student_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `teacher_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `teacher_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`student_id`,`teacher_id`) USING BTREE,
  CONSTRAINT `teachers_to_students_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers_to_students`
--

LOCK TABLES `teachers_to_students` WRITE;
/*!40000 ALTER TABLE `teachers_to_students` DISABLE KEYS */;
INSERT INTO `teachers_to_students` VALUES ('2021592','Jack','12021591','Alex');
/*!40000 ALTER TABLE `teachers_to_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `pow` int DEFAULT NULL COMMENT '1 is manager 2 is teacher 3 is student',
  PRIMARY KEY (`account`) USING BTREE,
  UNIQUE KEY `id_one` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=161176 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (161174,'12021591','12021591',2),(161175,'2021592','2021592',3),(1,'root','root',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'project'
--

--
-- Dumping routines for database 'project'
--
/*!50003 DROP PROCEDURE IF EXISTS `student_course` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_course`(
	IN student_id VARCHAR(100))
BEGIN
SELECT `id`, `coursname` FROM `optcous` WHERE `id` = student_id
; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-30 16:47:38

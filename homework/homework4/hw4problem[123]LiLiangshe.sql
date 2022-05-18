CREATE DATABASE  IF NOT EXISTS `hw4problem1_perfectpets` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hw4problem1_perfectpets`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: hw4problem1_perfectpets
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
-- Table structure for table `clinic`
--

DROP TABLE IF EXISTS `clinic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic` (
  `clinicNo` int NOT NULL,
  PRIMARY KEY (`clinicNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic`
--

LOCK TABLES `clinic` WRITE;
/*!40000 ALTER TABLE `clinic` DISABLE KEYS */;
/*!40000 ALTER TABLE `clinic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examination`
--

DROP TABLE IF EXISTS `examination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `examination` (
  `examNo` int NOT NULL,
  `staffNo` int DEFAULT NULL,
  `petNo` int DEFAULT NULL,
  PRIMARY KEY (`examNo`),
  KEY `staffNo` (`staffNo`),
  KEY `petNo` (`petNo`),
  CONSTRAINT `examination_ibfk_1` FOREIGN KEY (`staffNo`) REFERENCES `staff` (`staffNo`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `examination_ibfk_2` FOREIGN KEY (`petNo`) REFERENCES `pet` (`petNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examination`
--

LOCK TABLES `examination` WRITE;
/*!40000 ALTER TABLE `examination` DISABLE KEYS */;
/*!40000 ALTER TABLE `examination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `staffNo` int NOT NULL,
  `clinicNo` int NOT NULL,
  PRIMARY KEY (`staffNo`,`clinicNo`),
  KEY `clinicNo` (`clinicNo`),
  CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`staffNo`) REFERENCES `staff` (`staffNo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `manager_ibfk_2` FOREIGN KEY (`clinicNo`) REFERENCES `clinic` (`clinicNo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pet`
--

DROP TABLE IF EXISTS `pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pet` (
  `petNo` int NOT NULL,
  `ownerId` int DEFAULT NULL,
  `clinicNo` int DEFAULT NULL,
  PRIMARY KEY (`petNo`),
  KEY `ownerId` (`ownerId`),
  KEY `clinicNo` (`clinicNo`),
  CONSTRAINT `pet_ibfk_1` FOREIGN KEY (`ownerId`) REFERENCES `petowner` (`ownerId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pet_ibfk_2` FOREIGN KEY (`clinicNo`) REFERENCES `clinic` (`clinicNo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pet`
--

LOCK TABLES `pet` WRITE;
/*!40000 ALTER TABLE `pet` DISABLE KEYS */;
/*!40000 ALTER TABLE `pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `petowner`
--

DROP TABLE IF EXISTS `petowner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `petowner` (
  `ownerId` int NOT NULL,
  PRIMARY KEY (`ownerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `petowner`
--

LOCK TABLES `petowner` WRITE;
/*!40000 ALTER TABLE `petowner` DISABLE KEYS */;
/*!40000 ALTER TABLE `petowner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staffNo` int NOT NULL,
  `clinicNo` int DEFAULT NULL,
  PRIMARY KEY (`staffNo`),
  KEY `clinicNo` (`clinicNo`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`clinicNo`) REFERENCES `clinic` (`clinicNo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment`
--

DROP TABLE IF EXISTS `treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treatment` (
  `treatNo` int NOT NULL,
  `petNo` int DEFAULT NULL,
  `examNo` int DEFAULT NULL,
  PRIMARY KEY (`treatNo`),
  KEY `petNo` (`petNo`),
  KEY `examNo` (`examNo`),
  CONSTRAINT `treatment_ibfk_1` FOREIGN KEY (`petNo`) REFERENCES `pet` (`petNo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `treatment_ibfk_2` FOREIGN KEY (`examNo`) REFERENCES `examination` (`examNo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatment`
--

LOCK TABLES `treatment` WRITE;
/*!40000 ALTER TABLE `treatment` DISABLE KEYS */;
/*!40000 ALTER TABLE `treatment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-13 22:27:22
CREATE DATABASE  IF NOT EXISTS `hw4problem2_regionalschools` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hw4problem2_regionalschools`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: hw4problem2_regionalschools
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
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager` (
  `NIN` int NOT NULL,
  `schoolId` int NOT NULL,
  `start_date` date DEFAULT NULL,
  PRIMARY KEY (`NIN`,`schoolId`),
  KEY `schoolId` (`schoolId`),
  CONSTRAINT `manager_ibfk_1` FOREIGN KEY (`NIN`) REFERENCES `teacher` (`NIN`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `manager_ibfk_2` FOREIGN KEY (`schoolId`) REFERENCES `school` (`schoolId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pupil`
--

DROP TABLE IF EXISTS `pupil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pupil` (
  `pupilId` int NOT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `schoolId` int DEFAULT NULL,
  PRIMARY KEY (`pupilId`),
  KEY `schoolId` (`schoolId`),
  CONSTRAINT `pupil_ibfk_1` FOREIGN KEY (`schoolId`) REFERENCES `school` (`schoolId`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pupil`
--

LOCK TABLES `pupil` WRITE;
/*!40000 ALTER TABLE `pupil` DISABLE KEYS */;
/*!40000 ALTER TABLE `pupil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pupil_to_subject`
--

DROP TABLE IF EXISTS `pupil_to_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pupil_to_subject` (
  `pupilId` int NOT NULL,
  `subjectNo` int NOT NULL,
  PRIMARY KEY (`pupilId`,`subjectNo`),
  KEY `subjectNo` (`subjectNo`),
  CONSTRAINT `pupil_to_subject_ibfk_1` FOREIGN KEY (`pupilId`) REFERENCES `pupil` (`pupilId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `pupil_to_subject_ibfk_2` FOREIGN KEY (`subjectNo`) REFERENCES `subject_list` (`subjectNo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pupil_to_subject`
--

LOCK TABLES `pupil_to_subject` WRITE;
/*!40000 ALTER TABLE `pupil_to_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `pupil_to_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pupilname`
--

DROP TABLE IF EXISTS `pupilname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pupilname` (
  `pupilId` int NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pupilId`),
  CONSTRAINT `pupilname_ibfk_1` FOREIGN KEY (`pupilId`) REFERENCES `pupil` (`pupilId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pupilname`
--

LOCK TABLES `pupilname` WRITE;
/*!40000 ALTER TABLE `pupilname` DISABLE KEYS */;
/*!40000 ALTER TABLE `pupilname` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school` (
  `schoolId` int NOT NULL,
  `schoolName` varchar(64) DEFAULT NULL,
  `phone_number` int DEFAULT NULL,
  PRIMARY KEY (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school`
--

LOCK TABLES `school` WRITE;
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
/*!40000 ALTER TABLE `school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schooladdr`
--

DROP TABLE IF EXISTS `schooladdr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schooladdr` (
  `schoolId` int NOT NULL,
  `town` varchar(30) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `zip_code` int DEFAULT NULL,
  PRIMARY KEY (`schoolId`),
  CONSTRAINT `schooladdr_ibfk_1` FOREIGN KEY (`schoolId`) REFERENCES `school` (`schoolId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schooladdr`
--

LOCK TABLES `schooladdr` WRITE;
/*!40000 ALTER TABLE `schooladdr` DISABLE KEYS */;
/*!40000 ALTER TABLE `schooladdr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_list`
--

DROP TABLE IF EXISTS `subject_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject_list` (
  `subjectNo` int NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `subjectType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`subjectNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_list`
--

LOCK TABLES `subject_list` WRITE;
/*!40000 ALTER TABLE `subject_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `NIN` int NOT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `qualifications` varchar(200) DEFAULT NULL,
  `schoolId` int DEFAULT NULL,
  PRIMARY KEY (`NIN`),
  KEY `schoolId` (`schoolId`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`schoolId`) REFERENCES `school` (`schoolId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher_to_subject`
--

DROP TABLE IF EXISTS `teacher_to_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher_to_subject` (
  `NIN` int NOT NULL,
  `subjectNo` int NOT NULL,
  `hours_required` int DEFAULT NULL,
  PRIMARY KEY (`NIN`,`subjectNo`),
  KEY `subjectNo` (`subjectNo`),
  CONSTRAINT `teacher_to_subject_ibfk_1` FOREIGN KEY (`NIN`) REFERENCES `teacher` (`NIN`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `teacher_to_subject_ibfk_2` FOREIGN KEY (`subjectNo`) REFERENCES `subject_list` (`subjectNo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_to_subject`
--

LOCK TABLES `teacher_to_subject` WRITE;
/*!40000 ALTER TABLE `teacher_to_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `teacher_to_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachername`
--

DROP TABLE IF EXISTS `teachername`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachername` (
  `NIN` int NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`NIN`),
  CONSTRAINT `teachername_ibfk_1` FOREIGN KEY (`NIN`) REFERENCES `teacher` (`NIN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachername`
--

LOCK TABLES `teachername` WRITE;
/*!40000 ALTER TABLE `teachername` DISABLE KEYS */;
/*!40000 ALTER TABLE `teachername` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-13 22:27:22
CREATE DATABASE  IF NOT EXISTS `hw4problem3_busybee` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hw4problem3_busybee`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: hw4problem3_busybee
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
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrator` (
  `staffNo` int NOT NULL,
  PRIMARY KEY (`staffNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `adminstrator_office_work`
--

DROP TABLE IF EXISTS `adminstrator_office_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminstrator_office_work` (
  `admin_no` int NOT NULL,
  `work_content` varchar(50) NOT NULL,
  PRIMARY KEY (`admin_no`,`work_content`),
  KEY `work_content` (`work_content`),
  CONSTRAINT `adminstrator_office_work_ibfk_1` FOREIGN KEY (`admin_no`) REFERENCES `administrator` (`staffNo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `adminstrator_office_work_ibfk_2` FOREIGN KEY (`work_content`) REFERENCES `office_work` (`work_content`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminstrator_office_work`
--

LOCK TABLES `adminstrator_office_work` WRITE;
/*!40000 ALTER TABLE `adminstrator_office_work` DISABLE KEYS */;
/*!40000 ALTER TABLE `adminstrator_office_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clean_group`
--

DROP TABLE IF EXISTS `clean_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clean_group` (
  `groupNo` int NOT NULL,
  PRIMARY KEY (`groupNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clean_group`
--

LOCK TABLES `clean_group` WRITE;
/*!40000 ALTER TABLE `clean_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `clean_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clean_staff`
--

DROP TABLE IF EXISTS `clean_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clean_staff` (
  `staffNo` int NOT NULL,
  `is_supervisor` tinyint(1) DEFAULT NULL,
  `groupNo` int DEFAULT NULL,
  PRIMARY KEY (`staffNo`),
  KEY `groupNo` (`groupNo`),
  CONSTRAINT `clean_staff_ibfk_1` FOREIGN KEY (`groupNo`) REFERENCES `clean_group` (`groupNo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clean_staff`
--

LOCK TABLES `clean_staff` WRITE;
/*!40000 ALTER TABLE `clean_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `clean_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cleaning_staff_to_job`
--

DROP TABLE IF EXISTS `cleaning_staff_to_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cleaning_staff_to_job` (
  `staffNo` int NOT NULL,
  `jobNo` int NOT NULL,
  `hours_required` int DEFAULT NULL,
  PRIMARY KEY (`staffNo`,`jobNo`),
  KEY `jobNo` (`jobNo`),
  CONSTRAINT `cleaning_staff_to_job_ibfk_1` FOREIGN KEY (`staffNo`) REFERENCES `clean_staff` (`staffNo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cleaning_staff_to_job_ibfk_2` FOREIGN KEY (`jobNo`) REFERENCES `job` (`jobNo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cleaning_staff_to_job`
--

LOCK TABLES `cleaning_staff_to_job` WRITE;
/*!40000 ALTER TABLE `cleaning_staff_to_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `cleaning_staff_to_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_list`
--

DROP TABLE IF EXISTS `client_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_list` (
  `clientId` int NOT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `client_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`clientId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_list`
--

LOCK TABLES `client_list` WRITE;
/*!40000 ALTER TABLE `client_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `equipmentId` int NOT NULL,
  `equipment_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`equipmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment_to_job`
--

DROP TABLE IF EXISTS `equipment_to_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment_to_job` (
  `jobNo` int NOT NULL,
  `equipmentId` int NOT NULL,
  PRIMARY KEY (`jobNo`,`equipmentId`),
  KEY `equipmentId` (`equipmentId`),
  CONSTRAINT `equipment_to_job_ibfk_1` FOREIGN KEY (`jobNo`) REFERENCES `job` (`jobNo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `equipment_to_job_ibfk_2` FOREIGN KEY (`equipmentId`) REFERENCES `equipment` (`equipmentId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment_to_job`
--

LOCK TABLES `equipment_to_job` WRITE;
/*!40000 ALTER TABLE `equipment_to_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment_to_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job` (
  `jobNo` int NOT NULL,
  `specific_time` date NOT NULL,
  `specific_requirement` varchar(300) NOT NULL,
  `clientId` int DEFAULT NULL,
  `admin_no` int DEFAULT NULL,
  `supervisor_no` int DEFAULT NULL,
  PRIMARY KEY (`jobNo`),
  KEY `clientId` (`clientId`),
  KEY `admin_no` (`admin_no`),
  KEY `supervisor_no` (`supervisor_no`),
  CONSTRAINT `job_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `client_list` (`clientId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `job_ibfk_2` FOREIGN KEY (`admin_no`) REFERENCES `administrator` (`staffNo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `job_ibfk_3` FOREIGN KEY (`supervisor_no`) REFERENCES `supervisor` (`staffNo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `office_work`
--

DROP TABLE IF EXISTS `office_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `office_work` (
  `work_content` varchar(50) NOT NULL,
  PRIMARY KEY (`work_content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `office_work`
--

LOCK TABLES `office_work` WRITE;
/*!40000 ALTER TABLE `office_work` DISABLE KEYS */;
/*!40000 ALTER TABLE `office_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supervisor`
--

DROP TABLE IF EXISTS `supervisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supervisor` (
  `staffNo` int NOT NULL,
  `groupNo` int DEFAULT NULL,
  PRIMARY KEY (`staffNo`),
  KEY `groupNo` (`groupNo`),
  CONSTRAINT `supervisor_ibfk_1` FOREIGN KEY (`staffNo`) REFERENCES `clean_staff` (`staffNo`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `supervisor_ibfk_2` FOREIGN KEY (`groupNo`) REFERENCES `clean_group` (`groupNo`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supervisor`
--

LOCK TABLES `supervisor` WRITE;
/*!40000 ALTER TABLE `supervisor` DISABLE KEYS */;
/*!40000 ALTER TABLE `supervisor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-13 22:27:22

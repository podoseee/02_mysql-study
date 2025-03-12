DROP TABLE IF EXISTS `EMPLOYEE`;
DROP TABLE IF EXISTS `DEPARTMENT`;
DROP TABLE IF EXISTS `JOB`;
DROP TABLE IF EXISTS `LOCATION`;
DROP TABLE IF EXISTS `NATION`;
DROP TABLE IF EXISTS `SAL_GRADE`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
# SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup
--

#SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '94354f81-ddca-11ee-a8a5-f220cd67b23d:1-342';

--
-- Table structure for table `DEPARTMENT`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DEPARTMENT` (
                              `DEPT_ID` varchar(10) NOT NULL,
                              `DEPT_TITLE` varchar(100) DEFAULT NULL COMMENT '부서명',
                              `LOCATION_ID` varchar(100) NOT NULL,
                              PRIMARY KEY (`DEPT_ID`),
                              UNIQUE KEY `IDX_DEPARTMENT_DEPT_ID_PK` (`DEPT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='부서';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DEPARTMENT`
--

LOCK TABLES `DEPARTMENT` WRITE;
/*!40000 ALTER TABLE `DEPARTMENT` DISABLE KEYS */;
INSERT INTO `DEPARTMENT` VALUES ('D1','인사관리부','L1'),('D2','회계관리부','L1'),('D3','마케팅부','L1'),('D4','국내영업부','L1'),('D5','해외영업1부','L2'),('D6','해외영업2부','L3'),('D7','해외영업3부','L4'),('D8','기술지원부','L5'),('D9','총무부','L1');
/*!40000 ALTER TABLE `DEPARTMENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMPLOYEE`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EMPLOYEE` (
                            `EMP_ID` varchar(3) NOT NULL,
                            `EMP_NAME` varchar(20) NOT NULL,
                            `EMP_NO` char(14) NOT NULL,
                            `EMAIL` varchar(25) DEFAULT NULL COMMENT '이메일',
                            `PHONE` varchar(12) DEFAULT NULL COMMENT '전화번호',
                            `DEPT_CODE` varchar(10) DEFAULT NULL COMMENT '부서코드',
                            `JOB_CODE` varchar(10) NOT NULL,
                            `SAL_LEVEL` char(2) NOT NULL,
                            `SALARY` double DEFAULT NULL COMMENT '급여',
                            `BONUS` double DEFAULT NULL COMMENT '보너스율',
                            `MANAGER_ID` varchar(3) DEFAULT NULL COMMENT '관리자사번',
                            `HIRE_DATE` datetime DEFAULT NULL COMMENT '입사일',
                            `QUIT_DATE` datetime DEFAULT NULL COMMENT '퇴사일',
                            `QUIT_YN` char(1) DEFAULT 'N' COMMENT '재직여부',
                            PRIMARY KEY (`EMP_ID`),
                            UNIQUE KEY `IDX_EMPLOYEE_EMP_ID_PK` (`EMP_ID`),
                            UNIQUE KEY `UQ_EMPLOYEE_EMP_NO` (`EMP_NO`),
#   KEY `FK_EMPLOYEE_DEPARTMENT` (`DEPT_CODE`),
                            KEY `FK_EMPLOYEE_JOB` (`JOB_CODE`),
                            CONSTRAINT `FK_EMPLOYEE_DEPARTMENT` FOREIGN KEY (`DEPT_CODE`) REFERENCES `DEPARTMENT` (`DEPT_ID`),
                            CONSTRAINT `FK_EMPLOYEE_JOB` FOREIGN KEY (`JOB_CODE`) REFERENCES `JOB` (`JOB_CODE`),
                            CONSTRAINT `CK_EMPLOYEE_QUIT_YN` CHECK ((`QUIT_YN` in (_utf8mb4'Y',_utf8mb4'N')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='사원';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPLOYEE`
--

LOCK TABLES `EMPLOYEE` WRITE;
/*!40000 ALTER TABLE `EMPLOYEE` DISABLE KEYS */;
INSERT INTO `EMPLOYEE` VALUES ('200','선동일','621225-1985634','sun_di@ohgiraffers.com','01099546325','D9','J1','S1',8000000,0.3,NULL,'1990-02-06 00:00:00',NULL,'N'),('201','송종기','631126-1548654','song_jk@ohgiraffers.com','01045686656','D9','J2','S1',6000000,NULL,'200','2001-09-01 00:00:00',NULL,'N'),('202','노옹철','861015-1356452','no_hc@ohgiraffers.com','01066656263','D9','J2','S4',3700000,NULL,'201','2001-01-01 00:00:00',NULL,'N'),('203','송은희','070910-4653546','song_eh@ohgiraffers.com','01077607879','D6','J4','S5',2800000,NULL,'204','1996-05-03 00:00:00',NULL,'N'),('204','유재식','660508-1342154','yoo_js@ohgiraffers.com','01099999129','D6','J3','S4',3400000,0.2,'200','2000-12-29 00:00:00',NULL,'N'),('205','정중하','770102-1357951','jung_jh@ohgiraffers.com','01036654875','D6','J3','S4',3900000,NULL,'204','1999-09-09 00:00:00',NULL,'N'),('206','박나라','030709-4054321','pack_nr@ohgiraffers.com','01096935222','D5','J7','S6',1800000,NULL,'207','2008-04-02 00:00:00',NULL,'N'),('207','하이유','690402-2040612','ha_iy@ohgiraffers.com','01036654488','D5','J5','S5',2200000,0.1,'200','1994-07-07 00:00:00',NULL,'N'),('208','김해술','870927-1313564','kim_hs@ohgiraffers.com','01078634444','D5','J5','S5',2500000,NULL,'207','2004-04-30 00:00:00',NULL,'N'),('209','심봉선','750206-1325546','sim_bs@ohgiraffers.com','0113654485','D5','J3','S4',3500000,0.15,'207','2011-11-11 00:00:00',NULL,'N'),('210','윤은해','650505-2356985','youn_eh@ohgiraffers.com','0179964233','D5','J7','S5',2000000,NULL,'207','2001-02-03 00:00:00',NULL,'N'),('211','전형돈','830807-1121321','jun_hd@ohgiraffers.com','01044432222','D8','J6','S5',2000000,NULL,'200','2012-12-12 00:00:00',NULL,'N'),('212','장쯔위','780923-2234542','jang_zw@ohgiraffers.com','01066682224','D8','J6','S5',2550000,0.25,'211','2015-06-17 00:00:00',NULL,'N'),('213','하동운','621111-1785463','ha_dh@ohgiraffers.com','01158456632',NULL,'J6','S5',2320000,0.1,NULL,'1999-12-31 00:00:00',NULL,'N'),('214','방명수','850705-1313513','bang_ms@ohgiraffers.com','01074127545','D1','J7','S6',1380000,NULL,'200','2010-04-04 00:00:00',NULL,'N'),('215','대북혼','881130-1050911','dae_bh@ohgiraffers.com','01088808584','D5','J5','S4',3760000,NULL,NULL,'2017-06-19 00:00:00',NULL,'N'),('216','차태연','000704-3364897','cha_ty@ohgiraffers.com','01064643212','D1','J6','S5',2780000,0.2,'214','2013-03-01 00:00:00',NULL,'N'),('217','전지연','770808-2665412','jun_jy@ohgiraffers.com','01033624442','D1','J6','S4',3660000,0.3,'214','2007-03-20 00:00:00',NULL,'N'),('218','이오리','870427-2232123','loo_or@ohgiraffers.com','01022306545',NULL,'J7','S5',2890000,NULL,NULL,'2016-11-28 00:00:00',NULL,'N'),('219','임시환','660712-1212123','im_sw@ohgiraffers.com',NULL,'D2','J4','S6',1550000,NULL,NULL,'1999-09-09 00:00:00',NULL,'N'),('220','이중석','770823-1113111','lee_js@ohgiraffers.com',NULL,'D2','J4','S5',2490000,NULL,NULL,'2014-09-18 00:00:00',NULL,'N'),('221','유하진','800808-1123341','yoo_hj@ohgiraffers.com',NULL,'D2','J4','S5',2480000,NULL,NULL,'1994-01-20 00:00:00',NULL,'N'),('222','이태림','760918-2854697','lee_tr@ohgiraffers.com','01033000002','D8','J6','S5',2436240,0.35,'209','1997-09-12 00:00:00','2017-09-12 00:00:00','Y'),('223','고두밋','470808-2123341','go_dm@ohgiraffers.com',NULL,'D2','J2','S5',4480000,NULL,NULL,'1994-01-20 00:00:00',NULL,'N');
/*!40000 ALTER TABLE `EMPLOYEE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `JOB`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `JOB` (
                       `JOB_CODE` varchar(10) NOT NULL,
                       `JOB_NAME` varchar(35) DEFAULT NULL COMMENT '직급명',
                       PRIMARY KEY (`JOB_CODE`),
                       UNIQUE KEY `IDX_JOB_CODE_PK` (`JOB_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='직급';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `JOB`
--

LOCK TABLES `JOB` WRITE;
/*!40000 ALTER TABLE `JOB` DISABLE KEYS */;
INSERT INTO `JOB` VALUES ('J1','대표'),('J2','부사장'),('J3','부장'),('J4','차장'),('J5','과장'),('J6','대리'),('J7','사원');
/*!40000 ALTER TABLE `JOB` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LOCATION`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LOCATION` (
                            `LOCAL_CODE` char(2) NOT NULL,
                            `NATIONAL_CODE` char(2) NOT NULL,
                            `LOCAL_NAME` varchar(40) DEFAULT NULL COMMENT '지역명',
                            PRIMARY KEY (`LOCAL_CODE`),
                            UNIQUE KEY `IDX_LOCATION_LOCAL_CODE_PK` (`LOCAL_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='지역';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOCATION`
--

LOCK TABLES `LOCATION` WRITE;
/*!40000 ALTER TABLE `LOCATION` DISABLE KEYS */;
INSERT INTO `LOCATION` VALUES ('L1','KO','ASIA1'),('L2','JP','ASIA2'),('L3','CH','ASIA3'),('L4','US','AMERICA'),('L5','RU','EU');
/*!40000 ALTER TABLE `LOCATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NATION`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NATION` (
                          `NATIONAL_CODE` char(2) NOT NULL,
                          `NATIONAL_NAME` varchar(35) DEFAULT NULL COMMENT '국가명',
                          PRIMARY KEY (`NATIONAL_CODE`),
                          UNIQUE KEY `IDX_NATION_NATIONAL_CODE_PK` (`NATIONAL_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='국가';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NATION`
--

LOCK TABLES `NATION` WRITE;
/*!40000 ALTER TABLE `NATION` DISABLE KEYS */;
INSERT INTO `NATION` VALUES ('CH','중국'),('JP','일본'),('KO','한국'),('RU','러시아'),('US','미국');
/*!40000 ALTER TABLE `NATION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SAL_GRADE`
--


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SAL_GRADE` (
                             `SAL_LEVEL` char(2) NOT NULL,
                             `MIN_SAL` double DEFAULT NULL COMMENT '최소급여',
                             `MAX_SAL` double DEFAULT NULL COMMENT '최대급여',
                             PRIMARY KEY (`SAL_LEVEL`),
                             UNIQUE KEY `IDX_SAL_GRADE_SAL_LEVEL_PK` (`SAL_LEVEL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='급여등급';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SAL_GRADE`
--

LOCK TABLES `SAL_GRADE` WRITE;
/*!40000 ALTER TABLE `SAL_GRADE` DISABLE KEYS */;
INSERT INTO `SAL_GRADE` VALUES ('S1',6000000,10000000),('S2',5000000,5999999),('S3',4000000,4999999),('S4',3000000,3999999),('S5',2000000,2999999),('S6',1000000,1999999);
/*!40000 ALTER TABLE `SAL_GRADE` ENABLE KEYS */;
UNLOCK TABLES;
# SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: localhost    Database: amazon_analysis
-- ------------------------------------------------------
-- Server version	5.6.26-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `amazon_bestsellers`
--

DROP TABLE IF EXISTS `amazon_bestsellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `amazon_bestsellers` (
  `Name` varchar(255) DEFAULT NULL,
  `Author` varchar(255) DEFAULT NULL,
  `User Rating` double DEFAULT NULL,
  `Reviews` int(11) DEFAULT NULL,
  `Price` double DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  `Genre` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amazon_bestsellers`
--

LOCK TABLES `amazon_bestsellers` WRITE;
/*!40000 ALTER TABLE `amazon_bestsellers` DISABLE KEYS */;
INSERT INTO `amazon_bestsellers` VALUES ('Gone Girl','Gillian Flynn',4,57271,10,2012,'Fiction'),('Gone Girl','Gillian Flynn',4,57271,10,2013,'Fiction'),('Gone Girl','Gillian Flynn',4,57271,9,2014,'Fiction'),('Harry Potter and the Cursed Child, Parts 1 & 2, Special Rehearsal Edition Script','J.K. Rowling',4,23973,12,2016,'Fiction'),('StrengthsFinder 2.0','Gallup',4,5069,17,2009,'Non Fiction'),('StrengthsFinder 2.0','Gallup',4,5069,17,2010,'Non Fiction'),('StrengthsFinder 2.0','Gallup',4,5069,17,2011,'Non Fiction'),('StrengthsFinder 2.0','Gallup',4,5069,17,2012,'Non Fiction'),('StrengthsFinder 2.0','Gallup',4,5069,17,2013,'Non Fiction'),('StrengthsFinder 2.0','Gallup',4,5069,17,2014,'Non Fiction'),('StrengthsFinder 2.0','Gallup',4,5069,17,2015,'Non Fiction'),('StrengthsFinder 2.0','Gallup',4,5069,17,2016,'Non Fiction'),('StrengthsFinder 2.0','Gallup',4,5069,17,2017,'Non Fiction'),('The Elegance of the Hedgehog','Muriel Barbery',4,1859,11,2009,'Fiction');
/*!40000 ALTER TABLE `amazon_bestsellers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-09 15:01:24

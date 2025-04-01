CREATE DATABASE  IF NOT EXISTS `db_appmentoring` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_appmentoring`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_appmentoring
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `actividad`
--

DROP TABLE IF EXISTS `actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividad` (
  `id_actividad` int(11) NOT NULL AUTO_INCREMENT,
  `Profesor_usuario_id_usuario` int(11) NOT NULL,
  `fecha_publicacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `titulo_act` varchar(256) NOT NULL,
  `tipo_act` varchar(50) NOT NULL,
  `desc_act` varchar(500) NOT NULL,
  `est_act_prof` varchar(50) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_actividad`,`Profesor_usuario_id_usuario`),
  UNIQUE KEY `id_actividad_UNIQUE` (`id_actividad`),
  KEY `fk_actividad_Profesor1_idx` (`Profesor_usuario_id_usuario`),
  CONSTRAINT `fk_actividad_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumno`
--

DROP TABLE IF EXISTS `alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno` (
  `usuario_id_usuario` int(11) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usuario_id_usuario`),
  UNIQUE KEY `usuario_id_usuario_UNIQUE` (`usuario_id_usuario`),
  CONSTRAINT `fk_Alumno_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno`
--

LOCK TABLES `alumno` WRITE;
/*!40000 ALTER TABLE `alumno` DISABLE KEYS */;
INSERT INTO `alumno` VALUES (1,'2025-03-28 12:35:05',NULL),(2,'2025-03-28 12:35:05',NULL),(3,'2025-03-28 12:35:05',NULL),(4,'2025-03-28 12:35:05',NULL),(5,'2025-03-28 12:35:05',NULL),(6,'2025-03-28 12:35:05',NULL),(7,'2025-03-28 12:35:05',NULL),(8,'2025-03-28 12:35:05',NULL),(9,'2025-03-28 12:35:05',NULL),(10,'2025-03-28 12:35:05',NULL),(11,'2025-03-28 12:35:05',NULL),(12,'2025-03-28 12:35:05',NULL),(13,'2025-03-28 12:35:05',NULL),(14,'2025-03-28 12:35:05',NULL),(15,'2025-03-28 12:35:05',NULL),(16,'2025-03-28 12:35:05',NULL),(17,'2025-03-28 12:35:05',NULL),(18,'2025-03-28 12:35:05',NULL),(19,'2025-03-28 12:35:05',NULL),(20,'2025-03-28 12:35:05',NULL),(21,'2025-03-28 12:35:05',NULL);
/*!40000 ALTER TABLE `alumno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alumno_has_actividad`
--

DROP TABLE IF EXISTS `alumno_has_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno_has_actividad` (
  `Alumno_usuario_id_usuario` int(11) NOT NULL,
  `actividad_id_actividad` int(11) NOT NULL,
  `actividad_Profesor_usuario_id_usuario` int(11) NOT NULL,
  `est_act_alu` varchar(50) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Alumno_usuario_id_usuario`,`actividad_id_actividad`,`actividad_Profesor_usuario_id_usuario`),
  KEY `fk_Alumno_has_actividad_actividad1_idx` (`actividad_id_actividad`,`actividad_Profesor_usuario_id_usuario`),
  KEY `fk_Alumno_has_actividad_Alumno1_idx` (`Alumno_usuario_id_usuario`),
  CONSTRAINT `fk_Alumno_has_actividad_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`),
  CONSTRAINT `fk_Alumno_has_actividad_actividad1` FOREIGN KEY (`actividad_id_actividad`, `actividad_Profesor_usuario_id_usuario`) REFERENCES `actividad` (`id_actividad`, `Profesor_usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno_has_actividad`
--

LOCK TABLES `alumno_has_actividad` WRITE;
/*!40000 ALTER TABLE `alumno_has_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `alumno_has_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ciclo`
--

DROP TABLE IF EXISTS `ciclo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciclo` (
  `id_ciclo` int(11) NOT NULL AUTO_INCREMENT,
  `nom_ciclo` varchar(256) NOT NULL,
  `grado_ciclo` varchar(45) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_ciclo`),
  UNIQUE KEY `id_ciclo_UNIQUE` (`id_ciclo`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciclo`
--

LOCK TABLES `ciclo` WRITE;
/*!40000 ALTER TABLE `ciclo` DISABLE KEYS */;
INSERT INTO `ciclo` VALUES (1,'Técnico en Emergencias Sanitarias','Medio','2025-03-28 12:13:57',NULL),(2,'Técnico Superior en Anatomía Patológica y Citodiagnóstico','Superior','2025-03-28 12:13:57',NULL),(3,'Técnico Superior en Laboratorio Clínico y Biomédico','Superior','2025-03-28 12:13:57',NULL),(4,'Técnico Superior en Higiene Bucodental','Superior','2025-03-28 12:13:57',NULL),(5,'Técnico en Sistemas Microinformáticos y Redes','Medio','2025-03-28 12:13:57',NULL),(6,'Técnico Superior en Administración de Sistemas Informáticos en Red','Superior','2025-03-28 12:13:57',NULL),(7,'Técnico Superior en Desarrollo de Aplicaciones Multiplataforma','Superior','2025-03-28 12:13:57',NULL),(8,'Técnico en Actividades Comerciales','Medio','2025-03-28 12:13:57',NULL),(9,'Técnico Superior en Marketing y Publicidad','Superior','2025-03-28 12:13:57',NULL),(10,'Técnico Superior en Comercio Internacional','Superior','2025-03-28 12:13:57',NULL),(11,'Técnico en Gestión Administrativa','Medio','2025-03-28 12:13:57',NULL),(12,'Técnico Superior en Administración y Finanzas','Superior','2025-03-28 12:13:57',NULL);
/*!40000 ALTER TABLE `ciclo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo` (
  `id_grupo` int(11) NOT NULL AUTO_INCREMENT,
  `ciclo_id_ciclo` int(11) NOT NULL,
  `nom_grupo` varchar(45) NOT NULL,
  `curso_grupo` varchar(45) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_grupo`,`ciclo_id_ciclo`),
  UNIQUE KEY `id_grupo_UNIQUE` (`id_grupo`),
  KEY `fk_grupo_ciclo1_idx` (`ciclo_id_ciclo`),
  CONSTRAINT `fk_grupo_ciclo1` FOREIGN KEY (`ciclo_id_ciclo`) REFERENCES `ciclo` (`id_ciclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE;
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_has_actividad`
--

DROP TABLE IF EXISTS `grupo_has_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo_has_actividad` (
  `grupo_id_grupo` int(11) NOT NULL,
  `actividad_id_actividad` int(11) NOT NULL,
  `fecha_actividad` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`grupo_id_grupo`,`actividad_id_actividad`,`fecha_actividad`),
  KEY `fk_grupo_has_actividad_actividad1_idx` (`actividad_id_actividad`),
  KEY `fk_grupo_has_actividad_grupo1_idx` (`grupo_id_grupo`),
  CONSTRAINT `fk_grupo_has_actividad_actividad1` FOREIGN KEY (`actividad_id_actividad`) REFERENCES `actividad` (`id_actividad`),
  CONSTRAINT `fk_grupo_has_actividad_grupo1` FOREIGN KEY (`grupo_id_grupo`) REFERENCES `grupo` (`id_grupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_has_actividad`
--

LOCK TABLES `grupo_has_actividad` WRITE;
/*!40000 ALTER TABLE `grupo_has_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupo_has_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensajeria`
--

DROP TABLE IF EXISTS `mensajeria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensajeria` (
  `id_mensaje` int(11) NOT NULL AUTO_INCREMENT,
  `Profesor_usuario_id_usuario` int(11) NOT NULL,
  `Alumno_usuario_id_usuario` int(11) NOT NULL,
  `fecha_hora_mensaje` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `asunto_mensaje` varchar(45) DEFAULT NULL,
  `desc_mensaje` varchar(500) NOT NULL,
  `est_mensaje` tinyint(4) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_mensaje`,`Profesor_usuario_id_usuario`,`Alumno_usuario_id_usuario`),
  UNIQUE KEY `id_mensaje_UNIQUE` (`id_mensaje`),
  KEY `fk_mensajeria_Profesor1_idx` (`Profesor_usuario_id_usuario`),
  KEY `fk_mensajeria_Alumno1_idx` (`Alumno_usuario_id_usuario`),
  CONSTRAINT `fk_mensajeria_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`),
  CONSTRAINT `fk_mensajeria_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajeria`
--

LOCK TABLES `mensajeria` WRITE;
/*!40000 ALTER TABLE `mensajeria` DISABLE KEYS */;
/*!40000 ALTER TABLE `mensajeria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modulo`
--

DROP TABLE IF EXISTS `modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modulo` (
  `id_modulo` int(11) NOT NULL,
  `ciclo_id_ciclo` int(11) NOT NULL,
  `nom_modulo` varchar(256) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_modulo`,`ciclo_id_ciclo`),
  KEY `fk_modulo_ciclo1_idx` (`ciclo_id_ciclo`),
  CONSTRAINT `fk_modulo_ciclo1` FOREIGN KEY (`ciclo_id_ciclo`) REFERENCES `ciclo` (`id_ciclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulo`
--

LOCK TABLES `modulo` WRITE;
/*!40000 ALTER TABLE `modulo` DISABLE KEYS */;
INSERT INTO `modulo` VALUES (0,1,'Módulo profesional optativo','2025-03-28 12:14:55',NULL),(0,3,'Módulo profesional optativo','2025-03-28 12:25:49',NULL),(20,4,'Primeros auxilios','2025-03-28 12:14:58',NULL),(52,1,'Matenimiento mecánico preventivo del vehículo','2025-03-28 12:14:55',NULL),(53,1,'Logística sanitaria en emergencias','2025-03-28 12:14:56',NULL),(54,1,'Dotación sanitaria','2025-03-28 12:14:55',NULL),(55,1,'Atención sanitaria inicial en situaciones de emergencia','2025-03-28 12:14:55',NULL),(56,1,'Atención sanitaria especial en situaciones de emergencia','2025-03-28 12:14:55',NULL),(57,1,'Evacuación y tralado de pacientes','2025-03-28 12:14:56',NULL),(58,1,'Apoyo psicológico en situaciones de emergencia','2025-03-28 12:14:55',NULL),(59,1,'Planes de emergencias y dispositivos de riesgos previsibles','2025-03-28 12:14:55',NULL),(60,1,'Teleemergencias','2025-03-28 12:14:55',NULL),(61,1,'Anatomofisiología y patologías básicas','2025-03-28 12:14:55',NULL),(156,1,'Inglés profesional (GM)','2025-03-28 12:14:56',NULL),(179,2,'Inglés profesional (GS)','2025-03-28 12:14:58',NULL),(179,3,'Inglés profesional (GS)','2025-03-28 12:25:49',NULL),(221,5,'Montaje y mantenimiento de quipo','2025-03-28 12:14:58',NULL),(222,5,'Sistemas operativos monopuesto','2025-03-28 12:14:58',NULL),(224,5,'Sistemas operativos en red','2025-03-28 12:14:58',NULL),(225,5,'Redes locales','2025-03-28 12:14:58',NULL),(226,5,'Seguridad informática','2025-03-28 12:14:58',NULL),(227,5,'Servicios en red','2025-03-28 12:14:58',NULL),(228,5,'Aplicaciones web','2025-03-28 12:14:58',NULL),(369,6,'Implantación de sistemas operativos','2025-03-28 12:14:58',NULL),(370,6,'Planificación y administración de redes','2025-03-28 12:14:58',NULL),(371,6,'Fundamentos del hardware','2025-03-28 12:14:58',NULL),(372,6,'Gestión de bases de datos','2025-03-28 12:14:58',NULL),(373,6,'Lenguaje de marcas y sistemas de gestión de información','2025-03-28 12:14:58',NULL),(374,6,'Administración de sistemas operativos','2025-03-28 12:14:58',NULL),(375,6,'Servicios de red e internet','2025-03-28 12:14:58',NULL),(376,6,'Implantación de aplicaciones web','2025-03-28 12:14:58',NULL),(377,6,'Administración de sistemas gestores de bases de datos','2025-03-28 12:14:58',NULL),(378,6,'Seguridad y alta disponibilidad','2025-03-28 12:14:58',NULL),(379,6,'Proyecto intermodular','2025-03-28 12:14:58',NULL),(437,11,'Comunicación empresarial y atenciónal cliente','2025-03-28 12:14:59',NULL),(438,11,'Operadores administrativas de compra-venta','2025-03-28 12:14:59',NULL),(439,11,'Empresa y administración','2025-03-28 12:14:59',NULL),(440,11,'Tratamiento informático de la información','2025-03-28 12:14:59',NULL),(441,11,'Técnica contable','2025-03-28 12:14:59',NULL),(442,11,'Operaciones administrativas de recursos humanos','2025-03-28 12:14:59',NULL),(443,11,'Tratamiento de la documentación contable','2025-03-28 12:14:59',NULL),(446,11,'Empresa en el aula','2025-03-28 12:14:59',NULL),(448,11,'Operaciones auxiliares de gestión de tesorería','2025-03-28 12:14:59',NULL),(483,7,'Sistemas informáticos','2025-03-28 12:14:58',NULL),(484,7,'Bases de datos ','2025-03-28 12:14:58',NULL),(485,7,'Programación','2025-03-28 12:14:58',NULL),(486,7,'Acceso a datos','2025-03-28 12:14:59',NULL),(487,7,'Entornos de desarrollo','2025-03-28 12:14:58',NULL),(488,7,'Desarrollo de interfaces','2025-03-28 12:14:59',NULL),(489,7,'Programación multimedia y dispositivos móviles','2025-03-28 12:14:58',NULL),(490,7,'Programación de servicios y procesos','2025-03-28 12:14:58',NULL),(491,7,'Sistemas de gestión empresarial','2025-03-28 12:14:59',NULL),(492,7,'Proyecto intermodular','2025-03-28 12:14:59',NULL),(622,10,'Transporte internacional de mercancías','2025-03-28 12:14:59',NULL),(623,9,'Gestión económica y financiera de la empresa','2025-03-28 12:14:59',NULL),(625,10,'Logística de almacenamiento','2025-03-28 12:14:59',NULL),(627,10,'Gestión administrativa del comercio internacional','2025-03-28 12:14:59',NULL),(647,12,'Gestión de la documentación jurídica y empresarial','2025-03-28 12:14:59',NULL),(648,12,'Recursos humanos y RSC','2025-03-28 12:14:59',NULL),(649,12,'Ofimática y proceso de la información','2025-03-28 12:14:59',NULL),(650,12,'Proceso integral de la actividad comercial','2025-03-28 12:14:59',NULL),(651,12,'Comunicación y atención al cliente','2025-03-28 12:14:59',NULL),(652,12,'Gestión de recursos humanos','2025-03-28 12:14:59',NULL),(653,12,'Gestión financiera','2025-03-28 12:14:59',NULL),(654,12,'Contabilidad y fiscalidad','2025-03-28 12:14:59',NULL),(655,12,'Gestión logística y comercial','2025-03-28 12:14:59',NULL),(656,12,'Simulación empresarial','2025-03-28 12:14:59',NULL),(657,12,'Proyecto intermodular','2025-03-28 12:14:59',NULL),(730,4,'Recepción y logística en la clínica dental','2025-03-28 12:14:58',NULL),(731,4,'Estudio de la cavidad oral','2025-03-28 12:14:58',NULL),(732,4,'Exploración de la cavidad oral','2025-03-28 12:14:58',NULL),(733,4,'Intervención bucodental','2025-03-28 12:14:58',NULL),(734,4,'Epidemiología en salud oral','2025-03-28 12:14:58',NULL),(735,4,'Educación para la salud oral','2025-03-28 12:14:58',NULL),(736,4,'Conservadora, periodoncia, cirugía e implantes','2025-03-28 12:14:58',NULL),(737,4,'Prótesis y ortodoncia','2025-03-28 12:14:58',NULL),(738,4,'8 Proyecto intermodular de higiene bucodental','2025-03-28 12:14:58',NULL),(822,10,'Sistema de información de mercados','2025-03-28 12:14:59',NULL),(823,10,'Marketing internacional','2025-03-28 12:14:59',NULL),(824,10,'Negociación internacional','2025-03-28 12:14:59',NULL),(825,10,'Financiación internacional','2025-03-28 12:14:59',NULL),(826,10,'Medios de pago internacionales','2025-03-28 12:14:59',NULL),(827,10,'Comercio digital internacional','2025-03-28 12:14:59',NULL),(828,10,'Proyecto intermodular','2025-03-28 12:14:59',NULL),(930,9,'Políticas de marketing','2025-03-28 12:14:59',NULL),(931,9,'Marketing digital','2025-03-28 12:14:59',NULL),(1007,9,'Diseño y elaboración de material de comunicación','2025-03-28 12:14:59',NULL),(1008,9,'Medios y soportes de comunicación','2025-03-28 12:14:59',NULL),(1009,9,'Relaciones públicas y organización de eventos de mkt','2025-03-28 12:14:59',NULL),(1010,9,'Investigación comercial','2025-03-28 12:14:59',NULL),(1011,9,'Trabajo de campo en la investigación comercial','2025-03-28 12:14:59',NULL),(1012,9,'Proyecto intermodular','2025-03-28 12:14:59',NULL),(1109,9,'Lanzamiento de productos y servicios','2025-03-28 12:14:59',NULL),(1110,9,'Atención al cliente, consumidor y usuario','2025-03-28 12:14:59',NULL),(1226,8,'Marketing en la actividad comercial','2025-03-28 12:14:59',NULL),(1227,8,'Gestión de un pequeño comercio','2025-03-28 12:14:59',NULL),(1228,8,'Técnicas de almacén','2025-03-28 12:14:59',NULL),(1229,8,'Gestión de compras','2025-03-28 12:14:59',NULL),(1230,8,'Venta técnica','2025-03-28 12:14:59',NULL),(1231,8,'Dinamización del punto de venta','2025-03-28 12:14:59',NULL),(1232,8,'Procesos de venta','2025-03-28 12:14:59',NULL),(1233,8,'Aplicaciones informáticas para el comercio','2025-03-28 12:14:59',NULL),(1234,8,'Servicios de atención comercial','2025-03-28 12:14:59',NULL),(1235,8,'Comercio electrónico','2025-03-28 12:14:59',NULL),(1367,2,'Gestión de muestras biológicas','2025-03-28 12:14:57',NULL),(1367,3,'Gestión de muestras biológicas','2025-03-28 12:25:49',NULL),(1368,2,'Técnicas generales de laboratorio','2025-03-28 12:14:57',NULL),(1368,3,'Técnicas generales de laboratorio','2025-03-28 12:25:49',NULL),(1369,2,'Biología molecular y citogenética','2025-03-28 12:14:57',NULL),(1369,3,'Biología molecular y citogenética','2025-03-28 12:25:49',NULL),(1370,2,'Fisiopatología general','2025-03-28 12:14:57',NULL),(1370,3,'Fisiopatología general','2025-03-28 12:25:49',NULL),(1379,2,'Necropsias','2025-03-28 12:14:57',NULL),(1379,3,'Análisis bioquímico','2025-03-28 12:25:49',NULL),(1380,2,'Procesamiento citológico y tisular','2025-03-28 12:14:57',NULL),(1380,3,'Técnicas de inmunodiagnóstico','2025-03-28 12:25:49',NULL),(1381,2,'Citología ginecológica','2025-03-28 12:14:57',NULL),(1381,3,'Microbiología clínica','2025-03-28 12:25:49',NULL),(1382,2,'Citología general','2025-03-28 12:14:58',NULL),(1382,3,'Técnicas de análisis hamatológico','2025-03-28 12:25:49',NULL),(1383,2,'Proyecto intermodular de anatomía patológica y citodiagnóstico','2025-03-28 12:14:58',NULL),(1383,3,'Proyecto intermodular de Laboratorio','2025-03-28 12:25:49',NULL),(1664,1,'Digitalización aplicada a los sectores productivos','2025-03-28 12:14:56',NULL),(1665,2,'Digitalización aplicada a los sectores productivos','2025-03-28 12:14:58',NULL),(1665,3,'Digitalización aplicada a los sectores productivos','2025-03-28 12:25:49',NULL),(1708,1,'Sostenibilidad aplicada al sistema productivo','2025-03-28 12:14:56',NULL),(1708,3,'Sostenibilidad aplicada al sistema productivo','2025-03-28 12:25:49',NULL),(1709,1,'Itinerario personal para la Empreabilidad I','2025-03-28 12:14:55',NULL),(1709,3,'Itinerario personal para la empleabilidad I','2025-03-28 12:25:49',NULL),(1710,1,'Itinerario personal para la empleabilidad II','2025-03-28 12:14:56',NULL),(1710,3,'Itinerario personal para la empreabilidad II','2025-03-28 12:25:49',NULL),(1713,1,'Proyecto intermodular','2025-03-28 12:14:56',NULL),(2223,5,'Aplicaciones ofimáticas','2025-03-28 12:14:58',NULL);
/*!40000 ALTER TABLE `modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesor`
--

DROP TABLE IF EXISTS `profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesor` (
  `usuario_id_usuario` int(11) NOT NULL,
  `es_tutor` tinyint(4) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usuario_id_usuario`),
  UNIQUE KEY `usuario_id_usuario_UNIQUE` (`usuario_id_usuario`),
  CONSTRAINT `fk_Profesor_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesor`
--

LOCK TABLES `profesor` WRITE;
/*!40000 ALTER TABLE `profesor` DISABLE KEYS */;
INSERT INTO `profesor` VALUES (22,1,'2025-03-28 12:36:57',NULL),(23,0,'2025-03-28 12:38:13',NULL),(24,0,'2025-03-28 12:38:13',NULL),(25,0,'2025-03-28 12:38:13',NULL),(26,0,'2025-03-28 12:38:13',NULL),(27,0,'2025-03-28 12:38:13',NULL);
/*!40000 ALTER TABLE `profesor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recurso_actividad`
--

DROP TABLE IF EXISTS `recurso_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurso_actividad` (
  `id_recurso` int(11) NOT NULL AUTO_INCREMENT,
  `actividad_id_actividad` int(11) NOT NULL,
  `desc_recurso` varchar(500) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_recurso`,`actividad_id_actividad`),
  KEY `fk_recurso_actividad1_idx` (`actividad_id_actividad`),
  CONSTRAINT `fk_recurso_actividad1` FOREIGN KEY (`actividad_id_actividad`) REFERENCES `actividad` (`id_actividad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recurso_actividad`
--

LOCK TABLES `recurso_actividad` WRITE;
/*!40000 ALTER TABLE `recurso_actividad` DISABLE KEYS */;
/*!40000 ALTER TABLE `recurso_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutoria`
--

DROP TABLE IF EXISTS `tutoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutoria` (
  `id_tutoria` int(11) NOT NULL AUTO_INCREMENT,
  `Profesor_usuario_id_usuario` int(11) NOT NULL,
  `Alumno_usuario_id_usuario` int(11) NOT NULL,
  `fecha_tutoria` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `tema_tutoria` varchar(256) NOT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  `lug_tutoria` varchar(45) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Profesor_usuario_id_usuario`,`Alumno_usuario_id_usuario`,`id_tutoria`),
  UNIQUE KEY `id_tutoria_UNIQUE` (`id_tutoria`),
  KEY `fk_tutoria_Profesor1_idx` (`Profesor_usuario_id_usuario`),
  KEY `fk_tutoria_Alumno1_idx` (`Alumno_usuario_id_usuario`),
  CONSTRAINT `fk_tutoria_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`),
  CONSTRAINT `fk_tutoria_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutoria`
--

LOCK TABLES `tutoria` WRITE;
/*!40000 ALTER TABLE `tutoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `tutoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `est_usuario` tinyint(4) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellidos` varchar(256) NOT NULL,
  `user` varchar(45) NOT NULL,
  `pass` varchar(256) NOT NULL,
  `email` varchar(45) NOT NULL,
  `telf` varchar(45) DEFAULT NULL,
  `foto` varchar(500) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `id_usuario_UNIQUE` (`id_usuario`),
  UNIQUE KEY `user_UNIQUE` (`user`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,0,' Rubén','Aguado Perulero','r.aguado@pro2fp.es','1234','r.aguado@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(2,0,' Noé','Alba Wyss','n.alba@pro2fp.es','1234','n.alba@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(3,0,' Ignacio Ladislao','Ayllon Carrera','i.ayllon@pro2fp.es','1234','i.ayllon@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(4,0,' Christian','Ballesteros Pérez','c.ballesteros@pro2fp.es','1234','c.ballesteros@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(5,0,' Carlos','Bernal Ferreiro','c.bernal@pro2fp.es','1234','c.bernal@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(6,0,' Gonzalo','Bravo Maroto','g.bravo@pro2fp.es','1234','g.bravo@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(7,0,' Damián','Carrillo Arjones','d.carrillo@pro2fp.es','1234','d.carrillo@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(8,0,' Natalia','Chuquillanqui Cornejo','n.chuquillanqui@pro2fp.es','1234','n.chuquillanqui@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(9,0,' Carolina','De la Losa Díaz','c.delalosa@pro2fp.es','1234','c.delalosa@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(10,0,' Alejandro','Del Valle López','a.delvalle@pro2fp.es','1234','a.delvalle@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(11,0,' Mario','Fernández Díaz','m.diaz@pro2fp.es','1234','m.diaz@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(12,0,' Esteban','Garcés Pérez','e.garces@pro2fp.es','1234','e.garces@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(13,0,' Alejandro','García Salmerón','a.salmeron@pro2fp.es','1234','a.salmeron@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(14,0,' Pablo','Guillén Lucena','p.guillen@pro2fp.es','1234','p.guillen@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(15,0,' Pablo','Herrero González','p.herrero@pro2fp.es','1234','p.herrero@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(16,0,' Cintia','Jurado Hernández','c.jurado@pro2fp.es','1234','c.jurado@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(17,0,' Jorge','Llanes Díaz','j.llanes@pro2fp.es','1234','j.llanes@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(18,0,' Daniel','Martín López','d.martin@pro2fp.es','1234','d.martin@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(19,0,' Jaime','Robles Moreno','j.robles@pro2fp.es','1234','j.robles@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(20,0,' Carlos','Sibilio Moreno','c.sibilio@pro2fp.es','1234','c.sibilio@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(21,0,' Gonzalo','Tellado Simarro','g.tellado@pro2fp.es','1234','g.tellado@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(22,0,'Francisco Javier','Pons Ortega','javier.pons@pro2fp.es','1234','javier.pons@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(23,0,'Juan ','Ramirez Benitez','juan.ramirez@pro2fp.es','1234','juan.ramirez@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(24,0,'Marta','Gómez-Durán Costales','marta.gomezduran@pro2fp.es','1234','marta.gomezduran@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(25,0,'Luis Armando','Dans Rodríguez','luis.dans@pro2fp.es','1234','luis.dans@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(26,0,'Miguel','Carrascal García','miguel.carrascal@pro2fp.es','1234','miguel.carrascal@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL),(27,0,'Pablo','Montero Poyatos','pablo.montero@pro2fp.es','1234','pablo.montero@pro2fp.es',NULL,NULL,'2025-03-28 12:28:10',NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validar_user_en_email` BEFORE INSERT ON `usuario` FOR EACH ROW BEGIN
    IF NEW.email NOT LIKE CONCAT('%', NEW.user, '%') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El email debe coincidir con el user utilizado';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validar_user_en_email_update` BEFORE UPDATE ON `usuario` FOR EACH ROW BEGIN
    IF NEW.email NOT LIKE CONCAT('%', NEW.user, '%') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El email debe coincidir con el user utilizado';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuario_has_grupo`
--

DROP TABLE IF EXISTS `usuario_has_grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_has_grupo` (
  `usuario_id_usuario` int(11) NOT NULL,
  `grupo_id_grupo` int(11) NOT NULL,
  `vigencia_inicio` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `vigencia_fin` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usuario_id_usuario`,`grupo_id_grupo`),
  KEY `fk_usuario_has_grupo_grupo1_idx` (`grupo_id_grupo`),
  KEY `fk_usuario_has_grupo_usuario1_idx` (`usuario_id_usuario`),
  CONSTRAINT `fk_usuario_has_grupo_grupo1` FOREIGN KEY (`grupo_id_grupo`) REFERENCES `grupo` (`id_grupo`),
  CONSTRAINT `fk_usuario_has_grupo_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_has_grupo`
--

LOCK TABLES `usuario_has_grupo` WRITE;
/*!40000 ALTER TABLE `usuario_has_grupo` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario_has_grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'db_appmentoring'
--

--
-- Dumping routines for database 'db_appmentoring'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-28 13:41:05

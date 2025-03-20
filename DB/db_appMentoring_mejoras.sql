CREATE DATABASE  IF NOT EXISTS `db_appmentoring` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_appmentoring`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: db_appmentoring
-- ------------------------------------------------------
-- Server version	8.0.41

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
  `id_actividad` int NOT NULL,
  `Profesor_usuario_id_usuario` int NOT NULL,
  `fecha_publicacion` timestamp NOT NULL,
  `tipo_act` enum('Mentoring','Emprendimiento','Competencias Digitales') NOT NULL,
  `desc_act` varchar(500) NOT NULL,
  `est_act_prof` enum('No publicado','Publicado') NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_actividad`,`Profesor_usuario_id_usuario`),
  UNIQUE KEY `id_actividad_UNIQUE` (`id_actividad`),
  KEY `fk_actividad_Profesor1_idx` (`Profesor_usuario_id_usuario`),
  CONSTRAINT `fk_actividad_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alumno`
--

DROP TABLE IF EXISTS `alumno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno` (
  `usuario_id_usuario` int NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usuario_id_usuario`),
  UNIQUE KEY `usuario_id_usuario_UNIQUE` (`usuario_id_usuario`),
  CONSTRAINT `fk_Alumno_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alumno_has_actividad`
--

DROP TABLE IF EXISTS `alumno_has_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno_has_actividad` (
  `Alumno_usuario_id_usuario` int NOT NULL,
  `actividad_id_actividad` int NOT NULL,
  `actividad_Profesor_usuario_id_usuario` int NOT NULL,
  `est_act_alu` enum('No finalizada','En proceso','Finalizada') NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Alumno_usuario_id_usuario`,`actividad_id_actividad`,`actividad_Profesor_usuario_id_usuario`),
  KEY `fk_Alumno_has_actividad_actividad1_idx` (`actividad_id_actividad`,`actividad_Profesor_usuario_id_usuario`),
  KEY `fk_Alumno_has_actividad_Alumno1_idx` (`Alumno_usuario_id_usuario`),
  CONSTRAINT `fk_Alumno_has_actividad_actividad1` FOREIGN KEY (`actividad_id_actividad`, `actividad_Profesor_usuario_id_usuario`) REFERENCES `actividad` (`id_actividad`, `Profesor_usuario_id_usuario`),
  CONSTRAINT `fk_Alumno_has_actividad_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ciclo`
--

DROP TABLE IF EXISTS `ciclo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciclo` (
  `id_ciclo` int NOT NULL AUTO_INCREMENT,
  `nom_ciclo` varchar(45) NOT NULL,
  `grado_ciclo` enum('Medio','Superior') NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_ciclo`),
  UNIQUE KEY `id_ciclo_UNIQUE` (`id_ciclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo` (
  `id_grupo` int NOT NULL,
  `ciclo_id_ciclo1` int NOT NULL,
  `nom_grupo` varchar(45) NOT NULL,
  `curso_grupo` enum('Primero','Segundo') NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_grupo`,`ciclo_id_ciclo1`),
  UNIQUE KEY `id_grupo_UNIQUE` (`id_grupo`),
  KEY `fk_grupo_ciclo1_idx` (`ciclo_id_ciclo1`),
  CONSTRAINT `fk_grupo_ciclo1` FOREIGN KEY (`ciclo_id_ciclo1`) REFERENCES `ciclo` (`id_ciclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grupo_has_actividad`
--

DROP TABLE IF EXISTS `grupo_has_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo_has_actividad` (
  `grupo_id_grupo` int NOT NULL,
  `actividad_id_actividad` int NOT NULL,
  `fecha_actividad` timestamp NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`grupo_id_grupo`,`actividad_id_actividad`,`fecha_actividad`),
  KEY `fk_grupo_has_actividad_actividad1_idx` (`actividad_id_actividad`),
  KEY `fk_grupo_has_actividad_grupo1_idx` (`grupo_id_grupo`),
  CONSTRAINT `fk_grupo_has_actividad_actividad1` FOREIGN KEY (`actividad_id_actividad`) REFERENCES `actividad` (`id_actividad`),
  CONSTRAINT `fk_grupo_has_actividad_grupo1` FOREIGN KEY (`grupo_id_grupo`) REFERENCES `grupo` (`id_grupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mensajeria`
--

DROP TABLE IF EXISTS `mensajeria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensajeria` (
  `id_mensaje` int NOT NULL,
  `Profesor_usuario_id_usuario` int NOT NULL,
  `Alumno_usuario_id_usuario` int NOT NULL,
  `fecha_hora_mensaje` timestamp NOT NULL,
  `asunto_mensaje` varchar(45) DEFAULT NULL,
  `desc_mensaje` varchar(500) NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_mensaje`,`Profesor_usuario_id_usuario`,`Alumno_usuario_id_usuario`),
  UNIQUE KEY `id_mensaje_UNIQUE` (`id_mensaje`),
  KEY `fk_mensajeria_Profesor1_idx` (`Profesor_usuario_id_usuario`),
  KEY `fk_mensajeria_Alumno1_idx` (`Alumno_usuario_id_usuario`),
  CONSTRAINT `fk_mensajeria_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`),
  CONSTRAINT `fk_mensajeria_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modulo`
--

DROP TABLE IF EXISTS `modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modulo` (
  `id_modulo` int NOT NULL,
  `ciclo_id_ciclo` int NOT NULL,
  `nom_modulo` varchar(45) NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_modulo`,`ciclo_id_ciclo`),
  UNIQUE KEY `id_modulo_UNIQUE` (`id_modulo`),
  KEY `fk_modulo_ciclo1_idx` (`ciclo_id_ciclo`),
  CONSTRAINT `fk_modulo_ciclo1` FOREIGN KEY (`ciclo_id_ciclo`) REFERENCES `ciclo` (`id_ciclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profesor`
--

DROP TABLE IF EXISTS `profesor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesor` (
  `usuario_id_usuario` int NOT NULL,
  `es_tutor` tinyint NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usuario_id_usuario`),
  UNIQUE KEY `usuario_id_usuario_UNIQUE` (`usuario_id_usuario`),
  CONSTRAINT `fk_Profesor_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recurso_actividad`
--

DROP TABLE IF EXISTS `recurso_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurso_actividad` (
  `id_recurso` int NOT NULL,
  `actividad_id_actividad` int NOT NULL,
  `desc_recurso` varchar(500) NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_recurso`,`actividad_id_actividad`),
  KEY `fk_recurso_actividad1_idx` (`actividad_id_actividad`),
  CONSTRAINT `fk_recurso_actividad1` FOREIGN KEY (`actividad_id_actividad`) REFERENCES `actividad` (`id_actividad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tutoria`
--

DROP TABLE IF EXISTS `tutoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutoria` (
  `fecha_tutoria` timestamp NOT NULL,
  `Profesor_usuario_id_usuario` int NOT NULL,
  `Alumno_usuario_id_usuario` int NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `tema_tutoria` varchar(45) NOT NULL,
  `observaciones` varchar(45) DEFAULT NULL,
  `lug_tutoria` varchar(45) NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`fecha_tutoria`,`Profesor_usuario_id_usuario`,`Alumno_usuario_id_usuario`),
  KEY `fk_tutoria_Profesor1_idx` (`Profesor_usuario_id_usuario`),
  KEY `fk_tutoria_Alumno1_idx` (`Alumno_usuario_id_usuario`),
  CONSTRAINT `fk_tutoria_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`),
  CONSTRAINT `fk_tutoria_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `ape1` varchar(45) NOT NULL,
  `ape2` varchar(45) DEFAULT NULL,
  `user` varchar(45) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `telf` varchar(45) NOT NULL,
  `foto` varchar(45) NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `id_usuario_UNIQUE` (`id_usuario`),
  UNIQUE KEY `user_UNIQUE` (`user`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario_has_grupo`
--

DROP TABLE IF EXISTS `usuario_has_grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_has_grupo` (
  `usuario_id_usuario` int NOT NULL,
  `grupo_id_grupo` int NOT NULL,
  `fecha_insercion` timestamp NOT NULL,
  `fecha_modificacion` timestamp NOT NULL,
  `fecha_borrado` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usuario_id_usuario`,`grupo_id_grupo`),
  KEY `fk_usuario_has_grupo_grupo1_idx` (`grupo_id_grupo`),
  KEY `fk_usuario_has_grupo_usuario1_idx` (`usuario_id_usuario`),
  CONSTRAINT `fk_usuario_has_grupo_grupo1` FOREIGN KEY (`grupo_id_grupo`) REFERENCES `grupo` (`id_grupo`),
  CONSTRAINT `fk_usuario_has_grupo_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

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

-- Dump completed on 2025-03-20 10:04:10

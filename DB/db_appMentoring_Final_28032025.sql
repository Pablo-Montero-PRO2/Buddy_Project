/*Base de datos diseñada para el soporte y funcionamiento de un programa de gestión de un centro educativo.
Habilita la creación de actividades, la participación de estudiantes en ellas, la comunicación entre miembros, todo a través de un modelo relacional 
optimizado y normalizado, estructurado con restricciones de llaves foráneas, elementos que permiten el tracking de las horas en las que se actualizan 
o crean elementos nuevos e índices para optimizar las consultas.

Los usuarios se almacenan en la tabla usuario, que mantiene que todos los usuarios y correos sean únicos y contiene ambos roles de usuario, profesor y
alumno. Profesor tiene un boolean que determina si el profesor específico es tutor o nó, y la tabla alumno_has_actividad controla la participación
de estudiantes en actividades. Profesor y alumno se conectan a actividad, tutoría y mensajería.

La tabla actividad controla todas las actividades, permitiendo añadir títulos, tipo, descripción y estado, referenciando a profesor al ser un profesor el
que crea la actividad. Recurso_actividad es una tabla vinculada a actividad que contiene los recursos que un profesor pueda añadir a sus actividades. 
Grupo_has_actividad también está vinculado a actividad y existe para saber el estado de un grupo entero.

La tabla tutoria está vinculada a profesores y alumnos y contiene las tutorías que profesores pueden organizar. Similarmente, mensajería también conecta ambos
profesores y alumnos para permitir que los profesores puedan mandarle mensajes a los alumnos.

La tabla grupo, conectada a grupo_has_actividad, también está conectado a usuario_has_grupo, que en sí se conecta a la tabla usuario, para poder asegurarse
de que tanto alumnos como profesores tengan grupos. Grupo está conectado a la tabla ciclo para saber a que ciclo pertenece un grupo, y ciclo está conectado 
a la tabla módulo para poder ver que asignaturas contiene un ciclo concreto. 

*/

/*Principio del script que creará la base de datos una vez ejecutado. Las primeras líneas instruyen la creación de db_appmentoring si no existe e indica
que db_appmentoring debe ser la base de datos en la que todo se ejecutará.*/
CREATE DATABASE  IF NOT EXISTS `db_appmentoring` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
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

DROP TABLE IF EXISTS `actividad`; /*Se asegurá de que no exista una tabla de actividad previa y anticuada, intentando borrar la tabla llamada 'actividad' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividad` ( /*Crea la tabla que maneja actividades.*/
  `id_actividad` int NOT NULL AUTO_INCREMENT, /*ID Principal de las actividades (No puede estar vacío)*/
  `Profesor_usuario_id_usuario` int NOT NULL, /*Llave foranea del profesor que ha creado la actividad (No puede estar vacío)*/
  `fecha_publicacion` timestamp NOT NULL, /*Fecha que indica cuando se ha creado la actividad (No puede estar vacío)*/
  `titulo_act` varchar(50) NOT NULL, /*Título de la actividad con límite de 50 carácteres (No puede estar vacío)*/
  `tipo_act` varchar(50) NOT NULL, /*Tipo de actividad con límite de 50 carácteres (No puede estar vacío)*/
  `desc_act` varchar(500) NOT NULL, /*Descripción de la actividad con límite de 500 carácteres (No puede estar vacío)*/
  `est_act_prof` varchar(50) NOT NULL, /*Estado actual de la actividad con límite de 50 carácteres (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando se ha creado la actividad (No puede estar vacío.)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando se ha actualizado la actividad (Puede estar vacío, será vacío por defecto si no se especifica un valor.)*/
  PRIMARY KEY (`id_actividad`,`Profesor_usuario_id_usuario`), /*Llave primaria de la actividad creada*/
  UNIQUE KEY `id_actividad_UNIQUE` (`id_actividad`), /*Llave única para actividad.*/
  KEY `fk_actividad_Profesor1_idx` (`Profesor_usuario_id_usuario`), /*Índice para encontrar actividades con la ID del profesor*/
  CONSTRAINT `fk_actividad_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`) /*Restricción que se asegura de que la ID de profesor usada existe en la tabla profesor*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3; 
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `alumno`
--

DROP TABLE IF EXISTS `alumno`; /*Se asegurá de que no exista una tabla de alumno previa y anticuada, intentando borrar la tabla llamada 'alumno' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno` (
  `usuario_id_usuario` int NOT NULL, /*Llave foranea de usuario referenciada ya que los alumnos son usuarios (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando se ha creado un alumno (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando se ha actualizado un alumno (Puede estar vacío, será vacío por defecto si no se especifica un valor.)*/
  PRIMARY KEY (`usuario_id_usuario`), /*Llave principal del alumno*/
  UNIQUE KEY `usuario_id_usuario_UNIQUE` (`usuario_id_usuario`), /*Llave única para el alumno*/
  CONSTRAINT `fk_Alumno_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`) /*Restricción que se asegura de que la ID de usuario usada exista en la tabla de usuario*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno`
--

LOCK TABLES `alumno` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `alumno` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `alumno` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `alumno_has_actividad`
--

DROP TABLE IF EXISTS `alumno_has_actividad`; /*Se asegurá de que no exista una tabla de alumno_has_actividad previa y anticuada, intentando borrar la tabla llamada 'alumno_has_actividad' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno_has_actividad` ( /*Crea la tabla que gestiona el estado de un alumno que tiene una actividad*/
  `Alumno_usuario_id_usuario` int NOT NULL, /*Llave foránea del alumno asociado a la actividad (No puede estar vacío)*/
  `actividad_id_actividad` int NOT NULL, /*Llave foránea de la actividad que ha sido asignada al alumno (No puede estar vacío) */
  `actividad_Profesor_usuario_id_usuario` int NOT NULL, /*Llave foránea del profesor que ha creado la actividad (No puede estar vacío)*/
  `est_act_alu` varchar(50) NOT NULL, /*Llave que contiene el estado actual de la actividad que el profesor ha asignado al alumno (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que contiene cuando ha sido creada la tabla (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que contiene cuando ha sido actualizada la tabla (Puede estar vacío, estará vacío por defecto si no se le especifica un dato)*/
  PRIMARY KEY (`Alumno_usuario_id_usuario`,`actividad_id_actividad`,`actividad_Profesor_usuario_id_usuario`), /*Llave primaria del estado de una actividad, creada con una combinación de las IDs del profesor, el alumno y la actividad*/
  KEY `fk_Alumno_has_actividad_actividad1_idx` (`actividad_id_actividad`,`actividad_Profesor_usuario_id_usuario`), /*Índice que optimiza las consultas de actividades y profesores cuando se consulta la información de un alumno*/
  KEY `fk_Alumno_has_actividad_Alumno1_idx` (`Alumno_usuario_id_usuario`),
  CONSTRAINT `fk_Alumno_has_actividad_actividad1` FOREIGN KEY (`actividad_id_actividad`, `actividad_Profesor_usuario_id_usuario`) REFERENCES `actividad` (`id_actividad`, `Profesor_usuario_id_usuario`),
  CONSTRAINT `fk_Alumno_has_actividad_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno_has_actividad`
--

LOCK TABLES `alumno_has_actividad` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `alumno_has_actividad` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `alumno_has_actividad` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `ciclo`
--

DROP TABLE IF EXISTS `ciclo`; /*Se asegurá de que no exista una tabla de ciclo previa y anticuada, intentando borrar la tabla llamada 'ciclo' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciclo` (
  `id_ciclo` int NOT NULL AUTO_INCREMENT,
  `nom_ciclo` varchar(45) NOT NULL,
  `grado_ciclo` varchar(45) NOT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_ciclo`),
  UNIQUE KEY `id_ciclo_UNIQUE` (`id_ciclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciclo`
--

LOCK TABLES `ciclo` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `ciclo` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `ciclo` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`; /*Se asegurá de que no exista una tabla de grupo previa y anticuada, intentando borrar la tabla llamada 'grupo' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo` (
  `id_grupo` int NOT NULL AUTO_INCREMENT,
  `ciclo_id_ciclo` int NOT NULL,
  `nom_grupo` varchar(45) NOT NULL,
  `curso_grupo` varchar(45) NOT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_grupo`,`ciclo_id_ciclo`),
  UNIQUE KEY `id_grupo_UNIQUE` (`id_grupo`),
  KEY `fk_grupo_ciclo1_idx` (`ciclo_id_ciclo`),
  CONSTRAINT `fk_grupo_ciclo1` FOREIGN KEY (`ciclo_id_ciclo`) REFERENCES `ciclo` (`id_ciclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `grupo_has_actividad`
--

DROP TABLE IF EXISTS `grupo_has_actividad`; /*Se asegurá de que no exista una tabla de grupo_has_actividad previa y anticuada, intentando borrar la tabla llamada 'grupo_has_actividad' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo_has_actividad` (
  `grupo_id_grupo` int NOT NULL,
  `actividad_id_actividad` int NOT NULL,
  `fecha_actividad` timestamp NOT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`grupo_id_grupo`,`actividad_id_actividad`,`fecha_actividad`),
  KEY `fk_grupo_has_actividad_actividad1_idx` (`actividad_id_actividad`),
  KEY `fk_grupo_has_actividad_grupo1_idx` (`grupo_id_grupo`),
  CONSTRAINT `fk_grupo_has_actividad_actividad1` FOREIGN KEY (`actividad_id_actividad`) REFERENCES `actividad` (`id_actividad`),
  CONSTRAINT `fk_grupo_has_actividad_grupo1` FOREIGN KEY (`grupo_id_grupo`) REFERENCES `grupo` (`id_grupo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_has_actividad`
--

LOCK TABLES `grupo_has_actividad` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `grupo_has_actividad` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `grupo_has_actividad` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `mensajeria`
--

DROP TABLE IF EXISTS `mensajeria`; /*Se asegurá de que no exista una tabla de mensajería previa y anticuada, intentando borrar la tabla llamada 'mensajería' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensajeria` (
  `id_mensaje` int NOT NULL AUTO_INCREMENT,
  `Profesor_usuario_id_usuario` int NOT NULL,
  `Alumno_usuario_id_usuario` int NOT NULL,
  `fecha_hora_mensaje` timestamp NOT NULL,
  `asunto_mensaje` varchar(45) DEFAULT NULL,
  `desc_mensaje` varchar(500) NOT NULL,
  `est_mensaje` tinyint NOT NULL, -- 1: leído, 0: no leído.
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_mensaje`,`Profesor_usuario_id_usuario`,`Alumno_usuario_id_usuario`),
  UNIQUE KEY `id_mensaje_UNIQUE` (`id_mensaje`),
  KEY `fk_mensajeria_Profesor1_idx` (`Profesor_usuario_id_usuario`),
  KEY `fk_mensajeria_Alumno1_idx` (`Alumno_usuario_id_usuario`),
  CONSTRAINT `fk_mensajeria_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`),
  CONSTRAINT `fk_mensajeria_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajeria`
--

LOCK TABLES `mensajeria` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `mensajeria` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `mensajeria` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `modulo`
--

DROP TABLE IF EXISTS `modulo`; /*Se asegurá de que no exista una tabla de modulo previa y anticuada, intentando borrar la tabla llamada 'modulo' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modulo` (
  `id_modulo` int NOT NULL,
  `ciclo_id_ciclo` int NOT NULL,
  `nom_modulo` varchar(45) NOT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_modulo`,`ciclo_id_ciclo`),
  UNIQUE KEY `id_modulo_UNIQUE` (`id_modulo`),
  KEY `fk_modulo_ciclo1_idx` (`ciclo_id_ciclo`),
  CONSTRAINT `fk_modulo_ciclo1` FOREIGN KEY (`ciclo_id_ciclo`) REFERENCES `ciclo` (`id_ciclo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulo`
--

LOCK TABLES `modulo` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `modulo` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `modulo` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `profesor`
--

DROP TABLE IF EXISTS `profesor`; /*Se asegurá de que no exista una tabla de profesor previa y anticuada, intentando borrar la tabla llamada 'profesor' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesor` (
  `usuario_id_usuario` int NOT NULL,
  `es_tutor` tinyint NOT NULL,  -- 1: es tutor, 0: no es tutor
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usuario_id_usuario`),
  UNIQUE KEY `usuario_id_usuario_UNIQUE` (`usuario_id_usuario`),
  CONSTRAINT `fk_Profesor_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesor`
--

LOCK TABLES `profesor` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `profesor` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `profesor` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `recurso_actividad`
--

DROP TABLE IF EXISTS `recurso_actividad`; /*Se asegurá de que no exista una tabla de recurso_actividad previa y anticuada, intentando borrar la tabla llamada 'recurso_actividad' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurso_actividad` (
  `id_recurso` int NOT NULL AUTO_INCREMENT,
  `actividad_id_actividad` int NOT NULL,
  `desc_recurso` varchar(500) NOT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_recurso`,`actividad_id_actividad`),
  KEY `fk_recurso_actividad1_idx` (`actividad_id_actividad`),
  CONSTRAINT `fk_recurso_actividad1` FOREIGN KEY (`actividad_id_actividad`) REFERENCES `actividad` (`id_actividad`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recurso_actividad`
--

LOCK TABLES `recurso_actividad` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `recurso_actividad` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `recurso_actividad` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `tutoria`
--

DROP TABLE IF EXISTS `tutoria`; /*Se asegurá de que no exista una tabla de tutoría previa y anticuada, intentando borrar la tabla llamada 'tutoria' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutoria` (
  `id_tutoria` int NOT NULL AUTO_INCREMENT,
  `Profesor_usuario_id_usuario` int NOT NULL,
  `Alumno_usuario_id_usuario` int NOT NULL,
  `fecha_tutoria` timestamp NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `tema_tutoria` varchar(45) NOT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  `lug_tutoria` varchar(45) NOT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Profesor_usuario_id_usuario`,`Alumno_usuario_id_usuario`,`id_tutoria`),
  UNIQUE KEY `id_tutoria_UNIQUE` (`id_tutoria`),
  KEY `fk_tutoria_Profesor1_idx` (`Profesor_usuario_id_usuario`),
  KEY `fk_tutoria_Alumno1_idx` (`Alumno_usuario_id_usuario`),
  CONSTRAINT `fk_tutoria_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`),
  CONSTRAINT `fk_tutoria_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutoria`
--

LOCK TABLES `tutoria` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `tutoria` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `tutoria` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`; /*Se asegurá de que no exista una tabla de usuario previa y anticuada, intentando borrar la tabla llamada 'usuario' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `est_usuario` tinyint NOT NULL, -- 1: activo, 0: inactivo
  `nombre` varchar(45) NOT NULL,
  `apellidos` varchar(45) NOT NULL,
  `user` varchar(45) NOT NULL,
  `pass` varchar(256) NOT NULL,
  `email` varchar(45) NOT NULL,
  `telf` varchar(45) NOT NULL,
  `foto` varchar(45) NOT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `id_usuario_UNIQUE` (`id_usuario`),
  UNIQUE KEY `user_UNIQUE` (`user`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

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

DROP TABLE IF EXISTS `usuario_has_grupo`; /*Se asegurá de que no exista una tabla de usuario_has_grupo previa y anticuada, intentando borrar la tabla llamada 'usuario_has_grupo' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_has_grupo` (
  `usuario_id_usuario` int NOT NULL,
  `grupo_id_grupo` int NOT NULL,
  `vigencia_inicio` timestamp NOT NULL,
  `vigencia_fin` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usuario_id_usuario`,`grupo_id_grupo`),
  KEY `fk_usuario_has_grupo_grupo1_idx` (`grupo_id_grupo`),
  KEY `fk_usuario_has_grupo_usuario1_idx` (`usuario_id_usuario`),
  CONSTRAINT `fk_usuario_has_grupo_grupo1` FOREIGN KEY (`grupo_id_grupo`) REFERENCES `grupo` (`id_grupo`),
  CONSTRAINT `fk_usuario_has_grupo_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_has_grupo`
--

LOCK TABLES `usuario_has_grupo` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `usuario_has_grupo` DISABLE KEYS */; /*Desabilita las llaves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `usuario_has_grupo` ENABLE KEYS */; /*Rehabilita las llaves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-25 11:02:31

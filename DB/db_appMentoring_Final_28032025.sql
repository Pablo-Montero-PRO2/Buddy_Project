/*Base de datos diseñada para el soporte y funcionamiento de un programa de gestión de un centro educativo.
Habilita la creación de actividades, la participación de estudiantes en ellas, la comunicación entre miembros, todo a través de un modelo relacional 
optimizado y normalizado, estructurado con restricciones de claves foráneas, elementos que permiten el tracking de las horas en las que se actualizan 
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
  `id_actividad` int NOT NULL AUTO_INCREMENT, /*Crea la ID principal de las actividades. Es un íntegro autoincrementativo para asegurar que sean únicos. (No puede estar vacío)*/
  `Profesor_usuario_id_usuario` int NOT NULL, /*Clave foranea del profesor que ha creado la actividad (No puede estar vacío)*/
  `fecha_publicacion` timestamp NOT NULL, /*Fecha que indica públicamente cuando se publica la actividad(No puede estar vacío)*/
  `titulo_act` varchar(256) NOT NULL, /*Título de la actividad con límite de 256 carácteres (No puede estar vacío)*/
  `tipo_act` varchar(50) NOT NULL, /*Tipo de actividad con límite de 50 carácteres (No puede estar vacío)*/
  `desc_act` varchar(500) NOT NULL, /*Descripción de la actividad con límite de 500 carácteres (No puede estar vacío)*/
  `est_act_prof` varchar(50) NOT NULL, /*Estado actual de la actividad con límite de 50 carácteres (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando se ha creado la actividad (No puede estar vacío.)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando se ha actualizado la actividad (Puede estar vacío, será vacío por defecto si no se especifica un valor.)*/
  PRIMARY KEY (`id_actividad`,`Profesor_usuario_id_usuario`), /*Define que la clave primaria de la tabla de actividad es una clave compuesdta de la id de la actividad y la id del profesor*/
  UNIQUE KEY `id_actividad_UNIQUE` (`id_actividad`), /*Crea una clave única en la columna de la ID para asegurarse de que cada fila tenga un valor diferente*/
  KEY `fk_actividad_Profesor1_idx` (`Profesor_usuario_id_usuario`), /*Índice para encontrar actividades con la ID del profesor*/
  CONSTRAINT `fk_actividad_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`) /*Restricción que se asegura de que la ID de profesor usada existe en la tabla profesor*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3; 
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */; /*Rehabilita las claves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `alumno`
--

DROP TABLE IF EXISTS `alumno`; /*Se asegurá de que no exista una tabla de alumno previa y anticuada, intentando borrar la tabla llamada 'alumno' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno` (
  `usuario_id_usuario` int NOT NULL, /*Clave foranea de usuario referenciada ya que los alumnos son usuarios (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando se ha creado un alumno (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando se ha actualizado un alumno (Puede estar vacío, será vacío por defecto si no se especifica un valor.)*/
  PRIMARY KEY (`usuario_id_usuario`), /*Determina que usuario_id_usuario es la clave primaria de la tabla alumno*/
  UNIQUE KEY `usuario_id_usuario_UNIQUE` (`usuario_id_usuario`), /*Crea una clave única en la columna de la ID para asegurarse de que cada fila tenga un valor diferente*/
  CONSTRAINT `fk_Alumno_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`) /*Restricción que se asegura de que la ID de usuario usada exista en la tabla de usuario*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno`
--

LOCK TABLES `alumno` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `alumno` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `alumno` ENABLE KEYS */; /*Rehabilita las claves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `alumno_has_actividad`
--

DROP TABLE IF EXISTS `alumno_has_actividad`; /*Se asegurá de que no exista una tabla de alumno_has_actividad previa y anticuada, intentando borrar la tabla llamada 'alumno_has_actividad' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumno_has_actividad` ( /*Crea la tabla que gestiona el estado de un alumno que tiene una actividad*/
  `Alumno_usuario_id_usuario` int NOT NULL, /*Clave foránea del alumno asociado a la actividad (No puede estar vacío)*/
  `actividad_id_actividad` int NOT NULL, /*clave foránea de la actividad que ha sido asignada al alumno (No puede estar vacío) */
  `actividad_Profesor_usuario_id_usuario` int NOT NULL, /*Clave foránea del profesor que ha creado la actividad (No puede estar vacío)*/
  `est_act_alu` varchar(50) NOT NULL, /*Clave que contiene el estado actual de la actividad que el profesor ha asignado al alumno con límite de 50 carácteres. (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que contiene cuando ha sido creada la actividad (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que contiene cuando ha sido actualizada la actividad (Puede estar vacío, estará vacío por defecto si no se le especifica un dato)*/
  PRIMARY KEY (`Alumno_usuario_id_usuario`,`actividad_id_actividad`,`actividad_Profesor_usuario_id_usuario`), /*Indica que la clave primaria de la tabla es una clave compuesta de la ID del alumno, la ID de la actividad y la ID del profesor*/
  KEY `fk_Alumno_has_actividad_actividad1_idx` (`actividad_id_actividad`,`actividad_Profesor_usuario_id_usuario`), /*Índice que optimiza las consultas de actividades y profesores cuando se consulta la información de un alumno*/
  KEY `fk_Alumno_has_actividad_Alumno1_idx` (`Alumno_usuario_id_usuario`), /*Índice que optimiza las consultas del ID del alumno cuando se quiere saber todas las actividades que tiene un alumno*/
  CONSTRAINT `fk_Alumno_has_actividad_actividad1` FOREIGN KEY (`actividad_id_actividad`, `actividad_Profesor_usuario_id_usuario`) REFERENCES `actividad` (`id_actividad`, `Profesor_usuario_id_usuario`), /*clave foránea que restringe las IDs de profesor y actividad usados para asegurarse de que las IDs existen en las tablas de profesor y actividad*/
  CONSTRAINT `fk_Alumno_has_actividad_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`) /*clave foránea que restringe la ID de alumno asegurándose de que existe en la tabla de alumnos.*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumno_has_actividad`
--

LOCK TABLES `alumno_has_actividad` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `alumno_has_actividad` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `alumno_has_actividad` ENABLE KEYS */; /*Rehabilita las claves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `ciclo`
--

DROP TABLE IF EXISTS `ciclo`; /*Se asegurá de que no exista una tabla de ciclo previa y anticuada, intentando borrar la tabla llamada 'ciclo' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciclo` ( /*Crea la tabla que contiene los ciclos de un grupo.*/
  `id_ciclo` int NOT NULL AUTO_INCREMENT, /*Crea la clave primaria de la tabla como íntegro autoincrementativo para que siempre sean únicos (No puede estar vacío).*/
  `nom_ciclo` varchar(256) NOT NULL, /*Define el nombre del ciclo con límite de 256 carácteres (No puede estar vacío)*/
  `grado_ciclo` varchar(45) NOT NULL, /*Define el grado del cíclo con un límite de 45 carácteres (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que determina cuando ha sido creado el cíclo (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que determina cuando se ha actualizado el ciclo (Puede estar vacío, si no se especifica un valor será vacío por defecto)*/
  PRIMARY KEY (`id_ciclo`), /*Define id_ciclo como la clave primaria de la tabla ciclo*/
  UNIQUE KEY `id_ciclo_UNIQUE` (`id_ciclo`)  /*Crea una clave única en la columna de la ID para asegurarse de que cada fila tenga un valor diferente*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciclo`
--

LOCK TABLES `ciclo` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `ciclo` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `ciclo` ENABLE KEYS */; /*Rehabilita las claves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`; /*Se asegurá de que no exista una tabla de grupo previa y anticuada, intentando borrar la tabla llamada 'grupo' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo` ( /*Crea la tabla que contiene los grupos que contienen usuarios y ciclos.*/
  `id_grupo` int NOT NULL AUTO_INCREMENT, /*Crea la clave primaria de la tabla grupo como íntegro autoincrementativo para asegurar que sean únicas. (No puede estar vacío)*/
  `ciclo_id_ciclo` int NOT NULL, /*Clave foránea del ciclo al que pertenece el grupo (No puede estar vacío)*/
  `nom_grupo` varchar(45) NOT NULL, /*Define el nombre del grupo con un límite de 45 carácteres (No puede estar vacío)*/
  `curso_grupo` varchar(45) NOT NULL, /*Define el curso del grupo con un límite de 45 carácteres (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando ha sido creado el grupo (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando ha sido actualizado el grupo (Puede estar vacío, si no se especifica un valor estará vacío por defecto)*/
  PRIMARY KEY (`id_grupo`,`ciclo_id_ciclo`), /*Indica que la clave primaria de la tabla grupo es una clave compuesta de la ID del crupo y la ID del ciclo.*/
  UNIQUE KEY `id_grupo_UNIQUE` (`id_grupo`), /*Crea una clave única en la columna de la ID para asegurarse de que cada fila tenga un valor diferente*/
  KEY `fk_grupo_ciclo1_idx` (`ciclo_id_ciclo`),/*Índice de id_grupo que optimiza consultas cuando se buscan los grupos de un ciclo*/
  CONSTRAINT `fk_grupo_ciclo1` FOREIGN KEY (`ciclo_id_ciclo`) REFERENCES `ciclo` (`id_ciclo`) /*Restricción de la clave de ID del ciclo, requiriendo que la ID referenciada en la tabla del grupo exista en la tabla del ciclo.*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */; /*Rehabilita las claves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `grupo_has_actividad`
--

DROP TABLE IF EXISTS `grupo_has_actividad`; /*Se asegurá de que no exista una tabla de grupo_has_actividad previa y anticuada, intentando borrar la tabla llamada 'grupo_has_actividad' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo_has_actividad` ( /*Crea la tabla que controla el estado de las actividades asignadas a un grupo*/
  `grupo_id_grupo` int NOT NULL, /*Clave foránea que referencia al grupo que tiene la actividad*/
  `actividad_id_actividad` int NOT NULL, /*Clave foránea que referencia la actividad asignada al grupo*/
  `fecha_actividad` timestamp NOT NULL, /*Fecha que indica públicamente cuando se realizará la actividad (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando se ha creado la actividad (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando se ha actualizado la actividad (Puede estar vacío, si no se especifica un valor estará vacío por defecto)*/
  PRIMARY KEY (`grupo_id_grupo`,`actividad_id_actividad`,`fecha_actividad`), /*Indica que la clave primaria de la tabla es una clave compuesta de la ID del grupo, la ID de la actividad y la ID de la fecha*/
  KEY `fk_grupo_has_actividad_actividad1_idx` (`actividad_id_actividad`), /*Índice que optimiza las consultas cuando se busca a través de las actividades*/
  KEY `fk_grupo_has_actividad_grupo1_idx` (`grupo_id_grupo`), /*Índice que optimiza las consultas cuando se busca a través de los grupos*/
  CONSTRAINT `fk_grupo_has_actividad_actividad1` FOREIGN KEY (`actividad_id_actividad`) REFERENCES `actividad` (`id_actividad`), /*Restricción en la ID de actividad que se asegura de que la ID presente en esta tabla coincide cun una ID presente en la tabla de actividades*/
  CONSTRAINT `fk_grupo_has_actividad_grupo1` FOREIGN KEY (`grupo_id_grupo`) REFERENCES `grupo` (`id_grupo`) /*Restricción en la ID de grupo que se asegura de que la ID presente en esta tabla coincide cun una ID presente en la tabla de grupos*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_has_actividad`
--

LOCK TABLES `grupo_has_actividad` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `grupo_has_actividad` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `grupo_has_actividad` ENABLE KEYS */; /*Rehabilita las claves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `mensajeria`
--

DROP TABLE IF EXISTS `mensajeria`; /*Se asegurá de que no exista una tabla de mensajería previa y anticuada, intentando borrar la tabla llamada 'mensajería' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensajeria` ( /*Crea la tabla que controla los mensajes entre un alumno y un profesor*/
  `id_mensaje` int NOT NULL AUTO_INCREMENT, /*Crea la ID de un mensaje en forma de un íntegro autoincrementativo para evitar que se repitan. (No puede estar vacío)*/
  `Profesor_usuario_id_usuario` int NOT NULL, /*Clave foránea del profesor mandándole un mensaje a un alumno. (No puede estar vacío)*/
  `Alumno_usuario_id_usuario` int NOT NULL, /*Clave foránea del alumno recibiendo un mensaje del profesor (No puede estar vacío)*/
  `fecha_hora_mensaje` timestamp NOT NULL, /*Fecha que indica cuando se mandó el mensaje (No puede estar vacío)*/
  `asunto_mensaje` varchar(45) DEFAULT NULL, /*Define el asunto del mensaje con un límite de 45 carácteres ()*/
  `desc_mensaje` varchar(500) NOT NULL, /*Cuerpo principal del mensaje con un límite de 500 carácteres (No puede estar vacío)*/
  `est_mensaje` tinyint NOT NULL,  /*Indica si el mensaje está leído o nó. 1: leído, 0: no leído.*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando ha sido creado el mensaje (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando ha sido actualizado el mensaje (Puede estar vacío, estará vaqcío por defecto si no se especifica un valor)*/
  PRIMARY KEY (`id_mensaje`,`Profesor_usuario_id_usuario`,`Alumno_usuario_id_usuario`), /*Indica que la clave primaria de la tabla es una clave compuesta de la ID del mensaje, la ID del profesor y la ID del alumno. */
  UNIQUE KEY `id_mensaje_UNIQUE` (`id_mensaje`), /*Crea una clave única en la columna de la ID para asegurarse de que cada fila tenga un valor diferente*/
  KEY `fk_mensajeria_Profesor1_idx` (`Profesor_usuario_id_usuario`), /*Índice que facilita las consultas al buscar los mensajes asociados con un profesor*/
  KEY `fk_mensajeria_Alumno1_idx` (`Alumno_usuario_id_usuario`), /*Índice que facilita las consultas al buscar los mensajes asociados con un alumno*/
  CONSTRAINT `fk_mensajeria_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`), /*Restricción de la ID del alumno que se asegura de que la ID usada en en mensaje también está presente en la tabla de alumnos*/
  CONSTRAINT `fk_mensajeria_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`) /*Restricción de la ID del profesor que se asegura de que la ID usada en en mensaje también está presente en la tabla de profesores*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajeria`
--

LOCK TABLES `mensajeria` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `mensajeria` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `mensajeria` ENABLE KEYS */; /*Rehabilita las claves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `modulo`
--

DROP TABLE IF EXISTS `modulo`; /*Se asegurá de que no exista una tabla de modulo previa y anticuada, intentando borrar la tabla llamada 'modulo' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modulo` (/*Crea la tabla que contiene los módulos que contiene un ciclo*/
  `id_modulo` int NOT NULL, /*Crea la ID del módulo en forma de íntegro (creado manualmente según la ID que le atribuye la Comunidad de Madrid, no puede estar vacío)*/
  `ciclo_id_ciclo` int NOT NULL, /*Clave foránea ID del ciclo al que pertenece el módulo (No puede estar vacío).*/
  `nom_modulo` varchar(256) NOT NULL, /*Define el nombre del módulo con un límite de 256 carácteres (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando ha sido creado un módulo (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando ha sido actualizado un módulo (Puede estar vacío, si no se le asigna un valor estará vacío por defecto)*/
  PRIMARY KEY (`id_modulo`,`ciclo_id_ciclo`), /*Indica que la clave primaria de la tabla es una clave compuesta de la ID del módulo y la ID del ciclo*/
  KEY `fk_modulo_ciclo1_idx` (`ciclo_id_ciclo`), /*Índice que optimiza las consultas de los módulos asignados a un ciclo*/
  CONSTRAINT `fk_modulo_ciclo1` FOREIGN KEY (`ciclo_id_ciclo`) REFERENCES `ciclo` (`id_ciclo`) /*Restricción a la ID del ciclo que se asegura de que la ID presente en la tabla de módulo también está presente en la tabla de ciclo.*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modulo`
--

LOCK TABLES `modulo` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `modulo` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `modulo` ENABLE KEYS */; /*Rehabilita las claves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `profesor`
--

DROP TABLE IF EXISTS `profesor`; /*Se asegurá de que no exista una tabla de profesor previa y anticuada, intentando borrar la tabla llamada 'profesor' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profesor` ( /*Crea la tabla profesor como un tipo de usuario vinculado a tutorías, mensajerías y actividades.*/
  `usuario_id_usuario` int NOT NULL, /*Clave foránea de usuario asignada al profesor ya que un profesor también es un usuario (No puede estar vacío)*/
  `es_tutor` tinyint NOT NULL,  /*Valor que controla si el profesor es un tutor o no. 1: es tutor, 0: no es tutor (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando ha sido creado el profesor (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando ha sido actualizado el profesor (Puede estar vacío, si no se le especifica un valor estará vacío por defecto)*/
  PRIMARY KEY (`usuario_id_usuario`), /*Indica que usuario_id_usuario es la clave primaria de la tabla profesor*/
  UNIQUE KEY `usuario_id_usuario_UNIQUE` (`usuario_id_usuario`), /*Crea una clave única en la columna de la ID para asegurarse de que cada fila tenga un valor diferente*/
  CONSTRAINT `fk_Profesor_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`) /*Restricción sobre la ID de usuario que se asegura de que la ID usada en la tabla de profesor también está presente en la tabla de usuario.*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesor`
--

LOCK TABLES `profesor` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `profesor` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `profesor` ENABLE KEYS */; /*Rehabilita las claves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `recurso_actividad`
--

DROP TABLE IF EXISTS `recurso_actividad`; /*Se asegurá de que no exista una tabla de recurso_actividad previa y anticuada, intentando borrar la tabla llamada 'recurso_actividad' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurso_actividad` ( /*Crea la tabla que contiene los recursos que un profesor le asigna a una actividad*/
  `id_recurso` int NOT NULL AUTO_INCREMENT, /*Crea la ID del recurso en forma de íntegro autoincremental para asegurarse de que todas las IDs sean únicas (No puede estar vacío)*/
  `actividad_id_actividad` int NOT NULL, /*Clave foránea de la actividad a la que está asignada el recurso (No puede estar vacío)*/
  `desc_recurso` varchar(500) NOT NULL, /*Cuerpo del recurso en formato de enlace con un límite de 500 carácteres (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha en la que se ha creado el recurso (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha en la que se ha actualizado el recurso (Puede estar vacío, si no se especifica un recurso estará vacío por defecto)*/
  PRIMARY KEY (`id_recurso`,`actividad_id_actividad`), /*Indica que la clave primaria de la tabla es una clave compuesta de la ID del recurso y la ID de la actividad*/
  KEY `fk_recurso_actividad1_idx` (`actividad_id_actividad`), /*Índice que optimiza las consultas cuando se buscan los recursos asignados a una actividad*/
  CONSTRAINT `fk_recurso_actividad1` FOREIGN KEY (`actividad_id_actividad`) REFERENCES `actividad` (`id_actividad`) ON DELETE CASCADE ON UPDATE CASCADE /*Restricción sobre la ID actividad que se asegura de que la ID presente en la tabla de recurso también está presente en la tabla de ID. Se asegura también de que borrar una actividad también borra los recursos.*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recurso_actividad`
--

LOCK TABLES `recurso_actividad` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `recurso_actividad` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `recurso_actividad` ENABLE KEYS */; /*Rehabilita las claves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `tutoria`
--

DROP TABLE IF EXISTS `tutoria`; /*Se asegurá de que no exista una tabla de tutoría previa y anticuada, intentando borrar la tabla llamada 'tutoria' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tutoria` ( /*Crea la tabla de tutorías entre un alumno y un profesor*/
  `id_tutoria` int NOT NULL AUTO_INCREMENT, /*Crea la ID de la tutoría como un íntegro único autoincremental para asegurarse de que sea único (No puede estar vacío)*/
  `Profesor_usuario_id_usuario` int NOT NULL, /*Clave foránea del profesor que organiza la tutoría (No puede estar vacío)*/
  `Alumno_usuario_id_usuario` int NOT NULL, /*Clave foránea del alumno que participa en la tutoría (No puede estar vacío)*/
  `fecha_tutoria` timestamp NOT NULL, /*Fecha que indica cuando se realizará la tutoría (No puede estar vacío)*/
  `hora_inicio` time NOT NULL, /*Hora que indica la hora exacta en la que comenzará la tutoría (No puede estar vacío)*/
  `hora_fin` time NOT NULL, /*Hora que indica la hora exacta en la que acabará la tutoría (No puede estar vacío)*/
  `tema_tutoria` varchar(256) NOT NULL, /*Descripción para indicar de que tratará la tutoría con un límite de 256 carácteres (No puede estar vacío)*/
  `observaciones` varchar(500) DEFAULT NULL, /*Observaciones sobre la tutoría con un límite de 500 carácteres (Puede estar vacío, si no se especifica un valor estará vacío por defecto)*/
  `lug_tutoria` varchar(45) NOT NULL, /*Indica donde tendrá lugar la tutoría (No puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando ha sido creada la tutoría (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando ha sido actualizada la tutoría (Puede estar vacío, si no se especifica un valor estará vacío por defecto)*/
  PRIMARY KEY (`Profesor_usuario_id_usuario`,`Alumno_usuario_id_usuario`,`id_tutoria`), /*Indica que la clave primaria de la tabla es una clabe compuesta de la ID del profesor, la ID del alumno y la ID de la tutoría*/
  UNIQUE KEY `id_tutoria_UNIQUE` (`id_tutoria`), /*Crea una clave única en la columna de la ID para asegurarse de que cada fila tenga un valor diferente */
  KEY `fk_tutoria_Profesor1_idx` (`Profesor_usuario_id_usuario`), /*Índice que optimiza consultas para ver las tutorías asociadas con un profesor*/
  KEY `fk_tutoria_Alumno1_idx` (`Alumno_usuario_id_usuario`), /*Índice que optimiza consultas para ver las tutorías asociadas con un alumno*/
  CONSTRAINT `fk_tutoria_Alumno1` FOREIGN KEY (`Alumno_usuario_id_usuario`) REFERENCES `alumno` (`usuario_id_usuario`), /*Restricción sobre la clave foránea de ID de alumno que se asegura de que la ID presente en la tabla de tutoría también está presente en la tabla de alumno*/
  CONSTRAINT `fk_tutoria_Profesor1` FOREIGN KEY (`Profesor_usuario_id_usuario`) REFERENCES `profesor` (`usuario_id_usuario`) /*Restricción sobre la clave foránea de ID de profesor que se asegura de que la ID presente en la tabla de tutoría también está presente en la tabla de profesor*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutoria`
--

LOCK TABLES `tutoria` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `tutoria` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `tutoria` ENABLE KEYS */; /*Rehabilita las claves*/
UNLOCK TABLES; /*Vuelve a abrir la tabla*/

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`; /*Se asegurá de que no exista una tabla de usuario previa y anticuada, intentando borrar la tabla llamada 'usuario' si
existe.*/
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` ( /*Crea la tabla que contiene los usuarios, tanto profesores como alumnos.*/
  `id_usuario` int NOT NULL AUTO_INCREMENT, /*ID única del usuario en forma de un íntegro autoincremental para asegurar que sean únicas (No puede estar vacío).*/
  `est_usuario` tinyint NOT NULL, /*Muestra el estado actual del usuario 1: activo, 0: inactivo. (No puede estar vacío)*/
  `nombre` varchar(45) NOT NULL, /*Define el nombre del usuario con un límite de 45 carácteres.(No puede estar vacío)*/
  `apellidos` varchar(256) NOT NULL, /*Define los apellidos del usuario con un límite de 256 carácteres.(No puede estar vacío)*/
  `user` varchar(45) NOT NULL, /*Define el nombre de usuario del usuario con un límite de 45 carácteres.(No puede estar vacío)*/
  `pass` varchar(256) NOT NULL, /*Define la contraseña del usuario con un límite de 256 carácteres.(No puede estar vacío)*/
  `email` varchar(45) NOT NULL, /*Define el email del usuario con un límite de 45 carácteres.(No puede estar vacío)*/
  `telf` varchar(45) NULL, /*Define el teléfono del usuario con un límite de 45 carácteres.(Puede estar vacío)*/
  `foto` varchar(500) NULL, /*Define la foto del usuario a través de un vínculo con un límite de 45 carácteres.(Puede estar vacío)*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando ha sido creado el usuario (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando ha sido actualizado el usuario (Puede estar vacío, si no se especifica un valor estará vacío por defecto)*/
  PRIMARY KEY (`id_usuario`), /*Define id_usuario como la clave primaria de la tabla usuario.*/
  UNIQUE KEY `id_usuario_UNIQUE` (`id_usuario`),  /*Crea una clave única en la columna de la ID para asegurarse de que cada fila tenga un valor diferente */
  UNIQUE KEY `user_UNIQUE` (`user`), /*Crea una clave única en la columna del usuario para asegurarse de que cada fila tenga un valor diferente */
  UNIQUE KEY `email_UNIQUE` (`email`) /*Crea una clave única en la columna del email para asegurarse de que cada fila tenga un valor diferente */
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */; /*Rehabilita las claves*/
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
CREATE TABLE `usuario_has_grupo` ( /*Crea la tabla que muestra el estado de los grupos en los que está un usuario*/
  `usuario_id_usuario` int NOT NULL, /*Clave foránea del usuario cuyo estado estamos definiendo. (No puede estar vacío)*/
  `grupo_id_grupo` int NOT NULL, /*Clave foránea del grupo cuyo estado estamos definiendo. (No puede estar vacío)*/
  `vigencia_inicio` timestamp NOT NULL, /*Fecha que indica a partir de cuando el usuario se considera parte de un grupo. (No puede estar vacío)*/
  `vigencia_fin` timestamp NULL DEFAULT NULL, /*Fecha que indica a partir de cuando el usuario deja de considerarse parte de un grupo. (Puede estar vacío, si no se especifica un valor estará vacío por defecto)*/
  `createdAt` timestamp NOT NULL, /*Fecha que indica cuando ha sido creado el estado del usuario (No puede estar vacío)*/
  `updatedAt` timestamp NULL DEFAULT NULL, /*Fecha que indica cuando ha sido actualizado el estado del usuario (Puede estar vacío, si no se especifica un valor estará vacío por defecto)*/
  PRIMARY KEY (`usuario_id_usuario`,`grupo_id_grupo`), /*Indica que la clave primaria de la tabla es una clave compuesta de la ID de usuario y la ID de grupo*/
  KEY `fk_usuario_has_grupo_grupo1_idx` (`grupo_id_grupo`), /*Índice que optimiza las consultas cuando se consulta que usuarios tienen un grupo*/
  KEY `fk_usuario_has_grupo_usuario1_idx` (`usuario_id_usuario`), /*Índice que optimiza las consultas cuando se consulta en que grupos está un usuario*/
  CONSTRAINT `fk_usuario_has_grupo_grupo1` FOREIGN KEY (`grupo_id_grupo`) REFERENCES `grupo` (`id_grupo`), /*Restricción sobre la ID de grupo que se asegura de que la ID de grupo presente en esta tabla también está presente en la tabla de grupo*/
  CONSTRAINT `fk_usuario_has_grupo_usuario1` FOREIGN KEY (`usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`) /*Restricción sobre la ID de usuario que se asegura de que la ID de usuario presente en esta tabla también está presente en la tabla de usuario*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_has_grupo`
--

LOCK TABLES `usuario_has_grupo` WRITE; /*Cierra la tabla para que no se pueda modificar*/
/*!40000 ALTER TABLE `usuario_has_grupo` DISABLE KEYS */; /*Desabilita las claves para permitir que las inserciones de datos masivas sean más fáciles*/
/*!40000 ALTER TABLE `usuario_has_grupo` ENABLE KEYS */; /*Rehabilita las claves*/
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

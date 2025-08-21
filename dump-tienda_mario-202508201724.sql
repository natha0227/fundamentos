-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: tienda_mario
-- ------------------------------------------------------
-- Server version	8.0.43

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

--
-- Table structure for table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulo` (
  `id` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `proveedor` int DEFAULT NULL,
  `costo_compra` decimal(15,2) DEFAULT NULL,
  `costo_venta` decimal(15,2) DEFAULT NULL,
  `categoria` int DEFAULT NULL,
  `estado` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proveedor` (`proveedor`),
  KEY `categoria` (`categoria`),
  CONSTRAINT `articulo_ibfk_1` FOREIGN KEY (`proveedor`) REFERENCES `proveedor` (`id`),
  CONSTRAINT `articulo_ibfk_2` FOREIGN KEY (`categoria`) REFERENCES `categoria` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulo`
--

LOCK TABLES `articulo` WRITE;
/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` VALUES (1,'nevera','nevera',5,1,1000000.00,4000000.00,1,1),(2,'iphone','barato',3,2,1000.00,1500.00,1,1),(3,'televisor','televisor 4K',10,3,1500000.00,3000000.00,1,1),(4,'tablet','tablet android',15,4,800000.00,1200000.00,2,1),(5,'consola','consola de videojuegos',7,5,1200000.00,1800000.00,8,1),(6,'zapatillas','zapatillas deportivas',20,6,200000.00,400000.00,4,1),(7,'camisa','camisa casual',30,7,50000.00,90000.00,4,1),(8,'licuadora','licuadora potente',12,8,300000.00,600000.00,1,1),(9,'taladro','taladro eléctrico',9,9,400000.00,700000.00,9,1),(10,'refresco','refresco 2L',50,10,2000.00,4000.00,11,1),(11,'libro','libro de programación',25,11,40000.00,80000.00,10,1),(12,'auto eléctrico','auto eléctrico compacto',2,12,30000000.00,45000000.00,12,1);
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articulo_caracteristicas`
--

DROP TABLE IF EXISTS `articulo_caracteristicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulo_caracteristicas` (
  `id` int NOT NULL,
  `articulo` int DEFAULT NULL,
  `caracteristica` int DEFAULT NULL,
  `valor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `articulo` (`articulo`),
  KEY `caracteristica` (`caracteristica`),
  CONSTRAINT `articulo_caracteristicas_ibfk_1` FOREIGN KEY (`articulo`) REFERENCES `articulo` (`id`),
  CONSTRAINT `articulo_caracteristicas_ibfk_2` FOREIGN KEY (`caracteristica`) REFERENCES `caracteristicas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulo_caracteristicas`
--

LOCK TABLES `articulo_caracteristicas` WRITE;
/*!40000 ALTER TABLE `articulo_caracteristicas` DISABLE KEYS */;
INSERT INTO `articulo_caracteristicas` VALUES (1,1,2,'10000'),(2,2,2,'500'),(4,3,1,'LG'),(5,3,2,'negro'),(6,3,3,'55 pulgadas'),(7,4,1,'Samsung'),(8,4,2,'blanco'),(9,4,3,'10 pulgadas'),(10,5,1,'Sony'),(11,5,2,'negro'),(12,5,3,'estándar'),(13,6,1,'Nike');
/*!40000 ALTER TABLE `articulo_caracteristicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caracteristicas`
--

DROP TABLE IF EXISTS `caracteristicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caracteristicas` (
  `id` int NOT NULL,
  `articulos` int DEFAULT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `medidas` varchar(50) DEFAULT NULL,
  `garantia` int DEFAULT NULL,
  `memoria` varchar(50) DEFAULT NULL,
  `capacidad` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `articulos` (`articulos`),
  CONSTRAINT `caracteristicas_ibfk_1` FOREIGN KEY (`articulos`) REFERENCES `articulo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caracteristicas`
--

LOCK TABLES `caracteristicas` WRITE;
/*!40000 ALTER TABLE `caracteristicas` DISABLE KEYS */;
INSERT INTO `caracteristicas` VALUES (1,1,'hacet','gris','300*100',1,NULL,NULL),(2,2,'iphone','verde',NULL,0,NULL,NULL),(3,3,'LG','negro','55 pulgadas',2,NULL,NULL),(4,4,'Samsung','blanco','10 pulgadas',1,NULL,NULL),(5,5,'Sony','negro','estándar',1,NULL,NULL),(6,6,'Nike','rojo','42',0,NULL,NULL),(7,7,'Adidas','azul','M',0,NULL,NULL),(8,8,'Philips','blanco','30x20 cm',1,NULL,NULL),(9,9,'Bosch','azul','compacto',2,NULL,NULL),(10,10,'Pepsi','naranja','2L',0,NULL,NULL),(11,11,'Panamericana','multicolor','300 páginas',0,NULL,NULL),(12,12,'Tesla','rojo','compacto',3,'128GB','2000cc');
/*!40000 ALTER TABLE `caracteristicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'electrodomesticos',NULL),(2,'celulares',NULL),(3,'muebles','Muebles para el hogar'),(4,'ropa','Ropa para toda la familia'),(5,'juguetes','Juguetes para niños'),(6,'deportes','Equipos deportivos'),(7,'hogar','Artículos para el hogar'),(8,'electronica','Dispositivos electrónicos'),(9,'herramientas','Herramientas y accesorios'),(10,'libros','Libros y revistas'),(11,'alimentacion','Productos alimenticios'),(12,'automotriz','Productos para autos');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'juan','carrascal',NULL,NULL,NULL,NULL),(2,'pedro','perez',NULL,NULL,NULL,NULL),(3,'maria','lopez','maria@gmail.com','3101234567','Calle 10 #20-30','1990-05-10'),(4,'carlos','perez','carlos@gmail.com','3112345678','Av. 50 #15-45','1985-09-20'),(5,'ana','martinez','ana@gmail.com','3123456789','Calle 22 #30-10','1995-12-15'),(6,'juan','gomez','juan.gomez@gmail.com','3134567890','Av. Central 100','1988-07-07'),(7,'laura','ruiz','laura@gmail.com','3145678901','Calle 18 #40-50','1992-03-22'),(8,'pedro','diaz','pedro@gmail.com','3156789012','Av. Libertad 55','1980-11-11'),(9,'luis','ramirez','luis@gmail.com','3167890123','Calle 25 #10-20','1983-08-30'),(10,'sofia','garcia','sofia@gmail.com','3178901234','Av. del Sol 99','1998-01-05'),(11,'diego','torres','diego@gmail.com','3189012345','Calle 30 #45-60','1991-04-18'),(12,'carolina','vargas','carolina@gmail.com','3190123456','Av. Nueva 77','1987-06-25');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
  `id` int NOT NULL,
  `proveedor` int DEFAULT NULL,
  `articulo` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proveedor` (`proveedor`),
  KEY `articulo` (`articulo`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`proveedor`) REFERENCES `proveedor` (`id`),
  CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`articulo`) REFERENCES `articulo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (1,2,2,2,'2025-08-19'),(2,1,2,5,'2025-08-19'),(3,3,3,5,'2025-08-18'),(4,4,4,10,'2025-08-17'),(5,5,5,3,'2025-08-16'),(6,6,6,8,'2025-08-15'),(7,7,7,12,'2025-08-14'),(8,8,8,7,'2025-08-13'),(9,9,9,4,'2025-08-12'),(10,10,10,20,'2025-08-11'),(11,11,11,15,'2025-08-10'),(12,12,12,1,'2025-08-09');
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `id` int NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `estado` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'haceb','3145278412',NULL,'hace@gmail.com',1),(2,'temu','4524645123',NULL,NULL,NULL),(3,'lg','3001234567','Calle 45 #12-34','lg@gmail.com',1),(4,'samsung','3012345678','Av. Siempre Viva 123','samsung@gmail.com',1),(5,'sony','3023456789','Calle Falsa 123','sony@gmail.com',1),(6,'nike','3034567890','Calle 7 #8-9','nike@gmail.com',1),(7,'adidas','3045678901','Av. Central 456','adidas@gmail.com',1),(8,'philips','3056789012','Av. Las Palmas 789','philips@gmail.com',1),(9,'bosch','3067890123','Calle Real 101','bosch@gmail.com',1),(10,'pepsico','3078901234','Av. del Rio 202','pepsico@gmail.com',1),(11,'panamericana','3089012345','Av. Cultura 303','panamericana@gmail.com',1),(12,'tesla','3090123456','Av. Futuro 404','tesla@gmail.com',1);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id` int NOT NULL,
  `referencia` varchar(50) DEFAULT NULL,
  `cliente` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `medi_pago` varchar(50) DEFAULT NULL,
  `valor_total` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente` (`cliente`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,'ref445',1,'2025-08-20',NULL,NULL),(2,'ref446',2,'2025-08-21','tarjeta',3500000.00),(3,'ref447',3,'2025-08-22','efectivo',1500000.00),(4,'ref448',4,'2025-08-23','tarjeta',2000000.00),(5,'ref449',5,'2025-08-24','efectivo',500000.00),(6,'ref450',6,'2025-08-25','tarjeta',400000.00),(7,'ref451',7,'2025-08-26','efectivo',700000.00),(8,'ref452',8,'2025-08-27','tarjeta',900000.00),(9,'ref453',9,'2025-08-28','efectivo',1200000.00),(10,'ref454',10,'2025-08-29','tarjeta',1100000.00),(11,'ref455',11,'2025-08-30','efectivo',850000.00);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas_articulo`
--

DROP TABLE IF EXISTS `ventas_articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas_articulo` (
  `id` int NOT NULL,
  `venta` int DEFAULT NULL,
  `articulo` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `valor_articulo` decimal(15,2) DEFAULT NULL,
  `iva_valor` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `venta` (`venta`),
  KEY `articulo` (`articulo`),
  CONSTRAINT `ventas_articulo_ibfk_1` FOREIGN KEY (`venta`) REFERENCES `ventas` (`id`),
  CONSTRAINT `ventas_articulo_ibfk_2` FOREIGN KEY (`articulo`) REFERENCES `articulo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas_articulo`
--

LOCK TABLES `ventas_articulo` WRITE;
/*!40000 ALTER TABLE `ventas_articulo` DISABLE KEYS */;
INSERT INTO `ventas_articulo` VALUES (1,1,2,2,NULL,NULL),(2,1,1,1,NULL,NULL),(3,2,3,1,3000000.00,570000.00),(4,2,4,2,2400000.00,456000.00),(5,3,5,1,1800000.00,342000.00),(6,4,6,3,1500000.00,285000.00),(7,5,7,5,450000.00,85500.00),(8,6,8,2,1200000.00,228000.00),(9,7,9,1,700000.00,133000.00),(10,8,10,4,16000.00,3040.00),(11,9,11,2,160000.00,30400.00),(12,10,12,1,45000000.00,8550000.00);
/*!40000 ALTER TABLE `ventas_articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'tienda_mario'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-20 17:24:17

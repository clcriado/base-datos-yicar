-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.11-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para yicar
DROP DATABASE IF EXISTS `yicar`;
CREATE DATABASE IF NOT EXISTS `yicar` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `yicar`;

-- Volcando estructura para tabla yicar.cliente
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `dni` varchar(15) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yicar.cliente: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
REPLACE INTO `cliente` (`id`, `nombre`, `apellidos`, `dni`, `email`, `telefono`) VALUES
	(1, 'Lucia', 'Lin', '1234567x', 'lucia@gmail.com', '123456789'),
	(2, 'Pepe', 'Lu', '1225567x', 'pepe@gmail.com', '12654789'),
	(3, 'Carlos', 'sanches', '6545567x', 'carlos@gmail.com', '123654987'),
	(4, 'Ying', 'Lin', 'x65178941z', 'ying@gmail.com', '987654321');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;

-- Volcando estructura para tabla yicar.concesionarios
DROP TABLE IF EXISTS `concesionarios`;
CREATE TABLE IF NOT EXISTS `concesionarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ciudad` varchar(200) DEFAULT NULL,
  `provincia` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yicar.concesionarios: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `concesionarios` DISABLE KEYS */;
REPLACE INTO `concesionarios` (`id`, `ciudad`, `provincia`) VALUES
	(1, 'Málaga', 'Málaga'),
	(2, 'Sevilla', 'Sevilla'),
	(3, 'Lucena', 'Cordoba'),
	(4, 'Granada', 'Granada'),
	(5, 'Sevilla', 'Sevilla'),
	(6, 'Lucena', 'Cordoba'),
	(7, 'Granada', 'Granada'),
	(8, 'Madrid', 'Madrid');
/*!40000 ALTER TABLE `concesionarios` ENABLE KEYS */;

-- Volcando estructura para tabla yicar.especialidad
DROP TABLE IF EXISTS `especialidad`;
CREATE TABLE IF NOT EXISTS `especialidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idmecanico` int(11) NOT NULL,
  `idtipo` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_mecanico_has_tipo_tipo1_idx` (`idtipo`) USING BTREE,
  KEY `fk_mecanico_has_tipo_mecanico1_idx` (`idmecanico`) USING BTREE,
  CONSTRAINT `fk_mecanico_has_tipo_mecanico1` FOREIGN KEY (`idmecanico`) REFERENCES `mecanico` (`id`),
  CONSTRAINT `fk_mecanico_has_tipo_tipo1` FOREIGN KEY (`idtipo`) REFERENCES `tipo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yicar.especialidad: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `especialidad` DISABLE KEYS */;
/*!40000 ALTER TABLE `especialidad` ENABLE KEYS */;

-- Volcando estructura para tabla yicar.jefe
DROP TABLE IF EXISTS `jefe`;
CREATE TABLE IF NOT EXISTS `jefe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_jefe_usuario1_idx` (`idusuario`),
  CONSTRAINT `fk_jefe_usuario1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yicar.jefe: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `jefe` DISABLE KEYS */;
/*!40000 ALTER TABLE `jefe` ENABLE KEYS */;

-- Volcando estructura para tabla yicar.mecanico
DROP TABLE IF EXISTS `mecanico`;
CREATE TABLE IF NOT EXISTS `mecanico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idusuario` int(11) NOT NULL,
  `esJefe` tinyint(4) NOT NULL,
  `numReparaciones` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_mecanico_usuario1_idx` (`idusuario`),
  CONSTRAINT `fk_mecanico_usuario1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yicar.mecanico: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `mecanico` DISABLE KEYS */;
REPLACE INTO `mecanico` (`id`, `idusuario`, `esJefe`, `numReparaciones`) VALUES
	(1, 1, 1, 0),
	(2, 4, 0, 0);
/*!40000 ALTER TABLE `mecanico` ENABLE KEYS */;

-- Volcando estructura para tabla yicar.reparacion
DROP TABLE IF EXISTS `reparacion`;
CREATE TABLE IF NOT EXISTS `reparacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idvehiculo` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idmecanico` int(11) NOT NULL,
  `presupuesto` decimal(10,2) DEFAULT NULL,
  `inicio` datetime DEFAULT NULL,
  `fin` datetime DEFAULT NULL,
  `componentes` text DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` enum('pendiente','proceso','finalizada') DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_vehiculo_has_cliente_cliente1_idx` (`idcliente`),
  KEY `fk_vehiculo_has_cliente_vehiculo1_idx` (`idvehiculo`),
  KEY `fk_reparación_mecanico1_idx` (`idmecanico`),
  CONSTRAINT `fk_reparación_mecanico1` FOREIGN KEY (`idmecanico`) REFERENCES `mecanico` (`id`),
  CONSTRAINT `fk_vehiculo_has_cliente_cliente1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`id`),
  CONSTRAINT `fk_vehiculo_has_cliente_vehiculo1` FOREIGN KEY (`idvehiculo`) REFERENCES `vehiculo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yicar.reparacion: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `reparacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `reparacion` ENABLE KEYS */;

-- Volcando estructura para tabla yicar.tipo
DROP TABLE IF EXISTS `tipo`;
CREATE TABLE IF NOT EXISTS `tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yicar.tipo: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo` DISABLE KEYS */;
REPLACE INTO `tipo` (`id`, `nombre`) VALUES
	(1, 'coche'),
	(2, 'motocicleta'),
	(3, 'ciclomotor');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;

-- Volcando estructura para tabla yicar.usuario
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idConcesionario` int(11) NOT NULL,
  `login` varchar(255) DEFAULT NULL,
  `clave` varchar(255) DEFAULT NULL,
  `dni` varchar(15) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `salario` decimal(7,2) NOT NULL,
  `tipo` enum('vendedor','mecanico','jefe') NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `login` (`login`),
  KEY `fk_usuario_concesionarios1_idx` (`idConcesionario`) USING BTREE,
  CONSTRAINT `fk_usuario_concesionarios1` FOREIGN KEY (`idConcesionario`) REFERENCES `concesionarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yicar.usuario: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
REPLACE INTO `usuario` (`id`, `idConcesionario`, `login`, `clave`, `dni`, `nombre`, `apellidos`, `email`, `salario`, `tipo`) VALUES
	(1, 1, 'mecanico_jefe', '1234', '123456789A', 'Mecánico Jefe', 'Apellidos', 'mecanico_jefe@email.es', 1200.00, 'mecanico'),
	(2, 1, 'vendedor', '1234', '789456123B', 'Vendedor', 'Apellidos', 'vendedor@email.es', 1200.00, 'vendedor'),
	(3, 1, 'jefe', '1234', '456789123C', 'TheBoss', 'Jefazo', 'elcapitan@email.es', 15000.00, 'jefe'),
	(4, 1, 'mecanico', '1234', '124566789A', 'Mecánico', 'Apellidos', 'mecanico@email.es', 1200.00, 'vendedor');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

-- Volcando estructura para tabla yicar.vehiculo
DROP TABLE IF EXISTS `vehiculo`;
CREATE TABLE IF NOT EXISTS `vehiculo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idConcesionario` int(11) NOT NULL,
  `idTipo` int(11) NOT NULL,
  `matricula` varchar(15) DEFAULT NULL,
  `precio` decimal(12,2) DEFAULT NULL,
  `segunda_mano` tinyint(1) DEFAULT NULL,
  `combustible` enum('diesel','gasolina') DEFAULT NULL,
  `km_recorridos` int(11) DEFAULT NULL,
  `modelo` varchar(255) DEFAULT NULL,
  `marca` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_vehiculo_tipo1_idx` (`idTipo`) USING BTREE,
  KEY `fk_vehiculo_concesionarios_idx` (`idConcesionario`) USING BTREE,
  CONSTRAINT `fk_vehiculo_concesionarios` FOREIGN KEY (`idConcesionario`) REFERENCES `concesionarios` (`id`),
  CONSTRAINT `fk_vehiculo_tipo1` FOREIGN KEY (`idTipo`) REFERENCES `tipo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yicar.vehiculo: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `vehiculo` DISABLE KEYS */;
REPLACE INTO `vehiculo` (`id`, `idConcesionario`, `idTipo`, `matricula`, `precio`, `segunda_mano`, `combustible`, `km_recorridos`, `modelo`, `marca`) VALUES
	(1, 2, 1, 'AA1234AA', 15000.00, 0, 'diesel', 0, 'Audi', 'A1'),
	(3, 3, 1, 'BB1234BB', 25000.00, 0, 'diesel', 0, 'Audi', 'Q1'),
	(4, 3, 1, 'BB1234CC', 21000.00, 0, 'diesel', 0, 'Dacia', 'Dokker'),
	(5, 3, 2, 'AA1234CC', 11000.00, 0, 'diesel', 0, 'ARC', 'Vector'),
	(6, 3, 3, 'DE1234CC', 2000.00, 1, 'diesel', 50, 'Yamaha', 'Aerox 4');
/*!40000 ALTER TABLE `vehiculo` ENABLE KEYS */;

-- Volcando estructura para tabla yicar.vendedor
DROP TABLE IF EXISTS `vendedor`;
CREATE TABLE IF NOT EXISTS `vendedor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `numVentas` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_venta_usuario_idx` (`idUsuario`),
  CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yicar.vendedor: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `vendedor` DISABLE KEYS */;
REPLACE INTO `vendedor` (`id`, `idUsuario`, `numVentas`) VALUES
	(1, 2, 10),
	(2, 4, 10),
	(3, 2, 10),
	(4, 4, 5);
/*!40000 ALTER TABLE `vendedor` ENABLE KEYS */;

-- Volcando estructura para tabla yicar.ventas
DROP TABLE IF EXISTS `ventas`;
CREATE TABLE IF NOT EXISTS `ventas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idVendedor` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idVehiculo` int(11) DEFAULT NULL,
  `estado` enum('pendiente','rechazada','aceptada') NOT NULL DEFAULT 'pendiente',
  `inicio` datetime NOT NULL DEFAULT current_timestamp(),
  `fin` datetime DEFAULT NULL,
  `fecha_limite` date NOT NULL,
  `presupuesto` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ventas_vendedor` (`idVendedor`),
  KEY `FK_ventas_cliente` (`idCliente`),
  KEY `FK_ventas_vehiculo` (`idVehiculo`),
  CONSTRAINT `FK_ventas_cliente` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`id`),
  CONSTRAINT `FK_ventas_vehiculo` FOREIGN KEY (`idVehiculo`) REFERENCES `vehiculo` (`id`),
  CONSTRAINT `FK_ventas_vendedor` FOREIGN KEY (`idVendedor`) REFERENCES `vendedor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla yicar.ventas: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
REPLACE INTO `ventas` (`id`, `idVendedor`, `idCliente`, `idVehiculo`, `estado`, `inicio`, `fin`, `fecha_limite`, `presupuesto`) VALUES
	(1, 2, 1, 1, 'pendiente', '2021-01-10 00:00:00', NULL, '2021-01-25', 14000.00),
	(2, 3, 2, 4, 'aceptada', '2021-01-03 00:00:00', '2021-01-07 00:00:00', '2021-01-14', 19000.00),
	(3, 1, 4, 6, 'rechazada', '2020-11-25 00:00:00', '2020-12-07 00:00:00', '2020-12-25', 1500.00);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

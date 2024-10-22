-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           8.0.29 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Copiando estrutura para tabela dipes_disst_seguranca.predios_base
CREATE TABLE IF NOT EXISTS `predios_base` (
  `idpredio` int NOT NULL AUTO_INCREMENT,
  `predio_nb` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `predio_nb_num` bigint DEFAULT NULL,
  `predio_nome` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `predio_logradouro` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `predio_bairro` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `predio_municipio` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `predio_uf` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `predio_area` int DEFAULT NULL COMMENT 'Área da DISEC',
  `predio_terreo` int DEFAULT '1',
  `predio_andares` int DEFAULT '0',
  `predio_subsolos` int DEFAULT '0',
  `predio_mezanino` int DEFAULT '0' COMMENT 'não utilizar, campo desativado, mantido para compatibilidade',
  `predio_sobreloja` int DEFAULT '0',
  `predio_terraco` int DEFAULT '0',
  PRIMARY KEY (`idpredio`) USING BTREE,
  UNIQUE KEY `predio_nb_UNIQUE` (`predio_nb`) USING BTREE,
  UNIQUE KEY `Index 3` (`predio_nb_num`) USING BTREE,
  KEY `Index 4` (`predio_uf`) USING BTREE,
  KEY `Index 5` (`predio_municipio`) USING BTREE,
  KEY `Index 10` (`predio_nome`) USING BTREE,
  KEY `Index 12` (`predio_area`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7779 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela dipes_disst_seguranca.predios_base: ~5.593 rows (aproximadamente)
REPLACE INTO `predios_base` (`idpredio`, `predio_nb`, `predio_nb_num`, `predio_nome`, `predio_logradouro`, `predio_bairro`, `predio_municipio`, `predio_uf`, `predio_area`, `predio_terreo`, `predio_andares`, `predio_subsolos`, `predio_mezanino`, `predio_sobreloja`, `predio_terraco`) VALUES
	(1, '7418133110004', 7418133110004, 'Edifício 1', 'Endereço Edifício 1', 'Bairro Edifício 1', 'Município Edifício 1', 'AA', 163078, 1, 16, 5, 0, 0, 0),
	(2, '1966050350005', 1966050350005, 'Edifício 2', 'Endereço Edifício 2', 'Bairro Edifício 2', 'Município Edifício 2', 'BB', 74537, 1, 0, 0, 0, 0, 0),
	(3, '1031323', 1031323, 'Edifício 3', 'Endereço Edifício 3', 'Bairro Edifício 3', 'Município Edifício 3', 'CC', 55567, 1, 44, 0, 0, 0, 0),
	(4, '9600122390108', 9600122390108, 'Edifício 4', 'Endereço Edifício 4', 'Bairro Edifício 4', 'Município Edifício 4', 'DD', 46054, 1, 25, 3, 0, 0, 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

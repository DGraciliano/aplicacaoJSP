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

-- Copiando estrutura para tabela dipes_disst_seguranca.mapa_risco
CREATE TABLE IF NOT EXISTS `mapa_risco` (
  `id_mapa` int NOT NULL AUTO_INCREMENT,
  `id_predio` int DEFAULT NULL,
  `andar` int DEFAULT NULL,
  `mapa_rpa_cipa` bit(1) DEFAULT NULL,
  `dt_avaliacao` datetime DEFAULT NULL,
  `dt_limite` datetime DEFAULT NULL,
  UNIQUE KEY `id_predio_andar_ano_dt_limite` (`id_predio`,`andar`) USING BTREE,
  KEY `id_predio` (`id_predio`) USING BTREE,
  KEY `andar` (`andar`) USING BTREE,
  KEY `id_mapa` (`id_mapa`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela dipes_disst_seguranca.mapa_risco: ~0 rows (aproximadamente)
REPLACE INTO `mapa_risco` (`id_mapa`, `id_predio`, `andar`, `mapa_rpa_cipa`, `dt_avaliacao`, `dt_limite`) VALUES
	(28, 1778, 18, NULL, '2024-08-05 14:31:34', '2025-08-05 00:00:00');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

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

-- Copiando estrutura para tabela dipes_disst_seguranca.mapa_risco_avaliacao
CREATE TABLE IF NOT EXISTS `mapa_risco_avaliacao` (
  `id_mapa` int DEFAULT NULL,
  `id_predio` int DEFAULT NULL,
  `andar` int DEFAULT NULL,
  `grupo` int DEFAULT NULL,
  `risco` int DEFAULT NULL,
  `quem_gravou` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `rpa_cipa` tinyint DEFAULT NULL,
  `intensidade` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `dt_gravacao` datetime DEFAULT NULL,
  `id_respondente` int DEFAULT NULL,
  `dt_alteracao` datetime DEFAULT NULL,
  UNIQUE KEY `id_predio_andar_grupo_risco_quem_gravou_dt_limite` (`id_mapa`,`grupo`,`risco`,`id_respondente`) USING BTREE,
  KEY `grupo` (`grupo`) USING BTREE,
  KEY `risco` (`risco`) USING BTREE,
  KEY `intensidade` (`intensidade`) USING BTREE,
  KEY `id_mapa` (`id_mapa`) USING BTREE,
  KEY `quem_gravou` (`id_respondente`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela dipes_disst_seguranca.mapa_risco_avaliacao: ~9 rows (aproximadamente)
REPLACE INTO `mapa_risco_avaliacao` (`id_mapa`, `id_predio`, `andar`, `grupo`, `risco`, `quem_gravou`, `rpa_cipa`, `intensidade`, `dt_gravacao`, `id_respondente`, `dt_alteracao`) VALUES
	(28, 1778, 18, 1, 2, '7654321', 1, '1', '2024-08-05 14:31:34', 7654321, '2024-08-05 14:33:37'),
	(28, 1778, 18, 2, 9, '7654321', 1, '1', '2024-08-05 14:31:34', 7654321, '2024-08-05 14:33:37'),
	(28, 1778, 18, 1, 3, '7654321', 1, '1', '2024-08-05 14:32:13', 7654321, '2024-08-05 14:33:37'),
	(28, 1778, 18, 1, 4, '7654321', 1, '1', '2024-08-05 14:32:13', 7654321, '2024-08-05 14:33:37'),
	(28, 1778, 18, 5, 59, '1234567', 0, '3', '2024-08-05 14:35:01', 1234567, '2024-09-19 13:31:21'),
	(28, 1778, 18, 5, 60, '1234567', 0, '3', '2024-08-05 14:35:01', 1234567, '2024-09-19 13:31:21'),
	(28, 1778, 18, 5, 62, '1234567', 0, '3', '2024-08-05 14:35:01', 1234567, '2024-09-19 13:31:21'),
	(28, 1778, 18, 1, 2, '1234567', 0, '3', '2024-08-06 15:46:38', 1234567, '2024-09-19 13:31:21'),
	(28, 1778, 18, 2, 9, '1234567', 0, '3', '2024-08-06 16:35:23', 1234567, '2024-09-19 13:31:21');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

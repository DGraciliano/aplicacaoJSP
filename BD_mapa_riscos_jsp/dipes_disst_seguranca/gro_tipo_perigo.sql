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

-- Copiando estrutura para tabela dipes_disst_seguranca.gro_tipo_perigo
CREATE TABLE IF NOT EXISTS `gro_tipo_perigo` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `observacao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `consequencia` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cd_grupo` smallint NOT NULL,
  `cd_esocial` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `ativo` bit(1) NOT NULL,
  `gravado_em` datetime DEFAULT NULL,
  PRIMARY KEY (`codigo`) USING BTREE,
  KEY `cd_grupo` (`cd_grupo`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- Copiando dados para a tabela dipes_disst_seguranca.gro_tipo_perigo: ~55 rows (aproximadamente)
REPLACE INTO `gro_tipo_perigo` (`codigo`, `descricao`, `observacao`, `consequencia`, `cd_grupo`, `cd_esocial`, `ativo`, `gravado_em`) VALUES
	(2, 'Ruído contínuo (Ruído não típico de escritório)', '', 'Perda auditiva, alteração do estado de alerta, zumbido, tontura, alterações da discriminação da fala, otalgia, estresse, insônia, irritabilidade, comprometimento do rendimento no trabalho por diminuição da capacidade de concentração mental e interferência na comunicação oral.', 1, '02.01.001', b'1', '2022-06-15 10:25:35'),
	(3, 'Radiação ultravioleta', '', 'Perturbações visuais (conjuntivites, cataratas), queimaduras, lesões na pele', 1, '09.01.001', b'1', '2022-03-10 10:18:55'),
	(4, 'Calor', '', 'Desidratação, erupção da pele, câimbras, fadiga física, distúrbios psiconeuróticos, problemas cardiocirculatórios, insolação.', 1, '02.01.014', b'1', '2022-06-15 10:29:24'),
	(5, 'Frio', '', 'Feridas, rachaduras e necrose na pele, enregelamento: ficar congelado, agravamento de doenças reumáticas, predisposição para acidentes, predisposição para doenças das vias respiratórias.', 1, '09.01.001', b'1', '2022-03-10 10:19:22'),
	(6, 'Umidade', '', 'Pode acarretar doenças do aparelho respiratório, quedas, doenças de pele, doenças circulatórias, entre outras.', 1, '09.01.001', b'1', '2022-03-10 10:31:01'),
	(7, 'Ruído de impacto ', '', 'Perda auditiva, alteração do estado de alerta, zumbido, tontura, alterações da discriminação da fala, otalgia, estresse, insônia, irritabilidade, comprometimento do rendimento no trabalho por diminuição da capacidade de concentração mental e interferência na comunicação oral.', 1, '02.01.001', b'1', '2022-06-15 10:31:28'),
	(9, 'Poeiras', '', 'A inalação de poeiras pode causar transtornos no trato respiratório, principalmente aos asmáticos e alérgicos.', 2, '09.01.001', b'1', '2022-03-10 10:31:19'),
	(10, 'Produtos de limpeza', '', 'Possibilidade de alergias, queimaduras e intoxicação pelo material.', 2, '09.01.001', b'1', '2022-03-10 10:30:52'),
	(11, 'Incêndio / explosão / derrame de óleo diesel', '', 'Possibilidade de derramamento de combustível e incêndio que pode gerar inalação da fumaça para o indivíduo com agravo para o pulmão, irritação de olhos e narinas, cegueira, desorientação espacial com dificuldade de abandono do local, queimaduras e morte.', 5, '09.01.001', b'0', '2022-08-01 12:52:33'),
	(12, 'Óleo Lubrificante e/ou graxa', '', 'Possibilidade de alergias, queimaduras e intoxicação pelo material.', 2, '09.01.001', b'0', '2022-07-11 16:01:33'),
	(14, 'Dióxido de carbono', '', 'Tontura, sonolência, confusão mental, ansiedade e declínio da percepção visual.', 2, '09.01.001', b'0', '2022-06-13 16:11:39'),
	(16, 'Agentes biológicos infecciosos (bactérias, vírus, protozoários, fungos,  parasitas e outros).', '', 'Aumento da exposição a microrganismos com possibilidade de contágio de doenças que podem gerar diarreia, infecções na pele, síndromes respiratórias, entre outras.', 3, '09.01.001', b'1', '2022-03-10 10:32:08'),
	(17, 'Possibilidade de contaminação por Covid-19', '', 'Febre, falta de ar, dores no corpo, perda de olfato e paladar, diarreia, síndrome respiratória aguda grave e morte.', 3, '09.01.001', b'0', '2022-03-10 10:32:15'),
	(18, 'Trabalho ambiente climatizado artificialmente', '', 'Aumento da exposição a microorganismos com possibilidade de contágio de doenças, principalmente de vias respiratórias e alergias.', 3, '09.01.001', b'1', '2023-01-04 13:15:47'),
	(19, 'Consumo de água da rede pública', '', 'Aumento da exposição a microorganismos com possibilidade de contágio de doenças que podem gerar transtornos gastrointestinais.', 3, '09.01.001', b'0', '2022-09-19 10:39:01'),
	(21, 'Levantamento, transporte e descarga de materiais.', '', 'Doenças osteomusculares, principalmente em região de coluna lombar e ombros.', 4, '09.01.001', b'1', '2022-09-21 09:20:40'),
	(22, 'Trabalho predominantemente executado na posição sentada', '', 'Pouca atividade física geral (sedentarismo), possibilidade de adoção de posturas desfavoráveis, lordose ou cifoses excessivas, dificuldade de retorno sanguíneo dos membros inferiores que pode ocasionar dor e fadiga nas pernas.', 4, '09.01.001', b'1', '2022-03-10 10:54:44'),
	(23, 'Trabalho em terminais de vídeo', '', 'Desconforto, fadiga visual e cefaléia que podem comprometer também a concentração e desempenho do trabalho.', 4, '09.01.001', b'1', '2023-01-03 15:26:24'),
	(24, 'Sistema de entintamento - disparo acidental', '', 'Possibilidade de lesão na pele e e região de face.', 5, '09.01.001', b'1', '2022-03-10 11:27:28'),
	(25, 'Organização do trabalho', '', 'Possibilidade de transtornos mentais, principalmente os de ansiedade e de humor.', 4, '09.01.001', b'1', '2022-03-10 10:54:54'),
	(26, 'Trabalho predominantemente executado em pé', '', 'Dificuldade de retorno venoso dos membros inferiores que predispõe ao aparecimento de insuficiência valvular venosa, resultando em varizes e sensação de peso, dor e tensão muscular nas pernas.', 4, '09.01.001', b'1', '2022-03-10 10:55:14'),
	(31, 'Movimentos repetitivos', '', 'Possibilidade de tenossinovites, principalmente em região de punho e mão.', 4, '09.01.001', b'0', '2022-07-07 13:52:24'),
	(32, 'Agentes Psicossociais / Cognitivos / Bulling / Vitimização / Assédio', '', 'Possibilidade de transtornos mentais, principalmente os de ansiedade e de humor.', 4, '09.01.001', b'1', '2022-04-04 14:58:22'),
	(34, 'Elevação  de membros superiores', '', 'Se a elevação for acima da linha dos ombros, há possibilidade de falta de oxigênio na musculatura, dor e tendência à lesão por acúmulo de ácido láctico nos tecidos da região do ombro.', 4, '09.01.001', b'1', '2022-03-10 11:26:46'),
	(35, 'Flexões de coluna vertebral', '', 'Fadiga muscular e dor em região da coluna, principalmente lombar.', 4, '09.01.001', b'1', '2022-03-10 11:26:55'),
	(36, 'Trabalho em altura', '', 'Possibilidade de queda, escoriações, hematomas, entorse, luxação de articulações, fratura de ossos do corpo e morte.', 5, '09.01.001', b'1', '2022-03-10 11:27:39'),
	(37, 'Incêndio', '', 'Possibilidade de inalação da fumaça com agravo para o pulmão, irritação de olhos e narinas, cegueira, desorientação espacial com dificuldade de abandono do local, queimaduras e morte.', 5, '09.01.001', b'1', '2022-03-10 11:27:48'),
	(38, 'Queda em nível e em desnível de piso', '', 'Possibilidade de queda, escoriações, hematomas, entorse, luxação de articulações, fratura de ossos do corpo e morte.', 5, '09.01.001', b'1', '2022-08-17 10:00:25'),
	(39, 'Batida contra', '', 'Possibilidade de escoriações, hematomas, luxações, fraturas de partes do corpo e morte.', 5, '09.01.001', b'1', '2022-03-10 11:28:07'),
	(40, 'Colisão, acidente de trânsito', '', 'Possibilidade de escoriações, hematomas, luxações, fraturas de partes do corpo e morte.', 5, '09.01.001', b'1', '2022-03-10 11:28:16'),
	(41, 'Atropelamento', '', 'Possibilidade de escoriações, hematomas, luxações, fraturas de partes do corpo e morte.', 5, '09.01.001', b'1', '2022-03-10 11:28:23'),
	(42, 'Roubo, assalto a mão armada', '', 'Possibilidade de escoriações, hematomas, lesões físicas, transtorno psicológico e morte.', 5, '09.01.001', b'1', '2022-03-10 11:28:31'),
	(43, 'Eletricidade, operações elementares (ligar/desligar) circuítos elétricos em baixa tensão.', '', 'Choque elétrico com possibilidade de queimaduras de partes do corpo e alteração no ritmo cardíaco que pode levar à parada cardíaca.', 5, '09.01.001', b'1', '2022-07-11 15:27:01'),
	(44, 'Espaço confinado', '', 'Morte, Desmaio, Escoriações e/ou Hematomas, Fratura de ossos do corpo, Inalação de gases tóxicos, Contaminação com substâncias perigosas', 5, '09.01.001', b'1', '2022-03-10 11:29:12'),
	(45, 'Agressão por clientes alterados ', '', 'Possibilidade de escoriações, hematomas, lesões físicas, transtorno psicológico e morte.', 5, '09.01.001', b'1', '2022-06-28 15:58:12'),
	(46, 'Ataque de animais', '', 'Possibilidade de escoriações, hematomas, lesões físicas, transtorno psicológico e morte.', 5, '09.01.001', b'1', '2022-03-10 11:29:21'),
	(49, 'Área classificada para risco de explosão', '', 'Exposição da dependência à fiscalizações e multas. Possibilidade de acidentes pela inadequada identificação deste risco, incêndios e explosões.', 5, '09.01.001', b'1', '2022-03-10 11:29:28'),
	(52, 'Condições de conforto térmico nos locais de trabalho', '', 'Nas situações com temperatura do ar abaixo do adequado pode haver calafrios no corpo, problemas de concentração e desconforto.\r\nNas situações com temperatura do ar acima do adequado pode haver irritabilidade, sudorese, desconforto, alteração na pressão arterial e queda da produtividade.', 4, '09.01.001', b'1', '2022-06-29 11:26:22'),
	(53, 'Condições de conforto acústico nos locais de trabalho', '', 'Possibilidade de irritabilidade, comprometimento do rendimento no trabalho por diminuição da capacidade de concentração mental e interferência na comunicação oral', 4, '09.01.001', b'1', '2022-03-10 11:27:02'),
	(54, 'Condições da iluminação dos ambientes de trabalho', '', 'Desconforto, fadiga visual e cefaléia que podem comprometer também a concentração e desempenho do trabalho.', 4, '09.01.001', b'1', '2022-03-10 11:27:10'),
	(55, 'Condições de conforto no ambiente de trabalho', 'Iluminação, conforto acústico e térmico', 'Possibilidade de irritabilidade, comprometimento do rendimento no trabalho por diminuição da capacidade de concentração mental e interferência na comunicação oral pelo ruído. Possibilidade de queda na produtividade, aumento na quantidade de erros e acidentes e algumas doenças devido o estresse térmico. Irritação na garganta, sangramento nasal, dores de cabeça, sensação de areia nos olhos e doenças respiratórias devido a umidade inadequada. Desconforto, fadiga visual e cefaléia que podem comprometer também a concentração e desempenho do trabalho por iluminação inadequada.', 4, '09.01.001', b'1', '2022-03-10 11:27:19'),
	(57, 'Eletricidade subestação (gestão)', 'Utilizar para avaliar as condições da subestação de energia elétrica', 'Exposição da dependência à fiscalizações e multas. Possibilidade de acidentes pela inadequada sinalização e restrição de acesso, o qual pode causar curto circuitos, incêndios e explosões.', 5, '09.01.001', b'1', '2022-07-14 11:28:43'),
	(58, 'Agente biológico (microrganismos)', '', 'Aumento da exposição a microrganismos com possibilidade de contágio de doenças, principalmente de vias respiratórias e alergias.', 3, '09.01.001', b'1', '2022-07-07 09:43:27'),
	(59, 'Obra ou serviço em prédios de uso do Banco', '', 'Exposição da dependência à fiscalizações e multas caso não haja o devido controle de restrição de acesso de pessoas não autorizadas.', 5, '09.01.001', b'1', '2022-08-12 11:28:57'),
	(60, 'Eletricidade subestação (operação)', 'Utilizar ao avaliar os Engenheiros Eletricistas do Banco com acesso a subestação', 'Choque elétrico com possibilidade de queimaduras de partes do corpo e alteração no ritmo cardíaco que pode levar à parada cardíaca.', 5, '09.01.001', b'1', '2022-07-12 13:24:25'),
	(61, 'Óleo diesel', '', 'Possibilidade de alergias,\r\nqueimaduras e intoxicação\r\npelo material.', 2, '09.01.001', b'0', '2022-08-01 10:29:10'),
	(62, 'Armazenagem de combustível (gerador eletricidade) ', '', 'Possibilidade de derramamento de combustível e incêndio que pode gerar inalação da fumaça para o indivíduo com agravo para o pulmão, irritação de olhos e narinas, cegueira, desorientação espacial com dificuldade de abandono do local, queimaduras e morte.', 5, '09.01.001', b'1', '2022-08-01 11:02:55'),
	(63, 'Consumo de água no ambiente de trabalho', '', 'Aumento da exposição a microorganismos com possibilidade de contágio de doenças que podem gerar transtornos gastrointestinais.', 3, '09.01.001', b'1', '2022-09-19 09:39:40'),
	(64, 'Compatibilidade entre demandas e capacidade da equipe (DEMANDAS)', '', 'Possibilidade de transtornos mentais, principalmente os de ansiedade e de humor.', 4, '09.01.001	', b'0', '2024-04-26 08:46:45'),
	(65, 'Controle da atividade laboral / assédio / vitimização (CONTROLE)', '', 'Possibilidade de transtornos mentais, principalmente os de ansiedade e de humor.', 4, '09.01.001', b'0', '2024-04-26 08:47:09'),
	(66, 'Apoio social (CHEFIA)', '', 'Possibilidade de transtornos mentais, principalmente os de ansiedade e de humor.', 4, '09.01.001', b'0', '2024-04-26 08:52:56'),
	(67, 'Apoio social (COLEGAS)', '', 'Possibilidade de transtornos mentais, principalmente os de ansiedade e de humor.', 4, '09.01.001', b'0', '2024-04-26 08:51:38'),
	(68, 'Relacionamentos interpessoais / Bulling / Assédio (RELACIONAMENTOS)', '', 'Possibilidade de transtornos mentais, principalmente os de ansiedade e de humor.', 4, '09.01.001', b'0', '2024-04-26 08:52:40'),
	(69, 'Cargo', '', 'Possibilidade de transtornos mentais, principalmente os de ansiedade e de humor.', 4, '09.01.001', b'0', '2024-04-26 08:53:57'),
	(70, 'Comunicação de mudanças', '', 'Possibilidade de transtornos mentais, principalmente os de ansiedade e de humor.', 4, '09.01.001', b'0', '2024-04-26 08:55:14');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

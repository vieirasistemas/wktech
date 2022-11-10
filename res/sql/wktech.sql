DROP TABLE IF EXISTS `produto`;
CREATE TABLE `produto` (
  `id_produto` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  `precovenda` double NOT NULL,
  PRIMARY KEY (`id_produto`),
  KEY `id_descricao` (`descricao`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

INSERT INTO `produto` VALUES ('1', 'OCULOS WAYFARER', '180');
INSERT INTO `produto` VALUES ('2', 'OC VER AVIADOR METAL', '109.99');
INSERT INTO `produto` VALUES ('3', 'OC VER B881291', '50');
INSERT INTO `produto` VALUES ('4', 'OC VER B881320', '74.99');
INSERT INTO `produto` VALUES ('5', 'OC VER B881266', '74.99');
INSERT INTO `produto` VALUES ('6', 'OC VER 009102', '109.99');
INSERT INTO `produto` VALUES ('7', 'OC VER 2140', '109.99');
INSERT INTO `produto` VALUES ('8', 'OC VER VZ003', '109.99');
INSERT INTO `produto` VALUES ('9', 'OC VER D2604', '109.99');
INSERT INTO `produto` VALUES ('10', 'OC VER 009184', '109.99');
INSERT INTO `produto` VALUES ('11', 'OC VER 1272', '109.99');
INSERT INTO `produto` VALUES ('12', 'OC VER 009264', '109.99');
INSERT INTO `produto` VALUES ('13', 'OC VER 2225', '109.99');
INSERT INTO `produto` VALUES ('14', 'OC VER 5500P', '109.99');
INSERT INTO `produto` VALUES ('15', 'OC VER 507', '109.99');
INSERT INTO `produto` VALUES ('16', 'OC VER MMJ287', '109.99');
INSERT INTO `produto` VALUES ('17', 'OC B881307', '50');
INSERT INTO `produto` VALUES ('18', 'OC VER B881247', '74.99');
INSERT INTO `produto` VALUES ('19', 'OC VER 1319', '109.99');
INSERT INTO `produto` VALUES ('20', 'OC VER B881284', '74.99');
INSERT INTO `produto` VALUES ('21', 'OC VER B881317', '74.99');
INSERT INTO `produto` VALUES ('22', 'OC VER B88371', '50');
INSERT INTO `produto` VALUES ('23', 'OC VER 17161', '50');
INSERT INTO `produto` VALUES ('24', 'OC VER 17164', '50');
INSERT INTO `produto` VALUES ('25', 'OC VER17159', '109.99');

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cidade` varchar(40) NOT NULL,
  `uf` char(2) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `idx_nome` (`nome`) USING BTREE,
  KEY `idx_cidade` (`cidade`) USING BTREE,
  KEY `idx_uf` (`uf`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

INSERT INTO `cliente` VALUES ('1', 'FABIO', 'GOIANIA', 'GO');
INSERT INTO `cliente` VALUES ('2', 'MARIA', 'GOIANIA', 'GO');
INSERT INTO `cliente` VALUES ('3', 'LUIZA', 'GOIANIA', 'GO');
INSERT INTO `cliente` VALUES ('4', 'JOANA', 'GOIANIA', 'GO');
INSERT INTO `cliente` VALUES ('5', 'CLAUDIA', 'GOIANIA', 'GO');
INSERT INTO `cliente` VALUES ('6', 'LUANNA', 'GOIANIA', 'GO');
INSERT INTO `cliente` VALUES ('7', 'FERNANDO', 'GOIANIA', 'GO');
INSERT INTO `cliente` VALUES ('8', 'ANTONIO', 'GOIANIA', 'GO');
INSERT INTO `cliente` VALUES ('9', 'CARLOS', 'GOIANIA', 'GO');
INSERT INTO `cliente` VALUES ('10', 'PEDRO', 'GOIANIA', 'GO');
INSERT INTO `cliente` VALUES ('11', 'LUISA', 'GOIANIA', 'GO');
INSERT INTO `cliente` VALUES ('12', 'ELENICE', 'SAO LUIS', 'MA');
INSERT INTO `cliente` VALUES ('13', 'SULIENE', 'GOIANIRA', 'GO');
INSERT INTO `cliente` VALUES ('14', 'SULIETE', 'GOIANIRA', 'GO');
INSERT INTO `cliente` VALUES ('15', 'SUELI', 'GOIANIRA', 'GO');
INSERT INTO `cliente` VALUES ('16', 'SOLANGE', 'GOIANIRA', 'GO');
INSERT INTO `cliente` VALUES ('17', 'ROBERT', 'GOIANIRA', 'GO');
INSERT INTO `cliente` VALUES ('18', 'VALTELINA', 'GOIANIRA', 'GO');
INSERT INTO `cliente` VALUES ('19', 'VALTER', 'GOIANIRA', 'GO');
INSERT INTO `cliente` VALUES ('20', 'ZAIRI', 'GOIANIRA', 'GO');

DROP TABLE IF EXISTS `pedido`;
CREATE TABLE `pedido` (
  `idpedido` int(11) NOT NULL,
  `emissao` date NOT NULL,
  `idcliente` int(11) NOT NULL,
  `vlrtotal` double NOT NULL,
  PRIMARY KEY (`idpedido`),
  UNIQUE KEY `pk_pedido` (`idpedido`),
  KEY `idx_emissao` (`emissao`) USING BTREE,
  KEY `idx_cliente` (`idcliente`) USING BTREE,
  CONSTRAINT `fk_cliente` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `pedido_produto`;
CREATE TABLE `pedido_produto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idpedido` int(11) NOT NULL,
  `idproduto` int(11) NOT NULL,
  `qtd` float(11,0) NOT NULL,
  `vlrunit` float NOT NULL,
  `vlrtotal` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pk_pedido_produto` (`id`),
  KEY `idx_pedido` (`idpedido`),
  KEY `idx_produto` (`idproduto`),
  CONSTRAINT `fk_pedido` FOREIGN KEY (`idpedido`) REFERENCES `pedido` (`idpedido`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`id_produto`) ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;


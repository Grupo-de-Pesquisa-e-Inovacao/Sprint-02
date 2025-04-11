-- GRUPO 11 - AviTrack
-- Kauan Luna
-- Nicolly Cristine
-- André Boer
-- Eduardo Gomes
-- Daniel Guimarães

CREATE DATABASE avitrack;

USE avitrack;

-- Criando a tabela 'funcionario_empresa'
CREATE TABLE representante (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
	cargo VARCHAR(30) NOT NULL,
    email_comercial VARCHAR(70) NOT NULL UNIQUE,
    senha VARCHAR(30) NOT NULL
);

-- Criando a tabela 'empresa_cliente'
CREATE TABLE empresa_cliente (
		id INT PRIMARY KEY AUTO_INCREMENT,
        nome VARCHAR(50) NOT NULL,
		cnpj VARCHAR(18) NOT NULL UNIQUE,
        email VARCHAR(50) NOT NULL UNIQUE,
        telefone_comercial CHAR(11) NOT NULL,
        cep VARCHAR(15) NOT NULL,
        uf CHAR(2) NOT NULL,
        cidade VARCHAR(40) NOT NULL,
        logradouro VARCHAR(100) NOT NULL,
        numero VARCHAR(6) NOT NULL,
        complemento VARCHAR(50),
        fk_representante INT, 
        CONSTRAINT fkEmpresaRepresentante FOREIGN KEY (fk_representante)
			REFERENCES representante(id)
);
        
CREATE TABLE setor (
	id INT,
    nome VARCHAR(45) NOT NULL,
    area FLOAT NOT NULL,
    fkEmpresa INT NOT NULL,
    CONSTRAINT fk_setor_empresa FOREIGN KEY (fkEmpresa)
		REFERENCES empresa_cliente(id),
	CONSTRAINT pk_composta PRIMARY KEY (id, fkEmpresa)
);

CREATE TABLE usuario(
	
);

-- Criando a tabela 'sensor'
CREATE TABLE sensor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45),
    tipo_leitura VARCHAR(45),
    num_serie VARCHAR(30),
	responsavel VARCHAR(50) NOT NULL,
    fk_setor INT,
    CONSTRAINT fk_setor_empresa FOREIGN KEY (fk_setor)
		REFERENCES setor(id),
	fk_empresa_setor INT,
    CONSTRAINT fk_empresa_sensor FOREIGN KEY (fk_empresa_setor)
		REFERENCES setor(fk_empresa)
);

-- Criando tabela 'dado_sensor' que é dependente da tabela 'sensor'
CREATE TABLE dado_sensor (
        id INT AUTO_INCREMENT,
        fkSensor INT,
        temperatura DECIMAL(4,2) NOT NULL,
        dt_hora DATETIME NOT NULL,
        CONSTRAINT pkComposta PRIMARY KEY (id, fkSensor),
        CONSTRAINT fkDadoSensor FOREIGN KEY (fkSensor)
			REFERENCES sensor(id)
);

-- Inserindo representantes das empresas
INSERT INTO funcionario_empresa (nome, cargo, email, senha) VALUES
('João Manoel Anderson da Mata', 'Representante', 'joao_manoel_damata@mindesign.com.br', 'ojBKH2BhOg'),
('Miguel Francisco Martins', 'Representante', 'miguel_martins@yogoothies.com.br', 'howaw54QZG'),
('Yago Bento Santos', 'Representante', 'yagoyagosantos@zaniniengenharia.com.br', '7ws3PAgmep'),
('Letícia Emilly Esther Moreira', 'Representante', 'leticia_moreira@acritica.com.br', 'up9cqZLi1G'),
('Priscila Ayla Jennifer Monteiro', 'Representante', 'priscila_ayla_monteiro@htmail.com', 'eCzBPJgwEE');

SELECT * FROM funcionario_empresa;

-- Inserindo empresas clientes
INSERT INTO empresa_cliente (nome, cnpj, email, telefone, cep, uf, cidade, logradouro, numero, fkRepresentante) VALUES 
('Larissa e Carolina Chiken Ltda', '12.345.678/0001-99', 'empresa1@larissaecarolina.com.br', '11987654321', '12345-678', 'SP', 'São Paulo', 'Rua das Flores', '123', 1),
('Levi e Arthur aviário Ltda', '98.765.432/0001-88', 'empresa2@leviearthur.com.br', '21998765432', '23456-789', 'RJ', 'Rio de Janeiro', 'Avenida Brasil', '456', 2),
('Granja Luiz e Giovanni Ltda', '11.223.344/0001-77', 'empresa3@luizegiovanni.com.br', '31987654321', '34567-890', 'MG', 'Belo Horizonte', 'Rua da Paz', '789', 3),
('Aviário João e Lucas Ltda', '22.334.455/0001-66', 'empresa4@joaolucas.com.br', '41999876543', '45678-901', 'PR', 'Curitiba', 'Rua das Américas', '321', 4),
('Granja Julia e Gustavo Ltda', '33.445.566/0001-55', 'empresa5@juliagustavo.com.br', '51988765432', '56789-012', 'RS', 'Porto Alegre', 'Avenida dos Estados', '654', 5);

-- Inserindo monitores
INSERT INTO funcionario_empresa (nome, cargo, email, senha, fkEmpresa) VALUES
('Teresinha Stella Nina Rocha', 'Monitor', 'teresinhastellarocha@fileno.com.br', 'u28If4tXn3', 1),
('Alice Rosa Santos', 'Monitor', 'alice_rosa_santos@iaru.com.br', 'howaw54QZG', 2),
('Henrique Alexandre Ramos', 'Monitor', 'bento-ramos94@spires.com.br', 'nfnEAhzFZc', 3),
('Edson Felipe Porto', 'Monitor', 'edson-porto76@ynail.com.br', 'h8Q5QCATC0', 4);

-- Inserindo supervisores
INSERT INTO funcionario_empresa (nome, cargo, email, senha, fkEmpresa) VALUES
('Carlos Eduardo Almeida', 'Supervisor', 'carlos_almeida@larissacarolina.com.br', 'sup1234', 1),
('Mariana Silva Costa', 'Supervisor', 'mariana_costa@leviearthur.com.br', 'sup5678', 2),
('Ricardo Henrique Gomes', 'Supervisor', 'ricardo_gomes@luizegiovanni.com.br', 'sup91011', 3),
('Fernanda Beatriz Lima', 'Supervisor', 'fernanda_lima@joaolucas.com.br', 'sup1213', 4),
('Thiago Rafael Souza', 'Supervisor', 'thiago_souza@juliagustavo.com.br', 'sup1415', 5);

-- Definindo os as empresas dos representantes
UPDATE funcionario_empresa SET fkEmpresa = 1 WHERE nome = 'João Manoel Anderson da Mata';
UPDATE funcionario_empresa SET fkEmpresa = 2 WHERE nome = 'Miguel Francisco Martins';
UPDATE funcionario_empresa SET fkEmpresa = 3 WHERE nome = 'Yago Bento Santos';
UPDATE funcionario_empresa SET fkEmpresa = 4 WHERE nome = 'Letícia Emilly Esther Moreira';
UPDATE funcionario_empresa SET fkEmpresa = 5 WHERE nome = 'Priscila Ayla Jennifer Monteiro';

-- Definindo os supervisores dos representantes
UPDATE funcionario_empresa SET fkSupervisor = 10 WHERE id = 1;
UPDATE funcionario_empresa SET fkSupervisor = 11 WHERE id = 2;
UPDATE funcionario_empresa SET fkSupervisor = 12 WHERE id = 3;
UPDATE funcionario_empresa SET fkSupervisor = 13 WHERE id = 4;
UPDATE funcionario_empresa SET fkSupervisor = 14 WHERE id = 5;

-- Inserindo sensores 
INSERT INTO sensor (modelo, tipo_leitura, num_serie, responsavel, fkEmpSensor) VALUES
('ST-100', 'Temperatura', 'SN001', 'Teresinha Stella Nina Rocha', 1),
('ST-100', 'Temperatura', 'SN002', 'Alice Rosa Santos', 2),
('ST-100', 'Temperatura', 'SN003', 'Henrique Alexandre Ramos', 3),
('ST-100', 'Temperatura', 'SN004', 'Edson Felipe Porto', 4),
('ST-100', 'Temperatura', 'TMP-001-A', 'João Manoel Anderson da Mata', 1),
('ST-100', 'Temperatura', 'TMP-002-B', 'Miguel Francisco Martins', 2),
('ST-100', 'Temperatura', 'TMP-004-D', 'Letícia Emilly Esther Moreira', 4);

SELECT * from sensor;

INSERT INTO dado_sensor (fkSensor, temperatura, dt_hora, setor) VALUES
(1, 25.4, '2025-04-07 08:00:00', 'Setor Norte'),
(1, 26.1, '2025-04-07 12:30:00', 'Setor Norte'),
(2, 24.9, '2025-04-07 08:15:00', 'Estufa A'),
(2, 25.6, '2025-04-07 13:00:00', 'Estufa A'),
(3, 27.2, '2025-04-07 09:00:00', 'Galpão Central'),
(3, 28.0, '2025-04-07 14:00:00', 'Galpão Central'),
(4, 26.3, '2025-04-07 10:00:00', 'Setor Sul'),
(4, 26.9, '2025-04-07 15:00:00', 'Setor Sul'),
(5, 25.7, '2025-04-07 07:45:00', 'Lote 01'),
(5, 26.4, '2025-04-07 13:45:00', 'Lote 01'),
(6, 23.8, '2025-04-07 08:30:00', 'Galpão Leste'),
(6, 24.5, '2025-04-07 14:30:00', 'Galpão Leste'),
(7, 22.9, '2025-04-07 09:15:00', 'Estufa 3'),
(7, 23.6, '2025-04-07 15:15:00', 'Estufa 3');

SELECT 
       e.nome as 'Nome da Empresa', 
       e.cnpj as 'CNPJ da Empresa', 
       e.email as 'Email da Empresa', 
       e.telefone as 'Telefone da Empresa', 
       e.cep as 'Cep da Empresa', 
       CONCAT(e.logradouro, ', ', e.numero, ', ', e.cidade, ', ', e.uf) as Endereço,
       IFNULL(e.complemento, 'Sem complemento') as Complemento
       FROM empresa_cliente as e;

SELECT 
       f.nome as 'Nome do Funcionário', 
       f.cargo as 'Cargo do Funcionário',
       IFNULL(s.nome, 'S/ supervisor') as Supervisor,
       e.nome as Empresa,
       CONCAT(e.email, ' - ', e.telefone) as Contatos
       FROM funcionario_empresa as f JOIN empresa_cliente as e
			ON f.fkEmpresa = e.id
	   LEFT JOIN funcionario_empresa as s
			ON f.fkSupervisor = s.id ORDER BY e.nome asc;
 
SELECT 
		e.nome as 'Empresa',
        ds.temperatura as 'Temperatura',  
        date_format(ds.dt_hora, '%d/%m/%Y - %h:%m') as 'Data & Hora', 
        ds.setor as 'Setor do Sensor',
        CONCAT(s.modelo, ' - ', s.num_serie) as Sensor
        FROM dado_sensor as ds RIGHT JOIN sensor as s
			ON fkSensor = s.id
		RIGHT JOIN empresa_cliente as e
			ON fkEmpSensor = e.id;

SELECT
	s.modelo as modelo,
    s.tipo_leitura as 'Tipo de leitura',
    s.num_serie as 'Número de série',
    s.responsavel as Responsável,
    e.nome as Empresa
    FROM sensor as s 
    JOIN empresa_cliente as e
		ON e.id = fkEmpSensor;

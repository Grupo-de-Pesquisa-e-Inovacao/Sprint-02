CREATE DATABASE avitrack;

USE avitrack;

CREATE TABLE pessoa_juridica (
	id INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(70) NOT NULL,
    email_comercial VARCHAR(60) NOT NULL,
    senha VARCHAR(30) NOT NULL,
    telefone_comercial CHAR(11) NOT NULL,
    cnpj CHAR(14) NOT NULL
);

CREATE TABLE login(
	id INT PRIMARY KEY AUTO_INCREMENT,
	usuario VARCHAR(45),
    senha VARCHAR(30),
    fk_pessoa_juridica INT,
    CONSTRAINT fkPessoaJuridica FOREIGN KEY (fk_pessoa_juridica)
		REFERENCES pessoa_juridica(id)
);

CREATE TABLE aviario (
	id INT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
    qtd_frangos INT NOT NULL,
    qtd_frangos_mortos INT NOT NULL,
    cep CHAR(15) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(6) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    uf CHAR(2) NOT NULL,
    complemento VARCHAR(50),
    fk_login INT,
    CONSTRAINT fkLogin FOREIGN KEY (fk_login)
		REFERENCES login(id)
);

CREATE TABLE setor(
	id INT,
	nome VARCHAR(45),
    fk_aviario INT,
    CONSTRAINT fkAviario FOREIGN KEY (fk_aviario)
		REFERENCES aviario(id),
	CONSTRAINT pkComposta PRIMARY KEY (id, fk_aviario)
);

CREATE TABLE sensor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45),
    tipo_leitura VARCHAR(45),
    num_serie VARCHAR(30),
    fk_setor INT,
    CONSTRAINT fkSetor FOREIGN KEY (fk_setor)
		REFERENCES setor(id),
	fk_setor_aviario INT,
    CONSTRAINT fkSetorAviario FOREIGN KEY (fk_setor_aviario)
		REFERENCES setor(fk_aviario)
);

CREATE TABLE dado_sensor (
	id INT AUTO_INCREMENT,
    temperatura DECIMAL(4,2),
    dt_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_sensor INT,
    CONSTRAINT fkSensor FOREIGN KEY (fk_sensor)
		REFERENCES sensor(id),
    CONSTRAINT pkCompostaDadoSensor PRIMARY KEY (id, fk_sensor)
);

-- Inserindo em pessoa_juridica
INSERT INTO pessoa_juridica (razao_social, email_comercial, senha, telefone_comercial, cnpj)
VALUES 
('Granja Bom Frango', 'contato@bomfrango.com.br', 'senha123', '11987654321', '12345678000199'),
('Aviários Vale Verde', 'suporte@valeverde.com.br', 'vale2024', '1133445566', '98765432000188'),
('Frango Feliz LTDA', 'comercial@frangofeliz.com', 'feliz2025', '1199887766', '45612378000166');

-- Inserindo em login (associado às pessoas jurídicas)
INSERT INTO login (usuario, senha, fk_pessoa_juridica)
VALUES 
('bomfrango_admin', 'senha123', 1),
('valeverde_user', 'vale2024', 2),
('frangofeliz_root', 'feliz2025', 3);

-- Inserindo em aviario (cada um vinculado a um login)
INSERT INTO aviario (id, nome, qtd_frangos, qtd_frangos_mortos, cep, logradouro, numero, cidade, uf, complemento, fk_login)
VALUES 
(1, 'Aviário Central', 1000, 12, '12345678', 'Estrada da Granja', '150', 'São Paulo', 'SP', 'Próximo ao silo', 1),
(2, 'Unidade Vale Norte', 800, 5, '87654321', 'Rodovia Verde', '300', 'Campinas', 'SP', 'Km 25', 2),
(3, 'Polo Feliz Oeste', 1200, 20, '11223344', 'Av. das Aves', '789', 'Ribeirão Preto', 'SP', NULL, 3);

-- Setores para Aviário 1
INSERT INTO setor (id, nome, fk_aviario)
VALUES 
(1, 'Setor A1', 1),
(2, 'Setor A2', 1),
(3, 'Setor A3', 1),

-- Setores para Aviário 2
(1, 'Setor B1', 2),
(2, 'Setor B2', 2),
(3, 'Setor B3', 2),

-- Setores para Aviário 3
(1, 'Setor C1', 3),
(2, 'Setor C2', 3),
(3, 'Setor C3', 3);

INSERT INTO sensor (modelo, tipo_leitura, num_serie, fk_setor, fk_setor_aviario)
VALUES 
-- Aviário 1
('LM35', 'Temperatura', 'LM35-A1-001', 1, 1),
('LM35', 'Temperatura', 'LM35-A2-002', 2, 1),
('LM35', 'Temperatura', 'LM35-A3-003', 3, 1),

-- Aviário 2
('LM35', 'Temperatura', 'LM35-B1-004', 1, 2),
('LM35', 'Temperatura', 'LM35-B2-005', 2, 2),
('LM35', 'Temperatura', 'LM35-B3-006', 3, 2),

-- Aviário 3
('LM35', 'Temperatura', 'LM35-C1-007', 1, 3),
('LM35', 'Temperatura', 'LM35-C2-008', 2, 3),
('LM35', 'Temperatura', 'LM35-C3-009', 3, 3);

INSERT INTO dado_sensor (temperatura, dt_hora, fk_sensor) VALUES
(28.5, '2025-04-22 08:00:00', 1),
(29.1, '2025-04-22 08:05:00', 2),
(27.8, '2025-04-22 08:10:00', 3),
(30.2, '2025-04-22 08:15:00', 4),
(28.9, '2025-04-22 08:20:00', 5),
(29.5, '2025-04-22 08:25:00', 6),
(26.7, '2025-04-22 08:30:00', 7),
(27.2, '2025-04-22 08:35:00', 8),
(28.0, '2025-04-22 08:40:00', 9);


SELECT * FROM pessoa_juridica;

SELECT * FROM login;

SELECT * FROM aviario;

SELECT * FROM setor;

SELECT * FROM sensor;

SELECT * FROM dado_sensor;

SELECT a.nome AS Aviário,
	a.qtd_frangos AS 'Quantidade de Frangos',
    a.cep AS CEP,
    CONCAT(a.logradouro, ' ', a.numero, ' ', a.cidade, ' ', a.uf) AS Endereço,
    IFNULL(a.complemento, 'Sem complemento') as Complemento,
    l.usuario AS 'Usuário dono'
    FROM aviario AS a 
	JOIN login AS l 
		ON a.fk_login = l.id;

SELECT pj.razao_social as 'Razão Social',
	CONCAT(pj.email_comercial, ' - ', pj.telefone_comercial) as Contatos,
    pj.cnpj as CNPJ,
    l.usuario as Usuário,
    l.senha as Senha
    FROM pessoa_juridica as pj
    JOIN login as l
		ON l.fk_pessoa_juridica = pj.id;

SELECT sensor.modelo as Modelo,
	sensor.tipo_leitura as 'Tipo de leitura',
    sensor.num_serie 'Número de série',
    CONCAT(aviario.nome, ' - ', setor.nome) as 'Aviário & Setor'
    FROM sensor
    JOIN setor
		ON sensor.fk_setor = setor.id
	JOIN aviario
		ON sensor.fk_setor_aviario = aviario.id;
        
SELECT ds.temperatura as Temperatura,
	date_format(ds.dt_hora, '%d-%m-%y / %h:%m') as 'Data & Hora',
    sensor.modelo as 'Modelo do sensor',
    sensor.num_serie as 'Número de série',
    CONCAT(aviario.nome, ' - ', setor.nome) as 'Aviário & Setor'
    FROM dado_sensor as ds
    JOIN sensor
		ON ds.fk_sensor = sensor.id
	JOIN setor
		ON sensor.fk_setor = setor.id
	JOIN aviario
		ON setor.fk_aviario = aviario.id
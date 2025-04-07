-- GRUPO 11 - AviTrack
-- Kauan Luna
-- Nicolly Cristine
-- André Boer
-- Eduardo Gomes
-- Daniel Guimarães

CREATE DATABASE avitrack;

USE avitrack;

CREATE TABLE funcionario_empresa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
	cargo VARCHAR(30) NOT NULL,
    email VARCHAR(70) NOT NULL UNIQUE,
    senha VARCHAR(30) NOT NULL,
    fkEmpresa INT,
	fkSupervisor INT,
    CONSTRAINT fkFuncSupervisor FOREIGN KEY (fkSupervisor) 
		REFERENCES funcionario_empresa(id)
);

ALTER TABLE funcionario_empresa ADD CONSTRAINT fkFuncionarioEmpresa FOREIGN KEY (fkEmpresa)
		REFERENCES empresa_cliente(id);

CREATE TABLE empresa_cliente (
		id INT PRIMARY KEY AUTO_INCREMENT,
        nome VARCHAR(50) NOT NULL,
		cnpj VARCHAR(18) NOT NULL UNIQUE,
        email VARCHAR(50) NOT NULL UNIQUE,
        telefone CHAR(11) NOT NULL,
        cep VARCHAR(15) NOT NULL,
        uf CHAR(2) NOT NULL,
        cidade VARCHAR(40) NOT NULL,
        logradouro VARCHAR(100) NOT NULL,
        numero VARCHAR(6) NOT NULL,
        complemento VARCHAR(50),
        fkRepresentante INT, 
        CONSTRAINT fkEmpresaRepresentante FOREIGN KEY (fkRepresentante)
			REFERENCES funcionario_empresa(id)
		
);

CREATE TABLE sensor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45),
    tipo_leitura VARCHAR(45),
    num_serie VARCHAR(30),
	responsavel VARCHAR(50) NOT NULL,
    fkEmpSensor INT,
    CONSTRAINT fkEmpresaSensor FOREIGN KEY (fkEmpSensor)
		REFERENCES empresa_cliente(id)
);
 
CREATE TABLE dado_sensor (
        id INT AUTO_INCREMENT,
        fkSensor INT,
        temperatura DECIMAL(4,2) NOT NULL,
        dt_hora DATETIME NOT NULL,
        setor VARCHAR(100) NOT NULL,
        CONSTRAINT pkComposta PRIMARY KEY (id, fkSensor),
        CONSTRAINT fkDadoSensor FOREIGN KEY (fkSensor)
			REFERENCES sensor(id)
);

INSERT INTO funcionario_empresa (nome, cargo, email, senha)
VALUES
('João Manoel Anderson da Mata', 'Representante', 'joao_manoel_damata@mindesign.com.br', 'ojBKH2BhOg'),
('Teresinha Stella Nina Rocha', 'Monitor', 'teresinhastellarocha@fileno.com.br', 'u28If4tXn3'),
('Miguel Francisco Martins', 'Representante', 'miguel_martins@yogoothies.com.br', 'howaw54QZG'),
('Alice Rosa Santos', 'Monitor', 'alice_rosa_santos@iaru.com.br', 'howaw54QZG'),
('Yago Bento Santos', 'Representante', 'yagoyagosantos@zaniniengenharia.com.br', '7ws3PAgmep'),
('Clarice Rosângela da Cruz', 'Monitor', 'claricerosangeladacruz@oi15.com.br', 'RawyI8nFzs'),
('Letícia Emilly Esther Moreira', 'Representante', 'leticia_moreira@acritica.com.br', 'up9cqZLi1G'),
('Bento Henrique Alexandre Ramos', 'Monitor', 'bento-ramos94@spires.com.br', 'nfnEAhzFZc'),
('Priscila Ayla Jennifer Monteiro', 'Representante', 'priscila_ayla_monteiro@htmail.com', 'eCzBPJgwEE'),
('Edson Felipe Porto', 'Monitor', 'edson-porto76@ynail.com.br', 'h8Q5QCATC0');

-- Inserindo supervisores (um para cada empresa)
INSERT INTO funcionario_empresa (nome, cargo, email, senha, fkEmpresa)
VALUES
('Carlos Eduardo Almeida', 'Supervisor', 'carlos_almeida@larissacarolina.com.br', 'sup1234', 1),
('Mariana Silva Costa', 'Supervisor', 'mariana_costa@leviearthur.com.br', 'sup5678', 2),
('Ricardo Henrique Gomes', 'Supervisor', 'ricardo_gomes@luizegiovanni.com.br', 'sup91011', 3),
('Fernanda Beatriz Lima', 'Supervisor', 'fernanda_lima@joaolucas.com.br', 'sup1213', 4),
('Thiago Rafael Souza', 'Supervisor', 'thiago_souza@juliagustavo.com.br', 'sup1415', 5);

-- Atualizando os representantes para terem um supervisor
UPDATE funcionario_empresa SET fkSupervisor = 21 WHERE id = 1;
UPDATE funcionario_empresa SET fkSupervisor = 22 WHERE id = 3;
UPDATE funcionario_empresa SET fkSupervisor = 23 WHERE id = 5;
UPDATE funcionario_empresa SET fkSupervisor = 24 WHERE id = 7;
UPDATE funcionario_empresa SET fkSupervisor = 25 WHERE id = 9;

-- Inserindo empresas com fkRepresentante (vamos supor que os IDs dos representantes são 1, 3, 5, 7, 9)
INSERT INTO empresa_cliente (nome, cnpj, email, telefone, cep, uf, cidade, logradouro, numero, fkRepresentante)
VALUES 
('Larissa e Carolina Chiken Ltda', '12.345.678/0001-99', 'atendimento@larissaecarolinachikenltda.com.br', '11987654321', '12345-678', 'SP', 'São Paulo', 'Rua das Flores', '123', 1),
('Levi e Arthur aviário Ltda', '98.765.432/0001-88', 'comunicacoes@leviearthuraviariotda.com.br', '21998765432', '23456-789', 'RJ', 'Rio de Janeiro', 'Avenida Brasil', '456', 3),
('Granja Luiz e Giovanni Ltda', '11.223.344/0001-77', 'sac@luizegiovannigranjaltda.com.br', '31987654321', '34567-890', 'MG', 'Belo Horizonte', 'Rua da Paz', '789', 5),
('Aviário João e Lucas Ltda', '22.334.455/0001-66', 'financeiro@joaoelucasaviarioltda.com.br', '41999876543', '45678-901', 'PR', 'Curitiba', 'Rua das Américas', '321', 7),
('Granja Julia e Gustavo Ltda', '33.445.566/0001-55', 'diretoria@juliaegustavogranjaltda.com.br', '51988765432', '56789-012', 'RS', 'Porto Alegre', 'Avenida dos Estados', '654', 9);

-- Atualizar os funcionários com suas empresas agora que elas existem
UPDATE funcionario_empresa SET fkEmpresa = 1 WHERE id IN (1, 6);
UPDATE funcionario_empresa SET fkEmpresa = 2 WHERE id IN (2, 7);
UPDATE funcionario_empresa SET fkEmpresa = 3 WHERE id IN (3, 8);
UPDATE funcionario_empresa SET fkEmpresa = 4 WHERE id IN (4, 9);
UPDATE funcionario_empresa SET fkEmpresa = 5 WHERE id IN (5, 10); 

-- Inserindo sensores
INSERT INTO sensor (modelo, tipo_leitura, num_serie, responsavel, fkEmpSensor)
VALUES
('ST-100', 'Temperatura', 'SN001', 'Teresinha Stella Nina Rocha', 1),
('ST-100', 'Temperatura', 'SN002', 'Alice Rosa Santos', 2),
('ST-100', 'Temperatura', 'SN003', 'Henrique Alexandre Ramos', 3),
('ST-100', 'Temperatura', 'SN004', 'Edson Felipe Porto', 4);

-- Inserindo dados dos sensores (IDs 1 a 4)
INSERT INTO dado_sensor (fkSensor, temperatura, dt_hora, setor)
VALUES
(1, 16.10, '2023-12-31 14:30:00', "Sul"),
(2, 19.10, '2023-12-31 15:30:00', "Leste"),
(3, 18.10, '2023-12-31 16:30:00', "Oeste"),
(4, 20.10, '2023-12-31 17:30:00', "Norte");

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
       f.email as 'Email do Funcionário',
       f.senha as 'Senha do Funcionário',
       s.nome as Supervisor,
       e.nome as Empresa,
       CONCAT(e.email, ' - ', e.telefone) as Contatos
       FROM funcionario_empresa as f JOIN empresa_cliente as e
			ON f.fkEmpresa = e.id
	   JOIN funcionario_empresa as s
			ON f.fkSupervisor = s.id;
 
SELECT 
        ds.temperatura as 'Temperatura',  
        date_format(ds.dt_hora, '%d/%m/%Y - %h:%m') as 'Data & Hora', 
        ds.setor as 'Setor do Sensor',
        CONCAT(s.modelo, ' - ', s.num_serie) as Sensor,
        es.nome as 'Empresa'
        FROM dado_sensor as ds JOIN sensor as s
			ON fkSensor = s.id
		JOIN empresa_cliente as es
			ON fkEmpSensor = es.id;

SELECT 
		f.id as id,
        f.nome as Funcionario,
        f.cargo as Cargo,
        e.nome as Empresa
		FROM funcionario_empresa as f JOIN empresa_cliente as e
			ON e.id = f.fkEmpresa;
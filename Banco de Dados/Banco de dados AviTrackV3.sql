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
    qtd_frango_mortos INT,
    cep CHAR(15) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(6) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    uf CHAR(2) NOT NULL,
    complemento_endereco VARCHAR(50),
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
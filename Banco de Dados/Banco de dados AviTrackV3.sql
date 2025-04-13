CREATE DATABASE avitrack;

USE avitrack;

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email_comercial VARCHAR(60) NOT NULL,
    senha VARCHAR(30) NOT NULL,
    telefone_comercial CHAR(11) NOT NULL,
    cpf CHAR(11) NOT NULL,
    cnpj CHAR(14)
);

CREATE TABLE endereco (
	id INT AUTO_INCREMENT,
    cep CHAR(15) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(6) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    uf CHAR(2) NOT NULL,
    complemento VARCHAR(50),
    fk_usuario INT,
    CONSTRAINT fkUsuario FOREIGN KEY (fk_usuario) 
		REFERENCES usuario(id),
    CONSTRAINT pkCompostaEndereco PRIMARY KEY (id, fk_usuario)
);

CREATE TABLE aviario (
	id INT,
    nome VARCHAR(45),
    capacidade_maxima INT,
    capacidade_atual INT,
    fk_endereco INT,
    CONSTRAINT fkEndereco FOREIGN KEY (fk_endereco) 
		REFERENCES endereco(id),
    fk_endereco_usuario INT,
    CONSTRAINT fkEnderecoUsuario FOREIGN KEY (fk_endereco_usuario) 
		REFERENCES endereco(fk_usuario),
	CONSTRAINT pkCompostaAviario PRIMARY KEY (id, fk_endereco, fk_endereco_usuario)
);

CREATE TABLE franganada (
	id INT PRIMARY KEY,
    qtd_frangos INT,
    qtd_frango_mortos INT
);

CREATE TABLE setor(
	id INT,
	nome VARCHAR(45),
    area FLOAT,
    fk_aviario INT,
    CONSTRAINT fkAviario FOREIGN KEY (fk_aviario)
		REFERENCES aviario(id),
	fk_aviario_endereco INT,
    CONSTRAINT fkAviarioEndereco FOREIGN KEY (fk_aviario_endereco)
		REFERENCES aviario(fk_endereco),
    fk_aviario_endereco_usuario INT,
    CONSTRAINT fkAviarioEnderecoUsuario FOREIGN KEY (fk_aviario_endereco_usuario)
		REFERENCES aviario(fk_endereco_usuario),
    fk_franganada INT,
    CONSTRAINT fkFranganada FOREIGN KEY (fk_franganada)
		REFERENCES franganada(id),
	CONSTRAINT pkCompostaSetor PRIMARY KEY (id, fk_aviario, fk_aviario_endereco, fk_aviario_endereco_usuario, fk_franganada)
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
		REFERENCES setor(fk_aviario),
	fk_setor_aviario_endereco INT,
    CONSTRAINT fkSetorAviarioEndereco FOREIGN KEY (fk_setor_aviario_endereco)
		REFERENCES setor(fk_aviario_endereco),
	fk_setor_aviario_endereco_usuario INT,
    CONSTRAINT fkSetorAviarioEnderecoUsuario FOREIGN KEY (fk_setor_aviario_endereco_usuario)
		REFERENCES setor(fk_aviario_endereco_usuario),
	fk_setor_franganada INT,
    CONSTRAINT fkSetorFranganada FOREIGN KEY (fk_setor_franganada)
		REFERENCES setor(fk_franganada)
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
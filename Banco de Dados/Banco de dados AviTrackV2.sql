
USE avitrack ;

CREATE TABLE usuario (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  email_comercial VARCHAR(70) NOT NULL,
  senha VARCHAR(30) NOT NULL,
  telefone_comercial VARCHAR(45) NOT NULL,
  cpf CHAR(11) NOT NULL,
  cnpj CHAR(14) NULL
);

CREATE TABLE endereco (
  id INT NOT NULL,
  fk_usuario INT NOT NULL,
  cep CHAR(15) NOT NULL,
  logradouro VARCHAR(100) NOT NULL,
  numero VARCHAR(6) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  uf CHAR(2) NOT NULL,
  complemento VARCHAR(50) NULL,
  PRIMARY KEY (id, fk_usuario)
);

CREATE TABLE setor (
  id INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  area FLOAT NOT NULL,
  fk_endereco INT NOT NULL,
  fk_usuario_endereco INT NOT NULL,
  CONSTRAINT PRIMARY KEY (id, fk_endereco, fk_usuario_endereco)
);

CREATE TABLE sensor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  modelo VARCHAR(45) NOT NULL,
  tipo_leitura VARCHAR(45) NOT NULL,
  num_serie VARCHAR(30) NOT NULL,
  fk_setor INT NOT NULL,
  fk_endereco_setor INT NOT NULL,
  fk_usuario_endereco_setor INT NOT NULL
);

CREATE TABLE dado_sensor (
  id INT NOT NULL AUTO_INCREMENT,
  fk_sensor INT NOT NULL,
  temperatura DECIMAL(4,2) NOT NULL,
  dt_hora DATETIME NOT NULL,
  CONSTRAINT PRIMARY KEY (id, fk_sensor)
);

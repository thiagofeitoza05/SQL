USE MASTER
GO
DROP DATABASE exerciciocontraints

CREATE DATABASE exerciciocontraints
GO
USE exerciciocontraints
GO
CREATE TABLE editora (
id_editora				INT				NOT NULL	IDENTITY(491,16),
nome					VARCHAR(70)		NOT NULL	UNIQUE,
telefone				VARCHAR(11)		NOT NULL	UNIQUE	CHECK(telefone = 10),
logradouro_endereco		VARCHAR(200)	NOT NULL,
numero_endereco			INT				NOT NULL	CHECK(numero_endereco > 0),
cep_endereco			CHAR(8)			NOT NULL	CHECK(cep_endereco = 8),
complemento_endereco	VARCHAR(255)	NOT NULL
PRIMARY KEY (id_editora)
)
GO
CREATE TABLE edicao (
isbn			CHAR(13)		NOT NULL	CHECK(isbn = 13),
preco			DECIMAL(4,2)	NOT NULL	CHECK(preco > 0),
ano				INT				NOT NULL	CHECK(ano > 1993),
numero_paginas	INT				NOT NULL	CHECK(numero_paginas > 15),
qnt_estoque		INT				NOT NULL
PRIMARY KEY	(isbn)
)
GO
CREATE TABLE autor (
id_autor	INT				NOT NULL	IDENTITY(2351,1),
nome		VARCHAR(100)	NOT NULL	UNIQUE,
data_nasc	DATE			NOT NULL,
pais_nasc	VARCHAR(50)		NOT NULL	CHECK(pais_nasc = 'Brasil' OR pais_nasc = 'Estados Unidos' OR 
													pais_nasc = 'Inglaterra' OR pais_nasc = 'Alemanha'),
biografia	VARCHAR(255)	NOT NULL
PRIMARY KEY (id_autor)
)
GO
CREATE TABLE livroo (
codigo		INT				NOT NULL	IDENTITY(100001,100),		
nome		VARCHAR(200)	NOT NULL,
lingua		VARCHAR(10)		NOT NULL	DEFAULT('PT-BR'),
ano			INT				NOT NULL	CHECK(ano > 1990),
PRIMARY KEY (codigo)
)
GO
CREATE TABLE livroo_autor (
codigo		INT		NOT NULL,
id_aut		INT		NOT NULL
PRIMARY KEY (codigo, id_aut)
FOREIGN KEY (id_aut) REFERENCES autor(id_autor),
FOREIGN KEY (codigo) REFERENCES livroo(codigo)
)
GO
CREATE TABLE editora_edicao_livroo (
codigo		INT			NOT NULL,
isbn		CHAR(13)	NOT NULL,
id_editora	INT			NOT NULL
PRIMARY KEY (codigo, isbn, id_editora)
FOREIGN KEY (codigo) REFERENCES livroo(codigo),
FOREIGN KEY (isbn) REFERENCES edicao(isbn),
FOREIGN KEY (id_editora) REFERENCES editora(id_editora)
)

EXEC sp_help livroo
EXEC sp_help edicao
EXEC sp_help editora
EXEC sp_help livroo_autor
EXEC sp_help editora_edicao_livroo

SELECT * FROM editora
SELECT * FROM livroo
SELECT * FROM edicao
SELECT * FROM livroo_autor
SELECT * FROM editora_edicao_livroo

INSERT INTO livroo (nome, ano) VALUES 
('O pequeno Prinicpe', '1991')
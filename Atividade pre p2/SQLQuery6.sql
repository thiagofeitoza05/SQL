--comentario
/*comentario*/

/*Esquema - DDL:
CREATE (criar)
ALTER (alterar/atualizar)
DROP (descartar/excluir)
*/

/*
n�o confiar muito no tracejado de erro dele pq ele � meio burrinho
ele � multithread, ent�o cada linha aqui vai ser executada ao mesmo tempo
ativar uma database � muito mais rapido do que criar, ent�o ela vai ser executada antes
e vai dar erro :)

Conseguimos usar ordena��o de threads para evitar erros e deadlocks

N�o, ele n�o � sens�vel a CAPS, pode escrever de qualquer jeito

"GO" faz com que o SQL execute cada coisa por vez - "sem�foro"

N�o d� pra criar uma database duas vezes no mesmo servidor; d� erro

Isso aqui � um T-SQL; suas a��es s�o definitivas e irrevers�veis
*/
CREATE DATABASE primeiraaula011024

/* USE <database> define a database atual a rodar */
USE primeiraaula011024

USE master

DROP DATABASE primeiraaula011024
/* mesmo trocando pra master, n�o daria pra excluir essa database ainda
� uma opera��o muito complexa pois exclui todas as tabelas de tudo,
e n�o d� pra desfazer 
*/
--------------------------------------------------------------------------
CREATE DATABASE primeiraaula011024
GO
USE primeiraaula011024
--------------------------------------------------------------------------
--CTRL+R ativa/desativa mensagens de terminal
/*Cria��o de tabela
CREATE TABLE <nome> (
Atributo1	TIPO	NULIDADE,
Atributo2	TIPO	NULIDADE,
...
AtributoN	TIPO	NULIDADE

PRIMARY KEY (Atributo1) ou
PRIMARY KEY (Atributo1, Atributo2, ... AtributoN)

FOREIGN KEY (Atributo4) REFERENCES TabelaX(PK)
FOREIGN KEY (Atributo5) REFERENCES TabelaY(PK)
)
*/
CREATE TABLE produto (
codProduto		INT				NOT NULL,
nomeProduto		VARCHAR(20)		NOT NULL,
valorUnitario	DECIMAL(7,2)	NULL
PRIMARY KEY (codProduto)
)
GO
CREATE TABLE pedido (
idPedido		INT				NOT NULL,
dataPedido		DATE			NOT NULL
PRIMARY KEY (idPedido)
)
GO
CREATE TABLE produto_pedido (
codProd		INT				NOT NULL,
idPed		int				NOT NULL,
qtd				int				NOT NULL,
valorTotal		DECIMAL(7,2)	not null
primary key (codProd, idPed)
FOREIGN KEY (codProd) REFERENCES produto(codProduto),
FOREIGN KEY (idPed) REFERENCES pedido(idPedido)
)
----------------------------------------------
/* Verificar dados das tabelas
EXEC sp_help <nomeTabela> */
EXEC sp_help produto
EXEC sp_help pedido
EXEC sp_help produto_pedido
-----------------------------------------------
/*Modifica��es na estrutura da tabela j� criada
ALTER TABLE

Adicionar coluna descricao VARCHAR(50) na tabela produto

S� d� pra adicionar assim se n�o houverem dados na tabela
Se houverem, a nova coluna precisaria ser NULL
*/
ALTER TABLE produto
ADD descricao		VARCHAR		NOT NULL	

/*Se tivesse esquecido de definir a PK de algo
ALTER TABLE produto
ADD FOREIGN KEY (codProduto)
*/
/*Alterar tipo e nulidade da coluna
ALTER TABLE <nomeTabela>
ALTER COLUMN <nomeColuna>		<novoTipo>(length)		<nulidade>*/
ALTER TABLE produto
ALTER COLUMN descricao	VARCHAR(50)		NOT NULL

/*Descartar coluna
ALTER TABLE <nomeTabela>
DROP COLUMN <nomeColuna>
*/
ALTER TABLE produto
DROP COLUMN descricao
-----------------------------------------------
/*Descartar tabela inteira
DROP TABLE <nomeTabela>
*/
-----------------------------------------------
/*Inst�ncia - DML:
INSERT (Create)
SELECT (Read)
UPDATE (Update)
DELETE (Delete)

Inserindo registros (linhas/tuplas) em uma tabela
INSERT INTO <nomeTabela> (Atr1, Atr2 ... AtrN) VALUES
(Dado1Atr1, Dado1Atr2 ... Dado1AtrN)

Em blocos (Bulk Insert)
INSERT INTO <nomeTabela> (Atr1, Atr2 ... AtrN) VALUES
(Dado1Atr1, Dado1Atr2 ... Dado1AtrN),
(Dado2Atr1, Dado2Atr2 ... Dado2AtrN),
(Dado3Atr1, Dado3Atr2 ... Dado3AtrN),
...
(DadoNAtr1, DadoNAtr2 ... DadoNAtrN)


Erro "dados ou valores bin�rios ser�o truncated - estourou varchar length
*/
INSERT INTO produto (codProduto, nomeProduto, valorUnitario) VALUES
(1, 'melancia', 12.99)

INSERT INTO produto VALUES
(2, 'samba', 1200.99)

INSERT INTO produto (valorUnitario, codProduto, nomeProduto) VALUES
(200.00, 3, 'pagodinho')

INSERT INTO produto VALUES
(4, 'rock n roll', 7930.50),
(5, 'capinha iphone', 25.00),
(6, 'hello world', 0.00)

INSERT INTO produto VALUES
(7, 'tem nd aq n', NULL)

INSERT INTO produto (codProduto, nomeProduto) VALUES
(8, 'la ele')

INSERT INTO pedido VALUES
(1001, /*padrao'2024-10-01'*/ /*na FATEC*/ '01/10/2024'),
(1002, '02/10/2024')

INSERT INTO produto_pedido VALUES
(4, 1001, 10, 79305.00)
INSERT INTO produto_pedido VALUES
(1, 1001, 100, 1209.90)
-------------------------------------------------------
/*consultando todas as linhas e colunas de uma tabela
*/
SELECT * FROM produto
SELECT * FROM produto_pedido
-------------------------------------------------------
/* Atualiza��o de dados de uma tabela 
SET Atributo1 = novoValor, Atributo2 = novoValor

**Desse jeito aqui, ele colocaria novoValor em Atributo1 em TODAS as suas linhas;
precisa ter um filtro: cl�usula WHERE (condi��o(s))
*/
UPDATE pedido
SET dataPedido = '03/10/2024'
--WHERE dataPedido = '02/10/2024'
-- � burro pq podem ter datas iguais 
WHERE idPedido = 1002
--agora sim, pq s� tem UM idPedido = 1002

UPDATE produto_pedido
SET qtd = 4, valorTotal = 150.00
WHERE codProd = 1 and idPed = 1001

UPDATE produto
SET valorUnitario = valorUnitario + 1.00
WHERE codProduto = 1 OR codProduto = 2

UPDATE produto_pedido
SET valorTotal = valorTotal * 0.9
WHERE idPed <1002 --( pode ser =, != ou <>, <, <=, >, >= )

---------------------------------------------------------------
/*Exclus�o de registros/tuplas/linhas de uma tabela
DELETE <nome>
WHERE ( condi��o(s) )

DELETE produto
limpa toda a tabela produto

DELETE produto
WHERE codProduto = 2
nao rola pq o codProduto = 2 est� em uma linha da tabela associativa produto_pedido
*/
DELETE produto
WHERE codProduto = 1

-----------------------------------------------
--Renomear coluna (tabela)
/*EXEC sp_renae 'dbo.<tabela>.<coluna>' , 'novoNome' , 'COLUMN' --para colunas
  EXEC sp_rename 'dbo.<tabela>' , 'novoNome' --para tabelas
*/
ALTER TABLE produto
ADD descricao VARCHAR(50) NULL

select * from produto

EXEC sp_rename 'dbo.produto.desc' , 'descr'

ALTER TABLE produto
DROP COLUMN descr
-----------------------------------------------

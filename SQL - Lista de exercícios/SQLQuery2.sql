USE ex9

--1) Consultar nome, valor unitário, nome da editora e nome do autor dos livros do estoque que foram vendidos. Não podem haver 
--repetições.
SELECT DISTINCT est.nome, est.valor, edi.nome, aut.nome 

FROM estoque est
INNER JOIN autor aut
ON aut.codigo = est.codAutor
INNER JOIN editora edi
ON edi.codigo = est.codEditora
INNER JOIN compra comp
ON comp.codEstoque = est.codigo

--2) Consultar nome do livro, quantidade comprada e valor de compra da compra 15051	

SELECT est.nome, comp.qtdComprada, comp.valor
FROM estoque est
INNER JOIN compra comp
ON comp.codEstoque = est.codigo
WHERE comp.codigo = 15051

--3) Consultar Nome do livro e site da editora dos livros da Makron books (Caso o site tenha mais de 10 dígitos, remover o www.).

SELECT est.nome, 
CASE 
	WHEN LEN(edi.site) > 10
		THEN SUBSTRING(edi.site, 5, 40)
	END AS site
FROM estoque est
INNER JOIN editora edi
ON edi.codigo = est.codEditora
WHERE edi.nome = 'Makron books'

--4) Consultar nome do livro e Breve Biografia do David Halliday	

SELECT est.nome, aut.biografia
FROM estoque est
INNER JOIN autor aut
ON aut.codigo = est.codAutor
WHERE aut.nome = 'David Halliday'

-- 5) Consultar código de compra e quantidade comprada do livro Sistemas Operacionais Modernos

SELECT comp.codigo, comp.qtdComprada
FROM compra comp
INNER JOIN estoque est
ON est.codigo = comp.codEstoque
WHERE est.nome = 'Sistemas Operacionais Modernos'

--6) Consultar quais livros não foram vendidos	

SELECT est.nome
FROM estoque est 
LEFT OUTER JOIN compra comp
ON comp.codEstoque = est.codigo
WHERE comp.codestoque IS NULL

--7) Consultar quais livros foram vendidos e não estão cadastrados. 
--Caso o nome dos livros terminem com espaço, fazer o trim apropriado.	

SELECT RTRIM(est.nome) AS nome
FROM compra comp
LEFT OUTER JOIN estoque est
ON comp.codEstoque = est.codigo
WHERE est.codigo IS NULL

--8) Consultar Nome e site da editora que não tem Livros no estoque (Caso o site tenha mais de 10 dígitos, remover o www.)

SELECT edi.nome, SUBSTRING(edi.site, 5, 40) AS site
FROM editora edi
LEFT OUTER JOIN estoque est
ON edi.codigo = est.codEditora
WHERE est.codEditora IS NULL

--9) Consultar Nome e biografia do autor que não tem Livros no estoque 
--(Caso a biografia inicie com Doutorado, substituir por Ph.D.)	

SELECT aut.nome, aut.biografia
FROM autor aut
LEFT OUTER JOIN estoque est
ON aut.codigo = est.codAutor
WHERE est.codAutor IS NULL

--10) Consultar o nome do Autor, e o maior valor de Livro no estoque. Ordenar por valor descendente

SELECT aut.nome, est.valor
FROM autor aut
INNER JOIN estoque est
ON aut.codigo = est.codAutor
WHERE est.valor in (
	SELECT MAX(est.valor)
	FROM estoque est 
	GROUP BY est.codAutor
	)

--11) Consultar o código da compra, o total de livros comprados e a soma dos valores gastos. 
--Ordenar por Código da Compra ascendente.

SELECT comp.codigo, SUM(comp.qtdComprada) AS qtdComprada, SUM(comp.valor) AS valor
FROM compra comp
GROUP BY comp.codigo
ORDER BY comp.codigo ASC

--12) Consultar o nome da editora e a média de preços dos livros em estoque.Ordenar pela Média de Valores ascendente.

SELECT edi.nome, AVG(est.valor) AS media_valor
FROM estoque est
INNER JOIN editora edi
ON edi.codigo = est.codEditora
GROUP BY edi.nome
ORDER BY media_valor ASC

--13) Consultar o nome do Livro, a quantidade em estoque o nome da editora, o site da editora (Caso o site tenha mais de 
--10 dígitos, remover o www.), criar uma coluna status onde:	
--	Caso tenha menos de 5 livros em estoque, escrever Produto em Ponto de Pedido
--	Caso tenha entre 5 e 10 livros em estoque, escrever Produto Acabando
--	Caso tenha mais de 10 livros em estoque, escrever Estoque Suficiente
--	A Ordenação deve ser por Quantidade ascendente

SELECT est.nome, est.quantidade, edi.nome, 
CASE
	WHEN LEN(edi.site) > 10
		THEN SUBSTRING(edi.site, 5, 40)
		END AS site,
CASE 
	WHEN est.quantidade < 5
		THEN 'Produto em Ponto de Pedido'
	WHEN est.quantidade <= 10
		THEN 'Produto Acabando'
	WHEN est.quantidade > 10
		THEN 'Estoque Suficiente'
	END AS status
FROM estoque est
INNER JOIN editora edi
ON edi.codigo = est.codEditora
ORDER BY est.quantidade ASC
		
--14) Para montar um relatório, é necessário montar uma consulta com a seguinte saída: Código do Livro, Nome do Livro, Nome do 
--Autor, Info Editora (Nome da Editora + Site) de todos os livros	
--	Só pode concatenar sites que não são nulos

SELECT est.codigo, aut.nome, 
CASE 
	WHEN edi.site IS NOT NULL
		THEN edi.nome + ', ' + edi.site
	WHEN edi.site IS NULL
		THEN edi.nome
	END AS concate
FROM estoque est
INNER JOIN autor aut
ON aut.codigo = est.codAutor
INNER JOIN editora edi
ON est.codEditora = edi.codigo

--15) Consultar Codigo da compra, quantos dias da compra até hoje e quantos meses da compra até hoje

SELECT comp.codigo, DATEDIFF(DAY, comp.dataCompra, GETDATE()) AS em_dias,
		DATEDIFF(MONTH, comp.dataCompra, GETDATE()) AS em_meses
FROM compra comp

--16) Consultar o código da compra e a soma dos valores gastos das compras que somam mais de 200.00	

SELECT comp.codigo, 
CASE 
	WHEN SUM(comp.valor) > 200
		THEN SUM(comp.valor)
	END AS soma
FROM compra comp
GROUP BY comp.codigo
HAVING SUM(comp.valor) > 200
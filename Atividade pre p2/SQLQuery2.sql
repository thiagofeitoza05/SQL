USE ex05

--1. Consultar a quantidade, valor total e valor total com desconto (25%) dos itens comprados par Maria Clara.
SELECT ped.quantidade, prod.valor_unitario * ped.quantidade AS valor_total,
			CAST(((prod.valor_unitario * ped.quantidade) * 0.75) AS DECIMAL(7,2))  AS valor_desconto
FROM pedido ped
INNER JOIN cliente c
ON c.codigo = ped.cod_cli
INNER JOIN produto prod
ON prod.codigo = ped.cod_prod
WHERE c.nome = 'Maria Clara'


--2. Consultar quais brinquedos não tem itens em estoque.

SELECT forn.atividade, prod.qtd_estoque
FROM fornecedor forn
INNER JOIN produto prod
ON forn.codigo = prod.cod_forn
WHERE forn.atividade LIKE 'Brinquedo%' AND prod.qtd_estoque = 0

--3. Consultar quais nome e descrições de produtos que não estão em pedidos

SELECT prod.nome, prod.descricao
FROM produto prod
LEFT OUTER JOIN pedido ped
ON prod.codigo = ped.cod_prod
WHERE ped.cod_prod IS NULL

--4. Alterar a quantidade em estoque do faqueiro para 10 peças.

UPDATE produto
SET qtd_estoque = 10
WHERE nome = 'faqueiro'

SELECT nome, qtd_estoque
FROM produto

--5. Consultar Quantos clientes tem mais de 40 anos.

SELECT COUNT(nome) AS qnt_clientes
FROM cliente
WHERE DATEDIFF(YEAR, data_nasc, GETDATE()) > 40

--6. Consultar Nome e telefone (Formatado XXXX-XXXX) dos fornecedores de Brinquedos e Chocolate.

SELECT nome, SUBSTRING(telefone, 1, 4) + '-' + SUBSTRING(telefone, 5, 4) AS telefone
FROM fornecedor
WHERE atividade LIKE 'Brinquedo%' OR atividade = 'Chocolate'

--7. Consultar nome e desconto de 25% no preço dos produtos que custam menos de R$50,00

SELECT nome, CAST((valor_unitario * 0.75) AS DECIMAL (7,2)) AS valor_novo
FROM produto
WHERE valor_unitario < 50

--8. Consultar nome e aumento de 10% no preço dos produtos que custam mais de R$100,00

SELECT nome, CAST((valor_unitario * 1.10) AS DECIMAL (7,2)) AS valor_ajustado
FROM produto
WHERE valor_unitario > 100

--9. Consultar desconto de 15% no valor total de cada produto da venda 99001.

SELECT CAST(((prod.valor_unitario * ped.quantidade) * 0.85) AS DECIMAL (7,2)) AS valor_desconto, prod.nome
FROM pedido ped
INNER JOIN produto prod
ON ped.cod_prod = prod.codigo
WHERE ped.codigo = 99001

--10. Consultar Código do pedido, nome do cliente e idade atual do cliente

SELECT ped.codigo, c.nome, DATEDIFF(YEAR, c.data_nasc, GETDATE()) AS idade
FROM pedido ped
INNER JOIN cliente c
ON c.codigo = ped.cod_cli

--11. Consultar o nome do fornecedor do produto mais caro

SELECT forn.nome
FROM fornecedor forn
INNER JOIN produto prod
ON prod.cod_forn = forn.codigo
WHERE prod.valor_unitario IN
( SELECT MAX(prod.valor_unitario)
FROM produto prod )

-- 12. Consultar a média dos valores cujos produtos ainda estão em estoque

SELECT AVG(valor_unitario)
FROM produto
WHERE qtd_estoque > 0

--13. Consultar o nome do cliente, endereço composto por logradouro e número, o valor unitário do produto, o valor total 
--(Quantidade * valor unitario) da compra do cliente de nome Maria Clara

SELECT c.nome, c.logradouro + ', ' + CAST((c.numero) AS VARCHAR(5)) AS endereco, prod.valor_unitario, 
			(ped.quantidade * prod.valor_unitario) AS valor_total
FROM cliente c
INNER JOIN pedido ped
ON ped.cod_cli = c.codigo
INNER JOIN produto prod
ON prod.codigo = ped.cod_prod
WHERE c.nome LIKE 'Maria Clara%'

--14. Considerando que o pedido de Maria Clara foi entregue 15/03/2023, consultar quantos dias houve de atraso. 
--A cláusula do WHERE deve ser o nome da cliente.

SELECT DATEDIFF(DAY, ped.previsao_ent, '15/03/2023') AS atraso
FROM pedido ped
INNER JOIN cliente c
ON c.codigo = ped.cod_cli
WHERE c.nome = 'Maria Clara'
GROUP BY ped.previsao_ent

--15. Consultar qual a nova data de entrega para o pedido de Alberto% sabendo que se pediu 9 dias a mais. 
--A cláusula do WHERE deve ser o nome do cliente. A data deve ser exibida no formato dd/mm/aaaa.

SELECT CONVERT(char(10), DATEADD(DAY, 9, ped.previsao_ent), 103) AS nova_data
FROM pedido ped
INNER JOIN cliente c
ON c.codigo = ped.cod_cli
WHERE c.nome LIKE 'Alberto%'
GROUP BY ped.previsao_ent
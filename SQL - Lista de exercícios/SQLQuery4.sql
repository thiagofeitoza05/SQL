Pede-se:	
1) Consultar nome, valor unit�rio, nome da editora e nome do autor dos livros do estoque que foram vendidos. N�o podem haver repeti��es.	
2) Consultar nome do livro, quantidade comprada e valor de compra da compra 15051	
3) Consultar Nome do livro e site da editora dos livros da Makron books (Caso o site tenha mais de 10 d�gitos, remover o www.).	
4) Consultar nome do livro e Breve Biografia do David Halliday	
5) Consultar c�digo de compra e quantidade comprada do livro Sistemas Operacionais Modernos	
6) Consultar quais livros n�o foram vendidos	
7) Consultar quais livros foram vendidos e n�o est�o cadastrados. Caso o nome dos livros terminem com espa�o, fazer o trim apropriado.	
8) Consultar Nome e site da editora que n�o tem Livros no estoque (Caso o site tenha mais de 10 d�gitos, remover o www.)	
9) Consultar Nome e biografia do autor que n�o tem Livros no estoque (Caso a biografia inicie com Doutorado, substituir por Ph.D.)	
10) Consultar o nome do Autor, e o maior valor de Livro no estoque. Ordenar por valor descendente	
11) Consultar o c�digo da compra, o total de livros comprados e a soma dos valores gastos. Ordenar por C�digo da Compra ascendente.	
12) Consultar o nome da editora e a m�dia de pre�os dos livros em estoque.Ordenar pela M�dia de Valores ascendente.	
13) Consultar o nome do Livro, a quantidade em estoque o nome da editora, o site da editora (Caso o site tenha mais de 10 d�gitos, remover o www.), criar uma coluna status onde:	
	Caso tenha menos de 5 livros em estoque, escrever Produto em Ponto de Pedido
	Caso tenha entre 5 e 10 livros em estoque, escrever Produto Acabando
	Caso tenha mais de 10 livros em estoque, escrever Estoque Suficiente
	A Ordena��o deve ser por Quantidade ascendente
14) Para montar um relat�rio, � necess�rio montar uma consulta com a seguinte sa�da: C�digo do Livro, Nome do Livro, Nome do Autor, Info Editora (Nome da Editora + Site) de todos os livros	
	S� pode concatenar sites que n�o s�o nulos
15) Consultar Codigo da compra, quantos dias da compra at� hoje e quantos meses da compra at� hoje	
16) Consultar o c�digo da compra e a soma dos valores gastos das compras que somam mais de 200.00	
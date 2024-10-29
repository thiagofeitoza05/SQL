USE aulajoin
 
SELECT * FROM alunos
SELECT * FROM materias
SELECT * FROM alunomateria
SELECT * FROM avaliacoes
SELECT * FROM notas

SELECT SUBSTRING(al.ra,1,9)+'-'+SUBSTRING(al.ra,10,1) AS ra, 
	al.nome,	
	mat.nome AS disciplina,
	nt.nota, av.peso, nt.nota * av.peso as nt_calculada

FROM alunos al
INNER JOIN alunomateria am
ON al.ra = am.ra_aluno
INNER JOIN materias mat
ON mat.id = id_materia
INNER JOIN notas nt
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON av.id = nt.id_avaliacao
WHERE mat.nome LIKE 'Banco%'
ORDER BY al.nome ASC

SELECT SUBSTRING(al.ra,1,9)+'-'+SUBSTRING(al.ra,10,1) AS ra, 
	al.nome
FROM alunos al LEFT OUTER JOIN alunomateria am
ON al.ra = am.ra_aluno
WHERE am.ra_aluno IS NULL

SELECT SUBSTRING(al.ra,1,9)+'-'+SUBSTRING(al.ra,10,1) AS ra, 
	al.nome,
	mat.nome,
	nt.nota,
	av.tipo

FROM alunos al
INNER JOIN alunomateria am
ON al.ra = am.ra_aluno
INNER JOIN materias mat
ON mat.id = am.id_materia
INNER JOIN notas nt
ON mat.id = nt.id_materia
INNER JOIN avaliacoes av
ON nt.id_avaliacao = av.id
WHERE (av.tipo = 'P1' OR av.tipo = 'P2') AND nt.nota < 6.0

ORDER BY mat.nome ASC, al.nome ASC

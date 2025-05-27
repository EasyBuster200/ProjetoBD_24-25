--Consulta 1
SELECT p.nome as "Nome Ator"
FROM Atores a 
JOIN Pessoas p on a.idA = p.idP
WHERE NOT EXISTS (
  SELECT idCont
  FROM Conteudos  natural join Filmes
  WHERE idD = 10000000040
  MINUS
  SELECT p.idCont
  FROM participa p
  WHERE p.idA = a.idA
);

--Consulta 2
SELECT DISTINCT p.nome AS "Nome Diretor"
FROM Filmes f
  JOIN Conteudos c ON f.idCont = c.idCont
  JOIN Diretores d ON c.idD = d.idD
  JOIN Pessoas p ON d.idD = p.idP
WHERE c.classificacao >= 4;

--Consulta 3
SELECT c.nomeCont AS "Nome Serie", COUNT(t.numTemp) AS "Nº Temporadas", c.classificacao AS "Classificação"
FROM Conteudos c
JOIN Series s ON c.idCont = s.idCont
JOIN Temporadas t ON s.idCont = t.idCont
JOIN disponiboliza d ON c.idCont = d.idCont
JOIN Plataformas p ON d.idPlat = p.idPlat
WHERE p.nomePlat = 'Netflix'
GROUP BY c.nomeCont, c.classificacao;

--Consulta 4
SELECT 
  c.nomeCont AS "Titulo",
  c.classificacao AS "Classificação IMDB",
  c.linguagem as "Linguagem",
  p.nomePlat AS "Disponibilizado por"
FROM Filmes f
JOIN Conteudos c ON f.idCont = c.idCont
JOIN disponiboliza d ON f.idCont = d.idCont
JOIN Plataformas p ON d.idPlat = p.idPlat
order by "Titulo";
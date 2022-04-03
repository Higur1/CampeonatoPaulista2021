	/*SELECTS*/
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	/*PROCEDURE que seleciona os grupos gerados*/
CREATE PROC sp_selecionar_grupos
AS
	SELECT gp.nomeGrupo, tm.nomeTime, gp.pontos, gp.vitorias, gp.empates, gp.derrotas, gp.golsPro, gp.golsContra, gp.saldoGols
	FROM Grupos gp INNER JOIN Times tm 
	ON gp.codigoTime = tm.codigoTime
	ORDER BY nomeGrupo, pontos DESC
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	/*PROCEDURE que seleciona a tabela geral*/
CREATE PROC sp_gerar_tabela_geral
AS
	SELECT tm.nomeTime, gp.pontos, gp.vitorias, gp.empates, gp.derrotas, gp.golsPro, gp.golsContra, gp.saldoGols 
	FROM Grupos gp 
	INNER JOIN Times tm
	ON gp.codigoTime = tm.codigoTime 
	ORDER BY gp.pontos DESC, gp.vitorias DESC, gp.saldoGols DESC
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	/*PROCEDURE para selecionar todos os jogos*/
CREATE PROC sp_mostrar_jogos
AS
	SELECT dataJogo,
	       (SELECT nomeTime FROM Times WHERE codigoTime = codigoTimeA) AS TimeA, 
		   golsTimeA,golsTimeB,
		   (SELECT nomeTime FROM Times WHERE codigoTime = codigoTimeB) AS TimeB, 
		   estadio
	FROM Jogos
	ORDER BY dataJogo 
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*//*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/	
	/*PROCEDURE para selecionar os jogos por data*/
CREATE PROC sp_selecionar_por_data(@data DATE)
AS
	SELECT dataJogo, 
	       (SELECT nomeTime FROM Times WHERE codigoTime = codigoTimeA) AS TimeA, 
		   golsTimeA,golsTimeB,
		   (SELECT nomeTime FROM Times WHERE codigoTime = codigoTimeB) AS TimeB, 
		   estadio
	FROM Jogos
	WHERE dataJogo = @data
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/



	   /*PROCEDURES*/
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
 /*PROCEDURE que cria os grupos*/
CREATE PROC sp_gerar_grupos
AS
	DECLARE @count INT, @letra CHAR(1),@query VARCHAR(MAX)
	
	DELETE Grupos
	INSERT INTO Grupos VALUES
		('A', 2, 0, 0, 0, 0, 0, 0, 0),	
		('B', 9, 0, 0, 0, 0, 0, 0, 0),
		('C', 13, 0, 0, 0, 0, 0, 0, 0),
		('D', 16, 0, 0, 0, 0, 0, 0, 0)

	SET @count = 1
	WHILE @count <= 12
	BEGIN
		SET @letra = 
			CASE 
				WHEN (@count >= 1 and @count < 4) THEN 'A'
				WHEN (@count >= 4 and @count < 7) THEN 'B'
				WHEN (@count >= 7 and @count < 10) THEN 'C'
				WHEN (@count >= 10) THEN 'D'
			END
		SET @query = 'INSERT INTO Grupos VALUES('''+@letra+''', (SELECT TOP 1 codigoTime FROM Times WHERE codigoTime NOT IN (SELECT codigoTime FROM Grupos) ORDER BY NEWID()), 0, 0, 0, 0, 0, 0, 0)'
		EXEC(@query)
		SET @count = @count + 1
	END
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*PROCEDURE auxiliar que gera os jogos para a sp_armaze_jogos*/
CREATE PROC sp_gerar_jogos(@nomeGrupoRival CHAR(1), @timeA INT, @cod INT)
AS
	DECLARE @jogos INT, @fora INT, @casa INT, @data DATE, @timeB INT
	SET @jogos = 0
	SET @casa = 1
	SET @fora = 1
	WHILE @jogos <= 3
	BEGIN
		SET @timeB = (SELECT TOP 1 codigoTime FROM Grupos WHERE (nomeGrupo = @nomeGrupoRival) and codigoTime NOT IN(SELECT TOP (@jogos) codigoTime FROM Grupos WHERE nomeGrupo = @nomeGrupoRival))
		IF @cod = 1 
		BEGIN
			IF @casa <= 2
			BEGIN
				INSERT INTO Jogos(codigoTimeA, codigoTimeB, golsTimeA, golsTimeB, estadio) 
				VALUES (@timeA, @timeB, (SELECT CAST(RAND()*4 AS INT)), (SELECT CAST(RAND()*4 AS INT)),(SELECT estadio FROM Times WHERE codigoTime = @timeA))
				SET @casa += 1
			END
			ELSE
				IF @fora <= 2
				BEGIN
					INSERT INTO Jogos (codigoTimeA, codigoTimeB, golsTimeA, golsTimeB, estadio) 
					VALUES(@timeB, @timeA,(SELECT CAST(RAND()*4 AS INT)), (SELECT CAST(RAND()*4 AS INT)),(SELECT estadio FROM Times WHERE codigoTime = @timeB))
					SET @fora +=1
				END
		END
		ELSE
			IF @cod = 2
			BEGIN
				IF @fora <= 2
				BEGIN
					INSERT INTO Jogos(codigoTimeA, codigoTimeB, golsTimeA, golsTimeB, estadio) 
					VALUES (@timeB, @timeA, (SELECT CAST(RAND()*4 AS INT)), (SELECT CAST(RAND()*4 AS INT)),(SELECT estadio FROM Times WHERE codigoTime = @timeB))
					SET @fora += 1
				END
				ELSE
					IF @casa <=2
					BEGIN
						INSERT INTO Jogos (codigoTimeA, codigoTimeB, golsTimeA, golsTimeB, estadio) 
						VALUES(@timeA, @timeB,(SELECT CAST(RAND()*4 AS INT)), (SELECT CAST(RAND()*4 AS INT)),(SELECT estadio FROM Times WHERE codigoTime = @timeA))
						SET @casa +=1
					END
			END
		SET @jogos +=1
	END
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*PROCEDURE para armazenar na tabela Jogos os jogos gerados*/
CREATE PROC sp_armazena_jogos
AS
	DECLARE @totalDeJogosEmGrupo INT, @nomeGrupo CHAR(1), @nomeGrupoRival VARCHAR(1), @timeA INT, @timeB INT, @JogosTimeA INT, @cod INT

	DELETE Jogos
	DBCC CHECKIDENT (Jogos, RESEED, 0);
	SET @totalDeJogosEmGrupo = 0
	
	/*Escolhe o nome do grupo baseado no contador @totalDejogosEmGrupo
			A X B // C X D // A X C // B X D // A X D // B X C */
	WHILE @totalDeJogosEmGrupo <= 5
	BEGIN	
		SET @nomeGrupo = 
		CASE 
			WHEN @totalDeJogosEmGrupo = 0 THEN 'A'
			WHEN @totalDeJogosEmGrupo = 1 THEN 'C'
			WHEN @totalDeJogosEmGrupo = 2 THEN 'A'
			WHEN @totalDeJogosEmGrupo = 3 THEN 'B'
			WHEN @totalDeJogosEmGrupo = 4 THEN 'A'
			WHEN @totalDeJogosEmGrupo = 5 THEN 'B'
		END
		SET @nomeGrupoRival =
		CASE
			WHEN @totalDeJogosEmGrupo = 0 THEN 'B'
			WHEN @totalDeJogosEmGrupo = 1 THEN 'D'
			WHEN @totalDeJogosEmGrupo = 2 THEN 'C'
			WHEN @totalDeJogosEmGrupo = 3 THEN 'D'
			WHEN @totalDeJogosEmGrupo = 4 THEN 'D'
			WHEN @totalDeJogosEmGrupo = 5 THEN 'C'
		END	
		/*-------------------------------------------------------------------------*/
		/*Escolhe um time do primeiro grupo e gera 2 jogos em casa e 2 jogos fora*/
		SET @JogosTimeA = 0
		WHILE @JogosTimeA <= 3
		BEGIN
			SET @timeA = (SELECT TOP 1 codigoTime From Grupos WHERE(nomeGrupo = @nomeGrupo) and codigoTime NOT IN(SELECT TOP (@JogosTimeA)codigoTime FROM Grupos WHERE nomeGrupo = @nomeGrupo))
			SET @cod =
				CASE
					WHEN @jogosTimeA % 2 = 0 THEN 1
					WHEN @JogosTimeA % 2 = 1 THEN 2
				END
			EXEC sp_gerar_jogos @nomeGrupoRival, @timeA, @cod
			SET @JogosTimeA += 1
		END
		SET @totalDeJogosEmGrupo += 1
	END
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*PROCEDURE para inserir a data dos jogos*/
CREATE PROC sp_inserir_data_jogo 
AS
	DECLARE @data DATE, @jogos INT
	SET @jogos = 1
	WHILE @jogos <= 96
	BEGIN
		SET @data =
			CASE
				WHEN @jogos IN ( 1,  6, 11, 16, 17, 22, 27, 32) THEN '2021-02-28' /*Rodada 1*/
				WHEN @jogos IN ( 2,  7, 12, 13, 18, 23, 28, 29) THEN '2021-03-03'  /*Rodada 2*/ 
				WHEN @jogos IN ( 3,  8,  9, 14, 19, 24, 25, 30) THEN '2021-03-07'  /*Rodada 3*/ 
				WHEN @jogos IN ( 4,  5, 10, 15, 20, 21, 26, 31) THEN '2021-03-10' /*Rodada 4*/ 
				WHEN @jogos IN (33, 38, 43, 48, 49, 54, 59, 64) THEN '2021-03-14' /*Rodada 5*/ 
				WHEN @jogos IN (34, 39, 44, 45, 50, 55, 60, 61) THEN '2021-03-17' /*Rodada 6*/ 
				WHEN @jogos IN (35, 40, 41, 46, 51, 56, 57, 62) THEN '2021-03-21' /*Rodada 7*/ 
				WHEN @jogos IN (36, 37, 42, 47, 52, 53, 58, 63) THEN '2021-03-24' /*Rodada 8*/ 
				WHEN @jogos IN (65, 70, 75, 80, 81, 86, 91, 96) THEN '2021-03-28' /*Rodada 9*/ 
				WHEN @jogos IN (66, 71, 76, 77, 82, 87, 92, 93) THEN '2021-03-31' /*Rodada 10*/ 
				WHEN @jogos IN (67, 72, 73, 78, 83, 88, 89, 94) THEN '2021-04-04' /*Rodada 11*/ 
				WHEN @jogos IN (68, 69, 74, 79, 84, 85, 90, 95) THEN '2021-04-07' /*Rodada 12*/ 
			END
			UPDATE Jogos
				SET dataJogo = @data
				WHERE id = @jogos
			
			SET @jogos += 1
	END  
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	/* PROCEDURE para resetar a pontuacao*/
CREATE PROC sp_reset_pontuacao
AS
	UPDATE Grupos
	SET pontos = 0

	UPDATE Grupos
	SET vitorias = 0

	UPDATE Grupos
	SET derrotas = 0
	
	UPDATE Grupos
	SET empates = 0	

	UPDATE Grupos
	SET golsPro = 0

	UPDATE Grupos
	SET golsContra = 0

	UPDATE Grupos
	SET saldoGols = 0
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*PROCEDURE para update dos grupos*/	
CREATE PROC sp_pontuacao
AS
	DECLARE @pontos INT, @jogo INT, @query VARCHAR(max), @golsContra INT
	DECLARE @golsPro INT, @golsProAtual INT, @golsContraAtual INT
	EXEC sp_reset_pontuacao
	SET @jogo = 1
	WHILE @jogo <= 96
		BEGIN
			SET @pontos = 
				CASE 
					WHEN (SELECT golsTimeA FROM Jogos WHERE id = @jogo) > (SELECT golsTimeB FROM Jogos WHERE id = @jogo) THEN 3
					WHEN (SELECT golsTimeA FROM Jogos WHERE id = @jogo) = (SELECT golsTimeB FROM Jogos WHERE id = @jogo) THEN 1
					WHEN (SELECT golsTimeA FROM Jogos WHERE id = @jogo) < (SELECT golsTimeB FROM Jogos WHERE id = @jogo) THEN 0
				END
			IF @pontos = 3
				BEGIN
					UPDATE Grupos
						SET pontos += 3
						WHERE codigoTime = (SELECT codigoTimeA FROM Jogos WHERE id = @jogo)
					UPDATE Grupos
						SET vitorias +=1
						WHERE codigoTime = (SELECT codigoTimeA FROM Jogos WHERE id = @jogo)
					UPDATE Grupos
						SET derrotas += 1 
						WHERE codigoTime = (SELECT codigoTimeB FROM Jogos WHERE id = @jogo)
				END
			IF @pontos = 1
				BEGIN
					UPDATE Grupos
						SET pontos += 1
						WHERE codigoTime = (SELECT codigoTimeA FROM Jogos WHERE id = @jogo)
					UPDATE Grupos
						SET pontos += 1
						WHERE codigoTime = (SELECT codigoTimeB FROM Jogos WHERE id = @jogo)
					UPDATE Grupos
						SET empates +=1
						WHERE codigoTime = (SELECT codigoTimeA FROM Jogos WHERE id = @jogo)
					UPDATE Grupos
						SET empates +=1
						WHERE codigoTime = (SELECT codigoTimeB FROM Jogos WHERE id = @jogo)
				END
			IF @pontos = 0
				BEGIN 
					UPDATE Grupos
						SET pontos += 3
						WHERE codigoTime = (SELECT codigoTimeB FROM Jogos WHERE id = @jogo)
					UPDATE Grupos
						SET vitorias +=1
						WHERE codigoTime = (SELECT codigoTimeB FROM Jogos WHERE id = @jogo)
					UPDATE Grupos
						SET derrotas += 1 
						WHERE codigoTime = (SELECT codigoTimeA FROM Jogos WHERE id = @jogo)
				ENd
				UPDATE Grupos
					SET golsPro += (SELECT golsTimeA FROM Jogos WHERE id = @jogo)
					WHERE codigoTime = (SELECT codigoTimeA FROM Jogos WHERE id = @jogo)
					
				UPDATE Grupos
					SET golsContra += (SELECT golsTimeB FROM Jogos WHERE id = @jogo)
					WHERE codigoTime = (SELECT codigoTimeA FROM Jogos WHERE id = @jogo)

				UPDATE Grupos
					SET saldoGols = (SELECT golsPro FROM Grupos WHERE codigoTime = (SELECT codigoTimeA From Jogos WHERE id = @jogo))
														-
									(SELECT golsContra FROM Grupos WHERE codigoTime = (SELECT codigoTimeA From Jogos WHERE id = @jogo)) 
					WHERE codigoTime = (SELECT codigoTimeA FROM Jogos WHERE id = @jogo)

					UPDATE Grupos
					SET golsPro += (SELECT golsTimeB FROM Jogos WHERE id = @jogo)
					WHERE codigoTime = (SELECT codigoTimeB FROM Jogos WHERE id = @jogo)
					
				UPDATE Grupos
					SET golsContra += (SELECT golsTimeA FROM Jogos WHERE id = @jogo)
					WHERE codigoTime = (SELECT codigoTimeB FROM Jogos WHERE id = @jogo)

				UPDATE Grupos
					SET saldoGols = (SELECT golsPro FROM Grupos WHERE codigoTime = (SELECT codigoTimeB From Jogos WHERE id = @jogo))
														-
									(SELECT golsContra FROM Grupos WHERE codigoTime = (SELECT codigoTimeB From Jogos WHERE id = @jogo)) 
					WHERE codigoTime = (SELECT codigoTimeB FROM Jogos WHERE id = @jogo)


			SET @jogo += 1
		END
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	/*PROCEDURE que cria um novo campeonato*/
CREATE PROC sp_gerar_campeonato
AS
	DELETE Grupos
	DELETE Jogos

	EXEC sp_gerar_grupos
	EXEC sp_armazena_jogos
	EXEC sp_inserir_data_jogo
	EXEC sp_pontuacao
	EXEC sp_gerar_tabela_geral
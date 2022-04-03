/*COMANDOS*/
 /*-----------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	/*Comando para gerar os grupos*/
	EXEC sp_gerar_grupos

	/*Comando para selecionar os grupos*/
	EXEC sp_selecionar_grupos

	/*Comando para selecionar tabela geral*/
	EXEC sp_gerar_tabela_geral

	/*Comando para gerar os jogos e armazenar*/
	EXEC sp_armazena_jogos

	/*Comando para mostrar todos os jogos*/
	EXEC sp_mostrar_jogos

	/*Comando para inserir as datas dos jogos*/
	EXEC sp_inserir_data_jogo

	/*Comando para selecionar jogos por data*/
	EXEC  sp_selecionar_por_data '2021-03-28'
	
	/*Comando para gerar a pontuacao baseada nos jogos */
	EXEC sp_pontuacao
	
	/*Exclui e cria um novo campeonato*/
	EXEC sp_gerar_campeonato

	
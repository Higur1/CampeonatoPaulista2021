<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Jogos</title>
</head>
<body>
	<div class="menu-superior">
		<a href="./index.jsp">Tabela</a>
		<a href="./grupos.jsp">Grupos</a>
		<a href="./grupos.jsp">Jogos</a>
	</div>
	<div align="center" class="container">
		<form action="jogos" method="post">
			<table class= "tabelaGeral">
				<tr>
					<th><input type="date" id="botaoData" name="botaoData"></th>
					<th>Time A</th>
					<th>Gols Pro</th>
					<th>Gols Contra</th>
					<th>Time B</th>
					<th>Estadio</th>
				</tr>
			
				<c:forEach var="j" items="${jogos}">
				<tr class="jogos"> 
					<td><c:out value="${j.data}"></c:out></td>
					<td><c:out value="${j.timeA}"/></td>
					<td><c:out value="${j.golsPro}"/></td>
					<td><c:out value="${j.golsContra}"/></td>
					<td><c:out value="${j.timeB}"/></td>
					<td><c:out value="${j.estadio}"/></td>
				</tr>
				</c:forEach>
			</table>
			<input type="submit" id="botao" name="botaoJogos" value="Mostrar Jogos" class="botaoGerar">
		</form>
	</div>
</body>
</html>
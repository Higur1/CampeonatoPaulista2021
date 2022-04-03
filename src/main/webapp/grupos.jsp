<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Grupos</title>
</head>
<body>

	<div class="menu-superior">
		<a href="./index.jsp">Tabela</a>
		<a href="./grupos.jsp">Grupos</a>
		<a href="./jogos.jsp">Jogos</a>
	</div>
	<div align="center" class="container">
		<form action="grupos" method="post" class="form">
		
			<table class="table">
				<thead>
					<tr>
						<th>Posicao</th>
						<th>Time</th>
						<th>Pontos</th>
						<th>Vitorias</th>
						<th>Empates</th>
						<th>Derrotas</th>
						<th>Gols Pro</th>
						<th>Gols Contra</th>
						<th>Saldo de Gols</th>
					</tr>
				</thead>
				<tbody>
					<div class="nomeGrupo">GRUPO A</div>
					<c:forEach var="g" items="${grupos}">
						<c:if test="${g.nomeGrupo == 'A'}">
							<tr class="nomeTime">
								<td><c:out value="${g.posicao}"/></td>
								<td><c:out value="${g.nomeTime}"/></td>
								<td><c:out value="${g.pontos}"/></td>
								<td><c:out value="${g.vitorias}"/></td>
								<td><c:out value="${g.empates}"/></td>
								<td><c:out value="${g.derrotas}"/></td>
								<td><c:out value="${g.golsPro}"/></td>
								<td><c:out value="${g.golsContra}"/></td>
								<td><c:out value="${g.saldoGols}"/></td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
			</br>
			<table class="table">
				<thead>
					<tr>
						<th>Posicao</th>
						<th>Time</th>
						<th>Pontos</th>
						<th>Vitorias</th>
						<th>Empates</th>
						<th>Derrotas</th>
						<th>Gols Pro</th>
						<th>Gols Contra</th>
						<th>Saldo de Gols</th>
					</tr>
				</thead>
				<tbody>
					<div class="nomeGrupo">GRUPO B</div>
					<c:forEach var="g" items="${grupos}">
						<c:if test="${g.nomeGrupo == 'B'}">
							<tr class="nomeTime">
								<td><c:out value="${g.posicao}"/></td>
								<td><c:out value="${g.nomeTime}"/></td>
								<td><c:out value="${g.pontos}"/></td>
								<td><c:out value="${g.vitorias}"/></td>
								<td><c:out value="${g.empates}"/></td>
								<td><c:out value="${g.derrotas}"/></td>
								<td><c:out value="${g.golsPro}"/></td>
								<td><c:out value="${g.golsContra}"/></td>
								<td><c:out value="${g.saldoGols}"/></td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
			</br>
			<table class="table">
				<thead>
					<tr>
						<th>Posicao</th>
						<th>Time</th>
						<th>Pontos</th>
						<th>Vitorias</th>
						<th>Empates</th>
						<th>Derrotas</th>
						<th>Gols Pro</th>
						<th>Gols Contra</th>
						<th>Saldo de Gols</th>
					</tr>
				</thead>
				<tbody>
					<div class="nomeGrupo">GRUPO C</div>
					<c:forEach var="g" items="${grupos}">
						<c:if test="${g.nomeGrupo == 'C'}">
							<tr class="nomeTime">
								<td><c:out value="${g.posicao}"/></td>
								<td><c:out value="${g.nomeTime}"/></td>
								<td><c:out value="${g.pontos}"/></td>
								<td><c:out value="${g.vitorias}"/></td>
								<td><c:out value="${g.empates}"/></td>
								<td><c:out value="${g.derrotas}"/></td>
								<td><c:out value="${g.golsPro}"/></td>
								<td><c:out value="${g.golsContra}"/></td>
								<td><c:out value="${g.saldoGols}"/></td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
			</br>
			<table class="table">
				<thead>
					<tr>
						<th>Posicao</th>
						<th>Time</th>
						<th>Pontos</th>
						<th>Vitorias</th>
						<th>Empates</th>
						<th>Derrotas</th>
						<th>Gols Pro</th>
						<th>Gols Contra</th>
						<th>Saldo de Gols</th>
					</tr>
				</thead>
				<tbody>
					<div class="nomeGrupo">GRUPO D</div>
					<c:forEach var="g" items="${grupos}">
						<c:if test="${g.nomeGrupo == 'D'}">
							<tr class="nomeTime">
								<td><c:out value="${g.posicao}"/></td>
								<td><c:out value="${g.nomeTime}"/></td>
								<td><c:out value="${g.pontos}"/></td>
								<td><c:out value="${g.vitorias}"/></td>
								<td><c:out value="${g.empates}"/></td>
								<td><c:out value="${g.derrotas}"/></td>
								<td><c:out value="${g.golsPro}"/></td>
								<td><c:out value="${g.golsContra}"/></td>
								<td><c:out value="${g.saldoGols}"/></td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		<input type="submit" id="botaoGrupos" name="botaoGrupos" value="Mostrar Grupos" style="align-items: center;">
	</form>
	</div>
</body>
</html>
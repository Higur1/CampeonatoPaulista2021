package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Times;
import persistence.GenericDAO;
import persistence.TabelaDAO;

@WebServlet("/tabelaGeral")
public class TabelaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public TabelaServlet() {
        super();
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String botaoGerar = request.getParameter("botaoTabela");
		String botaoNovaTabela = request.getParameter("botaoNovaTabela");
		String erro = "";
		int contador = 1;
		GenericDAO gDAO = new GenericDAO();
		TabelaDAO tDAO = new TabelaDAO(gDAO);
		
		List<Times> times = new ArrayList<Times>();
		try {
			if(botaoGerar != null && botaoGerar.equals("Gerar Tabela")) {
				contador = 1;
				times = tDAO.listTimes();
				for(Times time: times) {
					time.setPosicao(contador);
					contador += 1;
				}
			}
			if(botaoNovaTabela != null &&  botaoNovaTabela.equals("Nova Tabela")) {
				contador = 1;
				times = tDAO.listNovaTabela();
				for(Times time: times) {
					time.setPosicao(contador);
					contador += 1;
				}
			}
		}catch(SQLException | ClassNotFoundException e){
			erro = e.getMessage();
		}finally {
			RequestDispatcher  rd = request.getRequestDispatcher("index.jsp");
			request.setAttribute("times", times);
			request.setAttribute("erro", erro);
			rd.forward(request, response);
		}
	}

}

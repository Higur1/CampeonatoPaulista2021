package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Jogos;
import persistence.GenericDAO;
import persistence.TabelaDAO;

@WebServlet("/jogos")
public class JogosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public JogosServlet() {
        super();
      
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String botaoData = request.getParameter("botaoData");
		String erro = "";
		GenericDAO gDAO = new GenericDAO();
		TabelaDAO tDAO = new TabelaDAO(gDAO);
	
		List<Jogos> jogos = new ArrayList<Jogos>();
	
		try {
			jogos = tDAO.ListJogos();
			if(!botaoData.isEmpty()) {
				jogos.clear();
				jogos = tDAO.buscarPorData(botaoData);
				if(jogos.isEmpty()) {
					jogos = tDAO.ListJogos();
				}
			}
			
		} catch(SQLException | ClassNotFoundException e){
			erro = e.getMessage();
		} finally {
			RequestDispatcher  rd = request.getRequestDispatcher("jogos.jsp");
			request.setAttribute("jogos", jogos);
			request.setAttribute("erro", erro);
			rd.forward(request, response);
		}
	}

}

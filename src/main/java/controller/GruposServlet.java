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

import model.Grupos;
import persistence.GenericDAO;
import persistence.TabelaDAO;

@WebServlet("/grupos")
public class GruposServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
    public GruposServlet() {
        super();
    }
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String botao = request.getParameter("botaoGrupos");
		String erro = "";
		int contador = 1;
		
		GenericDAO gDAO = new GenericDAO();
		TabelaDAO tDAO = new TabelaDAO(gDAO);
		
		List<Grupos> grupos = new ArrayList<Grupos>();
		try {
			if(botao.equals("Mostrar Grupos")) {
				grupos = tDAO.ListGroupos();
				for(Grupos grupo: grupos) {
					if (contador == 5){
						contador = 1;
					}
					grupo.setPosicao(contador);
					contador += 1;
				}
			}
		}catch(SQLException | ClassNotFoundException e){
			erro = e.getMessage();
		}finally {
			RequestDispatcher  rd = request.getRequestDispatcher("grupos.jsp");
			request.setAttribute("grupos", grupos);
			request.setAttribute("erro", erro);
			rd.forward(request, response);
		}
	}

}

package persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Grupos;
import model.Jogos;
import model.Times;

public class TabelaDAO implements ITabela{

	private GenericDAO gDAO;
	
	public TabelaDAO(GenericDAO gDAO) {
		this.gDAO = gDAO;
	}
	
	
	public List<Times> listTimes() throws SQLException, ClassNotFoundException {
		
		Connection c =  gDAO.getConnection();
		
		List<Times> times = new ArrayList<Times>();
		
		String sql = "EXEC sp_gerar_tabela_geral";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Times time = new Times();
			time.setNome(rs.getString("nomeTime"));
			time.setPontos(rs.getInt("pontos"));		
			time.setVitorias(rs.getInt("vitorias"));
			time.setEmpates(rs.getInt("empates"));
			time.setDerrotas(rs.getInt("derrotas"));
			time.setGolsPro(rs.getInt("golsPro"));
			time.setGolsContra(rs.getInt("golsContra"));
			time.setSaldoGols(rs.getInt("saldoGols"));
			times.add(time);
		}
		rs.close();
		ps.close();
		c.close();
		
		return times;
	}
	public List<Grupos> ListGroupos() throws SQLException, ClassNotFoundException{
		Connection c = gDAO.getConnection();
		
		List<Grupos> grupos = new ArrayList<Grupos>();
		
		String sql = "EXEC sp_selecionar_grupos";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Grupos grupo = new Grupos();
			grupo.setNomeGrupo(rs.getString("nomeGrupo"));
			grupo.setNomeTime(rs.getString("nomeTime"));
			grupo.setPontos(rs.getInt("pontos"));
			grupo.setVitorias(rs.getInt("vitorias"));
			grupo.setEmpates(rs.getInt("empates"));
			grupo.setDerrotas(rs.getInt("derrotas"));
			grupo.setGolsPro(rs.getInt("golsPro"));
			grupo.setGolsContra(rs.getInt("golsContra"));
			grupo.setSaldoGols(rs.getInt("saldoGols"));
			grupos.add(grupo);
		}
		rs.close();
		ps.close();
		c.close();
		return grupos;
	}


	public List<Jogos> ListJogos() throws SQLException, ClassNotFoundException{
		Connection c = gDAO.getConnection();

		List<Jogos> jogos = new ArrayList<Jogos>();
		String sql = "EXEC sp_mostrar_jogos"; 
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Jogos jogo = new Jogos();
			jogo.setTimeA(rs.getString("TimeA"));
			jogo.setTimeB(rs.getString("TimeB"));
			jogo.setGolsPro(rs.getInt("golsTimeA"));
			jogo.setGolsContra(rs.getInt("golsTimeB"));
			jogo.setData(rs.getDate("dataJogo").toLocalDate());
			jogo.setEstadio(rs.getString("estadio"));
			jogos.add(jogo);
		}
		rs.close();
		ps.close();
		c.close();
		return jogos;
	}
	public List<Jogos> buscarPorData(String data)throws SQLException, ClassNotFoundException{
		Connection c = gDAO.getConnection();
	
		List<Jogos> jogos = new ArrayList<Jogos>();
		String sql = "EXEC sp_selecionar_por_data ?"; 
		
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setDate (1, Date.valueOf(data));
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Jogos jogo = new Jogos();
			jogo.setData(rs.getDate("dataJogo").toLocalDate());
			jogo.setTimeA(rs.getString("TimeA"));
			jogo.setGolsPro(rs.getInt("golsTimeA"));
			jogo.setGolsContra(rs.getInt("golsTimeB"));
			jogo.setTimeB(rs.getString("TimeB"));
			jogo.setEstadio(rs.getString("estadio"));
			jogos.add(jogo);
		}
		rs.close();
		ps.close();
		c.close();
		return jogos;
	}
	public List<Jogos> buscarPorTime(String time)throws SQLException, ClassNotFoundException{
		Connection c = gDAO.getConnection();
		
		List<Jogos> jogos = new ArrayList<Jogos>();
		String sql = "EXEC sp_selecionar_por_time ?"; 
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, time);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Jogos jogo = new Jogos();
			jogo.setTimeA(rs.getString("TimeA"));
			jogo.setTimeB(rs.getString("TimeB"));
			jogo.setGolsPro(rs.getInt("golsTimeA"));
			jogo.setGolsContra(rs.getInt("golsTimeB"));
			jogo.setData(rs.getDate("dataJogo").toLocalDate());
			jogo.setEstadio(rs.getString("estadio"));
			jogos.add(jogo);
		}
		rs.close();
		ps.close();
		c.close();
		return jogos;
	}
	public List<Times> listNovaTabela() throws SQLException, ClassNotFoundException {
		
		Connection c =  gDAO.getConnection();
		
		List<Times> times = new ArrayList<Times>();
		String sql = "EXEC sp_gerar_campeonato";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Times time = new Times();
			time.setNome(rs.getString("nomeTime"));
			time.setPontos(rs.getInt("pontos"));		
			time.setVitorias(rs.getInt("vitorias"));
			time.setEmpates(rs.getInt("empates"));
			time.setDerrotas(rs.getInt("derrotas"));
			time.setGolsPro(rs.getInt("golsPro"));
			time.setGolsContra(rs.getInt("golsContra"));
			time.setSaldoGols(rs.getInt("saldoGols"));
			times.add(time);
		}
		rs.close();
		ps.close();
		c.close();
		return times;
	}
}

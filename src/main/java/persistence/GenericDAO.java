package persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDAO {
	
	private Connection c;
	
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		
		String hostName= "127.0.0.1";
		String dbName="CampeonatoPaulista2021";
		String user = "higor";
		String senha = "123456";
		Class.forName("net.sourceforge.jtds.jdbc.Driver");
		String connect = String.format("jdbc:jtds:sqlserver://%s:1433;databaseName=%s;user=%s;password=%s;instance=SQLEXPRESS;namedPipes=false",hostName, dbName, user, senha);
		c= DriverManager.getConnection(connect);
		
		return c;
	}
}

package persistence;

import java.sql.SQLException;
import java.util.List;

import model.Times;

public interface ITabela {
	public List<Times> listTimes() throws SQLException, ClassNotFoundException;
}

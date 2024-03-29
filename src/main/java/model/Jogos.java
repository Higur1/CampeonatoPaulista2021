package model;

import java.sql.Date;
import java.time.LocalDate;

public class Jogos {
	private String timeA;
	private String timeB;
	private int golsPro;
	private int golsContra;
	private LocalDate data;
	private String estadio;
	public String getTimeA() {
		return timeA;
	}
	public void setTimeA(String timeA) {
		this.timeA = timeA;
	}
	public String getTimeB() {
		return timeB;
	}
	public void setTimeB(String timeB) {
		this.timeB = timeB;
	}
	public int getGolsPro() {
		return golsPro;
	}
	public void setGolsPro(int golsPro) {
		this.golsPro = golsPro;
	}
	public int getGolsContra() {
		return golsContra;
	}
	public void setGolsContra(int golsContra) {
		this.golsContra = golsContra;
	}
	public LocalDate getData() {
		return data;
	}
	public void setData(LocalDate date) {
		this.data = date;
	}
	public String getEstadio() {
		return estadio;
	}
	public void setEstadio(String estadio) {
		this.estadio = estadio;
	}
	@Override
	public String toString() {
		return "Jogos [timeA=" + timeA + ", timeB=" + timeB + ", golsPro=" + golsPro + ", golsContra=" + golsContra
				+ ", data=" + data + ", estadio=" + estadio + "]";
	}
}

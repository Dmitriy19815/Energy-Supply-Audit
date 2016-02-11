package ua.datapark.audit;

import java.util.ArrayList;

public class Dogovor {
	String value;	
	public int dogov_id;
	public String nomer;
	public int ks_id;
	public String ks_name;
	public int obl_id;
	public String obl_name;
	public String dat_podpis;
	public String dat_start;
	public String dat_end;
	public int days;
	public ArrayList<Object> points = new ArrayList<Object>();

	public Dogovor( int dogov_id, String nomer, int ks_id, String ks_name, 
					int obl_id, String obl_name, 
					String dat_podpis, String dat_start, String dat_end, 
					int days, ArrayList<Object> points) {
		this.dogov_id = dogov_id;
		this.nomer = nomer;
		this.ks_id = ks_id;
		this.ks_name = ks_name;
		this.obl_id = obl_id;
		this.obl_name = obl_name;
		this.dat_podpis = dat_podpis;
		this.dat_start = dat_start;
		this.dat_end = dat_end;
		this.days = days;
		this.points = points;
	}

	public Dogovor() {
	
	}
	
	public ArrayList<Object> getPoints() { 
		return  points; 
	}
}

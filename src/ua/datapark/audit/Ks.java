package ua.datapark.audit;

import java.util.ArrayList;

public class Ks {
	String value;
	
	public int ks_id;
	public String ks_name;
	public int lpu_id;
	public String lpu_name;
	public int umg_id;
	public String umg_name;
	public ArrayList<Object> Points = new ArrayList<Object>();

	public Ks(	int ks_id, String ks_name, 
				int lpu_id, String lpu_name, 
				int umg_id, String umg_name, ArrayList<Object> points) {
		this.ks_id = ks_id;
		this.ks_name = ks_name;
		this.umg_id = umg_id;
		this.umg_name = umg_name;
		this.lpu_id = lpu_id;
		this.lpu_name = lpu_name;
		this.Points = points;
	}

	public String getStri(int i) {
		switch (i) {
			case 0: value = String.valueOf(ks_id); break;
			case 1: value = ks_name; break;
			case 2: value = String.valueOf(lpu_id); break;
			case 3: value = lpu_name; break;
			case 4: value = String.valueOf(umg_id); break;
			case 5: value = umg_name; break;
		}
		return value;
	}
	
	public ArrayList<Object> getPoints() { 
		return Points; 
	}
}

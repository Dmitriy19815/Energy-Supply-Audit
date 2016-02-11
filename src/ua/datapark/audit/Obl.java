package ua.datapark.audit;

import java.util.ArrayList;

public class Obl {
	String value;
	public int Id; 
	public String Name;
	
	public ArrayList<Object> Points = new ArrayList<Object>();
	
	public Obl(int id, String name, ArrayList<Object> points) {
		this.Id = id;
		this.Name = name;
		this.Points = points;
	}
	
	public String getStri(int i) {
		switch (i) {
			case 0: value = String.valueOf(Id); break;
			case 1: value = Name; break;
		}				
		return value;
	}
	
	public ArrayList<Object> getPoints() { 
		return Points; 
	}
}

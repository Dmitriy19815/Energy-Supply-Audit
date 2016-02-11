package ua.datapark.audit;

public class Umg {
	public int Id; 
	public String Name;
	String value;
	
	public Umg(int id, String name) {
		this.Id = id;
		this.Name = name;
	}
	
	public String getStri(int i) {
		switch (i){
			case 0: value = String.valueOf(Id); break;
			case 1: value = Name; break;
		}				
		return value;
	}
}

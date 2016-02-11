package ua.datapark.audit;

public class Point {
	String value;
	public int point_id; 
	public String point_name;
	public String device_id;
	public int ks_id; 
	public String ks_name;
	public int lpu_id; 
	public String lpu_name;
	public int umg_id; 
	public String umg_name;
	public int obl_id; 
	public String obl_name;
	
	public Point(	int point_id,	String point_name, String device_id,
					int ks_id, 		String ks_name,
					int lpu_id, 	String lpu_name,
					int umg_id, 	String umg_name,
					int obl_id, 	String obl_name ) {
		this.point_id = point_id;
		this.point_name = point_name;
		this.ks_id = ks_id;
		this.ks_name = ks_name;
		this.lpu_id = lpu_id;
		this.lpu_name = lpu_name;
		this.umg_id = umg_id;
		this.umg_name = umg_name;
		this.obl_id = obl_id;
		this.obl_name = obl_name;
		this.device_id = device_id;
	}

	public Point() {
	}
	
	public String getStri(int i) {
		switch (i){
			case 0: value = String.valueOf(point_id); break;
			case 1: value = point_name; break;
			case 2: value = String.valueOf(ks_id); break;
			case 3: value = ks_name; break;
			case 4: value = String.valueOf(lpu_id); break;
			case 5: value = lpu_name; break;
			case 6: value = String.valueOf(umg_id); break;
			case 7: value = umg_name; break;
			case 8: value = String.valueOf(obl_id); break;
			case 9: value = obl_name; break;
			case 10: value = device_id; break;
		}				
		return value;
	}
}

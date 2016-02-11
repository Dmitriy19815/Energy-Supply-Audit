package ua.datapark.audit;

import ua.datapark.commons.Basic;

public class DataVector {
	public String ks_id = "";
	public String point_id = "";
	public String dat = "";
	public String h = "";
	public double fval = 0;
	public int zval = 0;
	public double p_qua_0 = 0;
	public double p_gen_0 = 0;
	public double q_qua_0 = 0;
	public double q_gen_0 = 0;

	public double p_qua_1 = 0;
	public double p_gen_1 = 0;
	public double q_qua_1 = 0;
	public double q_gen_1 = 0;

	public double p_qua_2 = 0;
	public double p_gen_2 = 0;
	public double q_qua_2 = 0;
	public double q_gen_2 = 0;

	public double p_qua_3 = 0;
	public double p_gen_3 = 0;
	public double q_qua_3 = 0;
	public double q_gen_3 = 0;

	public String time_p_qua = "";
	public String time_p_gen = "";
	public String time_q_qua = "";
	public String time_q_gen = "";

	public String time_p_qua_0 = "";
	public String time_p_gen_0 = "";
	public String time_q_qua_0 = "";
	public String time_q_gen_0 = "";

	public String time_p_qua_1 = "";
	public String time_p_gen_1 = "";
	public String time_q_qua_1 = "";
	public String time_q_gen_1 = "";

	public String time_p_qua_2 = "";
	public String time_p_gen_2 = "";
	public String time_q_qua_2 = "";
	public String time_q_gen_2 = "";

	public String time_p_qua_3 = "";
	public String time_p_gen_3 = "";
	public String time_q_qua_3 = "";
	public String time_q_gen_3 = "";

	public String notes = "";
	public String actualtime = "";
	public String parameter_description = "";
	
	public int num = -1;
	public boolean valid = true;
	
	public DataVector() {}

	public void reset() {
		ks_id = "_";
		point_id = "_";
		dat = "_";
		h = "_";
		fval = 1;
		zval = -1;
		p_qua_0 = 0;
		p_gen_0 = 0;
		q_qua_0 = 0;
		q_gen_0 = 0;

		p_qua_1 = 0;
		p_gen_1 = 0;
		q_qua_1 = 0;
		q_gen_1 = 0;

		p_qua_2 = 0;
		p_gen_2 = 0;
		q_qua_2 = 0;
		q_gen_2 = 0;

		p_qua_3 = 0;
		p_gen_3 = 0;
		q_qua_3 = 0;
		q_gen_3 = 0;

		time_p_qua = "_";
		time_p_gen = "_";
		time_q_qua = "_";
		time_q_gen = "_";

		time_p_qua_0 = "_";
		time_p_gen_0 = "_";
		time_q_qua_0 = "_";
		time_q_gen_0 = "_";

		time_p_qua_1 = "_";
		time_p_gen_1 = "_";
		time_q_qua_1 = "_";
		time_q_gen_1 = "_";

		time_p_qua_2 = "_";
		time_p_gen_2 = "_";
		time_q_qua_2 = "_";
		time_q_gen_2 = "_";

		time_p_qua_2 = "_";
		time_p_gen_2 = "_";
		time_q_qua_2 = "_";
		time_q_gen_2 = "_";

		notes = "_";
		actualtime = "_";
		parameter_description = "_";
		
		num = -1;
		valid = true;
	}
	
	public DataVector(	String ks_id, String point_id, String dat, String h,
					    double fval, int zval,
						double p_qua, double p_gen, double q_qua, double q_gen,
						String time_p_qua, String time_p_gen, String time_q_qua, String time_q_gen,
						String notes, String actualtime, String parameter_description, int num) {
		this.ks_id = ks_id;
		this.point_id = point_id;
		this.dat = dat;
		this.h = h;
		this.fval = fval;
		this.zval = zval;
		this.p_qua_0 = p_qua;
		this.p_gen_0 = p_gen;
		this.q_qua_0 = q_qua;
		this.q_gen_0 = q_gen;
		this.time_p_qua = time_p_qua;
		this.time_p_gen = time_p_gen;
		this.time_q_qua = time_q_qua;
		this.time_q_gen = time_q_gen;
		this.notes = notes;
		this.actualtime = actualtime;
		this.parameter_description = parameter_description;
		this.num = num;
	}
	
	public String getByName(String s) {
		String value = "_";
		if (s.equals("ks_id")) { value = ks_id; }
		if (s.equals("point_id")) { value = point_id; }
		if (s.equals("dat")) { value = dat; }
		if (s.equals("h")) { value = h; }
		if (s.equals("fval")) { value = String.valueOf(fval); }
		if (s.equals("zval")) { value = String.valueOf(zval); }
		
		//data_* для совместимости со старым кодом, надо убрать
		if (s.equals("data_p_qua")) { value = valid==true?Basic.formatNumber(1,9,2,2,p_qua_0):"-"; }
		if (s.equals("data_p_gen")) { value = valid==true?Basic.formatNumber(1,9,2,2,p_gen_0):"-"; }
		if (s.equals("data_q_qua")) { value = valid==true?Basic.formatNumber(1,9,2,2,q_qua_0):"-"; }
		if (s.equals("data_q_gen")) { value = valid==true?Basic.formatNumber(1,9,2,2,q_gen_0):"-"; }

		
		if (s.equals("p_qua_0")) { value = valid==true?Basic.formatNumber(1,9,2,2,p_qua_0):"-"; }
		if (s.equals("p_gen_0")) { value = valid==true?Basic.formatNumber(1,9,2,2,p_gen_0):"-"; }
		if (s.equals("q_qua_0")) { value = valid==true?Basic.formatNumber(1,9,2,2,q_qua_0):"-"; }
		if (s.equals("q_gen_0")) { value = valid==true?Basic.formatNumber(1,9,2,2,q_gen_0):"-"; }

		if (s.equals("p_qua_1")) { value = valid==true?Basic.formatNumber(1,9,2,2,p_qua_1):"-"; }
		if (s.equals("p_gen_1")) { value = valid==true?Basic.formatNumber(1,9,2,2,p_gen_1):"-"; }
		if (s.equals("q_qua_1")) { value = valid==true?Basic.formatNumber(1,9,2,2,q_qua_1):"-"; }
		if (s.equals("q_gen_1")) { value = valid==true?Basic.formatNumber(1,9,2,2,q_gen_1):"-"; }

		if (s.equals("p_qua_2")) { value = valid==true?Basic.formatNumber(1,9,2,2,p_qua_2):"-"; }
		if (s.equals("p_gen_2")) { value = valid==true?Basic.formatNumber(1,9,2,2,p_gen_2):"-"; }
		if (s.equals("q_qua_2")) { value = valid==true?Basic.formatNumber(1,9,2,2,q_qua_2):"-"; }
		if (s.equals("q_gen_2")) { value = valid==true?Basic.formatNumber(1,9,2,2,q_gen_2):"-"; }
		
		if (s.equals("p_qua_3")) { value = valid==true?Basic.formatNumber(1,9,2,2,p_qua_3):"-"; }
		if (s.equals("p_gen_3")) { value = valid==true?Basic.formatNumber(1,9,2,2,p_gen_3):"-"; }
		if (s.equals("q_qua_3")) { value = valid==true?Basic.formatNumber(1,9,2,2,q_qua_3):"-"; }
		if (s.equals("q_gen_3")) { value = valid==true?Basic.formatNumber(1,9,2,2,q_gen_3):"-"; }

		if (s.equals("time_p_qua")) { value = time_p_qua!=null?time_p_qua:""; }
		if (s.equals("time_p_gen")) { value = time_p_gen!=null?time_p_gen:""; }
		if (s.equals("time_q_qua")) { value = time_q_qua!=null?time_q_qua:""; }
		if (s.equals("time_q_gen")) { value = time_q_gen!=null?time_q_gen:""; }

		if (s.equals("time_p_qua_0")) { value = time_p_qua_1!=null?time_p_qua_0:""; }
		if (s.equals("time_p_gen_0")) { value = time_p_gen_1!=null?time_p_gen_0:""; }
		if (s.equals("time_q_qua_0")) { value = time_q_qua_1!=null?time_q_qua_0:""; }
		if (s.equals("time_q_gen_0")) { value = time_q_gen_1!=null?time_q_gen_0:""; }

		if (s.equals("time_p_qua_1")) { value = time_p_qua_1!=null?time_p_qua_1:""; }
		if (s.equals("time_p_gen_1")) { value = time_p_gen_1!=null?time_p_gen_1:""; }
		if (s.equals("time_q_qua_1")) { value = time_q_qua_1!=null?time_q_qua_1:""; }
		if (s.equals("time_q_gen_1")) { value = time_q_gen_1!=null?time_q_gen_1:""; }

		if (s.equals("time_p_qua_2")) { value = time_p_qua_2!=null?time_p_qua_2:""; }
		if (s.equals("time_p_gen_2")) { value = time_p_gen_2!=null?time_p_gen_2:""; }
		if (s.equals("time_q_qua_2")) { value = time_q_qua_2!=null?time_q_qua_2:""; }
		if (s.equals("time_q_gen_2")) { value = time_q_gen_2!=null?time_q_gen_2:""; }

		if (s.equals("time_p_qua_3")) { value = time_p_qua_3!=null?time_p_qua_3:""; }
		if (s.equals("time_p_gen_3")) { value = time_p_gen_3!=null?time_p_gen_3:""; }
		if (s.equals("time_q_qua_3")) { value = time_q_qua_3!=null?time_q_qua_3:""; }
		if (s.equals("time_q_gen_3")) { value = time_q_gen_3!=null?time_q_gen_3:""; }

		if (s.equals("notes")) { 
			value = (notes != null) ? notes : ""; 
		}
		if (s.equals("actualtime")) { 
			value = (actualtime != null) ? actualtime : ""; 
		}
		if (s.equals("parameter_description")) { 
			value = (parameter_description != null) ? parameter_description : ""; 
		}

		if (s.equals("num")) { 
			value = String.valueOf(num); 
		}
		if (s.equals("valid")) { 
			value = (valid == true) ? "true" : "false"; 
		}
		return value;
	}

	public double getByNameDouble(String s) {
		double value = -1;
		if (s.equals("fval")) { value = fval; }
		if (s.equals("data_p_qua")) { value = p_qua_0; }
		if (s.equals("data_p_gen")) { value = p_gen_0; }
		if (s.equals("data_q_qua")) { value = q_qua_0; }
		if (s.equals("data_q_gen")) { value = q_gen_0; }

		if (s.equals("p_qua_0")) { value = p_qua_0; }
		if (s.equals("p_gen_0")) { value = p_gen_0; }
		if (s.equals("q_qua_0")) { value = q_qua_0; }
		if (s.equals("q_gen_0")) { value = q_gen_0; }

		if (s.equals("p_qua_1")) { value = p_qua_1; }
		if (s.equals("p_gen_1")) { value = p_gen_1; }
		if (s.equals("q_qua_1")) { value = q_qua_1; }
		if (s.equals("q_gen_1")) { value = q_gen_1; }

		if (s.equals("p_qua_2")) { value = p_qua_2; }
		if (s.equals("p_gen_2")) { value = p_gen_2; }
		if (s.equals("q_qua_2")) { value = q_qua_2; }
		if (s.equals("q_gen_2")) { value = q_gen_2; }

		if (s.equals("p_qua_3")) { value = p_qua_3; }
		if (s.equals("p_gen_3")) { value = p_gen_3; }
		if (s.equals("q_qua_3")) { value = q_qua_3; }
		if (s.equals("q_gen_3")) { value = q_gen_3; }

		if (s.equals("num")) { value = num; }

		return value;
	}
}

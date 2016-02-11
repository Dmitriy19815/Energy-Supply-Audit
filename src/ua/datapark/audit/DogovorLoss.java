package ua.datapark.audit;

public class DogovorLoss implements Cloneable {
	
	public int dogov_loss_id;
	public int dogov_id;
	public String dogovor_nomer;
	public String dogovor_dat_podpis;

	public int point_id;
	public String point_name;
	
	public double loss_fixed_sa_1;
	public double loss_fixed_sa_2;
	public double loss_fixed_sa_3;
	public double loss_fixed_sr_1;
	public double loss_fixed_sr_2;
	public double loss_fixed_sr_3;
	public double loss_fixed_gr_1;
	public double loss_fixed_gr_2;
	public double loss_fixed_gr_3;

	public double loss_float_sa_1;
	public double loss_float_sa_2;
	public double loss_float_sa_3;
	public double loss_float_sr_1;
	public double loss_float_sr_2;
	public double loss_float_sr_3;
	public double loss_float_gr_1;
	public double loss_float_gr_2;
	public double loss_float_gr_3;

	String value;

	public DogovorLoss(int dogov_loss_id, int dogov_id, String dogovor_nomer, String dogovor_dat_podpis, int point_id, String point_name, 
			double loss_fixed_sa_1, double loss_fixed_sa_2, double loss_fixed_sa_3,
			double loss_fixed_sr_1, double loss_fixed_sr_2, double loss_fixed_sr_3,
			double loss_fixed_gr_1, double loss_fixed_gr_2, double loss_fixed_gr_3,

			double loss_float_sa_1, double loss_float_sa_2, double loss_float_sa_3,
			double loss_float_sr_1, double loss_float_sr_2, double loss_float_sr_3,
			double loss_float_gr_1, double loss_float_gr_2, double loss_float_gr_3	) {

		this.dogov_loss_id = dogov_loss_id;
		this.dogov_id = dogov_id;
		this.dogovor_nomer = dogovor_nomer;
		this.dogovor_dat_podpis = dogovor_dat_podpis;
		
		this.point_id = point_id;
		this.point_name = point_name;
		
		this.loss_fixed_sa_1 = loss_fixed_sa_1;
		this.loss_fixed_sa_2 = loss_fixed_sa_2;
		this.loss_fixed_sa_3 = loss_fixed_sa_3;

		this.loss_fixed_sr_1 = loss_fixed_sr_1;
		this.loss_fixed_sr_2 = loss_fixed_sr_2;
		this.loss_fixed_sr_3 = loss_fixed_sr_3;

		this.loss_fixed_sa_1 = loss_fixed_sa_1;
		this.loss_fixed_sa_2 = loss_fixed_sa_2;
		this.loss_fixed_sa_3 = loss_fixed_sa_3;

		this.loss_float_sa_1 = loss_float_sa_1;
		this.loss_float_sa_2 = loss_float_sa_2;
		this.loss_float_sa_3 = loss_float_sa_3;

		this.loss_float_sr_1 = loss_float_sr_1;
		this.loss_float_sr_2 = loss_float_sr_2;
		this.loss_float_sr_3 = loss_float_sr_3;

		this.loss_float_sa_1 = loss_float_sa_1;
		this.loss_float_sa_2 = loss_float_sa_2;
		this.loss_float_sa_3 = loss_float_sa_3;
	}

	public DogovorLoss(DogovorLoss dg) {

		this.dogov_loss_id = dg.dogov_loss_id;
		this.dogov_id = dg.dogov_id;
		this.dogovor_nomer = dg.dogovor_nomer;
		this.dogovor_dat_podpis = dg.dogovor_dat_podpis;
		
		this.point_id = dg.point_id;
		this.point_name = dg.point_name;
		
		this.loss_fixed_sa_1 = dg.loss_fixed_sa_1;
		this.loss_fixed_sa_2 = dg.loss_fixed_sa_2;
		this.loss_fixed_sa_3 = dg.loss_fixed_sa_3;

		this.loss_fixed_sr_1 = dg.loss_fixed_sr_1;
		this.loss_fixed_sr_2 = dg.loss_fixed_sr_2;
		this.loss_fixed_sr_3 = dg.loss_fixed_sr_3;

		this.loss_fixed_sa_1 = dg.loss_fixed_sa_1;
		this.loss_fixed_sa_2 = dg.loss_fixed_sa_2;
		this.loss_fixed_sa_3 = dg.loss_fixed_sa_3;

		this.loss_float_sa_1 = dg.loss_float_sa_1;
		this.loss_float_sa_2 = dg.loss_float_sa_2;
		this.loss_float_sa_3 = dg.loss_float_sa_3;

		this.loss_float_sr_1 = dg.loss_float_sr_1;
		this.loss_float_sr_2 = dg.loss_float_sr_2;
		this.loss_float_sr_3 = dg.loss_float_sr_3;

		this.loss_float_sa_1 = dg.loss_float_sa_1;
		this.loss_float_sa_2 = dg.loss_float_sa_2;
		this.loss_float_sa_3 = dg.loss_float_sa_3;
	}

	public DogovorLoss() { }
	
	public Object clone() {
		return this.clone();
	}
}

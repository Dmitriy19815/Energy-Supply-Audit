package ua.datapark.audit;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;
// import org.apache.commons.dbcp.SQLNestedException;

import ua.datapark.commons.Basic;
import ua.datapark.db.DatabaseTon;

public class _DogovorLoss {
	DataSource ds;
	AuditNSI au;
	Dogovor dg;
	String query = "";
	String processingtime = "";
	
	DogovorLoss dl = new DogovorLoss();
	
	public _DogovorLoss() {
		ds = DatabaseTon.getInstance().getDataSource();
		au = AuditNSI.getInstance();
	}

	public String loadDogovorLoss(int point_id, int dogov_id) {
		String value = "";
		long stime = System.currentTimeMillis();
		try {
			Connection conn = ds.getConnection();
			Statement st = conn.createStatement();
//	    	st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
			
			query = "select dogov_loss_id, dogov_id, dogovor_nomer, to_char(dogovor_dat_podpis,'dd.mm.yyyy') dd, " +
			"point_id, point_name, " +
			"loss_fixed_sa_1, loss_fixed_sa_2, loss_fixed_sa_3, " +
			"loss_fixed_sr_1, loss_fixed_sr_2, loss_fixed_sr_3, " +
			"loss_fixed_gr_1, loss_fixed_gr_2, loss_fixed_gr_3, " +
			"loss_float_sa_1, loss_float_sa_2, loss_float_sa_3, " +
			"loss_float_sr_1, loss_float_sr_2, loss_float_sr_3, " +
			"loss_float_gr_1, loss_float_gr_2, loss_float_gr_3 " +
			"from o$dogov_loss " +
			"WHERE point_id="+point_id+" AND dogov_id="+dogov_id;
			
			ResultSet rs = st.executeQuery(query);
			
			while (rs.next()){
				
				dl.dogov_loss_id =  rs.getInt("dogov_loss_id");
				dl.dogov_id =  rs.getInt("dogov_id");
				dl.dogovor_nomer =  rs.getString("dogovor_nomer");
				dl.dogovor_dat_podpis =  rs.getString("dd");
				
				dl.point_id =  rs.getInt("point_id");
				dl.point_name =  rs.getString("point_name");
	
				dl.loss_fixed_sa_1 = rs.getDouble("loss_fixed_sa_1");
				dl.loss_fixed_sa_2 = rs.getDouble("loss_fixed_sa_2");
				dl.loss_fixed_sa_3 = rs.getDouble("loss_fixed_sa_3");

				dl.loss_fixed_sr_1 = rs.getDouble("loss_fixed_sr_1");
				dl.loss_fixed_sr_2 = rs.getDouble("loss_fixed_sr_2");
				dl.loss_fixed_sr_3 = rs.getDouble("loss_fixed_sr_3");

				dl.loss_fixed_gr_1 = rs.getDouble("loss_fixed_gr_1");
				dl.loss_fixed_gr_2 = rs.getDouble("loss_fixed_gr_2");
				dl.loss_fixed_gr_3 = rs.getDouble("loss_fixed_gr_3");

				dl.loss_float_sa_1 = rs.getDouble("loss_float_sa_1");
				dl.loss_float_sa_2 = rs.getDouble("loss_float_sa_2");
				dl.loss_float_sa_3 = rs.getDouble("loss_float_sa_3");

				dl.loss_float_sr_1 = rs.getDouble("loss_float_sr_1");
				dl.loss_float_sr_2 = rs.getDouble("loss_float_sr_2");
				dl.loss_float_sr_3 = rs.getDouble("loss_float_sr_3");

				dl.loss_float_gr_1 = rs.getDouble("loss_float_gr_1");
				dl.loss_float_gr_2 = rs.getDouble("loss_float_gr_2");
				dl.loss_float_gr_3 = rs.getDouble("loss_float_gr_3");
			}
			rs.close();
		    st.close();
			conn.close();
		} 
		catch (SQLException e) {
			Basic.Logerr("loadDogovorLoss error: "+e.getLocalizedMessage());
			value = "SQL Exception";
		} 
		catch (Exception e) {
			Basic.Logerr("loadDogovorLoss error: "+e.getLocalizedMessage());
			value = "Exception";
		}
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
		return value;
	}
	
	public DogovorLoss getDogovorLoss() {
		return dl;
	}
	
    public String updateDogovorLoss(DogovorLoss dl) {
    	Connection conn = null;
    	String message = "_";
    	
	 	try {
	 		conn = ds.getConnection();
		    Statement st = conn.createStatement();
		    
		    query = "UPDATE oblik_dogov_loss SET " +
			"loss_fixed_sa_1="+dl.loss_fixed_sa_1+", " +
			"loss_fixed_sa_2="+dl.loss_fixed_sa_2+", " +
			"loss_fixed_sa_3="+dl.loss_fixed_sa_3+", " +
			"loss_fixed_sr_1="+dl.loss_fixed_sr_1+", " +
			"loss_fixed_sr_2="+dl.loss_fixed_sr_2+", " +
			"loss_fixed_sr_3="+dl.loss_fixed_sr_3+", " +
			"loss_fixed_gr_1="+dl.loss_fixed_gr_1+", " +
			"loss_fixed_gr_2="+dl.loss_fixed_gr_2+", " +
			"loss_fixed_gr_3="+dl.loss_fixed_gr_3+", " +

			"loss_float_sa_1="+dl.loss_float_sa_1+", " +
			"loss_float_sa_2="+dl.loss_float_sa_2+", " +
			"loss_float_sa_3="+dl.loss_float_sa_3+", " +
			"loss_float_sr_1="+dl.loss_float_sr_1+", " +
			"loss_float_sr_2="+dl.loss_float_sr_2+", " +
			"loss_float_sr_3="+dl.loss_float_sr_3+", " +
			"loss_float_gr_1="+dl.loss_float_gr_1+", " +
			"loss_float_gr_2="+dl.loss_float_gr_2+", " +
			"loss_float_gr_3="+dl.loss_float_gr_3+" " +
			
    		"WHERE point_id="+dl.point_id+" AND dogov_id="+dl.dogov_id;
		    
		    st.executeUpdate(query);		 
		    st.close();
		    conn.close();
		} 
	 	catch (SQLException e) {
			Basic.Logerr("updateDogovorLoss error: "+e.getLocalizedMessage());
		} 
	 	catch (Exception e) {
			Basic.Logerr("updateDogovorLoss error: "+e.getLocalizedMessage());
		}
 		
// 		au.load();
		return message;
    }
}
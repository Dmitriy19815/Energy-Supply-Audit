package ua.datapark.audit;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
//import java.util.Date;

import javax.sql.DataSource;

import ua.datapark.commons.Basic;
import ua.datapark.db.DatabaseTon;

public class _Dov {
	String processingtime = "";
	String umg_id;

	DataSource ds = DatabaseTon.getInstance().getDataSource();
	AuditNSI au = AuditNSI.getInstance();
	
	ArrayList<Object> DataDov1 = new ArrayList<Object>();
	ArrayList<Object> DataDov2 = new ArrayList<Object>();
	ArrayList<Object> DataDovDiff = new ArrayList<Object>();
	ArrayList<Object> DataDovSaldo = new ArrayList<Object>();

	ArrayList<Object> Kss = new ArrayList<Object>();
	ArrayList<Object> Ss1 = new ArrayList<Object>();
	ArrayList<Object> Ss2 = new ArrayList<Object>();
	
	String query="";
	
	public _Dov() {
		umg_id = au.getAuditProps().umg_id; 
		Kss = au.getKss();
	}
	
	public void loadDataDov(String ks, String dat_start, String dat_end) throws SQLException {
		Connection conn = null;
		long stime = System.currentTimeMillis();
		
		ArrayList<Object> Points = new ArrayList<Object>();
		
		for (int j=0; j<Kss.size(); j++) {
			Ks _ks = (Ks) Kss.get(j);
			if (_ks.ks_id == Integer.parseInt(ks)) Points = _ks.Points;
		}
		try {
			conn = ds.getConnection();
			Statement st = conn.createStatement();
			//st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
			// накопительные данные по точкам код 52

			DataDov1.clear();
			DataDov2.clear();
			DataDovDiff.clear();
			DataDovSaldo.clear();
			String last_point = "";
			
			DataVector tempData = new DataVector();
			
			query = "SELECT ks_id, point_id, to_char(dat,'dd-mm-yyyy') dd, h, " +
					"fval, zval, " +
					"data_p_qua, data_p_gen, data_q_qua, data_q_gen, " +
					"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
					"notes, actualtime, description " +
					"FROM oblik, oblik_param " +
					"WHERE oblik_param.id=oblik.h "+
					"AND ks_id='"+ks+"' AND h='52' " +
					"AND zval>0 AND zval<4 " +
					"AND to_char(dat,'yyyy-mm-dd')='"+dat_start+"' "+
					"ORDER BY point_id asc, zval asc";
			ResultSet rs = st.executeQuery(query);

			Ss1.clear();
			
			while (rs.next()){
				if (!(rs.getString("point_id").equals(last_point))) { // new point
					last_point = rs.getString("point_id");
					tempData = new DataVector();
					
					tempData.ks_id =  rs.getString("ks_id");
					tempData.point_id =  rs.getString("point_id");
					tempData.dat =  rs.getString("dd");
					tempData.h =  rs.getString("h");
					tempData.fval =  rs.getDouble("fval");
					tempData.zval =  rs.getInt("zval");
					tempData.actualtime =  rs.getString("actualtime");
					
					Ss1.add(tempData);
				} 
				if (rs.getInt("zval") == 1) {
					tempData.p_qua_1 = rs.getDouble("data_p_qua");
					tempData.p_gen_1 = rs.getDouble("data_p_gen");
					tempData.q_qua_1 = rs.getDouble("data_q_qua");
					tempData.q_gen_1 = rs.getDouble("data_q_gen");
				}
				if (rs.getInt("zval") == 2) {
					tempData.p_qua_2 = rs.getDouble("data_p_qua");
					tempData.p_gen_2 = rs.getDouble("data_p_gen");
					tempData.q_qua_2 = rs.getDouble("data_q_qua");
					tempData.q_gen_2 = rs.getDouble("data_q_gen");
				}
				if (rs.getInt("zval") == 3) {
					tempData.p_qua_3 = rs.getDouble("data_p_qua");
					tempData.p_gen_3 = rs.getDouble("data_p_gen");
					tempData.q_qua_3 = rs.getDouble("data_q_qua");
					tempData.q_gen_3 = rs.getDouble("data_q_gen");
				}		    		
			}
	    
			query = "SELECT ks, point, to_char(dat,'dd-mm-yyyy') dd, h, " +
					"fval, zval, " +
					"data_p_qua, data_p_gen, data_q_qua, data_q_gen, " +
					"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
					"notes, actualtime, parameter_description, actualtime " +
					"FROM oblik, oblik_param " +
					"WHERE oblik_param.parameter_index=oblik.h "+
					"AND ks='"+ks+"' AND h='52' " +
					"AND zval>0 AND zval<4 " +
					"AND to_char(dat,'yyyy-mm-dd')='"+dat_end+"' "+
					"ORDER BY point asc, zval asc";
		    rs = st.executeQuery(query);
			Ss2.clear();
			
			while (rs.next()){
				if (!(rs.getString("point_id").equals(last_point))) { // new point
					last_point = rs.getString("point_id");
					tempData = new DataVector();
					
					tempData.ks_id =  rs.getString("ks_id");
					tempData.point_id =  rs.getString("point_id");
					tempData.dat =  rs.getString("dd");
					tempData.h =  rs.getString("h");
					tempData.fval =  rs.getDouble("fval");
					tempData.zval =  rs.getInt("zval");
					tempData.actualtime =  rs.getString("actualtime");

					Ss2.add(tempData);
				} 
				if (rs.getInt("zval") == 1) {
					tempData.p_qua_1 = rs.getDouble("data_p_qua");
					tempData.p_gen_1 = rs.getDouble("data_p_gen");
					tempData.q_qua_1 = rs.getDouble("data_q_qua");
					tempData.q_gen_1 = rs.getDouble("data_q_gen");
				}
				if (rs.getInt("zval") == 2) {
					tempData.p_qua_2 = rs.getDouble("data_p_qua");
					tempData.p_gen_2 = rs.getDouble("data_p_gen");
					tempData.q_qua_2 = rs.getDouble("data_q_qua");
					tempData.q_gen_2 = rs.getDouble("data_q_gen");
				}
				if (rs.getInt("zval") == 3) {
					tempData.p_qua_3 = rs.getDouble("data_p_qua");
					tempData.p_gen_3 = rs.getDouble("data_p_gen");
					tempData.q_qua_3 = rs.getDouble("data_q_qua");
					tempData.q_gen_3 = rs.getDouble("data_q_gen");
				}		    		
			}
			tempData = null;
			rs.close();
		    st.close();
		    conn.close();
		} 
		catch (SQLException e) {
			Basic.Logerr("loadDataDov error: "+e.getLocalizedMessage());
		} 
		catch (Exception e) {
			Basic.Logerr("devLoad error: "+e.getLocalizedMessage());
		}
		
		DataVector _dv;
	    //выполняется для одной строки - начало периода
		for (int j=0; j<Points.size(); j++) {
			Point point = (Point) Points.get(j);
			_dv = new DataVector();
			_dv.ks_id = ks;
			_dv.point_id = String.valueOf(point.point_id);
			_dv.valid = false;
			DataDov1.add(_dv);

			_dv = new DataVector();
			_dv.ks_id = ks;
			_dv.point_id = String.valueOf(point.point_id);
			_dv.valid = false;
			DataDov2.add(_dv);

			_dv = new DataVector();
			_dv.ks_id = ks;
			_dv.point_id = String.valueOf(point.point_id);
			_dv.valid = false;
			DataDovDiff.add(_dv);

			_dv = new DataVector();
			_dv.ks_id = ks;
			_dv.point_id = String.valueOf(point.point_id);
			_dv.valid = false;
			DataDovSaldo.add(_dv);
		}
		_dv = null;
		
	    for (int i=0; i<Ss1.size(); i++) {
			DataVector s = (DataVector) Ss1.get(i);
			
			for (int j=0; j<Points.size(); j++) {
				Point point = (Point) Points.get(j);
				if ( Integer.parseInt(s.point_id) == point.point_id ) 
					DataDov1.set(j,s); 
			}
		}
	    for (int i=0; i<Ss2.size(); i++) {
			DataVector s = (DataVector) Ss2.get(i);
			
			for (int j=0; j<Points.size(); j++) {
				Point point = (Point) Points.get(j);
				if ( Integer.parseInt(s.point_id) == point.point_id ) 
					DataDov2.set(j,s); 
				s.valid = true;
			}
		}
		    
	    DataVector dv1, dv2, dvdiff, dvsaldo;
	    
	    if ( DataDov1.size()==DataDov2.size() && DataDov1.size()>0 ) {
	    	for (int i=0; i<Points.size(); i++) {
	    		dv1 = (DataVector) DataDov1.get(i);
	    		dv2 = (DataVector) DataDov2.get(i);

	    		dvdiff = (DataVector) DataDovDiff.get(i);
	    		dvsaldo = (DataVector) DataDovSaldo.get(i);

	    		if ( dv1.valid && dv2.valid ) {
		    		dvdiff.valid = true;
		    		dvsaldo.valid = true;

	    			dvdiff.p_qua_1 = dv2.p_qua_1-dv1.p_qua_1; dvsaldo.p_qua_1 = dvdiff.p_qua_1 * dv1.fval;
	    			dvdiff.p_qua_2 = dv2.p_qua_2-dv1.p_qua_2; dvsaldo.p_qua_2 = dvdiff.p_qua_2 * dv1.fval;
	    			dvdiff.p_qua_3 = dv2.p_qua_3-dv1.p_qua_3; dvsaldo.p_qua_3 = dvdiff.p_qua_3 * dv1.fval;

	    			dvdiff.p_gen_1 = dv2.p_gen_1-dv1.p_gen_1; dvsaldo.p_gen_1 = dvdiff.p_gen_1 * dv1.fval;
	    			dvdiff.p_gen_2 = dv2.p_gen_2-dv1.p_gen_2; dvsaldo.p_gen_2 = dvdiff.p_gen_2 * dv1.fval;
	    			dvdiff.p_gen_3 = dv2.p_gen_3-dv1.p_gen_3; dvsaldo.p_gen_3 = dvdiff.p_gen_3 * dv1.fval;

	    			dvdiff.q_qua_1 = dv2.q_qua_1-dv1.q_qua_1; dvsaldo.q_qua_1 = dvdiff.q_qua_1 * dv1.fval;
	    			dvdiff.q_qua_2 = dv2.q_qua_2-dv1.q_qua_2; dvsaldo.q_qua_2 = dvdiff.q_qua_2 * dv1.fval;
	    			dvdiff.q_qua_3 = dv2.q_qua_3-dv1.q_qua_3; dvsaldo.q_qua_3 = dvdiff.q_qua_3 * dv1.fval;

	    			dvdiff.q_gen_1 = dv2.q_gen_1-dv1.q_gen_1; dvsaldo.q_gen_1 = dvdiff.q_gen_1 * dv1.fval;
	    			dvdiff.q_gen_2 = dv2.q_gen_2-dv1.q_gen_2; dvsaldo.q_gen_2 = dvdiff.q_gen_2 * dv1.fval;
	    			dvdiff.q_gen_3 = dv2.q_gen_3-dv1.q_gen_3; dvsaldo.q_gen_3 = dvdiff.q_gen_3 * dv1.fval;
	    			
	    			if (dv1.valid) { dvdiff.fval = dv1.fval; dvsaldo.fval = dv1.fval; }
	    			if (dv2.valid) { dvdiff.fval = dv2.fval; dvsaldo.fval = dv1.fval; }	    			  
	    			 
	    		} else {
	    			dvdiff.p_qua_1 = 0; dvsaldo.p_qua_1 = 0;
	    			dvdiff.p_qua_2 = 0; dvsaldo.p_qua_2 = 0;
	    			dvdiff.p_qua_3 = 0; dvsaldo.p_qua_3 = 0;

	    			dvdiff.p_gen_1 = 0; dvsaldo.p_gen_1 = 0;
	    			dvdiff.p_gen_2 = 0; dvsaldo.p_gen_2 = 0;
	    			dvdiff.p_gen_3 = 0; dvsaldo.p_gen_3 = 0;

	    			dvdiff.q_qua_1 = 0; dvsaldo.q_qua_1 = 0;
	    			dvdiff.q_qua_2 = 0; dvsaldo.q_qua_2 = 0;
	    			dvdiff.q_qua_3 = 0; dvsaldo.q_qua_3 = 0;

	    			dvdiff.q_gen_1 = 0; dvsaldo.q_gen_1 = 0;
	    			dvdiff.q_gen_2 = 0; dvsaldo.q_gen_2 = 0;
	    			dvdiff.q_gen_3 = 0; dvsaldo.q_gen_3 = 0;
	    		}
	    	}
	    }
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
		dv1 = dv2 = dvdiff = dvsaldo = null;
	}

	
	public String getDataDov1ByName(int i, String name) {
		DataVector ad = (DataVector) DataDov1.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	public double getDataDov1ByNameDouble(int i, String name) {
		DataVector ad = (DataVector) DataDov1.get(i);
		double value = ad.getByNameDouble(name); 
		return value;
	}
	public String getDataDov2ByName(int i, String name) {
		DataVector ad = (DataVector) DataDov2.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	public double getDataDov2ByNameDouble(int i, String name) {
		DataVector ad = (DataVector) DataDov2.get(i);
		double value = ad.getByNameDouble(name); 
		return value;
	}
	public String getDataDovDiffByName(int i, String name) {
		DataVector ad = (DataVector) DataDovDiff.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	public double getDataDovDiffByNameDouble(int i, String name) {
		DataVector ad = (DataVector) DataDovDiff.get(i);
		double value = ad.getByNameDouble(name); 
		return value;
	}
	public String getDataDovSaldoByName(int i, String name) {
		DataVector ad = (DataVector) DataDovSaldo.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	public double getDataDovSaldoByNameDouble(int i, String name) {
		DataVector ad = (DataVector) DataDovSaldo.get(i);
		double value = ad.getByNameDouble(name); 
		return value;
	}
	public int DataDov1Size() { return DataDov1.size(); }
	public int DataDov2Size() { return DataDov2.size(); }
	public int DataDovDiffSize() { return DataDovDiff.size(); }
	public int DataDovSaldoSize() { return DataDovSaldo.size(); }
	
	public String getProcessingTime() {
		return processingtime; 
	}	
}
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

public class _Akt {
	String umg_id;
	DataSource ds = DatabaseTon.getInstance().getDataSource();
	AuditNSI au = AuditNSI.getInstance();
	String processingtime = "";
	
	ArrayList<Object> DataAkt1 = new ArrayList<Object>();
	ArrayList<Object> DataAkt2 = new ArrayList<Object>();
	ArrayList<Object> DataAktDiff = new ArrayList<Object>();
	ArrayList<Object> DataAktSaldo = new ArrayList<Object>();

	ArrayList<Object> Ss1 = new ArrayList<Object>();
	ArrayList<Object> Ss2 = new ArrayList<Object>();
	
	public _Akt() {
		umg_id = au.getAuditProps().umg_id; 
	}
	
	public String loadDataAkt(Point[] points, String ks, String dat_start, String dat_end) throws SQLException {
		String value = "", query = "";
		Connection conn = null;
		
		long stime = System.currentTimeMillis();

		try {
			conn = ds.getConnection();
			Statement st = conn.createStatement();
			//st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
			// накопительные данные по точкам код 52

			DataAkt1.clear();
			DataAkt2.clear();
			DataAktDiff.clear();
			DataAktSaldo.clear();
			Ss1.clear();
			Ss2.clear();

			ResultSet rs = null;
			DataVector tempData; // = new DataVector();

			for (int i=0; i<points.length; i++) {
				tempData = new DataVector();
				Ss1.add(tempData);
				tempData.point_id =  String.valueOf(points[i].point_id);

				query = ("SELECT ks_id, point_id, to_char(dat,'dd-mm-yyyy') dd, h, " +
						"fval, zval, " +
						"data_p_qua, data_p_gen, data_q_qua, data_q_gen, " +
						"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
						"notes, actualtime, description " +
						"FROM oblik, oblik_param " +
						"WHERE oblik_param.id=oblik.h "+
						"AND point_id='"+points[i].point_id+"' AND h='52' " +
						"AND zval>0 AND zval<4 " +
						"AND to_char(dat,'yyyy-mm-dd')='"+dat_start+"' "+
						"ORDER BY point_id asc, zval asc");
				rs = st.executeQuery(query);

				while (rs.next()){
					tempData.ks_id =  rs.getString("ks_id");
					tempData.dat =  rs.getString("dd");
					tempData.h =  rs.getString("h");
					tempData.fval =  rs.getDouble("fval");
					tempData.zval =  rs.getInt("zval");
					tempData.actualtime =  rs.getString("actualtime");
					
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
			}

			for (int i=0; i<points.length; i++) {
			    tempData = new DataVector();
				Ss2.add(tempData);

				query = "SELECT ks_id, point_id, to_char(dat,'dd-mm-yyyy') dd, h, " +
						"fval, zval, " +
						"data_p_qua, data_p_gen, data_q_qua, data_q_gen, " +
						"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
						"notes, actualtime, oblik_param.description, actualtime " +
						"FROM oblik, oblik_param " +
						"WHERE oblik_param.id=oblik.h "+
						"AND point_id='"+points[i].point_id+"' AND h='52' " +
						"AND zval>0 AND zval<4 " +
						"AND to_char(dat,'yyyy-mm-dd')='"+dat_end+"' "+
						"ORDER BY point_id asc, zval asc";
			    rs = st.executeQuery(query);

				tempData.point_id =  String.valueOf(points[i].point_id);
				while (rs.next()){
					tempData.ks_id =  rs.getString("ks_id");
					tempData.dat =  rs.getString("dd");
					tempData.h =  rs.getString("h");
					tempData.fval =  rs.getDouble("fval");
					tempData.zval =  rs.getInt("zval");
					tempData.actualtime =  rs.getString("actualtime");
				 
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
			}
			tempData = null;
			
			rs.close();
		    st.close();
		    conn.close();
		} 
		catch (SQLException e) {
			Basic.Logerr("loadDataAkt error: "+e.getLocalizedMessage());
		} 
		catch (Exception e) {
			Basic.Logerr("loadDataAkt error: "+e.getLocalizedMessage());
		}
		
		DataVector _dv;
	    //выполняется для одной строки - начало периода
		for (int j=0; j<points.length; j++) {
			Point point = points[j];
			_dv = new DataVector();
			_dv.ks_id = ks;
			_dv.point_id = String.valueOf(point.point_id);
			_dv.valid = false;
			DataAkt1.add(_dv);

			_dv = new DataVector();
			_dv.ks_id = ks;
			_dv.point_id = String.valueOf(point.point_id);
			_dv.valid = false;
			DataAkt2.add(_dv);

			_dv = new DataVector();
			_dv.ks_id = ks;
			_dv.point_id = String.valueOf(point.point_id);
			_dv.valid = false;
			DataAktDiff.add(_dv);

			_dv = new DataVector();
			_dv.ks_id = ks;
			_dv.point_id = String.valueOf(point.point_id);
			_dv.valid = false;
			DataAktSaldo.add(_dv);
		}
		_dv = null;

		for (int i=0; i<Ss2.size(); i++) {
			DataVector s = (DataVector) Ss2.get(i);
			
			for (int j=0; j<points.length; j++) {
				Point point = points[j];
				if ( Integer.parseInt(s.point_id) == point.point_id ) 
					DataAkt2.set(j,s); 
				s.valid = true;
			}
		}
		
	    for (int i=0; i<Ss1.size(); i++) {
			DataVector s = (DataVector) Ss1.get(i); 
			for (int j=0; j<points.length; j++) {
				Point point = points[j];
				if ( Integer.parseInt(s.point_id) == point.point_id ) 
					DataAkt1.set(j,s); 
			}
		}
		    
	    DataVector dv1, dv2, dvdiff, dvsaldo;
	    
	    if ( DataAkt1.size() == DataAkt2.size() && DataAkt1.size() > 0 ) {
	    	for (int i=0; i<points.length; i++) {
	    		dv1 = (DataVector) DataAkt1.get(i);
	    		dv2 = (DataVector) DataAkt2.get(i);

	    		dvdiff = (DataVector) DataAktDiff.get(i);
	    		dvsaldo = (DataVector) DataAktSaldo.get(i);

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
	    dv1 = dv2 = dvdiff = dvsaldo = null;

	    processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
		return value;
	}
	
	public String getDataAkt1ByName(int i, String name) {
		DataVector ad = (DataVector) DataAkt1.get(i);
		String value = ad.getByName(name); 
		return value;
	}

	public double getDataAkt1ByNameDouble(int i, String name) {
		DataVector ad = (DataVector) DataAkt1.get(i);
		double value = ad.getByNameDouble(name); 
		return value;
	}
	
	public String getDataAkt2ByName(int i, String name) {
		DataVector ad = (DataVector) DataAkt2.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	
	public double getDataAkt2ByNameDouble(int i, String name) {
		DataVector ad = (DataVector) DataAkt2.get(i);
		double value = ad.getByNameDouble(name); 
		return value;
	}
	
	public String getDataDovDiffByName(int i, String name) {
		DataVector ad = (DataVector) DataAktDiff.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	
	public double getDataDovDiffByNameDouble(int i, String name) {
		DataVector ad = (DataVector) DataAktDiff.get(i);
		double value = ad.getByNameDouble(name); 
		return value;
	}
	
	public String getDataDovSaldoByName(int i, String name) {
		DataVector ad = (DataVector) DataAktSaldo.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	
	public double getDataDovSaldoByNameDouble(int i, String name) {
		DataVector ad = (DataVector) DataAktSaldo.get(i);
		double value = ad.getByNameDouble(name); 
		return value;
	}
	
	public int DataDov1Size() { 
		return DataAkt1.size(); 
	}
	public int DataDov2Size() { 
		return DataAkt2.size(); 
	}
	public int DataDovDiffSize() { 
		return DataAktDiff.size(); 
	}
	public int DataDovSaldoSize() { 
		return DataAktSaldo.size(); 
	}
	
	public String getProcessingTime() { 
		return processingtime; 
	}	
}
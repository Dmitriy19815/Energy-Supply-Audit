package ua.datapark.audit;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

// import org.apache.commons.dbcp.SQLNestedException;

import ua.datapark.commons.Basic;
import ua.datapark.db.DatabaseTon;

public class _Range {
	String umg_id;
	DataSource ds = DatabaseTon.getInstance().getDataSource();
	AuditNSI au = AuditNSI.getInstance();
	String processingtime = "";
	
	ArrayList<DataVector> DataRange = new ArrayList<DataVector>();
	
	String query="";
	
	public _Range() {
		umg_id = au.getAuditProps().umg_id;
	}
	
	public String loadDataRangeZero(String ks, String dat_start, String dat_end, String recalc) {
		String value = "";
		long stime = System.currentTimeMillis();
		try {
			Connection conn = ds.getConnection();
			Statement st = conn.createStatement();
//	    	st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
//			расчет за день по всему объекту код 49
			
			query = "SELECT ks_id, point_id, to_char(dat,'dd-mm-yyyy') dd, h, " +
					"fval, zval, " +
					"data_p_qua, data_p_gen, data_q_qua, data_q_gen, " +
					"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
					"notes, actualtime, description " +
					"FROM oblik, oblik_param " +
					"WHERE oblik_param.id=oblik.h "+
					"AND point_id=0 AND h=49 " +
					"AND ks_id='"+ks+"' " +
					"AND zval<4 " +
					"AND to_char(dat,'yyyy-mm-dd')>='"+dat_start+"' "+
					"AND to_char(dat,'yyyy-mm-dd')<='"+dat_end+"' "+
					"ORDER BY dat desc, zval asc";
			ResultSet rs = st.executeQuery(query);

			DataRange.clear();
			String last_dat = "";
			double fval = 1;
			
			DataVector tempData = new DataVector();
			DataVector tempDataSum = new DataVector();
		
			tempDataSum.h = "50";
			DataRange.add(tempDataSum);
			
			while (rs.next()){
				if (!(rs.getString("dd").equals(last_dat))) { // new dat
					tempData = new DataVector();

					tempData.ks_id =  rs.getString("ks_id");
					tempData.point_id =  rs.getString("point_id");
					tempData.dat = rs.getString("dd");
					last_dat = rs.getString("dd");
					tempData.h =  rs.getString("h");
					tempData.fval =  rs.getDouble("fval");
					fval = recalc.equals("on")?rs.getDouble("fval"):1;				
					tempData.zval =  rs.getInt("zval");
					if (rs.getInt("zval") == 0) {
						tempData.p_qua_0 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_0 += tempData.p_qua_0;
						tempData.p_gen_0 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_0 += tempData.p_gen_0;
						tempData.q_qua_0 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_0 += tempData.q_qua_0;
						tempData.q_gen_0 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_0 += tempData.q_gen_0;
					}
					if (rs.getInt("zval") == 1) {
						tempData.p_qua_1 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_1 += tempData.p_qua_1;
						tempData.p_gen_1 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_1 += tempData.p_gen_1;
						tempData.q_qua_1 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_1 += tempData.q_qua_1;
						tempData.q_gen_1 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_1 += tempData.q_gen_1;
					}
					if (rs.getInt("zval") == 2) {
						tempData.p_qua_2 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_2 += tempData.p_qua_2;
						tempData.p_gen_2 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_2 += tempData.p_gen_2;
						tempData.q_qua_2 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_2 += tempData.q_qua_2;
						tempData.q_gen_2 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_2 += tempData.q_gen_2;
					}
					if (rs.getInt("zval") == 3) {
						tempData.p_qua_3 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_3 += tempData.p_qua_3;
						tempData.p_gen_3 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_3 += tempData.p_gen_3;
						tempData.q_qua_3 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_3 += tempData.q_qua_3;
						tempData.q_gen_3 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_3 += tempData.q_gen_3;
					}

					tempData.time_p_qua = rs.getString("time_p_qua");
					tempData.time_p_gen = rs.getString("time_p_gen");
					tempData.time_q_qua = rs.getString("time_q_qua");
					tempData.time_q_gen = rs.getString("time_q_gen");
					tempData.notes = rs.getString("notes"); 
					tempData.actualtime = rs.getString("actualtime");
					
					tempData.parameter_description = rs.getString("description");
	
					DataRange.add(tempData);

				} else {
					if (rs.getInt("zval") == 0) {
						tempData.p_qua_0 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_0 += tempData.p_qua_0;
						tempData.p_gen_0 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_0 += tempData.p_gen_0;
						tempData.q_qua_0 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_0 += tempData.q_qua_0;
						tempData.q_gen_0 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_0 += tempData.q_gen_0;
					}
					if (rs.getInt("zval") == 1) {
						tempData.p_qua_1 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_1 += tempData.p_qua_1;
						tempData.p_gen_1 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_1 += tempData.p_gen_1;
						tempData.q_qua_1 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_1 += tempData.q_qua_1;
						tempData.q_gen_1 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_1 += tempData.q_gen_1;
					}
					if (rs.getInt("zval") == 2) {
						tempData.p_qua_2 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_2 += tempData.p_qua_2;
						tempData.p_gen_2 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_2 += tempData.p_gen_2;
						tempData.q_qua_2 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_2 += tempData.q_qua_2;
						tempData.q_gen_2 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_2 += tempData.q_gen_2;
					}
					if (rs.getInt("zval") == 3) {
						tempData.p_qua_3 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_3 += tempData.p_qua_3;
						tempData.p_gen_3 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_3 += tempData.p_gen_3;
						tempData.q_qua_3 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_3 += tempData.q_qua_3;
						tempData.q_gen_3 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_3 += tempData.q_gen_3;
					}
				}
			}

			rs.close();
		    st.close();
			conn.close();
			tempData = tempDataSum = null;
		} 
		catch (SQLException e) {
			Basic.Logerr("loadDataRangeZero error: "+e.getLocalizedMessage());
			value = "SQL Exception";
		}
		catch (Exception e) {
			Basic.Logerr("loadDataRangeZero error: "+e.getLocalizedMessage());
			value = "Exception";
		}
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
		return value;
	}
	public String loadDataRange(String point, String dat_start, String dat_end, String recalc) {
		String value = "";
		long stime = System.currentTimeMillis();
		try {
			Connection conn = ds.getConnection();
		    Statement st = conn.createStatement();
//		    st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
//			расчет за день код 49
		    query = "SELECT ks_id, point_id, to_char(dat,'dd-mm-yyyy') dd, h, " +
					"fval, zval, " +
					"data_p_qua, data_p_gen, data_q_qua, data_q_gen, " +
					"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
					"notes, actualtime, description " +
					"FROM oblik, oblik_param " +
					"WHERE oblik_param.id=oblik.h "+
					"AND point_id="+point+" AND h=49 " +
					"AND zval<4 " +
					"AND to_char(dat,'yyyy-mm-dd')>='"+dat_start+"' "+
					"AND to_char(dat,'yyyy-mm-dd')<='"+dat_end+"' "+
					"ORDER BY dat desc, zval asc";
		    ResultSet rs = st.executeQuery(query);
		    
		    Basic.Log(this.getClass().getCanonicalName());
	    
		    DataRange.clear();
		    String last_dat = "";
		    double fval = 1;
	
		    DataVector tempData = new DataVector();
		    DataVector tempDataSum = new DataVector();
			
		    tempDataSum.h = "50";
			DataRange.add(tempDataSum);
	
			while (rs.next()){
				if (!(rs.getString("dd").equals(last_dat))) { // new dat
					tempData = new DataVector();
					
					tempData.ks_id =  rs.getString("ks_id");
					tempData.point_id =  rs.getString("point_id");
					tempData.dat =  rs.getString("dd");
					last_dat = rs.getString("dd");
	
					tempData.h =  rs.getString("h");
					tempData.fval =  rs.getDouble("fval");
					fval = recalc.equals("on")?rs.getDouble("fval"):1;
					tempData.zval =  rs.getInt("zval");
	
					if (rs.getInt("zval") == 0) {
						tempData.p_qua_0 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_0 += tempData.p_qua_0;
						tempData.p_gen_0 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_0 += tempData.p_gen_0;
						tempData.q_qua_0 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_0 += tempData.q_qua_0;
						tempData.q_gen_0 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_0 += tempData.q_gen_0;
					}
					if (rs.getInt("zval") == 1) {
						tempData.p_qua_1 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_1 += tempData.p_qua_1;
						tempData.p_gen_1 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_1 += tempData.p_gen_1;
						tempData.q_qua_1 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_1 += tempData.q_qua_1;
						tempData.q_gen_1 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_1 += tempData.q_gen_1;
					}
					if (rs.getInt("zval") == 2) {
						tempData.p_qua_2 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_2 += tempData.p_qua_2;
						tempData.p_gen_2 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_2 += tempData.p_gen_2;
						tempData.q_qua_2 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_2 += tempData.q_qua_2;
						tempData.q_gen_2 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_2 += tempData.q_gen_2;
					}
					if (rs.getInt("zval") == 3) {
						tempData.p_qua_3 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_3 += tempData.p_qua_3;
						tempData.p_gen_3 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_3 += tempData.p_gen_3;
						tempData.q_qua_3 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_3 += tempData.q_qua_3;
						tempData.q_gen_3 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_3 += tempData.q_gen_3;
					}
						
					tempData.time_p_qua = rs.getString("time_p_qua");
					tempData.time_p_gen = rs.getString("time_p_gen");
					tempData.time_q_qua = rs.getString("time_q_qua");
					tempData.time_q_gen = rs.getString("time_q_gen");
					tempData.notes = rs.getString("notes");
					tempData.actualtime = rs.getString("actualtime");
					tempData.parameter_description = rs.getString("description");
	
					DataRange.add(tempData);
	
				} else {
					if (rs.getInt("zval") == 0) {
						tempData.p_qua_0 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_0 += tempData.p_qua_0;
						tempData.p_gen_0 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_0 += tempData.p_gen_0;
						tempData.q_qua_0 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_0 += tempData.q_qua_0;
						tempData.q_gen_0 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_0 += tempData.q_gen_0;
					}
					if (rs.getInt("zval") == 1) {
						tempData.p_qua_1 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_1 += tempData.p_qua_1;
						tempData.p_gen_1 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_1 += tempData.p_gen_1;
						tempData.q_qua_1 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_1 += tempData.q_qua_1;
						tempData.q_gen_1 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_1 += tempData.q_gen_1;
					}
					if (rs.getInt("zval") == 2) {
						tempData.p_qua_2 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_2 += tempData.p_qua_2;
						tempData.p_gen_2 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_2 += tempData.p_gen_2;
						tempData.q_qua_2 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_2 += tempData.q_qua_2;
						tempData.q_gen_2 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_2 += tempData.q_gen_2;
					}
					if (rs.getInt("zval") == 3) {
						tempData.p_qua_3 = rs.getDouble("data_p_qua")*fval; tempDataSum.p_qua_3 += tempData.p_qua_3;
						tempData.p_gen_3 = rs.getDouble("data_p_gen")*fval; tempDataSum.p_gen_3 += tempData.p_gen_3;
						tempData.q_qua_3 = rs.getDouble("data_q_qua")*fval; tempDataSum.q_qua_3 += tempData.q_qua_3;
						tempData.q_gen_3 = rs.getDouble("data_q_gen")*fval; tempDataSum.q_gen_3 += tempData.q_gen_3;
					}
				}
			}

			rs.close();
		    st.close();
		    conn.close();
		    tempData = tempDataSum = null;
		} 
		catch (SQLException e) {
			Basic.Logerr("loadDataRange error: "+e.getLocalizedMessage());
			value = "SQL Exception";
		}
		catch (Exception e) {
			Basic.Logerr("loadDataRange error: "+e.getLocalizedMessage());
			value = "Exception";
		}
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
		return value;
	}
	
	public String getDataRangeByName(int i, String name) {
		DataVector ad = (DataVector) DataRange.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	public double getDataRangeByNameDouble(int i, String name) {
		DataVector ad = (DataVector) DataRange.get(i);
		double value = ad.getByNameDouble(name); 
		return value;
	}
	public int DataRangeSize() {
		return DataRange.size(); 
	}
	public String getProcessingTime() { 
		return processingtime; 
	}
}
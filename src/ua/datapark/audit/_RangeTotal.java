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

public class _RangeTotal {
	String umg_id;
	DataSource ds = DatabaseTon.getInstance().getDataSource();
	AuditNSI au = AuditNSI.getInstance();
	String processingtime = "";
	
	ArrayList<DataVector> DataRangeTotal = new ArrayList<DataVector>();
	
	String query="";
	
	public _RangeTotal() {
		umg_id = au.getAuditProps().umg_id; 
	}

	public void loadDataRangeTotal(String point, String dat_start, String dat_end, String recalc) throws SQLException {
		Connection conn = null;
		long stime = System.currentTimeMillis();
		try {
			conn = ds.getConnection();
		    Statement st = conn.createStatement();
	//	    st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
		    // накопительные данные по точкам код 52
	
		    query = "SELECT ks_id, point_id, to_char(dat,'dd-mm-yyyy') dd, h, " +
		    		"fval, zval, " +
		    		"data_p_qua, data_p_gen, data_q_qua, data_q_gen, " +
		    		"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
		    		"notes, actualtime, oblik_param.description " +
		    		"FROM oblik, oblik_param " +
		    		"WHERE oblik_param.id=oblik.h "+
		    		"AND point_id='"+point+"' AND h='52' " +
		    		"AND zval<4 " +
		    		"AND to_char(dat,'yyyy-mm-dd')>='"+dat_start+"' "+
		    		"AND to_char(dat,'yyyy-mm-dd')<='"+dat_end+"' "+
		    		"ORDER BY dat desc, zval asc";
		    ResultSet rs = st.executeQuery(query);
		    
		    DataRangeTotal.clear();
		    String last_dat = "";
		    double fval = 1;
			DataVector tempDataTotal = new DataVector();
	
			while (rs.next()) {
				
				if (!(rs.getString("dd").equals(last_dat))) { // new dat
					tempDataTotal = new DataVector();
					
					tempDataTotal.ks_id =  rs.getString("ks_id");
					tempDataTotal.point_id =  rs.getString("point_id");
					tempDataTotal.dat =  rs.getString("dd");
					last_dat = rs.getString("dd");
	
					tempDataTotal.h =  rs.getString("h");
					tempDataTotal.fval =  rs.getDouble("fval");
					fval = recalc.equals("on")?rs.getDouble("fval"):1;
					tempDataTotal.zval =  rs.getInt("zval");
	
					if (rs.getInt("zval") == 0) {
						tempDataTotal.p_qua_0 = rs.getDouble("data_p_qua")*fval;
						tempDataTotal.p_gen_0 = rs.getDouble("data_p_gen")*fval;
						tempDataTotal.q_qua_0 = rs.getDouble("data_q_qua")*fval;
						tempDataTotal.q_gen_0 = rs.getDouble("data_q_gen")*fval;
					}
					if (rs.getInt("zval") == 1) {
						tempDataTotal.p_qua_1 = rs.getDouble("data_p_qua")*fval;
						tempDataTotal.p_gen_1 = rs.getDouble("data_p_gen")*fval;
						tempDataTotal.q_qua_1 = rs.getDouble("data_q_qua")*fval;
						tempDataTotal.q_gen_1 = rs.getDouble("data_q_gen")*fval;
					}
					if (rs.getInt("zval") == 2) {
						tempDataTotal.p_qua_2 = rs.getDouble("data_p_qua")*fval;
						tempDataTotal.p_gen_2 = rs.getDouble("data_p_gen")*fval;
						tempDataTotal.q_qua_2 = rs.getDouble("data_q_qua")*fval;
						tempDataTotal.q_gen_2 = rs.getDouble("data_q_gen")*fval;
					}
					if (rs.getInt("zval") == 3) {
						tempDataTotal.p_qua_3 = rs.getDouble("data_p_qua")*fval;
						tempDataTotal.p_gen_3 = rs.getDouble("data_p_gen")*fval;
						tempDataTotal.q_qua_3 = rs.getDouble("data_q_qua")*fval;
						tempDataTotal.q_gen_3 = rs.getDouble("data_q_gen")*fval;
					}
						
					tempDataTotal.notes = rs.getString("notes");
					tempDataTotal.actualtime = rs.getString("actualtime");
					tempDataTotal.parameter_description = rs.getString("description");
	
					DataRangeTotal.add(tempDataTotal);
	
				} else {
					tempDataTotal.ks_id =  rs.getString("ks_id");
					tempDataTotal.point_id =  rs.getString("point_id");
					tempDataTotal.dat =  rs.getString("dd");
	
					tempDataTotal.h =  rs.getString("h");
					tempDataTotal.fval =  rs.getDouble("fval");
					fval = recalc.equals("on")?rs.getDouble("fval"):1;
					tempDataTotal.zval =  rs.getInt("zval");
	
					if (rs.getInt("zval") == 0) {
						tempDataTotal.p_qua_0 = rs.getDouble("data_p_qua")*fval;
						tempDataTotal.p_gen_0 = rs.getDouble("data_p_gen")*fval;
						tempDataTotal.q_qua_0 = rs.getDouble("data_q_qua")*fval;
						tempDataTotal.q_gen_0 = rs.getDouble("data_q_gen")*fval;
					}
					if (rs.getInt("zval") == 1) {
						tempDataTotal.p_qua_1 = rs.getDouble("data_p_qua")*fval;
						tempDataTotal.p_gen_1 = rs.getDouble("data_p_gen")*fval;
						tempDataTotal.q_qua_1 = rs.getDouble("data_q_qua")*fval;
						tempDataTotal.q_gen_1 = rs.getDouble("data_q_gen")*fval;
					}
					if (rs.getInt("zval") == 2) {
						tempDataTotal.p_qua_2 = rs.getDouble("data_p_qua")*fval;
						tempDataTotal.p_gen_2 = rs.getDouble("data_p_gen")*fval;
						tempDataTotal.q_qua_2 = rs.getDouble("data_q_qua")*fval;
						tempDataTotal.q_gen_2 = rs.getDouble("data_q_gen")*fval;
					}
					if (rs.getInt("zval") == 3) {
						tempDataTotal.p_qua_3 = rs.getDouble("data_p_qua")*fval;
						tempDataTotal.p_gen_3 = rs.getDouble("data_p_gen")*fval;
						tempDataTotal.q_qua_3 = rs.getDouble("data_q_qua")*fval;
						tempDataTotal.q_gen_3 = rs.getDouble("data_q_gen")*fval;
					}
				}
			}
			// ! ПРОВЕРИТЬ, МНОЙ ДОБАВЛЕНО
			tempDataTotal = null;
			
			rs.close();
		    st.close();
		    conn.close();
		}
		catch (SQLException e) {
			Basic.Logerr("loadDataRangeTotal error: "+e.getLocalizedMessage());
		}
		catch (Exception e) {
			Basic.Logerr("loadDataRangeTotal error: "+e.getLocalizedMessage());
		}
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
	}

	public String getDataRangeTotalByName(int i, String name) {
		DataVector ad = (DataVector) DataRangeTotal.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	public double getDataRangeTotalByNameDouble(int i, String name) {
		DataVector ad = (DataVector) DataRangeTotal.get(i);
		double value = ad.getByNameDouble(name); 
		return value;
	}
	
	public int DataRangeTotalSize() { return DataRangeTotal.size(); }
	public String getProcessingTime() { return processingtime; }
}
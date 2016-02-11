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

public class _RangeDay {
	String umg_id;
	DataSource ds = DatabaseTon.getInstance().getDataSource();
	AuditNSI au = AuditNSI.getInstance();
	String processingtime = "";
	
	ArrayList<DataVector> DataDay = new ArrayList<DataVector>();
	
	String query="";
	
	public _RangeDay() {
		umg_id = au.getAuditProps().umg_id;
	}

	public void loadDataDay(String point, String dat, String recalc) {
		Connection conn = null;
		long stime = System.currentTimeMillis();
		try {
			conn = ds.getConnection();
			Statement st = conn.createStatement();
//	    	st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
			query = "SELECT ks_id, point_id, to_char(dat,'dd-mm-yyyy') dd, h, " +
					"fval, zval, " +
					"to_char(data_p_qua,'99999990.99'), to_char(data_p_gen,'99999990.99'), to_char(data_q_qua,'99999990.99'), to_char(data_q_gen,'99999990.99'), " +
					"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
					"notes, actualtime, description " +
					"FROM oblik, oblik_param " +
					"WHERE oblik_param.id=oblik.h "+
					"AND point_id='"+point+"' AND h<49" +
					"AND zval>0 " +
					"AND to_char(dat,'dd-mm-yyyy')='"+dat+"' "+
					"ORDER BY h desc";
			ResultSet rs = st.executeQuery(query);
			
			DataDay.clear();
			while (rs.next()){
				if (recalc.equals("on")) {
					DataDay.add(new DataVector(rs.getString("ks_id"),rs.getString("point_id"),rs.getString("dd"), rs.getString("h"),
							rs.getDouble("fval"),rs.getInt("zval"),
							
							rs.getDouble("to_char(data_p_qua,'99999990.99')")*rs.getDouble("fval"),
							rs.getDouble("to_char(data_p_gen,'99999990.99')")*rs.getDouble("fval"),
							rs.getDouble("to_char(data_q_qua,'99999990.99')")*rs.getDouble("fval"),
							rs.getDouble("to_char(data_q_gen,'99999990.99')")*rs.getDouble("fval"),
						
							rs.getString("time_p_qua"),rs.getString("time_p_gen"),rs.getString("time_q_qua"),rs.getString("time_q_gen"),
							rs.getString("notes"),rs.getString("actualtime"),
							rs.getString("description"),1));
				} else {
					DataDay.add(new DataVector(rs.getString("ks_id"),rs.getString("point_id"),rs.getString("dd"),rs.getString("h"),
							rs.getDouble("fval"),rs.getInt("zval"),

							rs.getDouble("to_char(data_p_qua,'99999990.99')"),
							rs.getDouble("to_char(data_p_gen,'99999990.99')"),
							rs.getDouble("to_char(data_q_qua,'99999990.99')"),
							rs.getDouble("to_char(data_q_gen,'99999990.99')"),
							
							rs.getString("time_p_qua"),rs.getString("time_p_gen"),rs.getString("time_q_qua"),rs.getString("time_q_gen"),
							rs.getString("notes"),rs.getString("actualtime"),
							rs.getString("description"),1));
				}
			}

			rs.close();
			st.close();
			conn.close();
		}
		catch (SQLException e) {
			Basic.Logerr("loadDataDay error: "+e.getLocalizedMessage());
		}
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
	}
	public void loadDataZeroDay(String ks, String dat, String recalc) {
		Connection conn = null;
		long stime = System.currentTimeMillis();
		try {
			conn = ds.getConnection();
		
		    Statement st = conn.createStatement();
	//	    st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
		    query = "SELECT ks_id, point_id, to_char(dat,'dd-mm-yyyy') dd, h, " +
					"fval, zval, " +
					"to_char(data_p_qua,'99999990.99'), to_char(data_p_gen,'99999990.99'), to_char(data_q_qua,'99999990.99'), to_char(data_q_gen,'99999990.99'), " +
					"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
					"notes, actualtime, description " +
					"FROM oblik, oblik_param " +
					"WHERE oblik_param.id=oblik.h "+
					"AND ks_id='"+ks+"' " +
					"AND point_id='0' AND h<49" +
					"AND zval>0 " +
					"AND to_char(dat,'dd-mm-yyyy')='"+dat+"' "+
					"ORDER BY h desc";
		    ResultSet rs = st.executeQuery(query);	
		    DataDay.clear();
			while (rs.next()){
				if (recalc.equals("on")) {
					DataDay.add(new DataVector(rs.getString("ks_id"),rs.getString("point_id"),rs.getString("dd"), rs.getString("h"),
							rs.getDouble("fval"),rs.getInt("zval"),
							
							rs.getDouble("to_char(data_p_qua,'99999990.99')")*rs.getDouble("fval"),
							rs.getDouble("to_char(data_p_gen,'99999990.99')")*rs.getDouble("fval"),
							rs.getDouble("to_char(data_q_qua,'99999990.99')")*rs.getDouble("fval"),
							rs.getDouble("to_char(data_q_gen,'99999990.99')")*rs.getDouble("fval"),
							
							rs.getString("time_p_qua"),rs.getString("time_p_gen"),rs.getString("time_q_qua"),rs.getString("time_q_gen"),
							rs.getString("notes"),rs.getString("actualtime"),rs.getString("description"),1));
				} else {
					DataDay.add(new DataVector(rs.getString("ks_id"),rs.getString("point_id"),rs.getString("dd"),rs.getString("h"),
							rs.getDouble("fval"),rs.getInt("zval"),
							rs.getDouble("to_char(data_p_qua,'99999990.99')"),
							rs.getDouble("to_char(data_p_gen,'99999990.99')"),
							rs.getDouble("to_char(data_q_qua,'99999990.99')"),
							rs.getDouble("to_char(data_q_gen,'99999990.99')"),
							
							rs.getString("time_p_qua"),rs.getString("time_p_gen"),rs.getString("time_q_qua"),rs.getString("time_q_gen"),
							rs.getString("notes"),rs.getString("actualtime"),rs.getString("description"),1));
				}
			}
	
			rs.close();
		    st.close();
		    conn.close();
		}
		catch (SQLException e) {
			Basic.Logerr("loadDataZeroDay error: "+e.getLocalizedMessage());
		}
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
	}

	public String getDataDayByName(int i, String name) {
		DataVector ad = (DataVector) DataDay.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	
	public double getDataDayByNameDouble(int i, String name) {
		DataVector ad = (DataVector) DataDay.get(i);
		double value = ad.getByNameDouble(name); 
		return value;
	}
	
	public int DataDaySize() { 
		return DataDay.size(); 
	}
	
	public String getProcessingTime() { 
		return processingtime; 
	}
}

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

public class _Power {
	String umg_id;
	DataSource ds = DatabaseTon.getInstance().getDataSource();
	AuditNSI au = AuditNSI.getInstance();
	String processingtime = "";

	ArrayList<DataVector> DataRangePower = new ArrayList<DataVector>();
	
	String query="";
	
	public _Power() {
		umg_id = au.getAuditProps().umg_id;
	}

	public void loadDataRangePower(String point, String dat_start, String dat_end, String recalc) throws SQLException {
		Connection conn = null;
		long stime = System.currentTimeMillis();
		try {
			conn = ds.getConnection();
			Statement st = conn.createStatement();
			//st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
			// расчет нагрузок код 61

			query = "SELECT ks_id, point_id, to_char(dat,'dd-mm-yyyy') dd, h, " +
					"fval, zval, " +
					"data_p_qua, data_p_gen, data_q_qua, data_q_gen, " +
					"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
					"notes, actualtime, description " +
					"FROM oblik, oblik_param " +
					"WHERE oblik_param.id=oblik.h "+
					"AND point_id='"+point+"' AND h='61' " +
					"AND zval<4 AND zval>0 " +
					"AND to_char(dat,'yyyy-mm-dd')>='"+dat_start+"' "+
					"AND to_char(dat,'yyyy-mm-dd')<='"+dat_end+"' "+
					"ORDER BY dat desc, zval asc";
			ResultSet rs = st.executeQuery(query);
			
			DataRangePower.clear();
			String last_dat = "";
			double fval = 1;

			DataVector tempDataPower = new DataVector();

			while (rs.next()) {
				
				if (!(rs.getString("dd").equals(last_dat))) { // new dat
					tempDataPower = new DataVector();
					
					tempDataPower.ks_id =  rs.getString("ks_id");
					tempDataPower.point_id =  rs.getString("point_id");
					tempDataPower.dat =  rs.getString("dd");
					last_dat = rs.getString("dd");
					
					tempDataPower.h =  rs.getString("h");
					tempDataPower.fval =  rs.getDouble("fval");
					fval = recalc.equals("on")?rs.getDouble("fval"):1;
					tempDataPower.zval =  rs.getInt("zval");

					if (rs.getInt("zval") == 0) {
						tempDataPower.p_qua_0 = rs.getDouble("data_p_qua")*fval;
						tempDataPower.p_gen_0 = rs.getDouble("data_p_gen")*fval;
						tempDataPower.q_qua_0 = rs.getDouble("data_q_qua")*fval;
						tempDataPower.q_gen_0 = rs.getDouble("data_q_gen")*fval;
						tempDataPower.time_p_qua_0 = rs.getString("time_p_qua");
						tempDataPower.time_p_gen_0 = rs.getString("time_p_gen");
						tempDataPower.time_q_qua_0 = rs.getString("time_q_qua");
						tempDataPower.time_q_gen_0 = rs.getString("time_q_gen");
					}
					if (rs.getInt("zval") == 1) {
						tempDataPower.p_qua_1 = rs.getDouble("data_p_qua")*fval;
						tempDataPower.p_gen_1 = rs.getDouble("data_p_gen")*fval;
						tempDataPower.q_qua_1 = rs.getDouble("data_q_qua")*fval;
						tempDataPower.q_gen_1 = rs.getDouble("data_q_gen")*fval;
						tempDataPower.time_p_qua_1 = rs.getString("time_p_qua");
						tempDataPower.time_p_gen_1 = rs.getString("time_p_gen");
						tempDataPower.time_q_qua_1 = rs.getString("time_q_qua");
						tempDataPower.time_q_gen_1 = rs.getString("time_q_gen");
					}
					if (rs.getInt("zval") == 2) {
						tempDataPower.p_qua_2 = rs.getDouble("data_p_qua")*fval;
						tempDataPower.p_gen_2 = rs.getDouble("data_p_gen")*fval;
						tempDataPower.q_qua_2 = rs.getDouble("data_q_qua")*fval;
						tempDataPower.q_gen_2 = rs.getDouble("data_q_gen")*fval;
						tempDataPower.time_p_qua_2 = rs.getString("time_p_qua");
						tempDataPower.time_p_gen_2 = rs.getString("time_p_gen");
						tempDataPower.time_q_qua_2 = rs.getString("time_q_qua");
						tempDataPower.time_q_gen_2 = rs.getString("time_q_gen");
					}
					if (rs.getInt("zval") == 3) {
						tempDataPower.p_qua_3 = rs.getDouble("data_p_qua")*fval;
						tempDataPower.p_gen_3 = rs.getDouble("data_p_gen")*fval;
						tempDataPower.q_qua_3 = rs.getDouble("data_q_qua")*fval;
						tempDataPower.q_gen_3 = rs.getDouble("data_q_gen")*fval;
						tempDataPower.time_p_qua_3 = rs.getString("time_p_qua");
						tempDataPower.time_p_gen_3 = rs.getString("time_p_gen");
						tempDataPower.time_q_qua_3 = rs.getString("time_q_qua");
						tempDataPower.time_q_gen_3 = rs.getString("time_q_gen");
					}
						
					tempDataPower.notes = rs.getString("notes");
					tempDataPower.actualtime = rs.getString("actualtime");
					tempDataPower.parameter_description = rs.getString("description");
	
					DataRangePower.add(tempDataPower);
	
				} else {
					tempDataPower.ks_id =  rs.getString("ks_id");
					tempDataPower.point_id =  rs.getString("point_id");
					tempDataPower.dat =  rs.getString("dd");
	
					tempDataPower.h =  rs.getString("h");
					tempDataPower.fval =  rs.getDouble("fval");
					fval = recalc.equals("on")?rs.getDouble("fval"):1;
					tempDataPower.zval =  rs.getInt("zval");
	
					if (rs.getInt("zval") == 0) {
						tempDataPower.p_qua_0 = rs.getDouble("data_p_qua")*fval;
						tempDataPower.p_gen_0 = rs.getDouble("data_p_gen")*fval;
						tempDataPower.q_qua_0 = rs.getDouble("data_q_qua")*fval;
						tempDataPower.q_gen_0 = rs.getDouble("data_q_gen")*fval;
						tempDataPower.time_p_qua_0 = rs.getString("time_p_qua");
						tempDataPower.time_p_gen_0 = rs.getString("time_p_gen");
						tempDataPower.time_q_qua_0 = rs.getString("time_q_qua");
						tempDataPower.time_q_gen_0 = rs.getString("time_q_gen");
					}
					if (rs.getInt("zval") == 1) {
						tempDataPower.p_qua_1 = rs.getDouble("data_p_qua")*fval;
						tempDataPower.p_gen_1 = rs.getDouble("data_p_gen")*fval;
						tempDataPower.q_qua_1 = rs.getDouble("data_q_qua")*fval;
						tempDataPower.q_gen_1 = rs.getDouble("data_q_gen")*fval;
						tempDataPower.time_p_qua_1 = rs.getString("time_p_qua");
						tempDataPower.time_p_gen_1 = rs.getString("time_p_gen");
						tempDataPower.time_q_qua_1 = rs.getString("time_q_qua");
						tempDataPower.time_q_gen_1 = rs.getString("time_q_gen");
					}
					if (rs.getInt("zval") == 2) {
						tempDataPower.p_qua_2 = rs.getDouble("data_p_qua")*fval;
						tempDataPower.p_gen_2 = rs.getDouble("data_p_gen")*fval;
						tempDataPower.q_qua_2 = rs.getDouble("data_q_qua")*fval;
						tempDataPower.q_gen_2 = rs.getDouble("data_q_gen")*fval;
						tempDataPower.time_p_qua_2 = rs.getString("time_p_qua");
						tempDataPower.time_p_gen_2 = rs.getString("time_p_gen");
						tempDataPower.time_q_qua_2 = rs.getString("time_q_qua");
						tempDataPower.time_q_gen_2 = rs.getString("time_q_gen");
					}
					if (rs.getInt("zval") == 3) {
						tempDataPower.p_qua_3 = rs.getDouble("data_p_qua")*fval;
						tempDataPower.p_gen_3 = rs.getDouble("data_p_gen")*fval;
						tempDataPower.q_qua_3 = rs.getDouble("data_q_qua")*fval;
						tempDataPower.q_gen_3 = rs.getDouble("data_q_gen")*fval;
						tempDataPower.time_p_qua_3 = rs.getString("time_p_qua");
						tempDataPower.time_p_gen_3 = rs.getString("time_p_gen");
						tempDataPower.time_q_qua_3 = rs.getString("time_q_qua");
						tempDataPower.time_q_gen_3 = rs.getString("time_q_gen");
					}
				}
			}
			tempDataPower = null;
			
			rs.close();
			st.close();
			conn.close();
		}
		catch (SQLException e) {
			Basic.Logerr("loadDataRangePower error: "+e.getLocalizedMessage());
		}
		catch (Exception e) {
			Basic.Logerr("loadDataRangePower error: "+e.getLocalizedMessage()); 
		}
			
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
	}

	public String getDataRangePowerByName(int i, String name) {
		DataVector ad = (DataVector) DataRangePower.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	
	public int DataRangePowerSize() { 
		return DataRangePower.size(); 
	}
	
	public String getProcessingTime() { 
		return processingtime; 
	}
}

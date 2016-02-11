package ua.datapark.audit;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;
// import org.apache.commons.dbcp2.*;

import ua.datapark.commons.Basic;
import ua.datapark.db.DatabaseTon;

public class _Offline {
	String umg_id;
	DataSource ds = DatabaseTon.getInstance().getDataSource();
	AuditNSI au = AuditNSI.getInstance();
	String processingtime = "";
	
	ArrayList<DataVector> DataRangeOffline = new ArrayList<DataVector>();
	
	String query="";
	
	public _Offline() {
		umg_id = au.getAuditProps().umg_id;
	}

	public void loadDataRangeOffline(String point, String dat_start, String dat_end) throws SQLException {
		Connection conn = null;
		long stime = System.currentTimeMillis();

		try {
			conn = ds.getConnection();
			Statement st = conn.createStatement();
			//st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");

			// выборка событий отключени€
			query = "SELECT ks_id, o$point.point_id, to_char(dat,'dd-mm-yyyy') dd, event, " +
					"actualtime, description " +
					"FROM oblik_events, oblik_param, o$point " +
					"WHERE o$point.point_id=oblik_events.point_id "+
					"AND event=oblik_param.id " +
					"AND o$point.point_id='"+point+"' " +
					"AND to_char(dat,'yyyy-mm-dd')>='"+dat_start+"' "+
					"AND to_char(dat,'yyyy-mm-dd')<='"+dat_end+"' "+
					"ORDER BY dat desc";
			ResultSet rs = st.executeQuery(query);
			
			// первична€ инициализаци€ отключений
			DataRangeOffline.clear();
			// промежуточный список
			ArrayList<DataVector> bufferDataRangeOffline = new ArrayList<DataVector>();

			String last_dat="";

			while (rs.next()) {
				if (!last_dat.equals(rs.getString("dd"))) {
					for (int i=0; i<bufferDataRangeOffline.size(); i++) {
						DataVector dv = (DataVector) bufferDataRangeOffline.get(i);
						dv.num = bufferDataRangeOffline.size();
						DataRangeOffline.add(dv);
					}
					bufferDataRangeOffline.clear();
				}
				last_dat = rs.getString("dd");
				
				DataVector tempDataOffline = new DataVector();
				
				tempDataOffline.ks_id =  rs.getString("ks_id");
				tempDataOffline.point_id =  rs.getString("point_id");
				tempDataOffline.dat =  rs.getString("dd");
				tempDataOffline.h =  rs.getString("event");
				
				tempDataOffline.actualtime = rs.getString("actualtime");
				tempDataOffline.parameter_description = rs.getString("description");
				
				bufferDataRangeOffline.add(tempDataOffline);
			}

			for (int i=0; i<bufferDataRangeOffline.size(); i++) {
				DataVector dv = (DataVector) bufferDataRangeOffline.get(i);
				dv.num = bufferDataRangeOffline.size();
				DataRangeOffline.add(dv);
			}
			
			bufferDataRangeOffline.clear();
			bufferDataRangeOffline = null;
		
			rs.close();
			st.close();
			conn.close();
		} 
		catch (SQLException e) {
			Basic.Logerr("loadDataRangeOffline error: "+e.getLocalizedMessage());
		} 
		catch (Exception e) {
			Basic.Logerr("loadDataRangeOffline error: "+e.getLocalizedMessage());
		}	
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
	}

	public String getDataRangeOfflineByName(int i, String name) {
		DataVector ad = (DataVector) DataRangeOffline.get(i);
		String value = ad.getByName(name); 
		return value;
	}
	
	public int DataRangeOfflineSize() { 
		return DataRangeOffline.size(); 
	}
	
	public String getProcessingTime() { 
		return processingtime; 
	}
}

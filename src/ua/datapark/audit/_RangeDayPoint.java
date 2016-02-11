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

public class _RangeDayPoint {
	String umg_id;
	DataSource ds = DatabaseTon.getInstance().getDataSource();
	AuditNSI au = AuditNSI.getInstance();
	String processingtime = "";
	
	ArrayList<ArrayList<DataVector>> DataDayPoint = new ArrayList<ArrayList<DataVector>>();
	// ArrayList<DataVector> DataDayPoint = new ArrayList<DataVector>();
	
	ArrayList<DataVector> Ss = new ArrayList<DataVector>();
	ArrayList<?> Kss = new ArrayList<Object>();
	
	String query="";
	
	public _RangeDayPoint() {
		Kss = au.getKss();
		umg_id = au.getAuditProps().umg_id;	
	}

	public void loadDataZeroDayAll(String ks, String dat, String recalc) {
		Connection conn = null;
		long stime = System.currentTimeMillis();
    	
		ArrayList<?> Points = new ArrayList<Object>();
		for (int j=0; j<Kss.size(); j++) {
			Ks _ks = (Ks) Kss.get(j);
			if (_ks.ks_id == Integer.parseInt(ks)) Points = _ks.Points;
		}

    	try {
			conn = ds.getConnection();
			Statement st = conn.createStatement();
			// st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
			// расчет за день по всему объекту коды 1-48
			query = "SELECT ks_id, point_id, to_char(dat,'dd-mm-yyyy') dd, h, " +
					"fval, zval, " +
					"data_p_qua, data_p_gen, data_q_qua, data_q_gen, " +
					"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
					"notes, actualtime, description " +
					"FROM oblik, oblik_param " +
					"WHERE oblik_param.id=oblik.h "+
					"AND h<49" +
					"AND ks_id='"+ks+"' " +
					"AND zval<4 " +
					"AND to_char(dat,'yyyy-mm-dd')='"+dat+"' "+
					"ORDER BY h desc, point_id asc, zval asc";
			ResultSet rs = st.executeQuery(query);
	    	double fval = 1;
	    	Ss.clear();

		    while (rs.next()){
		    	DataVector dv = new DataVector();
				Ss.add(dv);
					
				dv.ks_id =  rs.getString("ks_id");
				dv.point_id =  rs.getString("point_id");
				dv.dat =  rs.getString("dd");
				dv.h =  rs.getString("h");
				dv.fval =  rs.getDouble("fval");
				fval = recalc.equals("on")?rs.getDouble("fval"):1;
				dv.zval =  rs.getInt("zval");

				dv.p_qua_0 = rs.getDouble("data_p_qua")*fval;
				dv.p_gen_0 = rs.getDouble("data_p_gen")*fval;
				dv.q_qua_0 = rs.getDouble("data_q_qua")*fval;
				dv.q_gen_0 = rs.getDouble("data_q_gen")*fval;
				
				dv.time_p_qua = rs.getString("time_p_qua");
				dv.time_p_gen = rs.getString("time_p_gen");
				dv.time_q_qua = rs.getString("time_q_qua");
				dv.time_q_gen = rs.getString("time_q_gen");
				
				dv.notes = rs.getString("notes");
				dv.actualtime = rs.getString("actualtime");
				dv.parameter_description = rs.getString("description");
			}
			rs.close();
		    st.close();
		    conn.close();
		}
    	catch (SQLException e) {
			Basic.Logerr("loadDataZeroDayAll error: "+e.getLocalizedMessage());
		}

    	DataDayPoint.clear();

//    	ArrayList tempDataDayPointSumArr = new ArrayList();
//    	DataDayPoint.add(tempDataDayPointSumArr);

    	String last_h = "";
    	ArrayList<DataVector> tempDataPoint = new ArrayList<DataVector>();
    	for (int i=0; i< Ss.size(); i++) {
			DataVector s = (DataVector) Ss.get(i); 
			if (!(s.h.equals(last_h))) { // new hour
				last_h = s.h;
				
				tempDataPoint = new ArrayList<DataVector>();

				DataVector zero = new DataVector();
				zero.ks_id = ks;
				zero.point_id = "0";
				zero.dat = s.dat;
				zero.h = s.h;
				tempDataPoint.add(zero);
				for (int j=0; j<Points.size(); j++) {
					Point point = (Point) Points.get(j);
					DataVector _dv = new DataVector();
					_dv.ks_id = String.valueOf(point.ks_id);
					_dv.point_id = String.valueOf(point.point_id);
					_dv.h = s.h;
					_dv.zval = s.zval;
					_dv.valid = false;
					tempDataPoint.add(_dv);
				}
				DataDayPoint.add(tempDataPoint);
			}

			if ( Integer.parseInt(s.point_id) == 0 ) tempDataPoint.set(0,s);
			for (int j=0; j<Points.size(); j++) {
				Point point = (Point) Points.get(j);
				if ( Integer.parseInt(s.point_id) == point.point_id ) tempDataPoint.set(j+1,s);
			}
    	}

    	
//		if (DataDayPoint.size()>1) {
//			ArrayList ar = (ArrayList) DataDayPoint.get(1) ; 
//			for (int i=0; i<ar.size(); i++) {
//				DataVector dv = new DataVector(); 
//				dv.h = "50";
//				tempDataDayPointSumArr.add(dv);
//			}
//			for (int i=1; i<DataDayPoint.size(); i++) {
//				ArrayList dd = (ArrayList) DataDayPoint.get(i);
//				for (int j=0; j<dd.size(); j++) {
//					DataVector dvsum = (DataVector) tempDataDayPointSumArr.get(j);
//					DataVector dv = (DataVector) dd.get(j);
//
//					dvsum.point = dv.point;
//					dvsum.ks = dv.ks;
//					dvsum.dat = dv.dat;
//					dvsum.fval = dv.fval;
//					//dvsum.h = dv.h;
//					
//					dvsum.p_qua_0 += dv.p_qua_0;
//					dvsum.p_qua_1 += dv.p_qua_1;
//					dvsum.p_qua_2 += dv.p_qua_2;
//					dvsum.p_qua_3 += dv.p_qua_3;
//
//					dvsum.p_gen_0 += dv.p_gen_0;
//					dvsum.p_gen_1 += dv.p_gen_1;
//					dvsum.p_gen_2 += dv.p_gen_2;
//					dvsum.p_gen_3 += dv.p_gen_3;
//
//					dvsum.q_qua_0 += dv.q_qua_0;
//					dvsum.q_qua_1 += dv.q_qua_1;
//					dvsum.q_qua_2 += dv.q_qua_2;
//					dvsum.q_qua_3 += dv.q_qua_3;
//
//					dvsum.q_gen_0 += dv.q_gen_0;
//					dvsum.q_gen_1 += dv.q_gen_1;
//					dvsum.q_gen_2 += dv.q_gen_2;
//					dvsum.q_gen_3 += dv.q_gen_3;
//				}
//			}
//		}
		processingtime = String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
	}
	
	public ArrayList<?> getDataDayPoint(int i) {
		ArrayList<?> tempDataDayPoint = (ArrayList<?>) DataDayPoint.get(i);
		return tempDataDayPoint;
	}
	public int DataDayPointSize() { 
		return DataDayPoint.size(); 
	}
	public String getProcessingTime() { 
		return processingtime; 
	}
}

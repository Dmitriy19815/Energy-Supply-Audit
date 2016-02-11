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

public class _RangePoint {
	String umg_id;
	DataSource ds = DatabaseTon.getInstance().getDataSource();
	AuditNSI au = AuditNSI.getInstance();
	String processingtime = "";
	
	ArrayList<ArrayList<DataVector>> DataRangePoint = new ArrayList<ArrayList<DataVector>>();
	ArrayList<DataVector> Ss = new ArrayList<DataVector>();
	ArrayList<?> Kss = new ArrayList<Object>();
	
	String query="";
	
	public _RangePoint() {
		umg_id = au.getAuditProps().umg_id; 
		Kss = au.getKss();
	}
	
	public void loadDataRangeZeroAll(String ks, String dat_start, String dat_end, String recalc) {
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
			//st.executeUpdate("alter session set NLS_NUMERIC_CHARACTERS = '.,'");
			//расчет за период по всему объекту код 49
			query = "SELECT ks_id, point_id, to_char(dat,'dd-mm-yyyy') dd, h, " +
					"fval, zval, " +
					"data_p_qua, data_p_gen, data_q_qua, data_q_gen, " +
					"time_p_qua, time_p_gen, time_q_qua, time_q_gen, " +
					"notes, actualtime, description " +
					"FROM oblik, oblik_param " +
					"WHERE oblik_param.id=oblik.h "+
					"AND h='49' " +
					"AND ks_id='"+ks+"' " +
					"AND zval<4 " +
					"AND to_char(dat,'yyyy-mm-dd')>='"+dat_start+"' "+
					"AND to_char(dat,'yyyy-mm-dd')<='"+dat_end+"' "+
					"ORDER BY dat desc, point_id asc, zval asc";
			ResultSet rs = st.executeQuery(query);
		    Ss.clear();
		    String last_point = "";
		    double fval = 1;
	
		    DataVector tempData = new DataVector();
		    DataVector tempDataSum = new DataVector();

		    while (rs.next()){
		    	if (!(rs.getString("point_id").equals(last_point))) { // new point
		    		last_point = rs.getString("point_id");
					tempData = new DataVector();
						
					tempData.ks_id =  rs.getString("ks_id");
					tempData.point_id =  rs.getString("point_id");
					tempData.dat =  rs.getString("dd");
					tempData.h =  rs.getString("h");
					tempData.fval =  rs.getDouble("fval");
					fval = recalc.equals("on")?rs.getDouble("fval"):1;
					tempData.zval =  rs.getInt("zval");
	
					tempDataSum = new DataVector();
				    tempDataSum.h = "50";
				    tempDataSum.point_id = rs.getString("point_id");

					Ss.add(tempData);
		    	} 
				if (rs.getInt("zval") == 0) {
					tempData.p_qua_0 = rs.getDouble("data_p_qua")*fval;
					tempData.p_gen_0 = rs.getDouble("data_p_gen")*fval;
					tempData.q_qua_0 = rs.getDouble("data_q_qua")*fval;
					tempData.q_gen_0 = rs.getDouble("data_q_gen")*fval;
				}
				if (rs.getInt("zval") == 1) {
					tempData.p_qua_1 = rs.getDouble("data_p_qua")*fval;
					tempData.p_gen_1 = rs.getDouble("data_p_gen")*fval;
					tempData.q_qua_1 = rs.getDouble("data_q_qua")*fval;
					tempData.q_gen_1 = rs.getDouble("data_q_gen")*fval;
				}
				if (rs.getInt("zval") == 2) {
					tempData.p_qua_2 = rs.getDouble("data_p_qua")*fval;
					tempData.p_gen_2 = rs.getDouble("data_p_gen")*fval;
					tempData.q_qua_2 = rs.getDouble("data_q_qua")*fval;
					tempData.q_gen_2 = rs.getDouble("data_q_gen")*fval;
				}
				if (rs.getInt("zval") == 3) {
					tempData.p_qua_3 = rs.getDouble("data_p_qua")*fval;
					tempData.p_gen_3 = rs.getDouble("data_p_gen")*fval;
					tempData.q_qua_3 = rs.getDouble("data_q_qua")*fval;
					tempData.q_gen_3 = rs.getDouble("data_q_gen")*fval;
				}		    		
			}
			rs.close();
		    st.close();
			conn.close();
		}
		catch (SQLException e) {
			Basic.Logerr("loadDataRangeZeroAll error: "+e.getLocalizedMessage());
		}

	    ArrayList<DataVector> tempDataPointSumArr = new ArrayList<DataVector>();
	    DataRangePoint.add(tempDataPointSumArr);

	    String last_dat = "";
	    ArrayList<DataVector> tempDataPoint = new ArrayList<DataVector>();
		for (int i=0; i< Ss.size(); i++) {
			DataVector s = (DataVector) Ss.get(i); 
			if (!(s.dat.equals(last_dat))) { // new dat
				last_dat = s.dat;
				
				tempDataPoint = new ArrayList<DataVector>();

				DataVector zero = new DataVector();
				zero.ks_id = ks;
				zero.point_id = "0";
				zero.dat = s.dat;
				tempDataPoint.add(zero);
				
				for (int j=0; j<Points.size(); j++) {
					Point point = (Point) Points.get(j);
					DataVector _dv = new DataVector();
					_dv.ks_id = ks;
					_dv.point_id = String.valueOf(point.point_id);
					_dv.valid = false;
					tempDataPoint.add(_dv);
				}

				DataRangePoint.add(tempDataPoint);
			}

			if ( Integer.parseInt(s.point_id) == 0 ) tempDataPoint.set(0,s);
			for (int j=0; j<Points.size(); j++) {
				Point point = (Point) Points.get(j);
				if ( Integer.parseInt(s.point_id) == point.point_id ) tempDataPoint.set(j+1,s);
			}
		}
		
		if (DataRangePoint.size()>1) {
			ArrayList<?> ar = (ArrayList<?>) DataRangePoint.get(1) ; 
			for (int i=0; i<ar.size(); i++) {
				DataVector dv = new DataVector(); 
				dv.h = "50";
				tempDataPointSumArr.add(dv);
			}
			for (int i=1; i<DataRangePoint.size(); i++) {
				ArrayList<?> dd = (ArrayList<?>) DataRangePoint.get(i);
				for (int j=0; j<dd.size(); j++) {
					DataVector dvsum = (DataVector) tempDataPointSumArr.get(j);
					DataVector dv = (DataVector) dd.get(j);
					dvsum.point_id = dv.point_id;
					dvsum.ks_id = dv.ks_id;
					dvsum.dat = dv.dat;
					dvsum.fval = dv.fval;
					//dvsum.h = dv.h;

					if (dv.valid) {
						dvsum.p_qua_0 += dv.p_qua_0;
						dvsum.p_qua_1 += dv.p_qua_1;
						dvsum.p_qua_2 += dv.p_qua_2;
						dvsum.p_qua_3 += dv.p_qua_3;
	
						dvsum.p_gen_0 += dv.p_gen_0;
						dvsum.p_gen_1 += dv.p_gen_1;
						dvsum.p_gen_2 += dv.p_gen_2;
						dvsum.p_gen_3 += dv.p_gen_3;
	
						dvsum.q_qua_0 += dv.q_qua_0;
						dvsum.q_qua_1 += dv.q_qua_1;
						dvsum.q_qua_2 += dv.q_qua_2;
						dvsum.q_qua_3 += dv.q_qua_3;
	
						dvsum.q_gen_0 += dv.q_gen_0;
						dvsum.q_gen_1 += dv.q_gen_1;
						dvsum.q_gen_2 += dv.q_gen_2;
						dvsum.q_gen_3 += dv.q_gen_3;
					}
				}
			}
		}
		processingtime=String.valueOf(Basic.formatNumber(10,1,3,3,((double)(System.currentTimeMillis()-stime)/1000)));
	}

	public ArrayList<?> getDataRangePoint(int i) {
		ArrayList<?> tempDataRangePoint = (ArrayList<?>) DataRangePoint.get(i);
		return tempDataRangePoint;
	}
	public int DataRangePointSize() { return DataRangePoint.size(); }

	public String getProcessingTime() { return processingtime; }
}

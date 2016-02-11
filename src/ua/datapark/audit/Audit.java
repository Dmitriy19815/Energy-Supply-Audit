package ua.datapark.audit;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;
// import org.apache.commons.dbcp.SQLNestedException;

import ua.datapark.commons.Basic;
import ua.datapark.db.DatabaseTon;


public class Audit {
	DataSource ds;
	AuditNSI au;
	private static String stmtCheckAccess = "select pw, pw_adm from oblik_status";
	
	public Audit() {
		ds = DatabaseTon.getInstance().getDataSource();
		au = AuditNSI.getInstance();
	}

	public String load() { 
		return au.load(); 
	}

	public String getPass(String pas) {
		String value = "wrong";
	
		try {
	 		Connection conn = ds.getConnection();
		    Statement st = conn.createStatement();    
		    ResultSet rs = st.executeQuery(stmtCheckAccess);
		    
			while (rs.next()) {
				if (pas!=null && pas.equals(rs.getString("pw"))) value = "user";
				if (pas!=null && pas.equals(rs.getString("pw_adm"))) value = "admin";
			}
		    rs.close();
		    st.close();
		    conn.close();
		} 
		catch (SQLException e) {
			Basic.Logerr("getPass error: "+e.getLocalizedMessage());
    		value = "SQL Exception";
		} 
		catch (Exception e) {
			Basic.Logerr("getPass error: "+e.getLocalizedMessage());
    		value = "Exception";
		}
 		return value;
	}
//    public String updatePoint(Point p) {
//    	Connection conn = null;
//    	String message = "_";
//	 	try {
//	 		conn = ds.getConnection();
//		    Statement st = conn.createStatement();    
//		    st.executeUpdate("UPDATE oblik_info " +
//		    		"SET loss_fixed_a='"+p.loss_fixed_a+"', " +
//		    		"loss_fixed_a_1='"+p.loss_fixed_a_1+"', "+
//		    		"loss_fixed_a_2='"+p.loss_fixed_a_2+"', "+
//		    		"loss_fixed_a_3='"+p.loss_fixed_a_3+"', "+
//		    		"loss_fixed_r='"+p.loss_fixed_r+"', "+
//		    		"loss_fixed_r_1='"+p.loss_fixed_r_1+"', "+
//		    		"loss_fixed_r_2='"+p.loss_fixed_r_2+"', "+
//		    		"loss_fixed_r_3='"+p.loss_fixed_r_3+"', "+
//		    		"loss_float_a='"+p.loss_float_a+"', "+
//		    		"loss_fixed_r='"+p.loss_fixed_r+"' "+
//		    		"loss_float_a='"+p.loss_float_a+"', "+
//		    		"loss_fixed_r='"+p.loss_fixed_r+"' "+
//		    		"loss_lep_a='"+p.loss_lep_a+"', "+
//		    		"loss_lep_r='"+p.loss_lep_r+"' "+
//		    		"WHERE point_id='"+p.point_id+"'");		 
//		    st.close();
//		    conn.close();
//		} catch (SQLNestedException e) {
//			Basic.Logerr("updatePoint error: "+e);
//		} catch (SQLException e) {
//			Basic.Logerr("updatePoint error: "+e);
//		}
// 		
// 		au.load();
//		return message;
//    }
//============================================================================================================	

// Umg
	public ArrayList<Object> getUmgs() { 
		return au.getUmgs(); 
	}
	public int UmgSize() { 
		return au.getUmgSize(); 
	}
	public String getUmgName() { 
		return au.getUmgName(); 
	}
	public String getUmgf(int i, int j) { 
		return au.getUmgf(i,j); 
	}

// Obl
	public ArrayList<Object> getObls() {
		return au.getObls(); 
	}
	public int OblSize() { 
		return au.getOblSize(); 
	}
	public String getOblf(int i, int j) { 
		return au.getOblf(i,j); 
	}
	
// Ks
	public ArrayList<Object> getKss() { 
		return au.getKss(); 
	}
	public ArrayList<Object> getKss(String ks) { 
		return au.getKss(); 
	}
	public int KsSize() { 
		return au.getKsSize(); 
	}
	public String getKsName(String ks) { 
		return au.getKsName(ks); 
	}
	public String getLpuName(String ks) { 
		return au.getLpuName(ks); 
	}
	public String getKSf(int i, int j) { 
		return au.getKSf(i,j); 
	}
	
// Point
	public ArrayList<Object> getPoints (String ks) {
		return au.getPoints(ks); 
	}
	public ArrayList<Object> getPoints (String ks, String obl) {
		return au.getPoints(ks, obl); 
	}
	public ArrayList<Object> getPoints() {
		return au.getPoints(); 
	}
	public int PointSize() {
		return au.getPointSize(); 
	}
	public String getPointName(String point)  { 
		return au.getPointName(point); 
	}
	public String getPointf(int i, int j) {
		return au.getPointf(i,j); 
	} 
}
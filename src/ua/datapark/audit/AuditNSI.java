package ua.datapark.audit;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Properties;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import ua.datapark.commons.ApplicationContextListener;
import ua.datapark.commons.Basic;
import ua.datapark.db.DatabaseTon;
import ua.datapark.audit.Point;

public class AuditNSI {
    private static AuditNSI _instance = new AuditNSI();
    
    public synchronized static AuditNSI getInstance() { 
    	return _instance; 
    }
    
	String umg_id;
	// конфиг-файл размещен в каталоге "%app-root-dir%/WEB-INF/conf/audit.properties"
	String AppConfigFile = "conf/audit.properties"; 
	String AppConfigPath = "WEB-INF";
	
	DataSource ds = DatabaseTon.getInstance().getDataSource();

	private ArrayList<Object> Umgs = new ArrayList<Object>();
	private ArrayList<Object> Kss = new ArrayList<Object>();  
	private ArrayList<Object> Points = new ArrayList<Object>();  
	private ArrayList<Object> Obls = new ArrayList<Object>();  

	// method-constructor
	public AuditNSI() {
		umg_id = getAuditProps().umg_id; 
		load();
	}

	public String load() {
		String value = "";
		try {
			Connection conn = ds.getConnection();
			Statement st = conn.createStatement();
			
			ResultSet rs = st.executeQuery("SELECT umg_id, umg_name FROM o$umg ORDER BY umg_name");

			Umgs.clear();
		    

			while (rs.next()) {
		    	Umgs.add(new Umg(rs.getInt("umg_id"),rs.getString("umg_name")));
		    }

		    rs = st.executeQuery("SELECT point_id, point_name, device_id, " +
		    			"ks_id, ks_name, " +
		    			"lpu_id, lpu_name, " +
		    			"umg_id, umg_name, " +
		    			"obl_id, obl_name " +
		    			"FROM o$point "+
		    			"WHERE umg_id='"+umg_id+"' " +
		    			"AND point_id<>0 " +
		    			"ORDER BY obl_id, ks_id, point_name");

		    Points.clear();

			while (rs.next()) {
				Points.add(new Point(rs.getInt("point_id"), rs.getString("point_name").replaceAll("'","`"),rs.getString("device_id"),
						rs.getInt("ks_id"), rs.getString("ks_name"),
						rs.getInt("lpu_id"), rs.getString("lpu_name"),
						rs.getInt("umg_id"), rs.getString("umg_name"),
						rs.getInt("obl_id"), rs.getString("obl_name") ));
			}
		    
			rs = st.executeQuery( "SELECT DISTINCT ks_id, ks_name, " +
					" lpu_id, lpu_name, "+
					" umg_id, umg_name " +
					" FROM o$ks " +
    				"WHERE umg_id='"+umg_id+"' " +
	    			"AND ks_id<>0 " +
    				"ORDER BY ks_name");
			
			Kss.clear();
			
			while (rs.next()){
				Kss.add(new Ks(rs.getInt("ks_id"),rs.getString("ks_name"),
							rs.getInt("lpu_id"),rs.getString("lpu_name"),
							rs.getInt("umg_id"),rs.getString("umg_name"), new ArrayList<Object>()) );
			}
	
		    rs = st.executeQuery( "SELECT obl_id, obl_name FROM o$obl "+
		    					  "ORDER BY obl_name");
		    Obls.clear();
		    
		    while (rs.next()) {		 	
		    	Obls.add(new Obl(rs.getInt("obl_id"),rs.getString("obl_name"), new ArrayList<Object>()) );
		    }
		    
		    rs.close();
			st.close();
			conn.close();
			
			for (int i=0; i<Kss.size(); i++) {
				Ks k = (Ks) Kss.get(i);
				
				for (int j=0; j<Points.size();j++) {
					Point p = (Point) Points.get(j);
					if (p.ks_id == k.ks_id) 
						k.Points.add(p);
				}
			}

			for (int i=0; i<Obls.size(); i++) {
				Obl o = (Obl) Obls.get(i);
				
				for (int j=0; j<Points.size();j++) {
					Point p = (Point) Points.get(j);
					if (o.Id == p.obl_id) 
						o.Points.add(p);
				}
			}
		} 
		catch (SQLException e) { 
			Basic.Logerr("AuditNSI load error: "+e.getLocalizedMessage());
			value = "SQL Exception";
		}
		catch (Exception e) { 
			Basic.Logerr("AuditNSI load error: "+e.getLocalizedMessage());
			value = "Exception";
		}
		return value;
	}
//= Umg ==========================================================================================================		
	public ArrayList<Object> getUmgs() { 
		return Umgs; 
	}
	public int getUmgSize() { 
		return Umgs.size(); 
	}
	public String getUmgName() {
		String umg_name = "none";
		for (int i=0; i<Umgs.size(); i++ ) {
			Umg _umg = (Umg) Umgs.get(i);
			if (_umg.Id == Integer.parseInt(umg_id)) 
				umg_name = _umg.Name;
		}
		return umg_name;
	}
	public String getUmgName(String umg_id) {
		String umg_name = "none";
		for (int i=0; i<Umgs.size(); i++ ) {
			Umg _umg = (Umg) Umgs.get(i);
			if (_umg.Id == Integer.parseInt(umg_id)) umg_name = _umg.Name;
		}
		return umg_name;
	}
	public String getUmgf(int i, int j) {
		Umg ad = (Umg) Umgs.get(i);
		String value = ad.getStri(j);
		return (value==null) ? "" : value.trim();
	}
	
//= Obl ==========================================================================================================
	public ArrayList<Object> getObls() { 
		return Obls; 
	}
	public int getOblSize() { 
		return Obls.size(); 
	}
	public String getOblf(int i, int j) {
		Obl ad = (Obl) Obls.get(i);
		String value = ad.getStri(j);
		return (value==null) ? "" : value.trim();
	}
	
//= Ks ===========================================================================================================
	public ArrayList<Object> getKss() { 
		return Kss; 
	}
	public int getKsSize() { 
		return Kss.size(); 
	}
	public String getKsName(String ks) {
		String ks_name = "none";
		
		for (int i=0; i<Kss.size(); i++ ) {
			Ks _ks = (Ks) Kss.get(i);
			if (_ks.ks_id == Integer.parseInt(ks)) 
				ks_name = _ks.ks_name;
		}
		return ks_name;
	}
	public String getLpuName(String ks) {
		String lpu_name = "none";
		
		for (int i=0; i<Kss.size(); i++ ) {
			Ks _ks = (Ks) Kss.get(i);
			if (_ks.ks_id == Integer.parseInt(ks)) 
				lpu_name = _ks.lpu_name;
		}
		return lpu_name;
	}
	public String getKSf(int i, int j) {
		Ks ad = (Ks) Kss.get(i);
		String value = ad.getStri(j);
		return (value==null) ? "" : value.trim();
	}
//= Point ========================================================================================================
	public ArrayList<Object> getPoints() { 
		return Points; 
	}
	
	public ArrayList<Object> getPoints(String ks) {
		ArrayList<Object> points = new ArrayList<Object>();
		
		for (int i=0; i < Kss.size(); i++ ) {
			Ks _ks = (Ks) Kss.get(i);
			if (_ks.ks_id == Integer.parseInt(ks)) {
				points = _ks.Points;
			}
		}
		return points;
	}

	public ArrayList<Object> getPoints(String ks, String obl) {
		ArrayList<Object> points = new ArrayList<Object>();
		
		for (int i=0; i<Points.size(); i++ ) {
			Point p = (Point) Points.get(i);
			if (p.ks_id == Integer.parseInt(ks) && p.obl_id == Integer.parseInt(obl)) {
				points.add(p);
			}
		}
		return points;
	}

	public int getPointSize() { 
		return Points.size(); 
	}
	
	public String getPointName(String point) {
		String point_name = "none";
		
		if (point.equals("0")) point_name = "Власне споживання";
		else 
			for (int i=0; i<Points.size(); i++ ) {
				Point _point = (Point) Points.get(i);
				if (_point.point_id == Integer.parseInt(point)) 
					point_name = _point.point_name;
			}
		return point_name;
	}
	
	public String getPointf(int i, int j) {
		Point ad = (Point) Points.get(i);
		String value = ad.getStri(j);
		return (value == null) ? "" : value.trim();
	}
	
	public AuditProps getAuditProps() {
		InputStream configStream;
		
		Properties props = new Properties();
		AuditProps conf = new AuditProps();
		
		try {
			// читаем конфиг-файл web-приложения, достаточно указать ../conf/audit.properties 
			configStream = getClass().getClassLoader().getResourceAsStream("../"+AppConfigFile);
			if (configStream != null) {
				props.load(configStream);
			} else {
				throw new FileNotFoundException("\nProperty file '"+"../"+AppConfigFile+"' not found in the classpath");
			}

			Enumeration<?> eConf = props.propertyNames();
			while (eConf.hasMoreElements()) {
				String key = (String) eConf.nextElement();
				String value = props.getProperty(key);
				Basic.Log("["+eConf.toString()+"] property Key: '"+key+"', property Value: '"+value+"'");
			}			
			conf.umg_id=props.getProperty("umg_id","");
		} 
		catch (IOException e) {
			Basic.Logerr("properties config file read exception: "+e.getLocalizedMessage());
		} 
		catch (Exception e) {
			Basic.Logerr("properties config file read exception: "+e.getLocalizedMessage());
		}
		return conf;
	}

	public void storeAuditProps(AuditProps conf, String header) throws Exception {
    	OutputStream configStream = null;
    	
		Properties props = new Properties();
		props.put("umg_id", conf.umg_id);
		
		try {
			// Basic.Log(((String) new ApplicationContextListener().getContextPath()) + AppConfigPath+"/"+AppConfigFile);
			configStream = new FileOutputStream(((String) new ApplicationContextListener().getContextPath()) + AppConfigPath+"/"+AppConfigFile);			
			
			props.store(configStream, header);
			configStream.close();			
		} 
		catch (IOException e) { 
			Basic.Logerr("app config file store exception: "+e.getLocalizedMessage());
		} 
		catch (Exception e) { 
			Basic.Logerr("app config file store exception: "+e.getLocalizedMessage());
		}
		configStream = null;
		props.clear();
		props = null;
    }
}

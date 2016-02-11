package ua.datapark.db;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.Locale;
import java.util.TimeZone;
import java.util.Properties;

import java.sql.*;
import javax.sql.DataSource;

import org.apache.commons.pool2.ObjectPool;
import org.apache.commons.pool2.impl.GenericObjectPool;
import org.apache.commons.dbcp2.ConnectionFactory;
import org.apache.commons.dbcp2.PoolableConnection;
import org.apache.commons.dbcp2.PoolingDataSource;
import org.apache.commons.dbcp2.PoolableConnectionFactory;
import org.apache.commons.dbcp2.DriverManagerConnectionFactory;

import ua.datapark.commons.*;

public class DatabaseTon {
    private static DatabaseTon _instance = new DatabaseTon();
    
	String validationQuery = "select to_char(sysdate, 'Dy, dd-Mon-yyyy, hh24:mi:ss') host_datetime from dual";
	String dbConnOK = "Connection established successfully";	
	// конфиг-файл будет размещен в каталоге "%app-root-dir%/WEB-INF/conf/db.properties"
	String dbConfigFile = "conf/db.properties";
	String dbConfigPath = "WEB-INF";
    
//  ConnectionFactory connectionFactory = null; 
//  PoolableConnectionFactory poolableConnectionFactory = null; 
    ObjectPool<PoolableConnection> connectionPool = null;
    PoolingDataSource<PoolableConnection> dataSource = null;
  
  // PoolingDataSource dataSource; //    = null;
	// GenericObjectPool connectionPool;
  // PoolableConnectionFactory poolableConnectionFactory;

    public synchronized static DatabaseTon getInstance() { 
    	return _instance; 
    }
    
	private DatabaseTon() {
   		DatabaseProps db = getDatabaseProps();
		String connURI = "jdbc:oracle:thin:@"+db.ipport+":"+db.sid;
		// Driver driver = null;
		
		try {
			Locale.setDefault(Basic.defaultLocale);
	    	// TimeZone t_zone = TimeZone.getTimeZone(Basic.gefaultTimeZone); 
	        	TimeZone.setDefault(TimeZone.getTimeZone(Basic.gefaultTimeZone));
/*
	        Enumeration<Driver> drivers = DriverManager.getDrivers();
	        if (drivers.hasMoreElements()) {
	        	while (drivers.hasMoreElements()) {
	  	          driver = drivers.nextElement();
	  	          
	  	          try {
	  	        	  System.out.println("Exist driver: "+driver);
	  	          } 
	  	          catch (Exception e) {
	  	        	  Basic.Logerr("Error by driver info "+e.getLocalizedMessage());
	  	          }
	  	        }
	        }
	        else {
	        	driver = new oracle.jdbc.driver.OracleDriver();
	        	System.out.println("Registered driver: "+driver);
	        }
	        DriverManager.registerDriver(driver);
*/
	        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
	        
//	        connectionPool = new GenericObjectPool(null);
//			connectionPool.setWhenExhaustedAction(GenericObjectPool.WHEN_EXHAUSTED_BLOCK);
/*			
			if (db.behavior.equals("WHEN_EXHAUSTED_FAIL")) 
				connectionPool.setWhenExhaustedAction(GenericObjectPool.WHEN_EXHAUSTED_FAIL);
			if (db.behavior.equals("WHEN_EXHAUSTED_GROW")) 
				connectionPool.setWhenExhaustedAction(GenericObjectPool.WHEN_EXHAUSTED_GROW);
			
			connectionPool.setMaxActive(Integer.parseInt(db.maxactive));
			connectionPool.setMaxIdle(Integer.parseInt(db.maxidle));
			connectionPool.setMaxWait(Integer.parseInt(db.maxwait));
*/			
			ConnectionFactory connectionFactory = new DriverManagerConnectionFactory(connURI, db.user, db.password);
			
			PoolableConnectionFactory poolableConnectionFactory = new PoolableConnectionFactory(connectionFactory, null);
			poolableConnectionFactory.setDefaultAutoCommit(true);
			poolableConnectionFactory.setDefaultQueryTimeout(db.maxactive);
			poolableConnectionFactory.setValidationQuery(db.query); // validationQuery
			poolableConnectionFactory.setValidationQueryTimeout(db.maxidle);
						
			connectionPool = new GenericObjectPool<>(poolableConnectionFactory);
			
//			poolableConnectionFactory = new PoolableConnectionFactory(connectionFactory,connectionPool,null,db.query,false,true);
//			dataSource = new PoolingDataSource(connectionPool);
			
			poolableConnectionFactory.setPool(connectionPool); // Set the factory's pool property to the owning pool
			dataSource = new PoolingDataSource<>(connectionPool);
	        
		} 
		catch (SQLException e) { 
			Basic.Logerr("Driver error: "+e.getLocalizedMessage());
		}
		catch (Exception e) { 
			Basic.Logerr("Pool or DataSource creating error: "+e.getLocalizedMessage());
		}
		db = null; // ? It's working
    }

    public DataSource getDataSource() { 
    	return dataSource; 
    }
    public int getNumActive() { 
    	return connectionPool.getNumActive(); 
    }
    public int getMaxActive() { 
    	return -1; // connectionPool.getMaxActive(); 
    }
    public int getNumIdle() { 
    	return connectionPool.getNumIdle(); 
    }
    public int getMaxIdle() { 
    	return -1; // connectionPool.getMaxIdle(); 
    }
    public long getMaxWait() { 
    	return -1; // connectionPool.getMaxWait(); 
    }
    
    public String getBehavior() { 
    	String value = "WHEN_EXHAUSTED_GROW"; // that value more is unused
/*    	
    	switch (connectionPool.getWhenExhaustedAction()) {
    		case GenericObjectPool.WHEN_EXHAUSTED_FAIL : value = "WHEN_EXHAUSTED_FAIL"; break;
    		case GenericObjectPool.WHEN_EXHAUSTED_GROW : value = "WHEN_EXHAUSTED_GROW"; break;
    		case GenericObjectPool.WHEN_EXHAUSTED_BLOCK : value = "WHEN_EXHAUSTED_BLOCK"; 
    	}
*/    	
    return value;
    }
    
    public String testConn() {
    	String value = "";
    	Connection conn; 
    	try {    	
    		conn = dataSource.getConnection();
    		if (conn.isValid(5)) {
    			value = dbConnOK;
    		}
    		conn.close();
    	} 
    	catch (SQLException e) {
    		value = e.getLocalizedMessage();
    	}
    	catch (Exception e) {
    		value = e.getLocalizedMessage();
    	}
		conn = null;    	
/*    	
    	try {
    		Connection conn = dataSource.getConnection();
        	Statement st = conn.createStatement();
        	ResultSet rs = st.executeQuery(validationQuery);
        	
        	while (rs.next()) { 
        		if (rs.getString(1).equals("X")) value = "ok"; 
        	}
    	    rs.close();
    	    st.close();
        	conn.close();
    	} 
    	catch (SQLException e) {
    		value = e.getLocalizedMessage();
    	}
    	catch (Exception e) {
    		value = e.getLocalizedMessage();
    	}
*/    	
    	return value;
    }
    
    public DatabaseProps getDatabaseProps() {
        DatabaseProps db = new DatabaseProps();
        
        InputStream configStream;
        Properties props = new Properties();
		try {
			// читаем конфиг-файл web-приложения из каталога ../conf/db.properties
			configStream = getClass().getClassLoader().getResourceAsStream("../"+dbConfigFile);
			if (configStream != null) {
				props.load(configStream);
			} else {
				throw new FileNotFoundException("\nProperty file '"+"../"+dbConfigFile+"' not found in the classpath");
			}

			Enumeration<?> eConf = props.propertyNames();
			while (eConf.hasMoreElements()) {
				String key = (String) eConf.nextElement();
				String value = props.getProperty(key);
				Basic.Log("["+eConf.toString()+"] property Key: '"+key+"', property Value: '"+value+"'");
			}
			
			db.ipport = props.getProperty("ipport","");
			db.sid = props.getProperty("sid","");
			db.user = props.getProperty("user","");
			db.password = props.getProperty("password","");
			db.maxactive = Integer.valueOf(props.getProperty("maxactive", "0"));
			db.maxidle = Integer.valueOf(props.getProperty("maxidle", "0"));
			db.maxwait = Integer.valueOf(props.getProperty("maxwait","0"));
			db.behavior = props.getProperty("behavior","");
			db.query = props.getProperty("query", validationQuery);
		}
		catch (IOException e) {
			Basic.Logerr("database config file read exception: "+e.getLocalizedMessage());
		} 
		catch (Exception e) {
			Basic.Logerr("database config file exception: "+e.getLocalizedMessage());
		}
		props.clear();
		props = null;
	
		return db;
    }
    
    public void storeDatabaseProps(DatabaseProps db, String header) {
    	OutputStream configStream = null;
    	Properties props = new Properties();
		
		props.put("ipport", db.ipport);
		props.put("sid", db.sid);
		props.put("user", db.user);
		props.put("password", db.password);
		props.put("maxactive", db.maxactive);
		props.put("maxidle", db.maxidle);
		props.put("maxwait", db.maxwait);
		props.put("behavior",db.behavior);
		props.put("query",db.query);


		try {
			// Basic.Log(((String) new ApplicationContextListener().getContextPath()) + dbConfigPath+"/"+dbConfigFile);
			configStream = new FileOutputStream(((String) new ApplicationContextListener().getContextPath()) + dbConfigPath+"/"+dbConfigFile);
			
			props.store(configStream, header);
			configStream.close();
		} 
		catch (IOException e) { 
			Basic.Logerr("database config file save exception: "+e.getLocalizedMessage());
		} 
		catch (Exception e) {
			Basic.Logerr("database config file exception: "+e.getLocalizedMessage());
		}
		configStream = null;
		
		props.clear();
		props = null;
    }
}

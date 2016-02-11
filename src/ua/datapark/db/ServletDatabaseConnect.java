package ua.datapark.db;

import java.io.*;
import java.util.Locale;
import java.util.TimeZone;
import java.sql.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// import javax.servlet.FilterChain;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
// import javax.servlet.ServletRequest;
// import javax.servlet.ServletResponse;
import javax.sql.PooledConnection;
import oracle.jdbc.pool.*;

public class ServletDatabaseConnect extends HttpServlet  
{
    private static final long serialVersionUID = 1L;
    // static FilterChain fch = null;
    
	// static String url = "jdbc:oracle:thin:@a-x550cc-xx127d:1521:xe";
	static String url = "jdbc:oracle:thin:@10.101.0.10:1521:iasu";
	// static String url = "jdbc:oracle:thin:@10.3.1.8:1521:ltg";
    static String username = "ertcs"; // "scott";
    static String password = "scada"; // "tiger";
    
    private static PooledConnection pconn = null;

    protected static PooledConnection getOracleConnection(OracleConnectionPoolDataSource ocpds) 
    		throws SQLException {
        // Set  parameters of OracleConnectionPoolDataSource instance
        ocpds.setURL(url);
        ocpds.setUser(username);
        ocpds.setPassword(password);
        
        Locale.setDefault(Locale.ENGLISH);
    	TimeZone t_zone = TimeZone.getTimeZone("GMT+2:00");
        TimeZone.setDefault(t_zone);
        
        // Create a physical connection by OracleConnectionPoolDataSource instance
        PooledConnection poolconn  = ocpds.getPooledConnection();
       	return poolconn;
    } 
/*    
    public static Connection getOracleConnection() throws Exception {
        // String driver = "oracle.jdbc.driver.OracleDriver";
        // String url = "jdbc:oracle:thin:@a-x550cc-xx127d:1521:xe";
        // String url = "jdbc:oracle:thin:@10.3.1.8:1521:ltg";        
    	// String url = "jdbc:oracle:thin:@10.101.0.10:1521:iasu";

    	Locale.setDefault(Locale.ENGLISH);
    	TimeZone t_zone = TimeZone.getTimeZone("GMT+2:00");
        TimeZone.setDefault(t_zone);
    	
        // Create an OracleDataSource instance and set properties
        OracleDataSource ods = new OracleDataSource();
        ods.setURL(url);
        ods.setUser(username);
        ods.setPassword(password);
        
        Connection conn = ods.getConnection();
        conn.setAutoCommit(false);
        return conn;
    }
*/    
	public void init() throws ServletException {
		@SuppressWarnings("unused")
		ServletConfig config = getServletConfig();
		
		System.out.print("\nServlet init() now called !\n");
		
		try {
			// Created only once, at the first time  
			if (pconn == null)
				pconn = getOracleConnection(new OracleConnectionPoolDataSource());
			// con = getOracleConnection();
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.print(e.getLocalizedMessage()); 
		}
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		// String chenc_req = null, chenc_res = null;
		
		String tb = req.getParameter("table");

		// res.setCharacterEncoding("UTF-8"); 
		res.setContentType("text/html"); // 
		// System.out.println("\n\tRequest CharacterEncoding is "+req.getCharacterEncoding()+", Response CharacterEncoding is "+res.getCharacterEncoding()+"\n");

		PrintWriter out = res.getWriter();
		
		try
		{
			 // con = getOracleConnection();
			 conn = pconn.getConnection(); // Get a Logical connection
			 st = conn.createStatement();
			 // System.out.println("\nConnection established successfully...");	 
			 
			 rs = st.executeQuery("select * from "+tb);
			 out.println("<head>"+tb+"</head>");
			 
			 out.println("<table border=1>");
				 while(rs.next())
				 {
					 out.println("<tr><td> "+rs.getRow()+" </td><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td></tr>");
					 out.flush();
				 }
			 out.println("</table>");
			 out.flush();
			 
			 if (rs != null) rs.close();
		}	 
		catch (Exception e) {
			e.printStackTrace();
			out.println(e.getLocalizedMessage());			
			System.out.print(e.getLocalizedMessage()); 
		}
		
		finally {
			// System.out.println("\nClosing the connection and release the resources used...");			
			try {
				if (st != null) st.close();
				st = null;
			} catch (SQLException e) {
				e.printStackTrace();
				out.println(e.getLocalizedMessage());
			}
			try {
				if (conn != null) conn.close();
				conn = null;
			} catch (SQLException e) {
				e.printStackTrace();
				out.println(e.getLocalizedMessage());				
			}
			
			out.flush();
			out.close();			
		}
	}	

	public void destroy() {
		System.out.print("\nServlet destroy() now called !\n");
		try {
			if (pconn != null) pconn.close();
			pconn = null;
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
    }
       	
}

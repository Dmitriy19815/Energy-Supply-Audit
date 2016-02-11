package ua.datapark.commons;

// import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletRequestEvent;
// import javax.servlet.ServletRequestListener;
import javax.servlet.annotation.WebListener;

/**
 * Application Lifecycle Listener implementation class ApplicationContextListener
 *
 */
@WebListener
public class ApplicationContextListener implements ServletContextListener {
	private static String contextPath = ""; // null;
    
    // Default constructor 
    public ApplicationContextListener() {

    }

    public void contextInitialized(ServletRequestEvent event)  {
        // TODO Auto-generated method stub
        // System.out.println(new Date()+", void ApplicationContextListener@contextInitialized called");
     }
    public void contextDestroyed(ServletContextEvent event)  { 
         // TODO Auto-generated method stub
        // System.out.println(new Date()+", void ApplicationContextListener@contextDestroyed called");
    }

	@Override
	public void contextInitialized(ServletContextEvent event) {
        ServletContext servletContext = event.getServletContext();
        contextPath = servletContext.getRealPath("/");
        // System.out.println(new Date()+", %contextpath% = '"+contextPath+"'");
	}
	
	public String getContextPath() { 
    	return contextPath; 
    }
}
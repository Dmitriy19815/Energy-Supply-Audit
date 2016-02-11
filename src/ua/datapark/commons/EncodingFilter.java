package ua.datapark.commons;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * Changes the encoding of the request, in order to help the application server 
 * to correctly interpret request parameters into UTF-8
 */
public class EncodingFilter implements Filter {
    // Tomcat uses ISO-8859-1 as the default character encoding for URL parameters, 
	// regardless of the encoding of the page that contains the URL
	private static String encodingByDefault = "ISO-8859-1";
	private String encodingOfRequest = encodingByDefault;
	private String encodingOfResponese = encodingByDefault;	
		
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) 
 		throws IOException, ServletException {
        request.setCharacterEncoding(encodingOfRequest); // encoding
        response.setCharacterEncoding(encodingOfResponese); // encoding
        // System.out.println(request.getServletContext().getContextPath());
        // System.out.println(response.getClass().getClassLoader().toString());
        filterChain.doFilter(request, response);
    }
    
    public void init(FilterConfig filterConfig) throws ServletException {
    	if (filterConfig.getInitParameter("request-encoding") != null) {
        	encodingOfRequest = filterConfig.getInitParameter("request-encoding");
        }
        if (filterConfig.getInitParameter("response-encoding") != null) {
        	encodingOfResponese = filterConfig.getInitParameter("response-encoding");
        }
    }
    
    public void destroy() {
        // dummy, nothing to do
    }
}
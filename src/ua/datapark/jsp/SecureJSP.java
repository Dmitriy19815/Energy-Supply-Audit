package ua.datapark.jsp;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.jsp.HttpJspPage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public abstract class SecureJSP extends HttpServlet implements HttpJspPage {
	static final long serialVersionUID = 0x2;
	
	public void init() throws ServletException { 
		jspInit(); 
	}

	public void destroy() {	
		jspDestroy(); 
	}
	
	public void jspDestroy() { 
		// ? nothing to do
	}
	
	public void jspInit() { 
		// ? nothing to do	
	}

	public void service(HttpServletRequest request,	HttpServletResponse response) 
	throws IOException, ServletException {
		boolean isAuthorized = false;
		HttpSession session = request.getSession(false);
		
		if (session != null) {
			if (session.getAttribute("authorized") != null) 
				isAuthorized = true;
			//session.setAttribute("ref",request.getRequestURI()+(request.getQueryString()!=null ? "?"+request.getQueryString() : ""));
		}

		if (!isAuthorized) {
			String ref = request.getRequestURI() + ((request.getQueryString() != null) ? 
					"?" + request.getQueryString() : "");
			request.setAttribute("ref", ref);

			forward("/logon.jsp", request, response);
			return;
		}
		_jspService(request, response);
	}

	private void forward(String page, HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(page);
		dispatcher.forward(request, response);
	}
}

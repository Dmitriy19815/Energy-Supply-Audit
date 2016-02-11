<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page language="java" contentType="text/html" %> // pageEncoding="Windows-1251"
<% 	session.setAttribute("authorized",null); %>
<%	String password= request.getParameter("password"); 

	String message = request.getHeader("mess");
	if (message==null) message = request.getHeader("mess")!=null?request.getHeader("mess"):"";

	String ref = (String) request.getAttribute("ref");
	if (ref==null) ref = request.getParameter("ref");

	String mode = "";
	if (password != null) mode = c.getPass(password);

if (mode.equals("user") || mode.equals("admin")) {
	session = request.getSession(true); 
	session.setAttribute("authorized", "true");
	session.setMaxInactiveInterval(600);	// время действия сессии

	if (mode.equals("user")) session.setAttribute("mode", "user");
	if (mode.equals("admin")) session.setAttribute("mode", "admin");
	
	if (ref!=null && !ref.equals("null")) {
		response.sendRedirect(ref);
	} else {
		response.sendRedirect("index.jsp");
	}
	return;
} else if (mode.equals("SQL Exception")) message = "Виникла помилка підключення до БД"; 
else if (mode.equals("wrong")) message = "Невірний пароль"; { %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html">
	<title>Енергоаудит 5.4</title>
	<link rel="stylesheet" href="style.css" type="text/css" >
	<link rel="icon" href="images/audit.ico" type="image/x-icon" />
	<meta http-equiv="Pragma" content="no-cache">
	<script type="text/javascript">
		function cutloading() {
			if (parent.menu) {
				if (parent.complete) parent.menu.complete();
			}
		}
	</script>
</head>
<body onload="cutloading();">
<table width="95%" height="100%" align="center">
<tr>
	<td valign="middle" align="center">
		<form action="logon.jsp" method="post">

		<span style="font-size: 1.83em" align="center" > Енергоаудит 5.4 </span>
		<br><br><br>
		<table width="300" height="50" align="center">
		<tr><td style="font-weight:bold" align="center" bgcolor="#FFA500">пароль: &nbsp;
			<input type="password" name="password" value="pw"  />&nbsp;
			<input type="submit" name="butt" style="font-weight:bold" value="вхід"/></td></tr>
		</table>
		<span align="center"> </span>
		<div style="padding: 10px; color: red; text-align: center"><b><%= message %></b></div>
		<% if (ref!=null && !ref.equals("null")) { %>
			<input type="hidden" name="ref" value="<%= ref %>" />
		<% } %>
		</form>
	</td>
</tr>
</table>
</body>
</html>
<% } %>
<%@ page import="ua.datapark.commons.Basic" %>
<%@ page import="ua.datapark.db.DatabaseTon" %>
<%@ page import="ua.datapark.db.DatabaseProps" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%	 
	DatabaseTon dbt = DatabaseTon.getInstance();
	DatabaseProps db = dbt.getDatabaseProps();

	String message = request.getParameter("message");
	String store = request.getParameter("store");
	if (store != null) {
		DatabaseProps dbin = new DatabaseProps();
		
		dbin.ipport = (request.getParameter("ipport") != null) ? request.getParameter("ipport") : "";
		dbin.sid = (request.getParameter("sid") != null) ? request.getParameter("sid") : "";
		dbin.user = (request.getParameter("user") !=null) ? request.getParameter("user") : "";
		dbin.password = (request.getParameter("password") != null) ? request.getParameter("password") : "";
		dbin.maxactive = (request.getParameter("maxactive") != null) ? Integer.valueOf(request.getParameter("maxactive")) : 0;
		dbin.maxidle = (request.getParameter("maxidle") != null) ? Integer.valueOf(request.getParameter("maxidle")) : 0;
		dbin.behavior = (request.getParameter("behavior") != null) ? request.getParameter("behavior") : "";
		dbin.maxwait = (request.getParameter("maxwait") != null) ? Integer.valueOf(request.getParameter("maxwait")) : 0;
		dbin.query = (request.getParameter("query") !=null) ? request.getParameter("query") : "";
		
		dbt.storeDatabaseProps(dbin, null);
		
		response.sendRedirect("dbconfig.jsp");
		return;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Конфігурація пула з'єднань з БД - Енергоаудит 5.4</title>
	<link rel="icon" href="images/audit.ico" type="image/x-icon" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<style type="text/css">
		body {
			font: normal 0.8em Verdana;
			padding: 10px
		}
		table {
			font: normal 0.9em Verdana;
			border-top: 1px solid #AAAAAA;
			border-right: 1px solid #AAAAAA;
		}
		td {
			border-left : 1px solid #AAAAAA;
			border-bottom : 1px solid #AAAAAA;
		}
		.wh {
			font-weight: bold;
			text-align: right;
			vertical-align: middle;
			padding: 5px;
		}
		.gr {
			vertical-align: middle;
			background: #DDDDDD;
			padding: 5px;
		}
		.bt {
			text-align: right;
			vertical-align: middle;
			background: #DDDDDD;
			padding: 5px;
		}	
		.ie {
			font: normal 0.65em Verdana;
			color: #555555;
		}	
		.mess {
			font-weight: bold;
			color: #FF0000;
			border: 1px solid #AAAAAA;
		}	
	</style>
	<script type="text/javascript">
		function yesno() {
			if (confirm('Ви впевнені, що бажаєте зберегти нові параметри?\n\n (примітка: конфігурацію буде оновлено через декілька секунд...)')) {
				mform.submit();				
			} 
		}
	</script>
</head>
<body>
Конфігурація пула з'єднань з БД (<a href="dbstatus.jsp")>статус</a>)<br><br>
<form name="mform" method="post" action="dbconfig.jsp">
<table cellspacing="0" cellpadding="0">
	<tr><td class="wh">ip:port<br><span class="ie">наприклад, 192.168.1.1:1521</span></td>
		<td class="gr"><input name="ipport" value="<%= db.ipport %>"></td></tr>
	<tr><td class="wh">sid<br><span class="ie">наприклад, IASU</span></td>
		<td class="gr"><input name="sid" value="<%= db.sid %>" /></td></tr>
	<tr><td class="wh">user</td>
		<td class="gr"><input name="user" value="<%= db.user %>" /></td></tr>
	<tr><td class="wh">password</td>
		<td class="gr"><input type="password" name="password" value="<%= db.password %>" /></td></tr>
	<tr><td class="wh">max active (шт)<br><span class="ie">наприклад, 4</span></td>
		<td class="gr"><input name="maxactive" value="<%= db.maxactive %>" /></td></tr>
	<tr><td class="wh">max idle (шт)<br><span class="ie">наприклад, 2</span></td>
		<td class="gr"><input name="maxidle" value="<%= db.maxidle %>" /></td></tr>
	<tr><td class="wh">WHEN_EXHAUSTED pool behavior</td>
		<td class="gr"><select name="behavior">
							<option <% if (db.behavior.equals("WHEN_EXHAUSTED_BLOCK")) {%>selected<%} %> value="WHEN_EXHAUSTED_BLOCK">BLOCK</option>
							<option <% if (db.behavior.equals("WHEN_EXHAUSTED_GROW")) {%>selected<%} %> value="WHEN_EXHAUSTED_GROW">GROW</option>
							<option <% if (db.behavior.equals("WHEN_EXHAUSTED_FAIL")) {%>selected<%} %> value="WHEN_EXHAUSTED_FAIL">FAIL</option>
						</select>
		</td></tr>
	<tr><td class="wh">max wait, mc<br><span class="ie">наприклад, 5000</span></td>
		<td class="gr"><input name="maxwait" value="<%= db.maxwait %>" /></td></tr>
	<tr><td class="wh">validation query<br><span class="ie">наприклад, select * from dual</span></td>
		<td class="gr"><input name="query" value="<%= db.query %>" /></td></tr>
	<tr><td class="bt" colspan="2"><input type="button" onclick="yesno();" value=" зберегти " /></td></tr></table>
	<input type="hidden" name="store" value="yes">
</form>
</body>
</html>

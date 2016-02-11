<%@ page import="ua.datapark.commons.Basic" %>
<%@ page extends="ua.datapark.jsp.SecureJSP"%>
<%@ page import="ua.datapark.db.DatabaseTon" %>
<%@ page import="ua.datapark.db.DatabaseProps" %>
<jsp:useBean id="dd" scope="page" class="ua.datapark.audit._Dogovor"/>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit.AuditNSI"/>
<%@ page import="ua.datapark.audit.Dogovor" %>
<%@ page import="ua.datapark.audit.Ks" %>
<%@ page import="ua.datapark.audit.DogovorLoss" %>
<%@ page import="java.util.*;" %>
<%@ page language="java" contentType="text/html; charset=Windows-1251" pageEncoding="Windows-1251"%>

<%	 
	String mode = (String) session.getAttribute("mode");
	if ((mode!=null) && (mode.equals("admin"))) {
		
	} else response.sendRedirect("logon.jsp");

	String message = request.getParameter("message");
	String store = request.getParameter("store");
	int  dogov_id = Integer.parseInt(request.getParameter("dogov_id"));

	dd.loadDogovor(dogov_id);
	Dogovor d_in = dd.getDogovor();	
%>
<DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Договір - Енергоаудит 5.4</title>
	<link rel="icon" href="images/audit.ico" type="image/x-icon" />
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
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
			padding: 5px;
		}
		.wh {
			font-weight: bold;
			text-align: right;
			vertical-align: middle;
			padding: 5px;
		}
		.gr {
			vertical-align: middle;
			text-align: center;
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
<form name="mform" method="post" action="dogovor.jsp?<%= request.getQueryString() %>">

<table cellspacing="0" cellpadding="0">
	<tr>
		<td class="gr">Номер</td>
		<td class="gr">Об'єкт</td>
		<td class="gr">Постачальник</td>
		<td class="gr">Дата підписання</td>
		<td class="gr">Дата початку</td>
		<td class="gr">Дата закінчення</td>
	</tr>
	<tr>
		<td><input type="text" size="8" name="dogovor_nomer" value="<%= d_in.nomer %>" /></td>
		<td><input type="hidden" name="ks_id" value="<%= d_in.ks_id %>"><%= d_in.ks_name %></td>
		<td><%= d_in.obl_name %><input type="hidden" name="obl_id" value="<%= d_in.obl_id %>"></td>
		<td><input type="text" size="10" name="dogovor_dat_podpis" value="<%= d_in.dat_podpis %>" /></td>
		<td><input type="text" size="10" name="dogovor_dat_start" value="<%= d_in.dat_start %>" /></td>
		<td><input type="text" size="10" name="dogovor_dat_end" value="<%= d_in.dat_end %>" /></td>
	</tr>
	<tr>
		<td class="bt"><input type="reset" value=" відмінити " /></td>
		<td class="bt" colspan="4"></td>
		<td class="bt"><input type="submit" value=" зберегти " /></td>
	</tr>
</table>
<input type="hidden" name="store" value="store_dogovor">
<input type="hidden" name="dogov_id" value="<%= d_in.dogov_id %>">
</form>

</html>

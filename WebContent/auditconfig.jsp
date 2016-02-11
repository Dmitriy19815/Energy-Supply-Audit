<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page import="ua.datapark.commons.Basic" %>
<%@ page import="ua.datapark.audit.AuditNSI" %>
<%@ page import="ua.datapark.audit.AuditProps" %>
<%@ page language="java" contentType="text/html; charset=Windows-1251" pageEncoding="Windows-1251"%>
<%	 
	AuditNSI au = AuditNSI.getInstance();
	AuditProps conf = au.getAuditProps();
	
	String message = request.getParameter("message");
	String store = request.getParameter("store");
	if (store!=null) {
		AuditProps confin = new AuditProps();
		confin.umg_id = request.getParameter("umg_id")!=null ? request.getParameter("umg_id") : "";
		au.storeAuditProps(confin,null);
		response.sendRedirect("auditconfig.jsp");
		return;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Конфігурація системи - Енергоаудит 5.4</title>
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
Конфігурація системи "Енергоаудит"<br><br>
<form name="mform" method="post" action="auditconfig.jsp">
<table cellspacing="0" cellpadding="0">
	<tr><td class="wh">Підрозділ ДК "Укртрансгаз"</td>
		<td class="gr">
			<select name="umg_id">
				<% for (int i=0; i<c.UmgSize(); i++) { 	%><option <% if (c.getUmgf(i,0).equals(conf.umg_id)) { %>selected<% } %> value="<%= c.getUmgf(i,0) %>"><%= c.getUmgf(i,1) %></option>
				<% } %>
			</select>
		</td></tr>
	<tr><td class="bt" colspan="2"><input onclick="yesno();" type="button" value=" зберегти " /></td></tr>
</table>
<input type="hidden" name="store" value="yes">
</form>
</body>
</html>
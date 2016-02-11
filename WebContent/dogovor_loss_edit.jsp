<%@ page import="ua.datapark.commons.Basic" %>
<%@ page extends="ua.datapark.jsp.SecureJSP"%>
<jsp:useBean id="ddl" scope="page" class="ua.datapark.audit._DogovorLoss"/>
<%@ page import="ua.datapark.audit.Dogovor" %>
<%@ page import="ua.datapark.audit.DogovorLoss" %>
<%@ page import="java.util.*;" %>
<%@ page language="java" contentType="text/html; charset=Windows-1251" pageEncoding="Windows-1251"%>

<%	 
	String mode = (String) session.getAttribute("mode");
	if ((mode!=null) && (mode.equals("admin"))) {
	
	} else response.sendRedirect("logon.jsp");

	String message = request.getParameter("message");
	String store = request.getParameter("store");
	int point_id = Integer.parseInt(request.getParameter("point_id"));
	int  dogov_id = Integer.parseInt(request.getParameter("dogov_id"));

	ddl.loadDogovorLoss(point_id, dogov_id);
	DogovorLoss dl_in = ddl.getDogovorLoss();
%>

<DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Параметри втрат точки - Договір - Енергоаудит 5.4</title>
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
			if (confirm('Ви впевнені, що бажаєте зберегти нові параметри?')) {
				mform.submit();				
			} 
		}
	</script>
</head>
<body>

<a href="javascript: history.go(-1)">повернутись</a><br><br>

<form name="mform" method="post" action="dogovor.jsp">
<input type="hidden" name="point_id" value="<%= dl_in.point_id %>">
<input type="hidden" name="dogov_id" value="<%= dl_in.dogov_id %>">

<table cellspacing="0" cellpadding="0">
	<tr><td colspan="7" class="wh">Договір № <%= dl_in.dogovor_nomer %> від <%= dl_in.dogovor_dat_podpis %></td></tr>
	<tr><td class="wh"><%= dl_in.point_name %></td><td class="gr">СА пост.</td><td class="gr">СР пост.</td><td class="gr">ГР пост.</td><td class="gr">СА змін., %</td><td class="gr">СР змін., %</td><td class="gr">змін., %</td></tr>
	<tr><td class="gr">(Тариф 1 нічний)</td>
	   <td><input type="text" size="4" name="loss_fixed_sa_1" value="<%= dl_in.loss_fixed_sa_1 %>" /></td>
	   <td><input type="text" size="4" name="loss_fixed_sr_1" value="<%= dl_in.loss_fixed_sr_1 %>" /></td>
	   <td><input type="text" size="4" name="loss_fixed_gr_1" value="<%= dl_in.loss_fixed_gr_1 %>" /></td>
	   <td><input type="text" size="4" name="loss_float_sa_1" value="<%= dl_in.loss_float_sa_1 %>" /></td>
	   <td><input type="text" size="4" name="loss_float_sr_1" value="<%= dl_in.loss_float_sr_1 %>" /></td>
	   <td><input type="text" size="4" name="loss_float_gr_1" value="<%= dl_in.loss_float_gr_1 %>" /></td>
	</tr>
	<tr><td class="gr">(Тариф 2 напівпік.)</td>
	   <td><input type="text" size="4" name="loss_fixed_sa_2" value="<%= dl_in.loss_fixed_sa_2 %>" /></td>
	   <td><input type="text" size="4" name="loss_fixed_sr_2" value="<%= dl_in.loss_fixed_sr_2 %>" /></td>
	   <td><input type="text" size="4" name="loss_fixed_gr_2" value="<%= dl_in.loss_fixed_gr_2 %>" /></td>
	   <td><input type="text" size="4" name="loss_float_sa_2" value="<%= dl_in.loss_float_sa_2 %>" /></td>
	   <td><input type="text" size="4" name="loss_float_sr_2" value="<%= dl_in.loss_float_sr_2 %>" /></td>
	   <td><input type="text" size="4" name="loss_float_gr_2" value="<%= dl_in.loss_float_gr_2 %>" /></td>
	</tr>
	<tr><td class="gr">(Тариф 3 піковий)</td>
	   <td><input type="text" size="4" name="loss_fixed_sa_3" value="<%= dl_in.loss_fixed_sa_3 %>" /></td>
	   <td><input type="text" size="4" name="loss_fixed_sr_3" value="<%= dl_in.loss_fixed_sr_3 %>" /></td>
	   <td><input type="text" size="4" name="loss_fixed_gr_3" value="<%= dl_in.loss_fixed_gr_3 %>" /></td>
	   <td><input type="text" size="4" name="loss_float_sa_3" value="<%= dl_in.loss_float_sa_3 %>" /></td>
	   <td><input type="text" size="4" name="loss_float_sr_3" value="<%= dl_in.loss_float_sr_3 %>" /></td>
	   <td><input type="text" size="4" name="loss_float_gr_3" value="<%= dl_in.loss_float_gr_3 %>" /></td>
	</tr>
	<tr><td class="wh" colspan="7"></td></tr>
	<tr><td class="bt" colspan="7"><input type="submit" value=" зберегти " /></td></tr>
</table>
<input type="hidden" name="store" value="store_dogovor_loss">
</form>
</html>

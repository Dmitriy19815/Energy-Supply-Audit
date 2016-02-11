<%@ page import="ua.datapark.commons.Basic" %>
<%@ page extends="ua.datapark.jsp.SecureJSP"%>
<jsp:useBean id="dd" scope="page" class="ua.datapark.audit._Dogovor"/>
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

	String year1 = request.getParameter("year1")==null ? "" : request.getParameter("year1");
	String month1 = request.getParameter("month1")==null ? "" : request.getParameter("month1");
	String day1 = request.getParameter("day1")==null ? "" : request.getParameter("day1");

	String year2 = request.getParameter("year2")==null ? "" : request.getParameter("year2");
	String month2 = request.getParameter("month2")==null ? "" : request.getParameter("month2");
	String day2 = request.getParameter("day2")==null ? "" : request.getParameter("day2");

	String ks = request.getParameter("ks")==null ? "" : request.getParameter("ks");
	String obl = request.getParameter("obl")==null ? "" : request.getParameter("obl");

	
	if (store!=null && store.equals("store_dogovor_loss")) {

		DogovorLoss dl_in = new DogovorLoss();
		String dogov_id = request.getParameter("dogov_id")!=null ? request.getParameter("dogov_id") : "";
		dl_in.dogov_id = Integer.parseInt(dogov_id);
		String point_id = request.getParameter("point_id")!=null ? request.getParameter("point_id") : "";
		dl_in.point_id = Integer.parseInt(point_id);

		String loss_fixed_sa_1 = request.getParameter("loss_fixed_sa_1")!=null ? request.getParameter("loss_fixed_sa_1") : "0";
		dl_in.loss_fixed_sa_1 = Double.parseDouble(loss_fixed_sa_1);
		String loss_fixed_sa_2 = request.getParameter("loss_fixed_sa_2")!=null ? request.getParameter("loss_fixed_sa_2") : "0";
		dl_in.loss_fixed_sa_2 = Double.parseDouble(loss_fixed_sa_2);
		String loss_fixed_sa_3 = request.getParameter("loss_fixed_sa_3")!=null ? request.getParameter("loss_fixed_sa_3") : "0";
		dl_in.loss_fixed_sa_3 = Double.parseDouble(loss_fixed_sa_3);

		String loss_fixed_sr_1 = request.getParameter("loss_fixed_sr_1")!=null ? request.getParameter("loss_fixed_sr_1") : "0";
		dl_in.loss_fixed_sr_1 = Double.parseDouble(loss_fixed_sr_1);
		String loss_fixed_sr_2 = request.getParameter("loss_fixed_sr_2")!=null ? request.getParameter("loss_fixed_sr_2") : "0";
		dl_in.loss_fixed_sr_2 = Double.parseDouble(loss_fixed_sr_2);
		String loss_fixed_sr_3 = request.getParameter("loss_fixed_sr_3")!=null ? request.getParameter("loss_fixed_sr_3") : "0";
		dl_in.loss_fixed_sr_3 = Double.parseDouble(loss_fixed_sr_3);

		String loss_fixed_gr_1 = request.getParameter("loss_fixed_gr_1")!=null ? request.getParameter("loss_fixed_gr_1") : "0";
		dl_in.loss_fixed_gr_1 = Double.parseDouble(loss_fixed_gr_1);
		String loss_fixed_gr_2 = request.getParameter("loss_fixed_gr_2")!=null ? request.getParameter("loss_fixed_gr_2") : "0";
		dl_in.loss_fixed_gr_2 = Double.parseDouble(loss_fixed_gr_2);
		String loss_fixed_gr_3 = request.getParameter("loss_fixed_gr_3")!=null ? request.getParameter("loss_fixed_gr_3") : "0";
		dl_in.loss_fixed_gr_3 = Double.parseDouble(loss_fixed_gr_3);

		String loss_float_sa_1 = request.getParameter("loss_float_sa_1")!=null ? request.getParameter("loss_float_sa_1") : "0";
		dl_in.loss_float_sa_1 = Double.parseDouble(loss_float_sa_1);
		String loss_float_sa_2 = request.getParameter("loss_float_sa_2")!=null ? request.getParameter("loss_float_sa_2") : "0";
		dl_in.loss_float_sa_2 = Double.parseDouble(loss_float_sa_2);
		String loss_float_sa_3 = request.getParameter("loss_float_sa_3")!=null ? request.getParameter("loss_float_sa_3") : "0";
		dl_in.loss_float_sa_3 = Double.parseDouble(loss_float_sa_3);

		String loss_float_sr_1 = request.getParameter("loss_float_sr_1")!=null ? request.getParameter("loss_float_sr_1") : "0";
		dl_in.loss_float_sr_1 = Double.parseDouble(loss_float_sr_1);
		String loss_float_sr_2 = request.getParameter("loss_float_sr_2")!=null ? request.getParameter("loss_float_sr_2") : "0";
		dl_in.loss_float_sr_2 = Double.parseDouble(loss_float_sr_2);
		String loss_float_sr_3 = request.getParameter("loss_float_sr_3")!=null ? request.getParameter("loss_float_sr_3") : "0";
		dl_in.loss_float_sr_3 = Double.parseDouble(loss_float_sr_3);

		String loss_float_gr_1 = request.getParameter("loss_float_gr_1")!=null ? request.getParameter("loss_float_gr_1") : "0";
		dl_in.loss_float_gr_1 = Double.parseDouble(loss_float_gr_1);
		String loss_float_gr_2 = request.getParameter("loss_float_gr_2")!=null ? request.getParameter("loss_float_gr_2") : "0";
		dl_in.loss_float_gr_2 = Double.parseDouble(loss_float_gr_2);
		String loss_float_gr_3 = request.getParameter("loss_float_gr_3")!=null ? request.getParameter("loss_float_gr_3") : "0";
		dl_in.loss_float_gr_3 = Double.parseDouble(loss_float_gr_3);
		
		ddl.updateDogovorLoss(dl_in);
		
		response.sendRedirect("dogovor.jsp");
		return;
	}

	
	if (store!=null && store.equals("store_dogovor")) {

		Dogovor d_in = new Dogovor();
		String dogov_id = request.getParameter("dogov_id")!=null ? request.getParameter("dogov_id") : "";
		d_in.dogov_id = Integer.parseInt(dogov_id);
		String ks_id = request.getParameter("ks_id")!=null ? request.getParameter("ks_id") : "";
		d_in.ks_id = Integer.parseInt(ks_id);
		String obl_id = request.getParameter("obl_id")!=null ? request.getParameter("obl_id") : "";
		d_in.obl_id = Integer.parseInt(obl_id);

		d_in.nomer = request.getParameter("dogovor_nomer")!=null ? request.getParameter("dogovor_nomer") : ""; 

		d_in.dat_podpis = request.getParameter("dogovor_dat_podpis")!=null ? request.getParameter("dogovor_dat_podpis") : ""; 
		d_in.dat_start = request.getParameter("dogovor_dat_start")!=null ? request.getParameter("dogovor_dat_start") : ""; 
		d_in.dat_end = request.getParameter("dogovor_dat_end")!=null ? request.getParameter("dogovor_dat_end") : ""; 
		
		dd.updateDogovor(d_in);
		
		response.sendRedirect("dogovor.jsp");
		return;
	}

	if (store!=null && store.equals("create_dogovor")) {

		Dogovor d_in = new Dogovor();
		String ks_id = request.getParameter("ks_id")!=null ? request.getParameter("ks_id") : "";
		d_in.ks_id = Integer.parseInt(ks_id);
		String obl_id = request.getParameter("obl_id")!=null ? request.getParameter("obl_id") : "";
		d_in.obl_id = Integer.parseInt(obl_id);
		d_in.nomer = request.getParameter("dogovor_nomer")!=null ? request.getParameter("dogovor_nomer") : ""; 

		d_in.dat_podpis = request.getParameter("dogovor_dat_podpis")!=null ? request.getParameter("dogovor_dat_podpis") : ""; 
		d_in.dat_start = request.getParameter("dogovor_dat_start")!=null ? request.getParameter("dogovor_dat_start") : ""; 
		d_in.dat_end = request.getParameter("dogovor_dat_end")!=null ? request.getParameter("dogovor_dat_end") : ""; 
		
		dd.createDogovor(d_in);
		
		response.sendRedirect("dogovor.jsp");
		return;
	}

	if (store!=null && store.equals("delete_dogovor")) {

		String dogov_id = request.getParameter("dogov_id")!=null ? request.getParameter("dogov_id") : "";
		dd.deleteDogovor(Integer.parseInt(dogov_id));
		
		response.sendRedirect("dogovor.jsp");
		return;
	}
	
	dd.loadDogovors(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2);
	ArrayList Dogovors = dd.getDogovors();
	
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
			if (confirm('Ви впевнені, що бажаєте зберегти нові параметри?')) {
				mform.submit();				
			} 
		}
	</script>
</head>
<body>
<form name="mform" method="post" action="dogovor_edit.jsp">
</form>
<a href="dogovor_add.jsp">Додати договір</a><br><br>
<table cellspacing="0" cellpadding="0">
	<tr><td class="gr">Номер договору</td>
		<td class="gr">Об'єкт</td>
		<td class="gr">Постачальник</td>
		<td class="gr">Дата підписання</td>
		<td class="gr">Дата початку</td>
		<td class="gr">Дата закінчення</td>
		<td class="gr"></td>
	</tr>
	<%	for (int i=0; i<Dogovors.size(); i++) {
		Dogovor dog = (Dogovor) Dogovors.get(i); %>
		<tr><td><%= dog.nomer %></td>
			<td><%= dog.ks_name %></td>
			<td><%= dog.obl_name %></td>
			<td><%= dog.dat_podpis %></td>
			<td><%= dog.dat_start %></td>
			<td><%= dog.dat_end %></td>
			<td><a href="dogovor_edit.jsp?dogov_id=<%= dog.dogov_id %>">edit</a> <a href="dogovor.jsp?dogov_id=<%= dog.dogov_id %>&amp;store=delete_dogovor">delete</a></td>
		</tr>
		<tr><td></td>
			<td colspan="5">
				<table cellspacing="0" cellpadding="0">
			<%	for (int j=0; j<dog.points.size(); j++) {
				DogovorLoss dl = (DogovorLoss) dog.points.get(j); %>
				<tr><td class="wh"><%= dl.point_name %> <a href="dogovor_loss_edit.jsp?dogov_id=<%= dl.dogov_id %>&amp;point_id=<%= dl.point_id %>">edit</a></td><td class="gr">СА пост.</td><td class="gr">СР пост.</td><td class="gr">ГР пост.</td><td class="gr">СА змін., %</td><td class="gr">СР змін., %</td><td class="gr">змін., %</td></tr>
				<tr><td class="gr">(Тариф 1 нічний)</td><td><%= dl.loss_fixed_sa_1 %></td><td><%= dl.loss_fixed_sr_1 %></td><td><%= dl.loss_fixed_gr_1 %></td><td><%= dl.loss_float_sa_1 %></td><td><%= dl.loss_float_sr_1 %></td><td><%= dl.loss_float_gr_1 %></td></tr>
				<tr><td class="gr">(Тариф 2 напівпік.)</td><td><%= dl.loss_fixed_sa_2 %></td><td><%= dl.loss_fixed_sr_2 %></td><td><%= dl.loss_fixed_gr_2 %></td><td><%= dl.loss_float_sa_2 %></td><td><%= dl.loss_float_sr_2 %></td><td><%= dl.loss_float_gr_2 %></td></tr>
				<tr><td class="gr">(Тариф 3 піковий)</td><td><%= dl.loss_fixed_sa_3 %></td><td><%= dl.loss_fixed_sr_3 %></td><td><%= dl.loss_fixed_gr_3 %></td><td><%= dl.loss_float_sa_3 %></td><td><%= dl.loss_float_sr_3 %></td><td><%= dl.loss_float_gr_3 %></td></tr>
			
				<tr><td colspan="7" style="height: 10px;"></td></tr>
			<% } %>		
				</table>
			</td>
			<td></td>
		</tr>
	<% } %>
</html>

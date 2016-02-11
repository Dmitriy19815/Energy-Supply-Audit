<%@ page pageEncoding="Windows-1251"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._RangePoint"/>
<%@ page import="ua.datapark.commons.Basic" %>
<%@ page import="ua.datapark.audit.DataVector" %>
<%@ page import="java.util.*;" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
</head>
<body>
<%	//обязательные параметры
	String ks = request.getParameter("ks");
	String obl = request.getParameter("obl");
	if (ks==null && obl==null) { %>не указан объект<br><%  }
	String point = request.getParameter("point");
	if (point==null) { %>не указана точка<br><%  }

	String day1 = request.getParameter("day1");
	if (day1==null) { %>не указан день 1<br><% }
	String month1 = request.getParameter("month1");
	if (month1==null) { %>не указан месяц 1<br><% }
	String year1 = request.getParameter("year1");
	if (year1==null) { %>не указан год 1<br><% }

	String day2 = request.getParameter("day2");
	if (day2==null) { %>не указан день 2<br><% }
	String month2 = request.getParameter("month2");
	if (month2==null) { %>не указан месяц 2<br><% }
	String year2 = request.getParameter("year2");
	if (year2==null) { %>не указан год 2<br><% }

	if ( (ks==null && obl==null) || point==null 
		|| day1==null || month1==null || year1==null
		|| day2==null || month2==null || year2==null ) { return; }

	//определение флага пересчета
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }

	cc.loadDataRangeZeroAll(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, "on");
	
	ArrayList ar = cc.getDataRangePoint(0);
%>
<% if (!(cc.DataRangePointSize()>1)) { %>
<table class="datahead">
<tr><td height="2"></td></tr>
<tr><td class="c" align="center" height="40" width="550">дані відсутні</td></tr>
<tr><td height="2"></td></tr>
</table>
<% } else { %>

<%  double z1kvt = 0, z2kvt = 0, z3kvt = 0;
	double z1kvt_sum = 0, z2kvt_sum = 0, z3kvt_sum = 0, z_kvt_sum = 0;
%>
<b>1. Активна електроенергія</b><br><br>
<b>1.1. Розподіл сальдо активної електроенергії за об'єктами обліку</b><br><br>
	<img src="piem_ks_a.jsp?zvit=select_saldo&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>
	
<b>1.2. Розподіл сальдо активної електроенергії за тарифами</b><br><br>
	<img src="piem_a.jsp?zvit=chartm&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>						
<b>1.3. Таблиця розподілу сальдо активної електроенергії</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0" width="544">
  <tr align="center"> 
    <td rowspan="2" class="datarow" width="120">Точка<br>обліку</td>
    <td colspan="4" class="datarow">Сальдо електроенергії, кВт&#x00B7;г</td>
  </tr>
  
  <tr align="center"> 
    <td class="smalldatarow" width="100">Тариф 1<br>(нічний)</td>
    <td class="smalldatarow" width="100">Тариф 2<br>(напівпік)</td>
    <td class="smalldatarow" width="100">Тариф 3<br>(піковий)</td>
    <td class="smalldatarow" width="120">Сумарне</td>
  </tr>

<%	DataVector dv; %>
<%	for (int i=0; i<ar.size()-1; i++) { 
	dv = (DataVector) ar.get(i+1); %>

	<tr align="right">
       <td class="c" align="left" nowrap><%= c.getPointName(dv.point_id) %></td>
       <td class="c"><% z1kvt = dv.getByNameDouble("p_qua_1"); z1kvt_sum += z1kvt; %>
    	       					<%= Basic.formatNumber(1,9,1,1,z1kvt) %></td>
       <td class="c"><%	z2kvt = dv.getByNameDouble("p_qua_2"); z2kvt_sum += z2kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z2kvt) %></td>
	   <td class="c"><% z3kvt = dv.getByNameDouble("p_qua_3"); z3kvt_sum += z3kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z3kvt) %></td>
       <td class="c"><%= Basic.formatNumber(1,9,1,1,dv.getByNameDouble("p_qua_0")) %></td>
	</tr>  
<% } %>

<tr align="right">
       <td class="datarow" align="center">Всього</td>
       <td class="c"><b><% z_kvt_sum += z1kvt_sum; %>
       	    			<%= Basic.formatNumber(1,10,1,1,z1kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z2kvt_sum;;%>
       	    			<%= Basic.formatNumber(1,10,1,1,z2kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z3kvt_sum;; %>
       					<%= Basic.formatNumber(1,10,1,1,z3kvt_sum) %></b></td>
       <td class="c"><b><%= Basic.formatNumber(1,10,1,1,z_kvt_sum) %></b></td>
</tr >
</table>

<br><br><br>


<%	z1kvt = 0; z2kvt = 0; z3kvt = 0;
	z1kvt_sum = 0; z2kvt_sum = 0; z3kvt_sum = 0; z_kvt_sum = 0; %>

<b>2 Реактивна електроенергія (споживання)</b><br><br>
<b>2.1. Розподіл сальдо споживання реактивної електроенергії за об'єктами обліку</b><br><br>
	<img src="piem_ks_rp.jsp?zvit=select_saldo&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>
	
<b>2.2. Розподіл сальдо споживання реактивної електроенергії за тарифами</b><br><br>
	<img src="piem_rp.jsp?zvit=chartm&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>						
<b>2.3. Таблиця розподілу сальдо споживання реактивної електроенергії</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0">
  <tr align="center"> 
    <td rowspan="2" class="datarow" width="120">Точка<br>обліку</td>
    <td colspan="4" class="datarow">Сальдо електроенергії, кВт&#x00B7;г</td>
  </tr>
  
  <tr align="center"> 
    <td class="smalldatarow" width="100">Тариф 1<br>
      (нічний)</td>
    <td class="smalldatarow" width="100">Тариф 2<br>
      (напівпік)</td>
    <td class="smalldatarow" width="100">Тариф 3<br>
      (піковий)</td>
    <td class="smalldatarow" width="120">Сумарне</td>
  </tr>

<%	for (int i=0; i<ar.size()-1; i++) { 
	dv = (DataVector) ar.get(i+1); %>

	<tr align="right">
       <td class="c" align="left" nowrap><%= c.getPointName(dv.point_id) %></td>
       <td class="c"><% z1kvt = dv.getByNameDouble("q_qua_1"); z1kvt_sum += z1kvt; %>
    	       					<%= Basic.formatNumber(1,9,1,1,z1kvt) %></td>
       <td class="c"><%	z2kvt = dv.getByNameDouble("q_qua_2"); z2kvt_sum += z2kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z2kvt) %></td>
	   <td class="c"><% z3kvt = dv.getByNameDouble("q_qua_3"); z3kvt_sum += z3kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z3kvt) %></td>
       <td class="c"><%= Basic.formatNumber(1,9,1,1,dv.getByNameDouble("q_qua_0")) %></td>
	</tr>  
<% } %>

<tr align="right">
       <td class="datarow" align="center">Всього</td>
       <td class="c"><b><% z_kvt_sum += z1kvt_sum; %>
       	    			<%= Basic.formatNumber(1,10,1,1,z1kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z2kvt_sum;;%>
       	    			<%= Basic.formatNumber(1,10,1,1,z2kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z3kvt_sum;; %>
       					<%= Basic.formatNumber(1,10,1,1,z3kvt_sum) %></b></td>
       <td class="c"><b><%= Basic.formatNumber(1,10,1,1,z_kvt_sum) %></b></td>
</tr >
</table>

<br><br><br>



<%	z1kvt = 0; z2kvt = 0; z3kvt = 0;
	z1kvt_sum = 0; z2kvt_sum = 0; z3kvt_sum = 0; z_kvt_sum = 0; %>

<b>3 Реактивна електроенергія (генерація)</b><br><br>
<b>3.1. Розподіл сальдо генерації реактивної електроенергії за об'єктами обліку</b><br><br>
	<img src="piem_ks_rm.jsp?zvit=select_saldo&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>
	
<b>3.2. Розподіл сальдо генерації реактивної електроенергії за тарифами</b><br><br>
	<img src="piem_rm.jsp?zvit=chartm&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>						
<b>3.3. Таблиця розподілу сальдо генерації реактивної електроенергії</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0">
  <tr align="center"> 
    <td rowspan="2" class="datarow" width="120">Точка<br>обліку</td>
    <td colspan="4" class="datarow">Сальдо електроенергії, кВт&#x00B7;г</td>
  </tr>
  
  <tr align="center"> 
    <td class="smalldatarow" width="100">Тариф 1<br>(нічний)</td>
    <td class="smalldatarow" width="100">Тариф 2<br>(напівпік)</td>
    <td class="smalldatarow" width="100">Тариф 3<br>(піковий)</td>
    <td class="smalldatarow" width="120">Сумарне</td>
  </tr>

<%	for (int i=0; i<ar.size()-1; i++) { 
	dv = (DataVector) ar.get(i+1); %>

	<tr align="right">
       <td class="c" align="left" nowrap><%= c.getPointName(dv.point_id) %></td>
       <td class="c"><% z1kvt = dv.getByNameDouble("q_gen_1"); z1kvt_sum += z1kvt; %>
    	       					<%= Basic.formatNumber(1,9,1,1,z1kvt) %></td>
       <td class="c"><%	z2kvt = dv.getByNameDouble("q_gen_2"); z2kvt_sum += z2kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z2kvt) %></td>
	   <td class="c"><% z3kvt = dv.getByNameDouble("q_gen_3"); z3kvt_sum += z3kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z3kvt) %></td>
       <td class="c"><%= Basic.formatNumber(1,9,1,1,dv.getByNameDouble("q_gen_0")) %></td>
	</tr>  
<% } %>

<tr align="right">
       <td class="datarow" align="center">Всього</td>
       <td class="c"><b><% z_kvt_sum += z1kvt_sum; %>
       	    			<%= Basic.formatNumber(1,10,1,1,z1kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z2kvt_sum;;%>
       	    			<%= Basic.formatNumber(1,10,1,1,z2kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z3kvt_sum;; %>
       					<%= Basic.formatNumber(1,10,1,1,z3kvt_sum) %></b></td>
       <td class="c"><b><%= Basic.formatNumber(1,10,1,1,z_kvt_sum) %></b></td>
</tr >
</table>

<% } %>

</body>
</html>
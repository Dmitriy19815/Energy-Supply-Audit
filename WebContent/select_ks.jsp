<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._RangePoint"/>
<%@ page pageEncoding="Windows-1251"%>
<%@ page import="ua.datapark.audit.DataVector" %>
<%@ page import="ua.datapark.audit.Point" %>
<%@ page import="java.util.*;" %>
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

	String print = request.getParameter("print");
	if (print==null) { print = ""; }

	cc.loadDataRangeZeroAll(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, recalc);
	ArrayList Points = c.getPoints(ks);
	String[] str = new String[Points.size()+1];
	str[0]="<b>Всього по фідерах</b>";
	for (int i=1; i < Points.size()+1; i++) {
		Point p = (Point)Points.get(i-1);
		str[i] = p.point_name;
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
</head>
<body>
<% if (!(cc.DataRangePointSize()>1)) { %>
<table class="data">
<tr><td align="center" height="2"></td></tr>
<tr><td align="center" height="40" class="c" width="<%= 120+str.length*89	 %>">дані відсутні</td></tr>
<tr><td align="center" height="2""></td></tr>
</table>
<% } else { %>
<%	ArrayList dd = new ArrayList(); 
	DataVector dv; %>


<br><b>1. Всього по тарифах</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z0"><b>1.1. Споживання активної електроенергії, кВт&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr><td class="c" width="120">
			<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
			<% } else { %><b>Всього за період</b><% } %>
		</td>
		<% for (int k=0; k < dd.size(); k++) { dv = (DataVector) dd.get(k); %>
			<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("p_qua_0") %></td>
		<% } %>
		</tr>		
<% } %>
</table>
<br>
<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z0"><b>1.2. Споживання реактивної електроенергії, квар&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr>
			<td class="c" width="120">
				<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
				<% } else { %><b>Всього за період</b><% } %>
			</td>
				<% for (int k=0; k < dd.size(); k++) {
					dv = (DataVector) dd.get(k); %>
					<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("q_qua_0") %></td>
				<% } %>

		</tr>		
<% } %>
</table>
<br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z0"><b>1.3. Генерація реактивної електроенергії, квар&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>
		
<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr><td class="c" width="120">
			<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
			<% } else { %><b>Всього за період</b><% } %>
		</td>
			<% for (int k=0; k < dd.size(); k++) {
				dv = (DataVector) dd.get(k); %>
				<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("q_gen_0") %></td>
			<% } %>
		</tr>		
<% } %>
</table>

<br><b>2. Тариф 1 (нічний)</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z1"><b>2.1. Споживання активної електроенергії, кВт&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr><td class="c" width="120">
			<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
			<% } else { %><b>Всього за період</b><% } %>
		</td>
			<% for (int k=0; k < dd.size(); k++) { dv = (DataVector) dd.get(k); %>
				<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("p_qua_1") %></td>
			<% } %>
		</tr>		
<% } %>
</table>
<br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z1"><b>2.2. Споживання реактивної електроенергії, квар&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr>
			<td class="c" width="120">
				<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
				<% } else { %><b>Всього за період</b><% } %>
			</td>
				<% for (int k=0; k < dd.size(); k++) {
					dv = (DataVector) dd.get(k); %>
					<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("q_qua_1") %></td>
				<% } %>
		</tr>		
<% } %>
</table>
<br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z1"><b>2.3. Генерація реактивної електроенергії, квар&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>
<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr><td class="c" width="120">
			<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
			<% } else { %><b>Всього за період</b><% } %>
		</td>
			<% for (int k=0; k < dd.size(); k++) {
				dv = (DataVector) dd.get(k); %>
				<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("q_gen_1") %></td>
			<% } %>
		</tr>		
<% } %>
</table>
<br>


<b>3. Тариф 2 (напівпіковий)</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z2"><b>3.1. Споживання активної електроенергії, кВт&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr><td class="c" width="120">
			<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
			<% } else { %><b>Всього за період</b><% } %>
		</td>
			<% for (int k=0; k < dd.size(); k++) { dv = (DataVector) dd.get(k); %>
				<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("p_qua_2") %></td>
			<% } %>
		</tr>		
<% } %>
</table>
<br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z2"><b>3.2. Споживання реактивної електроенергії, квар&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr>
			<td class="c" width="120">
				<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
				<% } else { %><b>Всього за період</b><% } %>
			</td>
				<% for (int k=0; k < dd.size(); k++) {
					dv = (DataVector) dd.get(k); %>
					<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("q_qua_2") %></td>
				<% } %>
		</tr>		
<% } %>
</table>
<br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z2"><b>3.3. Генерація реактивної електроенергії, квар&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr><td class="c" width="120">
			<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
			<% } else { %><b>Всього за період</b><% } %>
		</td>
			<% for (int k=0; k < dd.size(); k++) {
				dv = (DataVector) dd.get(k); %>
				<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("q_gen_2") %></td>
			<% } %>
		</tr>		
<% } %>
</table>

<br><b>4. Тариф 3 (піковий)</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z3"><b>4.1. Споживання активної електроенергії, кВт&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr><td class="c" width="120">
			<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
			<% } else { %><b>Всього за період</b><% } %>
		</td>
			<% for (int k=0; k < dd.size(); k++) { dv = (DataVector) dd.get(k); %>
				<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("p_qua_3") %></td>
			<% } %>
		</tr>		
<% } %>
</table>
<br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z3"><b>4.2. Споживання реактивної електроенергії, квар&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr>
			<td class="c" width="120">
				<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
				<% } else { %><b>Всього за період</b><% } %>
			</td>
				<% for (int k=0; k < dd.size(); k++) {
					dv = (DataVector) dd.get(k); %>
					<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("q_qua_3") %></td>
				<% } %>
		</tr>		
<% } %>
</table>
<br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td colspan="<%= str.length+1 %>" height="24" class="z3"><b>4.3. Генерація реактивної електроенергії, квар&#x00B7;г</b></td></tr>

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="120">Дата</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataRangePointSize(); i++) { 
		dd = cc.getDataRangePoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr><td class="c" width="120">
			<% if (!dv.getByName("h").equals("50")) { %><%= dv.dat %>
			<% } else { %><b>Всього за період</b>
			<% } %>
		</td>
			<% for (int k=0; k < dd.size(); k++) {
				dv = (DataVector) dd.get(k); %>
				<td class="c" align="right" <% if (dv.getByName("h").equals("50")) { %>style="font-weight: bold"<% } %> width="80"><%= dv.getByName("q_gen_3") %></td>
			<% } %>
		</tr>		
<% } %>
</table>
<% } %>
<font size="-3">час обробки запиту: <%= cc.getProcessingTime() %> c</font>
<table cellpadding="0" cellspacing="0">
<tr><td height="5"></td></tr>
</table>
</body>
</html>	
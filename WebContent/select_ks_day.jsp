<%@ page pageEncoding="Windows-1251"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._RangeDayPoint"/>
<%@ page import="ua.datapark.audit.DataVector" %>
<%@ page import="ua.datapark.audit.Point" %>
<%@ page import="java.util.*;" %>
<%	//обязательные параметры
	String ks = request.getParameter("ks");
	String obl = request.getParameter("obl");
	if (ks==null && obl==null) { %>не указан объект<br><%  }
	String point = request.getParameter("point");
	if (point==null) { %>не указана точка<br><%  }

	String day = request.getParameter("day");
	if (day==null) { %>не указан день<br><% }
	String month = request.getParameter("month");
	if (month==null) { %>не указан месяц<br><% }
	String year = request.getParameter("year");
	if (year==null) { %>не указан год<br><% }

	if ( (ks==null && obl==null) || point==null 
		|| day==null || month==null || year==null ) { return; }

	//определение флага пересчета
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }

	String print = request.getParameter("print");
	if (print==null) { print = ""; }

	cc.loadDataZeroDayAll(ks, year+"-"+month+"-"+day, recalc);
	ArrayList Points = c.getPoints(ks);
	String[] str = new String[Points.size()+1];
	str[0]="<b>Всього по фідерах</b>";
	for (int i=1; i < Points.size()+1; i++) {
		Point p = (Point)Points.get(i-1);
		str[i] = p.point_name;
	}
%>
<% if (!(cc.DataDayPointSize()>1)) { %>
<table class="data">
<tr><td height="2"></td></tr>
<tr><td class="c" align="center" height="40" width="<%= 84+44+1+str.length*89 %>">дані відсутні</td></tr>
<tr><td height="2"></td></tr>
</table>
<% } else { %>
<%	ArrayList dd = new ArrayList(); 
	DataVector dv; %>

<br><b>1. Споживання активної електроенергії, кВт&#x00B7;г</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0">

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="80">Час</td>
	<td class="datarow" width="40" align="center">Тариф</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataDayPointSize(); i++) { 
		dd = cc.getDataDayPoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr><td class="c" align="center" width="80">
			<% if (!dv.getByName("h").equals("50")) { %><%= dv.getByName("parameter_description") %>
			<% } else { %><b>Всього за добу</b><% } %>
		</td>
		<td class="<%= "z"+dv.getByName("zval") %>" width="40" align="center">
			<% if (!dv.getByName("zval").equals("0")) { %><%= dv.getByName("zval") %><% } %>
		</td>
			<% for (int k=0; k < dd.size(); k++) { dv = (DataVector) dd.get(k); %>
				<td width="80" class="<%= "z"+dv.getByName("zval") %>" align="right"><%= dv.getByName("p_qua_0") %></td>
			<% } %>
		</tr>		
<% } %>
</table>

<br><b>2. Споживання реактивної електроенергії, квар&#x00B7;г</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0">

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="80">Час</td>
	<td class="datarow" width="40" align="center">Тариф</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataDayPointSize(); i++) { 
		dd = cc.getDataDayPoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr><td class="c" align="center" width="80">
			<% if (!dv.getByName("h").equals("50")) { %><%= dv.getByName("parameter_description") %>
			<% } else { %><b>Всього за добу</b><% } %>
		</td>
		<td class="<%= "z"+dv.getByName("zval") %>" width="40" align="center">
			<% if (!dv.getByName("zval").equals("0")) { %><%= dv.getByName("zval") %><% } %>
		</td>
			<% for (int k=0; k < dd.size(); k++) { dv = (DataVector) dd.get(k); %>
				<td width="80" class="<%= "z"+dv.getByName("zval") %>" align="right"><%= dv.getByName("q_qua_0") %></td>
			<% } %>
		</tr>		
<% } %>
</table>

<br><b>3. Генерація реактивної електроенергії, квар&#x00B7;г</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0">

<% if (print.equals("yes")) { %>
<tr><td align="center" class="datarow" width="80">Час</td>
	<td class="datarow" width="40" align="center">Тариф</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
<% } %>

<%	for (int i=0; i<cc.DataDayPointSize(); i++) { 
		dd = cc.getDataDayPoint(i);
		dv = (DataVector) dd.get(0); %>
		<tr><td class="c" align="center" width="80">
			<% if (!dv.getByName("h").equals("50")) { %><%= dv.getByName("parameter_description") %>
			<% } else { %><b>Всього за добу</b><% } %>
		</td>
		<td class="<%= "z"+dv.getByName("zval") %>" width="40" align="center">
			<% if (!dv.getByName("zval").equals("0")) { %><%= dv.getByName("zval") %><% } %>
		</td>
			<% for (int k=0; k < dd.size(); k++) { dv = (DataVector) dd.get(k); %>
				<td width="80" class="<%= "z"+dv.getByName("zval") %>" align="right"><%= dv.getByName("q_gen_0") %></td>
			<% } %>
		</tr>		
<% } %>
</table>
<font size="-3">час обробки запиту: <%= cc.getProcessingTime() %> c</font>
<br>
<% } %>
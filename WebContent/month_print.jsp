<%@ page pageEncoding="Windows-1251"%>
<%@ page import="ua.datapark.commons.Basic" %>
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit" />
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
	
	if ( point==null ) { return; }
	
	//определение флага пересчета
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Таблиця споживання та генерації електроенергії</title>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css">
</head>

<body>
<div align="center">
<table>
	<tr><td colspan="3" class="pad" style="font-size: 1.4em; border-bottom: 1px solid #707070">Таблиця споживання та генерації електроенергії</td></tr>
	<tr><td colspan="3" class="pad"></td></tr>

	<tr><td class="pad">
		<table>
			<tr><td class="pad" align="right">Споживач: </td><td class="pad"><b><%= c.getKsName(ks) %> <%= c.getUmgName() %></b></td></tr>
			<tr><td class="pad" align="right">Точка: </td><td class="pad"><b><%= c.getPointName(point) %></b></td></tr>
		</table>
	</td>
	<td class="pad"></td>
	<td class="pad">
		<table>
			<tr><td class="pad" align="right">Початок періоду: </td><td class="pad" style="color: #3A53E3"><b><%= day1 %> <%= Basic.monthNameRod(Integer.parseInt(month1)) %> <%= year1 %> р.</b></td></tr>
			<tr><td class="pad" align="right">Кінець періоду: </td><td class="pad" style="color: #3A53E3"><b><%= day2 %> <%= Basic.monthNameRod(Integer.parseInt(month2)) %> <%= year2 %> р.</b></td></tr>
		</table>
	</td></tr>
</table>
<br>
<table class="datahead" cellpadding="0" cellspacing="0">
	<tr>
	<td class="datarow" width="120" rowspan="3" align="center">Дата</td>
	<td class="datarow" width="40" rowspan="3" align="center">Тариф</td>
	<td class="datarow" align="center" colspan="11" height="5">Енергія</td>
</tr>
<tr>
	<td class="smalldatarow" align="center" height="18" colspan="1">Активна<% if (recalc.equals("on")) {  %>, кВт•год<% } %></td>
	<td class="smalldatarow" align="center" height="18" colspan="3">Реактивна<% if (recalc.equals("on")) {  %>, квар•год<% } %></td>
</tr>	
<tr>
	<td class="smalldatarow" width="125" align="center" height="18">спож.</td>

	<td class="smalldatarow" width="100" align="center">спож.</td>
	<td class="smalldatarow" width="100" align="center">генер.</td>
</tr>	
</table>
				
<jsp:include page="month.jsp" flush="true" />

<font size="-2"><br>Енергоаудит 5.4 (с)<br><br></font>
</div>
</body>
</html>
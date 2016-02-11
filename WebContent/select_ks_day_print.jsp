<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page import="ua.datapark.commons.Basic" %>
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
	
	ArrayList Points = c.getPoints(ks);
	String[] str = new String[Points.size()+1];
	str[0]="<b>Всього по фідерах</b>";
	for (int i=1; i < Points.size()+1; i++) {
		Point p = (Point)Points.get(i-1);
		str[i] = p.point_name;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Таблиця споживання та генерації електроенергії</title>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
</head>
<body>
<div align="center">
	<table>
	<tr><td colspan="3" class="pad" style="font-size: 1.4em; border-bottom: 1px solid #707070">Таблиця споживання та генерації електроенергії</td></tr>
	<tr><td colspan="3" class="pad"></td></tr>
	<tr><td class="pad">Споживач: <b><%= c.getKsName(ks) %> <%= c.getUmgName() %></td>
	<td class="pad"></td>
	<td class="pad" valign="top">Дата: <span style="color: #3A53E3"><b><%= day %> <%= Basic.monthNameRod(Integer.parseInt(month)) %> <%= year %> р.</b></span></td></tr>
	</table>
	<br>
<jsp:include page="select_ks_day.jsp" flush="true" />

<font size="-2"><br>Енергоаудит 5.4 (с)<br><br></font>
</div>

</body>
</html>
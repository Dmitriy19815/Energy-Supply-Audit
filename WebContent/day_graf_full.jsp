<%@ page pageEncoding="Windows-1251"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._RangeDay" />
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page import="ua.datapark.commons.Basic" %>
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

	if ( (ks==null && obl==null) || point==null || day==null || month==null || year==null) { return; }
	
	//определение флага пересчета
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }
	
	if (point.equals("0")) {
		cc.loadDataZeroDay(ks, day+"-"+month+"-"+year, recalc);
	} else {
		cc.loadDataDay(point, day+"-"+month+"-"+year, recalc);
	}
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
</head>
<body>
<% if (cc.DataDaySize()<1) { %>
<br><br>
<table class="datahead" align="center">
<tr><td align="center" height="40" width="600">дані відсутні</td></tr>
</table>
<% } else { %>
	<table>
	<tr><td colspan="3" class="pad" style="font-size: 1.4em; border-bottom: 1px solid #707070">Графік споживання та генерації електроенергії</td></tr>
	<tr><td colspan="3" class="pad"></td></tr>
	<tr>
		<td class="pad">
			<table>
				<tr><td class="pad" align="right">Споживач: </td><td class="pad"><b><%= c.getKsName(ks) %> <%= c.getUmgName() %></b></td></tr>
				<tr><td class="pad" align="right">Точка: </td><td class="pad"><b><%= c.getPointName(point) %></b></td></tr>
			</table>
		</td>
		<td class="pad"></td>
		<td class="pad" valign="top">Дата: <span style="color: #3A53E3"><b><%= day %> <%= Basic.monthNameRod(Integer.parseInt(month)) %> <%= year %> р.</b></span></td>
	</tr>
	</table>
	<br>	
<jsp:include page="day_graf.jsp" flush="true" />
<% } %>
<table><tr><td height="5"></td></tr></table>

</body>
</html>
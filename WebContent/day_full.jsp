<%@ page pageEncoding="Windows-1251"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
	<script type="text/javascript">
		IE = (document.all); // Internet Explorer
		NC = (document.layers); // Netscape
		Opera = (document.getElementById); // Opera

		function getHeight() { // Получаем высоту рабочей области браузера
			if (IE || Opera) send = document.body.clientHeight;
			if (NC) send = window.innerHeight;
			return send;
		}

		function getWidth() { // Получаем ширину рабочей области браузера
			if (IE || Opera) send = document.body.clientWidth;
			if (NC) send = window.innerWidth;
			return send;
		}

		function putLayer() {
			j = getHeight();
			jj = document.getElementById('iframe').offsetTop;
			document.getElementById("iframe").height = j - jj;
		}
	 	window.onresize = putLayer;	
	 	window.onload = putLayer;	
	</script>	
</head>
<body>
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
	<td class="pad" valign="top">Дата: <span style="color: #3A53E3"><b><%= day %> <%= Basic.monthNameRod(Integer.parseInt(month)) %> <%= year %> р.</b></span></td></tr>
</table>
<br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr>
	<td class="datarow" width="120" rowspan="3" align="center">Час</td>
	<td class="datarow" width="40" rowspan="3" align="center">Тариф</td>
	<td class="datarow" align="center" colspan="5" height="18">Енергія</td>
</tr>
<tr>
	<td class="smalldatarow" align="center" height="18" colspan="1">Активна<% if (recalc.equals("on")) {  %>, кВт•год<% } %></td>
	<td class="smalldatarow" align="center" height="18" colspan="3">Реактивна<% if (recalc.equals("on")) {  %>, квар•год<% } %></td>
</tr>	
<tr>
	<td class="smalldatarow" width="100" align="center" height="18">спож.</td>

	<td class="smalldatarow" width="75" align="center">спож.</td>
	<td class="smalldatarow" width="75" align="center">генер.</td>
</tr>	
</table>

<IFRAME id="iframe" FRAMEBORDER="0" SRC="day_frame.jsp?zvit=day&amp;recalc=<%= recalc %>&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year=<%= year %>&amp;month=<%= month %>&amp;day=<%= day %>" WIDTH="500" HEIGHT="80%"></IFRAME>

</body>
</html>
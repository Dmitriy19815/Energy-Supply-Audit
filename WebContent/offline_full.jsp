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

	String day1 = request.getParameter("day1");
	String month1 = request.getParameter("month1");
	String year1 = request.getParameter("year1");

	String day2 = request.getParameter("day2");
	String month2 = request.getParameter("month2");
	String year2 = request.getParameter("year2");
	
	if ( (ks==null && obl==null) || point==null ) { return; }
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<title></title>
	<link rel="stylesheet" href="style.css" type="text/css">
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
	<tr><td colspan="3" class="pad" style="font-size: 1.4em; border-bottom: 1px solid #707070">Таблиця відключень</td></tr>
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
	<td class="datarow" width="80" align="center">Дата</td>
	<td class="datarow" width="70" align="center">Час</td>
	<td class="datarow" width="350" align="center" height="30">Опис</td>
	<td class="datarow" width="200" align="center">Примітка</td>
</tr>
</table>
<IFRAME id="iframe" FRAMEBORDER="0" SRC="offline_frame.jsp?ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" WIDTH="780" HEIGHT="80%"></IFRAME>

</body>
</html>
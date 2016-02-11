<%@ page pageEncoding="Windows-1251"%>
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
	
	//определение флага пересчета
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Довідка про показники приладів обліку та використання електроенергії</title>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
</head>
<body>
<div align="center">
<table>
	<tr><td align="center" class="pad" style="font-size: 1.4em; border-bottom: 1px solid #707070">ДОВІДКА<br>про показники приладів обліку та використання електроенергії</td></tr>
	<tr><td class="pad"></td></tr>
	<tr><td align="center" class="pad">Споживач: <b><%= c.getKsName(ks) %> <%= c.getUmgName() %></b></td></tr>
	<tr><td align="center" class="pad">
		за період з <span style="color: #3A53E3"><b><%= day1 %> <%= Basic.monthNameRod(Integer.parseInt(month1)) %> <%= year1 %> р.</b></span>
		по <span style="color: #3A53E3"><b><%= day2 %> <%= Basic.monthNameRod(Integer.parseInt(month2)) %> <%= year2 %> р.</b></span>
	</td></tr>
</table>
<br>
<jsp:include page="dovidka_a.jsp" flush="true" />
<br><br><br>
<jsp:include page="dovidka_rp.jsp" flush="true" />
<br><br><br>
<jsp:include page="dovidka_rm.jsp" flush="true" />

<font size="-2"><br>Енергоаудит 5.4 (с)<br><br></font>

</div>
</body>
</html>
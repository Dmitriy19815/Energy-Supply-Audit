<%@ page extends="ua.datapark.jsp.SecureJSP"%>
<%@ page language="java" contentType="text/html; charset=Windows-1251" pageEncoding="Windows-1251"%>
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page import="ua.datapark.commons.Basic" %>
<%	//инициализаци€ даты
	String current_date = Basic.toDay("");
	String year = request.getParameter("year");
	if (year==null || year.equals("")) { year = current_date.substring(0,4); }
	String month = request.getParameter("month");
	if (month==null || month.equals("")) { month = current_date.substring(5,7); }
	String day = request.getParameter("day");
	if (day==null || day.equals("")) { day = current_date.substring(8,10); }

	String year1 = request.getParameter("year1");
	if (year1==null || year1.equals("")) { year1 = current_date.substring(0,4); }
	String month1 = request.getParameter("month1");
	if (month1==null || month1.equals("")) { month1 = current_date.substring(5,7); }
	String day1 = request.getParameter("day1");
	if (day1==null || day1.equals("")) { day1 = current_date.substring(8,10); }

	String year2 = request.getParameter("year2");
	if (year2==null || year2.equals("")) { year2 = current_date.substring(0,4); }
	String month2 = request.getParameter("month2");
	if (month2==null || month2.equals("")) { month2 = current_date.substring(5,7); }
	String day2 = request.getParameter("day2");
	if (day2==null || day2.equals("")) { day2 = current_date.substring(8,10); }

	String ks = request.getParameter("ks")!=null ? request.getParameter("ks") : "";
	String obl = request.getParameter("obl") !=null ? request.getParameter("obl") : "";
	String point = request.getParameter("point") !=null ? request.getParameter("point") : "0";

	//определение флага пересчета
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }

	//«ј√Ћ”Ў ј RECALC
	recalc = "on";
	
	//определение флага типа страницы
	String zvit = request.getParameter("zvit");
	if (zvit==null || zvit.equals("")) { zvit = "total"; }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<title><%= c.getUmgName() %> :: ≈нергоаудит 5.4</title>
	<link rel="stylesheet" href="style.css" type="text/css">
	<link rel="icon" href="images/audit.ico" type="image/x-icon">
	<script type="text/javascript">
		function menu_on() {
			document.getElementById('menu').style.display='';	
		}
		function menu_off() {
			document.getElementById('menu').style.display='none';	
		}
	</script>
</head>
<body>
<table cellspacing="0" cellpadding="0" width="100%" height="100%"> 
<tr><td colspan="3" height="21">
	<table width="100%" style="border-bottom: 1px solid #FFA500">
	<tr>
		<td width="210" class="pad">меню:&nbsp;<a href="javascript:menu_on();">показати</a>&nbsp;|&nbsp;<a href="javascript:menu_off();">сховати</a></td>
		<td width="110" class="pad"><a target="_blank" id="printlink" href="data.html">верс≥€ дл€ друку</a></td>
		<td class="pad"> </td>		
		<td align="right" class="pad" style="font-size: 1.2em"><%= c.getUmgName() %></td>
		<td width="160" class="pad" align="center" style="font: bold 1.2em Verdana; border-left: 1px solid #FFA500">≈нергоаудит 5.4</td>
		<td width="120" class="kolon" align="center"><b><a style="color:white" target="_blank" href="help/">допомога</a>&nbsp;Х&nbsp;<a style="color:white" target="_top" href="logon.jsp">вих≥д</a></b></td>
	</tr>
	</table>
</td></tr>
<tr>
	<td width="210" id="menu" valign="top"><jsp:include page="menu.jsp" flush="true" /></td>
	<td width="98%" valign="top" style="padding: 10px 0px 0px 10px"><IFRAME onload="complete();" id="destination" WIDTH="100%" HEIGHT="100%" FRAMEBORDER="0" SRC="data.html" align="left"></IFRAME></td>
</tr>
</table>

</body>
</html>

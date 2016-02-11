<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page import="ua.datapark.commons.Basic" %>
<jsp:useBean id="d" scope="page" class="ua.datapark.audit._Dogovor"/>
<%@ page import="ua.datapark.audit.Dogovor" %>
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

	String value = d.loadDogovor(ks,obl,year1+"-"+month1+"-"+day1,year2+"-"+month2+"-"+day2);
	
	if (!value.equals("")) {
		if (value.equals("more_than_2_dogovors")) { %>
			<div style="color: red">Більше двох договорів за цей період!</div>
		<% return; 
		} else {
			if (value.equals("no_dogovors")) { %>
				<div style="color: red">Договір за цей період відсутній, або інтервал дат запиту виходить за межі одного договора!</div>
			<% return; }
		}
	}
	
	Dogovor dg = d.getDogovor();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
</head>
<body>
<table style="width: 950">
	<tr><td class="pad" style="font-family: times; font-size: 1.4em; text-align: center; font-weight: bold;" >Акт про обсяги спожитої (переданої) споживачу (субспоживачу) електричної енергії<br>
	протягом розрахункового періоду від <span style="color: #3A53E3; text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%= day1 %>.<%= month1 %>.<%= year1 %>р.&nbsp;&nbsp;&nbsp;&nbsp;</b></span> до <span style="color: #3A53E3; text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%= day2 %>.<%= month2 %>.<%= year2 %>р.&nbsp;&nbsp;&nbsp;&nbsp;</span></td></tr>
	<tr><td class="pad"></td></tr>
	<tr><td class="pad" style=" font-family: times; text-align: right; font-size: 1.4em; text-decoration: underline;"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= c.getLpuName(ks)  %>&nbsp;&nbsp;&nbsp;<%= c.getUmgName() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></td></tr>
	<tr><td class="pad" style=" font-family: times; text-align: right; font-size: 1.0em;">повна юридична назва Споживача</td></tr>
	<tr><td class="pad"></td></tr>
	<tr><td class="pad" style=" font-family: times; font-style: italic; text-align: right; font-size: 1.2em;">№ та дата договору <span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%= dg.nomer %>&nbsp;&nbsp;від&nbsp;&nbsp;<%= dg.dat_podpis.replace('-','.') %>&nbsp;&nbsp;&nbsp;&nbsp;</span></td></tr>
	<tr><td class="pad" style=" font-family: times; font-style: italic; text-align: right; font-size: 1.2em;">дата запису показників <span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%= day2 %>.<%= month2 %>.<%= year2 %>р.&nbsp;&nbsp;&nbsp;&nbsp;</span></td></tr>
</table>
<br> 

<jsp:include page="akt_sa.jsp" flush="true" />
<br><br><br>

<br>
</body>
</html>
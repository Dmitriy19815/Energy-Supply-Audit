<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page import="ua.datapark.commons.Basic" %>
<jsp:useBean id="d" scope="page" class="ua.datapark.audit._Dogovor"/>
<%@ page import="ua.datapark.audit.Dogovor" %>
<%	//������������ ���������
	String ks = request.getParameter("ks");
	String obl = request.getParameter("obl");
	if (ks==null && obl==null) { %>�� ������ ������<br><%  }
	String point = request.getParameter("point");
	if (point==null) { %>�� ������� �����<br><%  }

	String day1 = request.getParameter("day1");
	String month1 = request.getParameter("month1");
	String year1 = request.getParameter("year1");

	String day2 = request.getParameter("day2");
	String month2 = request.getParameter("month2");
	String year2 = request.getParameter("year2");
	
	if ( (ks==null && obl==null) || point==null ) { return; }
	
	//����������� ����� ���������
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }

	String value = d.loadDogovor(ks,obl,year1+"-"+month1+"-"+day1,year2+"-"+month2+"-"+day2);
	
	if (!value.equals("")) {
		if (value.equals("more_than_2_dogovors")) { %>
			<div style="color: red">������ ���� �������� �� ��� �����!</div>
		<% return; 
		} else {
			if (value.equals("no_dogovors")) { %>
				<div style="color: red">������ �� ��� ����� �������, ��� �������� ��� ������ �������� �� ��� ������ ��������!</div>
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
	<tr><td class="pad" style="font-family: times; font-size: 1.4em; text-align: center; font-weight: bold;" >��� ��� ������ ������� (��������) ��������� (������������) ���������� ����㳿<br>
	�������� �������������� ������ �� <span style="color: #3A53E3; text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%= day1 %>.<%= month1 %>.<%= year1 %>�.&nbsp;&nbsp;&nbsp;&nbsp;</b></span> �� <span style="color: #3A53E3; text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%= day2 %>.<%= month2 %>.<%= year2 %>�.&nbsp;&nbsp;&nbsp;&nbsp;</span></td></tr>
	<tr><td class="pad"></td></tr>
	<tr><td class="pad" style=" font-family: times; text-align: right; font-size: 1.4em; text-decoration: underline;"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= c.getLpuName(ks)  %>&nbsp;&nbsp;&nbsp;<%= c.getUmgName() %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></td></tr>
	<tr><td class="pad" style=" font-family: times; text-align: right; font-size: 1.0em;">����� �������� ����� ���������</td></tr>
	<tr><td class="pad"></td></tr>
	<tr><td class="pad" style=" font-family: times; font-style: italic; text-align: right; font-size: 1.2em;">� �� ���� �������� <span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%= dg.nomer %>&nbsp;&nbsp;��&nbsp;&nbsp;<%= dg.dat_podpis.replace('-','.') %>&nbsp;&nbsp;&nbsp;&nbsp;</span></td></tr>
	<tr><td class="pad" style=" font-family: times; font-style: italic; text-align: right; font-size: 1.2em;">���� ������ ��������� <span style="text-decoration: underline;">&nbsp;&nbsp;&nbsp;&nbsp;<%= day2 %>.<%= month2 %>.<%= year2 %>�.&nbsp;&nbsp;&nbsp;&nbsp;</span></td></tr>
</table>
<br> 

<jsp:include page="akt_sa.jsp" flush="true" />
<br><br><br>

<br>
</body>
</html>
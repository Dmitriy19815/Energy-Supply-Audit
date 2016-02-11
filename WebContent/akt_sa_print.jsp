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
				<div style="color: red">������ �� ��� ����� �������!</div>
			<% return; }
		}
	}
	
	Dogovor dg = d.getDogovor();	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>��� ��� ������ ������� (��������) ��������� (������������) ���������� ����㳿 :: ����������� 5.4</title>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
</head>
<body>
<div align="center">
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
<br>
<jsp:include page="akt_sa.jsp" flush="true" />

<table style="width: 950">
	<tr><td colspan="2" class="pad" style="font-family: times; font-size: 0.9em;" >� ������� 4 ������� ���� �: �� &#151; ���������� ������� �����������㳿, �� &#151; ���������� ��������� �����������㳿; �� &#151; ��������� ��������� �����������㳿<br>
	<tr><td colspan="2" class="pad" style="height: 30px;"></td></tr>
	<tr><td colspan="2"class="pad" style="font-family: times; text-align: center;  font-size: 1.4em; font-weight: bold;">ϳ����� �����</td></tr>
	
	<tr><td colspan="2" class="pad"></td></tr>
	<tr>
		<td class="pad" style=" font-family: times; text-align: center; font-size: 1.4em;">������������ ���������� ����㳿</td>
		<td class="pad" style=" font-family: times; text-align: center; font-size: 1.4em;">�������� ���������� ����㳿</td>
	</tr>
	<tr><td colspan="2" class="pad"></td></tr>
	<tr>
		<td class="pad" style=" font-family: times; text-align: center; font-size: 1.4em;">_____________________________________<br>_____________________________________</td>
		<td class="pad" style=" font-family: times; text-align: center; font-size: 1.4em;">_____________________________________<br>_____________________________________</td>
	</tr>
	<tr><td colspan="2" class="pad"></td></tr>
	<tr>
		<td class="pad" style=" font-family: times; text-align: center; font-size: 1.4em;">�.�.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td class="pad" style=" font-family: times; text-align: center; font-size: 1.4em;">�.�.&nbsp;&nbsp;&nbsp;&nbsp;</td>
	</tr>
	<tr><td colspan="2" class="pad"></td></tr>
	<tr>
		<td class="pad" style=" font-family: times; text-align: center; font-size: 1.4em;">"____"________________&nbsp;&nbsp;______ p.</td>
		<td class="pad" style=" font-family: times; text-align: center; font-size: 1.4em;">"____"________________&nbsp;&nbsp;______ p.</td>
	</tr>
</table>
<br>
<br><br><br>
<div style=" font-family: times; text-align: center; font-size: 0.8em;"><br>����������� 5.4 (�)<br><br></div>

</div>
</body>
</html>
<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page import="ua.datapark.commons.Basic" %>
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
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>������� ���������</title>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
</head>
<body>

<table cellpadding="0" cellspacing="0">
<tr><td height="10"></td></tr>
</table>

<div align="center">
<table>
	<tr><td colspan="3" class="pad" style="font-size: 1.4em; border-bottom: 1px solid #707070">������� ���������</td></tr>
	<tr><td colspan="3" class="pad"></td></tr>

	<tr><td class="pad">
		<table>
			<tr><td class="pad" align="right">��������: </td><td class="pad"><b><%= c.getKsName(ks) %> <%= c.getUmgName() %></b></td></tr>
			<tr><td class="pad" align="right">�����: </td><td class="pad"><b><%= c.getPointName(point) %></b></td></tr>
		</table>
	</td>
	<td class="pad"></td>
	<td class="pad">
		<table>
			<tr><td class="pad" align="right">������� ������: </td><td class="pad" style="color: #3A53E3"><b><%= day1 %> <%= Basic.monthNameRod(Integer.parseInt(month1)) %> <%= year1 %> �.</b></td></tr>
			<tr><td class="pad" align="right">ʳ���� ������: </td><td class="pad" style="color: #3A53E3"><b><%= day2 %> <%= Basic.monthNameRod(Integer.parseInt(month2)) %> <%= year2 %> �.</b></td></tr>
		</table>
	</td></tr>
</table>
<br>

<table class="datahead" cellpadding="0" cellspacing="0">
<tr>
	<td class="datarow" width="80" align="center">����</td>
	<td class="datarow" width="70" align="center">���</td>
	<td class="datarow" width="350" align="center" height="30">����</td>
	<td class="datarow" width="200" align="center">�������</td>
</tr>
</table>

<jsp:include page="offline_frame.jsp" flush="true" />

<font size="-2"><br>����������� 5.4 (�)<br><br></font>
</div>

</body>
</html>
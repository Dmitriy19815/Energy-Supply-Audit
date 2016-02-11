<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page import="ua.datapark.commons.Basic" %>
<%@ page import="ua.datapark.audit.Point" %>
<%@ page import="java.util.*;" %>
<%	//������������ ���������
	String ks = request.getParameter("ks");
	String obl = request.getParameter("obl");
	if (ks==null && obl==null) { %>�� ������ ������<br><%  }
	String point = request.getParameter("point");
	if (point==null) { %>�� ������� �����<br><%  }

	String day = request.getParameter("day");
	if (day==null) { %>�� ������ ����<br><% }
	String month = request.getParameter("month");
	if (month==null) { %>�� ������ �����<br><% }
	String year = request.getParameter("year");
	if (year==null) { %>�� ������ ���<br><% }

	if ( (ks==null && obl==null) || point==null 
		|| day==null || month==null || year==null ) { return; }

	//����������� ����� ���������
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }
	
	ArrayList Points = c.getPoints(ks);
	String[] str = new String[Points.size()+1];
	str[0]="<b>������ �� �������</b>";
	for (int i=1; i < Points.size()+1; i++) {
		Point p = (Point)Points.get(i-1);
		str[i] = p.point_name;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>������� ���������� �� ��������� �����������㳿</title>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
</head>
<body>
<div align="center">
	<table>
	<tr><td colspan="3" class="pad" style="font-size: 1.4em; border-bottom: 1px solid #707070">������� ���������� �� ��������� �����������㳿</td></tr>
	<tr><td colspan="3" class="pad"></td></tr>
	<tr><td class="pad">��������: <b><%= c.getKsName(ks) %> <%= c.getUmgName() %></td>
	<td class="pad"></td>
	<td class="pad" valign="top">����: <span style="color: #3A53E3"><b><%= day %> <%= Basic.monthNameRod(Integer.parseInt(month)) %> <%= year %> �.</b></span></td></tr>
	</table>
	<br>
<jsp:include page="select_ks_day.jsp" flush="true" />

<font size="-2"><br>����������� 5.4 (�)<br><br></font>
</div>

</body>
</html>
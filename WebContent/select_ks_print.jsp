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

	String day1 = request.getParameter("day1");
	if (day1==null) { %>�� ������ ���� 1<br><% }
	String month1 = request.getParameter("month1");
	if (month1==null) { %>�� ������ ����� 1<br><% }
	String year1 = request.getParameter("year1");
	if (year1==null) { %>�� ������ ��� 1<br><% }

	String day2 = request.getParameter("day2");
	if (day2==null) { %>�� ������ ���� 2<br><% }
	String month2 = request.getParameter("month2");
	if (month2==null) { %>�� ������ ����� 2<br><% }
	String year2 = request.getParameter("year2");
	if (year2==null) { %>�� ������ ��� 2<br><% }

	if ( (ks==null && obl==null) || point==null 
		|| day1==null || month1==null || year1==null
		|| day2==null || month2==null || year2==null ) { return; }

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

<table width="100%"><tr><td height="5"></td></tr></table>

<div align="center">
<table>
	<tr><td colspan="3" class="pad" style="font-size: 1.4em; border-bottom: 1px solid #707070">������� ���������� �� ��������� �����������㳿</td></tr>
	<tr><td colspan="3" class="pad"></td></tr>
	<tr><td class="pad" valign="top">
		<table>
			<tr><td class="pad" align="right">��������: </td><td class="pad"><b><%= c.getKsName(ks) %> <%= c.getUmgName() %></b></td></tr>
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

<jsp:include page="select_ks.jsp" flush="true">
	<jsp:param name="print" value="yes" />
</jsp:include>

<font size="-2"><br>����������� 5.4 (�)<br><br></font>
</div>

</body>
</html>
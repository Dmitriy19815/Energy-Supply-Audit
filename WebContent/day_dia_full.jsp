<%@ page pageEncoding="Windows-1251"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page import="ua.datapark.commons.Basic" %>
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

	if ( (ks==null && obl==null) || point==null || day==null || month==null || year==null) { return; }
	
	//����������� ����� ���������
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
</head>
<body>

<table>
<tr><td colspan="3" class="pad" style="font-size: 1.4em; border-bottom: 1px solid #707070">ĳ������ �������� �������� ������ �����������㳿 �� ��������</td></tr>
<tr><td colspan="3" class="pad"></td></tr>
<tr>
	<td class="pad">
		<table>
			<tr><td class="pad" align="right">��������: </td><td class="pad"><b><%= c.getKsName(ks) %> <%= c.getUmgName() %></b></td></tr>
			<tr><td class="pad" align="right">�����: </td><td class="pad"><b><%= c.getPointName(point) %></b></td></tr>
		</table>
	</td>
	<td class="pad"></td>
	<td class="pad" valign="top">����: <span style="color: #3A53E3"><b><%= day %> <%= Basic.monthNameRod(Integer.parseInt(month)) %> <%= year %> �.</b></span></td></tr>
</table>
<br>
		
<b>������� ������<br>
	<img src="pied_a.jsp?zvit=chartm&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year=<%= year %>&amp;month=<%= month %>&amp;day=<%= day %>" ><br><br>						
	��������� ������ (����������)<br>
	<img src="pied_rp.jsp?zvit=chartm&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year=<%= year %>&amp;month=<%= month %>&amp;day=<%= day %>" ><br><br>
	��������� ������ (���������)<br>
	<img src="pied_rm.jsp?zvit=chartm&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year=<%= year %>&amp;month=<%= month %>&amp;day=<%= day %>" ><br><br>
</b>

<table><tr><td height="5"></td></tr></table>

</body>
</html>
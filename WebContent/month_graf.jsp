<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._Range"/>
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page import="ua.datapark.commons.Basic" %>
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

	if (point.equals("0")) {
		cc.loadDataRangeZero(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, recalc);
	} else {
		cc.loadDataRange(point, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, recalc);
	}
%>
<% if (cc.DataRangeSize() <2) { %>
<br><br>
<table class="datahead" align="center">
<tr><td align="center" height="40" width="600">��� ������</td></tr>
</table>
<% } else { %>

<table>
	<tr><td colspan="3" class="pad" style="font-size: 1.4em; border-bottom: 1px solid #707070">������ ���������� �� ��������� �����������㳿</td></tr>
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

	<b>1. ������� ������</b><br><br>
	<img src="chartm_a.jsp?recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>">
	<br><br>
	<b>2. ���������� ������ (���������� �� ���������)</b><br><br>
	<img src="chartm_r.jsp?recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>">
<br>
<% } %>

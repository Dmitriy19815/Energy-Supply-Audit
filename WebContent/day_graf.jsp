<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._RangeDay" />
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
	
	if (point.equals("0")) {
		cc.loadDataZeroDay(ks, day+"-"+month+"-"+year, recalc);
	} else {
		cc.loadDataDay(point, day+"-"+month+"-"+year, recalc);
	}
%>
<% if (cc.DataDaySize()<1) { %>
<table class="data">
<tr><td align="center" height="40" width="700">��� ������</td></tr>
</table>
<% } else { %>
	������� ������<br>
	<img src="chartd_a.jsp?recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year=<%= year %>&amp;month=<%= month %>&amp;day=<%= day %>" >
	<br><br>
	���������� ������ (���������� �� ���������)<br>
	<img src="chartd_r.jsp?recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year=<%= year %>&amp;month=<%= month %>&amp;day=<%= day %>" >
	</b>
<% } %>

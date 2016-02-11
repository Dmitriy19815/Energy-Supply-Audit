<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._RangeDay" />
<%	//об€зательные параметры
	String ks = request.getParameter("ks");
	String obl = request.getParameter("obl");
	if (ks==null && obl==null) { %>не указан объект<br><%  }
	String point = request.getParameter("point");
	if (point==null) { %>не указана точка<br><%  }
	String day = request.getParameter("day");
	if (day==null) { %>не указан день<br><% }
	String month = request.getParameter("month");
	if (month==null) { %>не указан мес€ц<br><% }
	String year = request.getParameter("year");
	if (year==null) { %>не указан год<br><% }

	if ( (ks==null && obl==null) || point==null || day==null || month==null || year==null) { return; }
	
	//определение флага пересчета
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
<tr><td align="center" height="40" width="700">дан≥ в≥дсутн≥</td></tr>
</table>
<% } else { %>
	јктивна енерг≥€<br>
	<img src="chartd_a.jsp?recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year=<%= year %>&amp;month=<%= month %>&amp;day=<%= day %>" >
	<br><br>
	–еактивна€ енерг≥€ (споживанн€ та генерац≥€)<br>
	<img src="chartd_r.jsp?recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year=<%= year %>&amp;month=<%= month %>&amp;day=<%= day %>" >
	</b>
<% } %>

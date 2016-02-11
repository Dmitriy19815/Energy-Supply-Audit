<%@ page pageEncoding="Windows-1251"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._RangeDay"/>
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
<table class="data" cellspacing="0" cellpadding="0">
<% if (cc.DataDaySize()<1) { %>
<tr><td height="2" ></td></tr>
<tr><td class="c" align="center" height="40" width="446">дан≥ в≥дсутн≥</td></tr>
<tr><td height="2" ></td></tr>
<% } else { %>
<tr><td colspan="50" height="2" ></td></tr>
<% for (int i=0; i<cc.DataDaySize(); i++) { 
	
//	h = Long.parseLong((c.getDataDayByName(i,"h")));
//	hh = h / 2;
//	mm = (h % 2)*30;
%>
<tr>
	<td class="c" width="120" align="center"><%= cc.getDataDayByName(i,"parameter_description") %></td>

	<td width="40" class=<%= "z"+cc.getDataDayByName(i,"zval") %> align="center"><%= cc.getDataDayByName(i,"zval") %></td>
	<td width="100" class=<%= "z"+cc.getDataDayByName(i,"zval") %> align="right"><%= cc.getDataDayByName(i,"data_p_qua") %></td>
	<td width="75" class=<%= "z"+cc.getDataDayByName(i,"zval") %> align="right"><%= cc.getDataDayByName(i,"data_q_qua") %></td>
	<td width="75" class=<%= "z"+cc.getDataDayByName(i,"zval") %> align="right"><%= cc.getDataDayByName(i,"data_q_gen") %></td>
</tr>
<% } %>
<tr><td colspan="5" height="2" ></td></tr>
<% } %>

</table>
<table><tr><td height="5"></td></tr></table>
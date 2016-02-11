<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._Offline"/>
<%@ page import="ua.datapark.commons.Basic" %>
<%	//об€зательные параметры
	String ks = request.getParameter("ks");
	String obl = request.getParameter("obl");
	if (ks==null && obl==null) { %>не указан объект<br><%  }
	String point = request.getParameter("point");
	if (point==null) { %>не указана точка<br><%  }

	String day1 = request.getParameter("day1");
	if (day1==null) { %>не указан день 1<br><% }
	String month1 = request.getParameter("month1");
	if (month1==null) { %>не указан мес€ц 1<br><% }
	String year1 = request.getParameter("year1");
	if (year1==null) { %>не указан год 1<br><% }

	String day2 = request.getParameter("day2");
	if (day2==null) { %>не указан день 2<br><% }
	String month2 = request.getParameter("month2");
	if (month2==null) { %>не указан мес€ц 2<br><% }
	String year2 = request.getParameter("year2");
	if (year2==null) { %>не указан год 2<br><% }
	
	if ( (ks==null && obl==null) || point==null 
			|| day1==null || month1==null || year1==null
			|| day2==null || month2==null || year2==null ) { return; }
	
	if (point.equals("0")) {
		//c.loadDataRangeOfflineZero(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2);
	} else {
		cc.loadDataRangeOffline(point, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2);
	}
%>

<table class="data" cellpadding="0" cellspacing="0">

<%	if ( cc.DataRangeOfflineSize()<1 ) { %>
	<tr><td height="2"></td></tr>
	<tr><td class="c" align="center" height="40" width="727">дан≥ в≥дсутн≥</td></tr>
	<tr><td height="2"></td></tr>
<% } else { 
	String last_dat = "";
	String cls = "c"; %>
	<% for (int i=0; i<cc.DataRangeOfflineSize(); i++) { %>
		<% if (cc.getDataRangeOfflineByName(i,"h").equals("64")) { cls = "z3"; } else { cls = "c"; } %>
			<% if (!last_dat.equals(cc.getDataRangeOfflineByName(i,"dat"))) { %>
				<tr><td colspan="4" height="2"></td></tr>
			<% } %>
		<tr>
			<% if (!last_dat.equals(cc.getDataRangeOfflineByName(i,"dat"))) { %>
				<td class="c" width="80" valign="top" align="center" rowspan="<%= Integer.parseInt(cc.getDataRangeOfflineByName(i,"num")) %>"><%= cc.getDataRangeOfflineByName(i,"dat") %></td>
			<% } %>
			<td class="<%= cls %>" width="70" align="center"><%= cc.getDataRangeOfflineByName(i,"actualtime") %></td>
			<td class="<%= cls %>" width="350" ><%= cc.getDataRangeOfflineByName(i,"parameter_description") %></td>
			<td class="<%= cls %>" width="200"><%= cc.getDataRangeOfflineByName(i,"notes") %></td>
		</tr>
	<%  last_dat = cc.getDataRangeOfflineByName(i,"dat");
	} %>
	<tr><td colspan="4" height="2"></td></tr>
<% } %>

</table>
<table cellpadding="0" cellspacing="0">
<tr><td height="5"></td></tr>
</table>

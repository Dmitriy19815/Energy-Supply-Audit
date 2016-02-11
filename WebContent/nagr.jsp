<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._Power"/>
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

	if ( ks==null || point==null 
			|| day1==null || month1==null || year1==null
			|| day2==null || month2==null || year2==null ) {  }

	//определение флага пересчета
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }
	
	cc.loadDataRangePower(point, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, recalc);
%>
<table class="data" cellpadding="0" cellspacing="0">
<% if (cc.DataRangePowerSize()<1) { %>
<tr><td height="2"></td></tr>
<tr><td class="c" align="center" height="40" width="672">дан≥ в≥дсутн≥</td></tr>
<tr><td height="2"></td></tr>
<% } else { %>
<% for (int i=0; i<cc.DataRangePowerSize(); i++) { %>
	<% for (int k=1; k<4; k++) { %>
		<% if (k==1) { %>
			<tr><td colspan="9" height="2" ></td></tr>
			<tr>
				<td class="c" width="70" rowspan="3"><%= cc.getDataRangePowerByName(i,"dat") %></td>
		<% } else { %>
			<tr>
		<% } %>
			<td width="40" class=<%= "z"+k %> align="center"><%= k %></td>
			<td width="65" class=<%= "z"+k %> align="right"><%= cc.getDataRangePowerByName(i,"time_p_qua_"+k) %></td>
			<td width="65" class=<%= "z"+k %> align="right"><%= cc.getDataRangePowerByName(i,"p_qua_"+k) %></td>
			<td width="65" class=<%= "z"+k %> align="right"><%= cc.getDataRangePowerByName(i,"time_q_qua_"+k) %></td>
			<td width="65" class=<%= "z"+k %> align="right"><%= cc.getDataRangePowerByName(i,"q_qua_"+k) %></td>
			<td width="65" class=<%= "z"+k %> align="right"><%= cc.getDataRangePowerByName(i,"time_q_gen_"+k) %></td>
			<td width="65" class=<%= "z"+k %> align="right"><%= cc.getDataRangePowerByName(i,"q_gen_"+k) %></td>
			<td width="100" class=<%= "z"+k %>><%= cc.getDataRangePowerByName(i,"notes") %></td>
		</tr>
	<% } %>
<% } %>
<tr><td colspan="9" height="2"></td></tr>
<% } %>
</table>
<table cellpadding="0" cellspacing="0">
<tr><td height="5"></td></tr>
</table>

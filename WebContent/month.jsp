<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._Range" />
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
	
	//определение флага пересчета
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }
	
	String value = "";
	if (point.equals("0")) {
		value = cc.loadDataRangeZero(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, recalc);
	} else {
		cc.loadDataRange(point, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, recalc);
	}
%>
<script type="text/javascript"><!--
	parent.parent.mess('<%= value %>');
//--></script>

<table class="data" cellpadding="0" cellspacing="0">
<% if ( cc.DataRangeSize()<2 ) { %>
<tr><td height="2"></td></tr>
<tr><td align="center" height="40" width="521" class="c">дан≥ в≥дсутн≥</td></tr>
<tr><td height="2"></td></tr>

<% } else { %>
	<% for (int i=0; i<cc.DataRangeSize(); i++) { %>
		<% for (int k=0; k<4; k++) { %>
			<% if (k==0) { %>
				<tr><td colspan="5" height="2" ></td></tr>
				<tr>
					<td class="c" width="120" rowspan="4">
					<% if (!cc.getDataRangeByName(i,"h").equals("50")) { %>
						<a onclick="parent.parent.menu.start();parent.parent.menu.mform.zvit.value='day';parent.parent.menu.zvitselect(parent.parent.menu.document.getElementById('_day'));parent.parent.menu.mform.day.value='<%= cc.getDataRangeByName(i,"dat").substring(0,2) %>';parent.parent.menu.mform.month.value='<%= cc.getDataRangeByName(i,"dat").substring(3,5) %>';parent.parent.menu.mform.year.value='<%= cc.getDataRangeByName(i,"dat").substring(6,10) %>';" target="destination" href="data.jsp?zvit=day&amp;recalc=<%= recalc %>&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year=<%= cc.getDataRangeByName(i,"dat").substring(6,10) %>&amp;month=<%= cc.getDataRangeByName(i,"dat").substring(3,5) %>&amp;day=<%= cc.getDataRangeByName(i,"dat").substring(0,2) %>"><%= cc.getDataRangeByName(i,"dat") %></a> <%= cc.getDataRangeByName(i,"actualtime") %>
					<% } else { %>
						<b>¬сього за пер≥од</b>
					<% } %>
					</td>
			<% } else { %>
				<tr>
			<% } %>
			<td width="40" class=<%= "z"+k %> align="center"><% if (k==0) { %>всього<% } else { %><%= k %><% } %></td>
			<td width="125" class=<%= "z"+k  %> align="right"><%= cc.getDataRangeByName(i,"p_qua_"+k) %></td>
			<td width="100" class=<%= "z"+k  %> align="right"><%= cc.getDataRangeByName(i,"q_qua_"+k) %></td>
			<td width="100" class=<%= "z"+k  %> align="right"><%= cc.getDataRangeByName(i,"q_gen_"+k) %></td>
		</tr>
	<% } %>

<% } %>
<tr><td colspan="5" height="2" ></td></tr>
<% } %>
</table>
<font size="-3">час обробки запиту: <%= cc.getProcessingTime() %> c</font>
<table cellpadding="0" cellspacing="0">
<tr><td height="5"></td></tr>
</table>
<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._RangeTotal"/>
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
	
	if ( point==null 
			|| day1==null || month1==null || year1==null
			|| day2==null || month2==null || year2==null ) { return; }
	
	//����������� ����� ���������
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }

	if (!point.equals("0")) {
		cc.loadDataRangeTotal(point, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, "");
	}
%>
<table class="data" cellspacing="0" cellpadding="0">

<% if ( cc.DataRangeTotalSize()<1 ) { %>
<tr><td height="2" ></td></tr>
<tr><td class="c" align="center" height="40" width="446">��� ������</td></tr>
<tr><td height="2" ></td></tr>
<% } else { %>
	<% for (int i=0; i<cc.DataRangeTotalSize(); i++) { %>
		<% for (int k=0; k<4; k++) { %>
			<% if (k==0) { %>
				<tr><td colspan="5" height="2" ></td></tr>
				<tr>
					<td class="c" width="120" rowspan="4">
					<% if (!cc.getDataRangeTotalByName(i,"h").equals("50")) { %>
						<%= cc.getDataRangeTotalByName(i,"dat") %> <%= cc.getDataRangeTotalByName(i,"actualtime") %>
					<% } else { %>
						<b>������ �� �����</b>
					<% } %>
					</td>
			<% } else { %>
				<tr>
			<% } %>
			<td width="40" class=<%= "z"+k %> align="center"><% if (k==0) { %>������<% } else { %><%= k %><% } %></td>
			<td width="100" class=<%= "z"+k  %> align="right"><%= cc.getDataRangeTotalByName(i,"p_qua_"+k) %></td>
			<td width="75" class=<%= "z"+k  %> align="right"><%= cc.getDataRangeTotalByName(i,"q_qua_"+k) %></td>
			<td width="75" class=<%= "z"+k  %> align="right"><%= cc.getDataRangeTotalByName(i,"q_gen_"+k) %></td>
		</tr>
	<% } %>

<% } %>
<tr><td colspan="5" height="2" ></td></tr>
<% } %>

</table>
<table cellpadding="0" cellspacing="0">
<tr><td height="5"></td></tr>
</table>

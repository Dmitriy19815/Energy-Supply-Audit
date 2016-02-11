<%@ page pageEncoding="Windows-1251"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._RangeDayPoint"/>
<%@ page import="ua.datapark.commons.Basic" %>
<%@ page import="ua.datapark.audit.Point" %>
<%@ page import="java.util.*;" %>
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

	if ( (ks==null && obl==null) || point==null 
		|| day==null || month==null || year==null ) { return; }

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
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
	<script type="text/javascript">
		IE = (document.all); // Internet Explorer
		NC = (document.layers); // Netscape
		Opera = (document.getElementById); // Opera

		function getHeight() { // �������� ������ ������� ������� ��������
			if (IE || Opera) send = document.body.clientHeight;
			if (NC) send = window.innerHeight;
			return send;
		}

		function getWidth() { // �������� ������ ������� ������� ��������
			if (IE || Opera) send = document.body.clientWidth;
			if (NC) send = window.innerWidth;
			return send;
		}

		function putLayer() {
			i = getWidth();
			j = getHeight();
			ii = document.getElementById('iframe').offsetLeft;
			jj = document.getElementById('iframe').offsetTop;
			document.getElementById("iframe").width = i - ii;
			document.getElementById("iframe").height = j - jj;
		}
	 	window.onresize = putLayer;	
	 	window.onload = putLayer;	
	</script>		
</head>
<body>
	<table>
	<tr><td colspan="3" class="pad" style="font-size: 1.4em; border-bottom: 1px solid #707070">������� ���������� �� ��������� �����������㳿</td></tr>
	<tr><td colspan="3" class="pad"></td></tr>
	<tr><td class="pad">��������: <b><%= c.getKsName(ks) %> <%= c.getUmgName() %></td>
	<td class="pad"></td>
	<td class="pad" valign="top">����: <span style="color: #3A53E3"><b><%= day %> <%= Basic.monthNameRod(Integer.parseInt(month)) %> <%= year %> �.</b></span></td></tr>
	</table>
	<br>

<table class="datahead" cellspacing="0" cellpadding="0">
<tr><td align="center" class="datarow" width="80">���</td>
	<td class="datarow" width="40" align="center">�����</td>
	<% for (int k=0; k < str.length; k++) { %>
		<td class="smalldatarow" width="80" align="center"><%= str[k] %></td>
	<% } %>
</tr>
</table>

<IFRAME id="iframe" FRAMEBORDER="0" SRC="select_ks_day_frame.jsp?recalc=<%= recalc %>&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year=<%= year %>&amp;month=<%= month %>&amp;day=<%= day %>" WIDTH="850" HEIGHT="90%"></IFRAME>

</body>
</html>
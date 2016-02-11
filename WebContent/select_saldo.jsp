<%@ page pageEncoding="Windows-1251"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._RangePoint"/>
<%@ page import="ua.datapark.commons.Basic" %>
<%@ page import="ua.datapark.audit.DataVector" %>
<%@ page import="java.util.*;" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
</head>
<body>
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

	cc.loadDataRangeZeroAll(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2, "on");
	
	ArrayList ar = cc.getDataRangePoint(0);
%>
<% if (!(cc.DataRangePointSize()>1)) { %>
<table class="datahead">
<tr><td height="2"></td></tr>
<tr><td class="c" align="center" height="40" width="550">��� ������</td></tr>
<tr><td height="2"></td></tr>
</table>
<% } else { %>

<%  double z1kvt = 0, z2kvt = 0, z3kvt = 0;
	double z1kvt_sum = 0, z2kvt_sum = 0, z3kvt_sum = 0, z_kvt_sum = 0;
%>
<b>1. ������� �������������</b><br><br>
<b>1.1. ������� ������ ������� �����������㳿 �� ��'������ �����</b><br><br>
	<img src="piem_ks_a.jsp?zvit=select_saldo&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>
	
<b>1.2. ������� ������ ������� �����������㳿 �� ��������</b><br><br>
	<img src="piem_a.jsp?zvit=chartm&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>						
<b>1.3. ������� �������� ������ ������� �����������㳿</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0" width="544">
  <tr align="center"> 
    <td rowspan="2" class="datarow" width="120">�����<br>�����</td>
    <td colspan="4" class="datarow">������ �����������㳿, ���&#x00B7;�</td>
  </tr>
  
  <tr align="center"> 
    <td class="smalldatarow" width="100">����� 1<br>(�����)</td>
    <td class="smalldatarow" width="100">����� 2<br>(������)</td>
    <td class="smalldatarow" width="100">����� 3<br>(������)</td>
    <td class="smalldatarow" width="120">�������</td>
  </tr>

<%	DataVector dv; %>
<%	for (int i=0; i<ar.size()-1; i++) { 
	dv = (DataVector) ar.get(i+1); %>

	<tr align="right">
       <td class="c" align="left" nowrap><%= c.getPointName(dv.point_id) %></td>
       <td class="c"><% z1kvt = dv.getByNameDouble("p_qua_1"); z1kvt_sum += z1kvt; %>
    	       					<%= Basic.formatNumber(1,9,1,1,z1kvt) %></td>
       <td class="c"><%	z2kvt = dv.getByNameDouble("p_qua_2"); z2kvt_sum += z2kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z2kvt) %></td>
	   <td class="c"><% z3kvt = dv.getByNameDouble("p_qua_3"); z3kvt_sum += z3kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z3kvt) %></td>
       <td class="c"><%= Basic.formatNumber(1,9,1,1,dv.getByNameDouble("p_qua_0")) %></td>
	</tr>  
<% } %>

<tr align="right">
       <td class="datarow" align="center">������</td>
       <td class="c"><b><% z_kvt_sum += z1kvt_sum; %>
       	    			<%= Basic.formatNumber(1,10,1,1,z1kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z2kvt_sum;;%>
       	    			<%= Basic.formatNumber(1,10,1,1,z2kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z3kvt_sum;; %>
       					<%= Basic.formatNumber(1,10,1,1,z3kvt_sum) %></b></td>
       <td class="c"><b><%= Basic.formatNumber(1,10,1,1,z_kvt_sum) %></b></td>
</tr >
</table>

<br><br><br>


<%	z1kvt = 0; z2kvt = 0; z3kvt = 0;
	z1kvt_sum = 0; z2kvt_sum = 0; z3kvt_sum = 0; z_kvt_sum = 0; %>

<b>2 ��������� ������������� (����������)</b><br><br>
<b>2.1. ������� ������ ���������� ��������� �����������㳿 �� ��'������ �����</b><br><br>
	<img src="piem_ks_rp.jsp?zvit=select_saldo&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>
	
<b>2.2. ������� ������ ���������� ��������� �����������㳿 �� ��������</b><br><br>
	<img src="piem_rp.jsp?zvit=chartm&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>						
<b>2.3. ������� �������� ������ ���������� ��������� �����������㳿</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0">
  <tr align="center"> 
    <td rowspan="2" class="datarow" width="120">�����<br>�����</td>
    <td colspan="4" class="datarow">������ �����������㳿, ���&#x00B7;�</td>
  </tr>
  
  <tr align="center"> 
    <td class="smalldatarow" width="100">����� 1<br>
      (�����)</td>
    <td class="smalldatarow" width="100">����� 2<br>
      (������)</td>
    <td class="smalldatarow" width="100">����� 3<br>
      (������)</td>
    <td class="smalldatarow" width="120">�������</td>
  </tr>

<%	for (int i=0; i<ar.size()-1; i++) { 
	dv = (DataVector) ar.get(i+1); %>

	<tr align="right">
       <td class="c" align="left" nowrap><%= c.getPointName(dv.point_id) %></td>
       <td class="c"><% z1kvt = dv.getByNameDouble("q_qua_1"); z1kvt_sum += z1kvt; %>
    	       					<%= Basic.formatNumber(1,9,1,1,z1kvt) %></td>
       <td class="c"><%	z2kvt = dv.getByNameDouble("q_qua_2"); z2kvt_sum += z2kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z2kvt) %></td>
	   <td class="c"><% z3kvt = dv.getByNameDouble("q_qua_3"); z3kvt_sum += z3kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z3kvt) %></td>
       <td class="c"><%= Basic.formatNumber(1,9,1,1,dv.getByNameDouble("q_qua_0")) %></td>
	</tr>  
<% } %>

<tr align="right">
       <td class="datarow" align="center">������</td>
       <td class="c"><b><% z_kvt_sum += z1kvt_sum; %>
       	    			<%= Basic.formatNumber(1,10,1,1,z1kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z2kvt_sum;;%>
       	    			<%= Basic.formatNumber(1,10,1,1,z2kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z3kvt_sum;; %>
       					<%= Basic.formatNumber(1,10,1,1,z3kvt_sum) %></b></td>
       <td class="c"><b><%= Basic.formatNumber(1,10,1,1,z_kvt_sum) %></b></td>
</tr >
</table>

<br><br><br>



<%	z1kvt = 0; z2kvt = 0; z3kvt = 0;
	z1kvt_sum = 0; z2kvt_sum = 0; z3kvt_sum = 0; z_kvt_sum = 0; %>

<b>3 ��������� ������������� (���������)</b><br><br>
<b>3.1. ������� ������ ��������� ��������� �����������㳿 �� ��'������ �����</b><br><br>
	<img src="piem_ks_rm.jsp?zvit=select_saldo&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>
	
<b>3.2. ������� ������ ��������� ��������� �����������㳿 �� ��������</b><br><br>
	<img src="piem_rm.jsp?zvit=chartm&amp;recalc=on&amp;ks=<%= ks %>&amp;obl=<%= obl %>&amp;point=<%= point %>&amp;year1=<%= year1 %>&amp;month1=<%= month1 %>&amp;day1=<%= day1 %>&amp;year2=<%= year2 %>&amp;month2=<%= month2 %>&amp;day2=<%= day2 %>" ><br><br>						
<b>3.3. ������� �������� ������ ��������� ��������� �����������㳿</b><br><br>

<table class="datahead" cellspacing="0" cellpadding="0">
  <tr align="center"> 
    <td rowspan="2" class="datarow" width="120">�����<br>�����</td>
    <td colspan="4" class="datarow">������ �����������㳿, ���&#x00B7;�</td>
  </tr>
  
  <tr align="center"> 
    <td class="smalldatarow" width="100">����� 1<br>(�����)</td>
    <td class="smalldatarow" width="100">����� 2<br>(������)</td>
    <td class="smalldatarow" width="100">����� 3<br>(������)</td>
    <td class="smalldatarow" width="120">�������</td>
  </tr>

<%	for (int i=0; i<ar.size()-1; i++) { 
	dv = (DataVector) ar.get(i+1); %>

	<tr align="right">
       <td class="c" align="left" nowrap><%= c.getPointName(dv.point_id) %></td>
       <td class="c"><% z1kvt = dv.getByNameDouble("q_gen_1"); z1kvt_sum += z1kvt; %>
    	       					<%= Basic.formatNumber(1,9,1,1,z1kvt) %></td>
       <td class="c"><%	z2kvt = dv.getByNameDouble("q_gen_2"); z2kvt_sum += z2kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z2kvt) %></td>
	   <td class="c"><% z3kvt = dv.getByNameDouble("q_gen_3"); z3kvt_sum += z3kvt; %>
		       				<%= Basic.formatNumber(1,9,1,1,z3kvt) %></td>
       <td class="c"><%= Basic.formatNumber(1,9,1,1,dv.getByNameDouble("q_gen_0")) %></td>
	</tr>  
<% } %>

<tr align="right">
       <td class="datarow" align="center">������</td>
       <td class="c"><b><% z_kvt_sum += z1kvt_sum; %>
       	    			<%= Basic.formatNumber(1,10,1,1,z1kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z2kvt_sum;;%>
       	    			<%= Basic.formatNumber(1,10,1,1,z2kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z3kvt_sum;; %>
       					<%= Basic.formatNumber(1,10,1,1,z3kvt_sum) %></b></td>
       <td class="c"><b><%= Basic.formatNumber(1,10,1,1,z_kvt_sum) %></b></td>
</tr >
</table>

<% } %>

</body>
</html>
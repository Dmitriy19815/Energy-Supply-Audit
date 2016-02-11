<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit._Dov"/>
<%@ page pageEncoding="Windows-1251" %>
<%@ page import="ua.datapark.commons.Basic" %>
<%@ page import="ua.datapark.audit.Point" %>
<%@ page import="java.util.*;" %>
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

	if (!ks.equals("")) { 
		cc.loadDataDov(ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2);
	}
	
	long days = Basic.substractDates(year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2);
	double z1 = 0, z2 = 0, z3 = 0; 
	double z1_ = 0, z2_ = 0, z3_ = 0;
	double z1r = 0, z2r = 0, z3r = 0;
	double z1kvt = 0, z2kvt = 0, z3kvt = 0, z_kvt = 0;
	double z1kvt_sum = 0, z2kvt_sum = 0, z3kvt_sum = 0, z_kvt_sum = 0, z_kvt_loss = 0;
	double z_kvt_sum_loss = 0, z_kvt_razom = 0;
	double fval = 1;
	
	ArrayList<Object> Points = c.getPoints(ks);
	String[] str = new String[Points.size()];
	String[] device_id = new String[Points.size()];
	double[] loss_float_a = new double[Points.size()];
	double[] loss_fixed_a = new double[Points.size()];
	for (int i=0; i < Points.size(); i++) {
		Point p = (Point) Points.get(i);
		str[i] = p.point_name;
		device_id[i] = p.device_id;
		loss_fixed_a[i] = 0; // p.loss_fixed_a;
		loss_float_a[i] = 0; // p.loss_float_a;
	}
%>
	
<div align="center"><b>1. ������� �������������</b></div><br>
<div align="center"><b>1.1. ������ ���������� ������� �����������㳿</b></div><br><br>
<table class="datahead" cellspacing="0" cellpadding="0" width="1534">
<tr align="center"> 
       <td class="datarow" rowspan="2" width="110">��'��� �����</td>
       <td class="datarow" rowspan="2" width="120">������������<br> ���������</td>
       <td class="datarow" rowspan="2" width="70">�����<br> ���������</td>
       <td class="datarow" colspan="3">��������� ��������� <br>�� 0� <%= day2 %>-��<br>����� ������� �����</td>
       <td class="datarow" colspan="3">��������� ��������� <br>�� 0� <%= day1 %>-��<br>����� �������� �����</td>
       <td class="datarow" colspan="3">г����� �������� ��������� �� <br>�����</td>
       <td class="datarow" rowspan="2" width="70" >����������<br>���������</td>
       <td class="datarow" colspan="4">ʳ������ �����������㳿, ���&#x00B7;�</td>
       <td class="datarow" rowspan="2" width="120">�������</td>
</tr>
<tr align="center">
       <td class="smalldatarow" width="70">����� 1<br>(�����)</td>
       <td class="smalldatarow" width="70">����� 2<br>(������.)</td>
       <td class="smalldatarow" width="70">����� 3<br>(������)</td>

       <td class="smalldatarow" width="70">����� 1<br>(�����)</td>
       <td class="smalldatarow" width="70">����� 2<br>(������.)</td>
       <td class="smalldatarow" width="70">����� 3<br>(������)</td>

       <td class="smalldatarow" width="70">����� 1<br>(�����)</td>
       <td class="smalldatarow" width="70">����� 2<br>(������.)</td>
       <td class="smalldatarow" width="70">����� 3<br>(������)</td>

	   <td class="smalldatarow" width="80">����� 1<br>(�����)</td>
	   <td class="smalldatarow" width="80">����� 2<br>(������.)</td>
       <td class="smalldatarow" width="80">����� 3<br>(������)</td>
       <td class="smalldatarow" width="100">�������</td>
</tr>

<%	for (int i=0; i<Points.size(); i++) { %>
	<tr align="right">
		<% if (i==0) { %>
	       <td class="c" align="left" nowrap rowspan="<%= Points.size() %>"><%= c.getKsName(ks) %></td>
		<% } %>
       <td class="c" align="left" nowrap><%= str[i] %></td>
       <td class="c"><%= device_id[i] %></td>

		<% if (cc.getDataDov2ByName(i,"valid").equals("true")) { %>
			<% if (cc.getDataDov2ByNameDouble(i,"fval")>0) { %>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov2ByNameDouble(i,"p_qua_1")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov2ByNameDouble(i,"p_qua_2")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov2ByNameDouble(i,"p_qua_3")) %></td>
			<% } else { %>		
				<td class="c">0</td>
				<td class="c">0</td>
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
			<td class="c">-</td>
			<td class="c">-</td>
		<% } %>

		<% if (cc.getDataDov1ByName(i,"valid").equals("true")) { %>
			<% if (cc.getDataDov1ByNameDouble(i,"fval")>0) { %>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov1ByNameDouble(i,"p_qua_1")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov1ByNameDouble(i,"p_qua_2")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov1ByNameDouble(i,"p_qua_3")) %></td>
			<% } else { %>		
				<td class="c">0</td>
				<td class="c">0</td>
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
			<td class="c">-</td>
			<td class="c">-</td>
		<% } %>

		<% if (cc.getDataDovDiffByName(i,"valid").equals("true")) { %>
			<% if (cc.getDataDovDiffByNameDouble(i,"fval")>0) { %>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDovDiffByNameDouble(i,"p_qua_1")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDovDiffByNameDouble(i,"p_qua_2")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDovDiffByNameDouble(i,"p_qua_3")) %></td>
			<% } else { %>		
				<td class="c">0</td>
				<td class="c">0</td>
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
			<td class="c">-</td>
			<td class="c">-</td>
		<% } %>
		


		<% if (cc.getDataDovDiffByName(i,"valid").equals("true")) { %>
			<td class="c"><%= Basic.formatNumber(1,9,0,0,cc.getDataDovDiffByNameDouble(i,"fval")) %></td>
			<% if (cc.getDataDovDiffByNameDouble(i,"fval")>0) { %>
				<td class="c"><% z1kvt = cc.getDataDovSaldoByNameDouble(i,"p_qua_1"); z1kvt_sum += z1kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z1kvt) %></td>
				<td class="c"><% z2kvt = cc.getDataDovSaldoByNameDouble(i,"p_qua_2"); z2kvt_sum += z2kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z2kvt) %></td>
				<td class="c"><% z3kvt = cc.getDataDovSaldoByNameDouble(i,"p_qua_3"); z3kvt_sum += z3kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z3kvt) %></td>
				<td class="c"><% z_kvt = z1kvt+z2kvt+z3kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z_kvt) %></td>
			<% } else { %>
				<td class="c">0</td>
				<td class="c">0</td>
				<td class="c">0</td>
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
			<td class="c">-</td>
			<td class="c">-</td>
			<td class="c">-</td>		
			<td class="c">-</td>		
		<% } %>

		<% if (cc.getDataDovDiffByName(i,"valid").equals("true")) { %>
			<td class="c" align="left" nowrap>ʳ��. ����� �� <%= cc.getDataDov2ByName(i,"dat") %> <%= cc.getDataDov2ByName(i,"actualtime") %></td>
		<% } else { %>
			<td class="c"></td>
		<% } %>
	</tr >
<% } %>

<tr align="right">
       <td class="datarow" align="center">������</td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>

       <td class="datarow"><br></td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>

       <td class="datarow"><br></td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>

       <td class="datarow"><br></td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>

       <td class="datarow"><br></td>

       <td class="c"><% z_kvt_sum += z1kvt_sum; %>
       	    			<b><%= Basic.formatNumber(1,9,2,2,z1kvt_sum) %></b></td>
       <td class="c"><% z_kvt_sum += z2kvt_sum;;%>
       	    			<b><%= Basic.formatNumber(1,9,2,2,z2kvt_sum) %></b></td>
       <td class="c"><% z_kvt_sum += z3kvt_sum;; %>
       					<b><%= Basic.formatNumber(1,9,2,2,z3kvt_sum) %></b></td>
       <td class="c"><b><%= Basic.formatNumber(1,9,2,2,z_kvt_sum) %></b></td>

       <td class="datarow"><br></td>
</tr >
</table>







<%	z1 = 0; z2 = 0; z3 = 0; 
	z1_ = 0; z2_ = 0; z3_ = 0;
	z1r = 0; z2r = 0; z3r = 0;
	z1kvt = 0; z2kvt = 0; z3kvt = 0; z_kvt = 0;
	z1kvt_sum = 0; z2kvt_sum = 0; z3kvt_sum = 0; z_kvt_sum = 0; z_kvt_loss = 0;
	z_kvt_sum_loss = 0; z_kvt_razom = 0;
	fval = 1;
	%>
<br><br>
<div align="center"><b>1.2. ������� ������� �����������㳿</b></div><br><br>
<table class="datahead" cellspacing="0" cellpadding="0" width="1534">
<tr align="center"> 
       <td class="datarow" rowspan="2" width="110">��'��� �����</td>
       <td class="datarow" rowspan="2" width="120">������������<br> ���������</td>
       <td class="datarow" rowspan="2" width="70">�����<br> ���������</td>
       <td class="datarow" colspan="3">��������� ��������� <br>�� 0� <%= day2 %>-��<br>����� ������� �����</td>
       <td class="datarow" colspan="3">��������� ��������� <br>�� 0� <%= day1 %>-��<br>����� �������� �����</td>
       <td class="datarow" colspan="3">г����� �������� ��������� �� <br>�����</td>
       <td class="datarow" rowspan="2" width="70" >����������<br>���������</td>
       <td class="datarow" colspan="4">ʳ������ �����������㳿, ���&#x00B7;�</td>
       <td class="datarow" rowspan="2" width="120">�������</td>
</tr>
<tr align="center">
       <td class="smalldatarow" width="70">����� 1<br>(�����)</td>
       <td class="smalldatarow" width="70">����� 2<br>(������.)</td>
       <td class="smalldatarow" width="70">����� 3<br>(������)</td>

       <td class="smalldatarow" width="70">����� 1<br>(�����)</td>
       <td class="smalldatarow" width="70">����� 2<br>(������.)</td>
       <td class="smalldatarow" width="70">����� 3<br>(������)</td>

       <td class="smalldatarow" width="70">����� 1<br>(�����)</td>
       <td class="smalldatarow" width="70">����� 2<br>(������.)</td>
       <td class="smalldatarow" width="70">����� 3<br>(������)</td>

	   <td class="smalldatarow" width="80">����� 1<br>(�����)</td>
	   <td class="smalldatarow" width="80">����� 2<br>(������.)</td>
       <td class="smalldatarow" width="80">����� 3<br>(������)</td>
       <td class="smalldatarow" width="100">�������</td>
</tr>


<%	for (int i=0; i<Points.size(); i++) { %>
	<tr align="right">
		<% if (i==0) { %>
	       <td class="c" align="left" nowrap rowspan="<%= Points.size() %>"><%= c.getKsName(ks) %></td>
		<% } %>
       <td class="c" align="left" nowrap><%= str[i] %></td>
       <td class="c"><%= device_id[i] %></td>

		<% if (cc.getDataDov2ByName(i,"valid").equals("true")) { %>
			<% if (cc.getDataDov2ByNameDouble(i,"fval")<0) { %>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov2ByNameDouble(i,"p_qua_1")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov2ByNameDouble(i,"p_qua_2")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov2ByNameDouble(i,"p_qua_3")) %></td>
			<% } else { %>		
				<td class="c">0</td>
				<td class="c">0</td>
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
			<td class="c">-</td>
			<td class="c">-</td>
		<% } %>

		<% if (cc.getDataDov1ByName(i,"valid").equals("true")) { %>
			<% if (cc.getDataDov1ByNameDouble(i,"fval")<0) { %>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov1ByNameDouble(i,"p_qua_1")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov1ByNameDouble(i,"p_qua_2")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDov1ByNameDouble(i,"p_qua_3")) %></td>
			<% } else { %>		
				<td class="c">0</td>
				<td class="c">0</td>
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
			<td class="c">-</td>
			<td class="c">-</td>
		<% } %>

		<% if (cc.getDataDovDiffByName(i,"valid").equals("true")) { %>
			<% if (cc.getDataDovDiffByNameDouble(i,"fval")<0) { %>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDovDiffByNameDouble(i,"p_qua_1")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDovDiffByNameDouble(i,"p_qua_2")) %></td>
				<td class="c"><%= Basic.formatNumber(1,9,2,2,cc.getDataDovDiffByNameDouble(i,"p_qua_3")) %></td>
			<% } else { %>		
				<td class="c">0</td>
				<td class="c">0</td>
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
			<td class="c">-</td>
			<td class="c">-</td>
		<% } %>
		
		<% if (cc.getDataDovDiffByName(i,"valid").equals("true")) { %>
			<td class="c"><%= Basic.formatNumber(1,9,0,0,cc.getDataDovDiffByNameDouble(i,"fval")) %></td>
			<% if (cc.getDataDovDiffByNameDouble(i,"fval")<0) { %>
				<td class="c"><% z1kvt = cc.getDataDovSaldoByNameDouble(i,"p_qua_1"); z1kvt_sum += z1kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z1kvt) %></td>
				<td class="c"><% z2kvt = cc.getDataDovSaldoByNameDouble(i,"p_qua_2"); z2kvt_sum += z2kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z2kvt) %></td>
				<td class="c"><% z3kvt = cc.getDataDovSaldoByNameDouble(i,"p_qua_3"); z3kvt_sum += z3kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z3kvt) %></td>
				<td class="c"><% z_kvt = z1kvt+z2kvt+z3kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z_kvt) %></td>
			<% } else { %>
				<td class="c">0</td>
				<td class="c">0</td>
				<td class="c">0</td>
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
			<td class="c">-</td>
			<td class="c">-</td>
			<td class="c">-</td>		
			<td class="c">-</td>		
		<% } %>

		<% if (cc.getDataDovDiffByName(i,"valid").equals("true")) { %>
			<td class="c" align="left" nowrap>ʳ��. ����� �� <%= cc.getDataDov2ByName(i,"dat") %> <%= cc.getDataDov2ByName(i,"actualtime") %></td>
		<% } else { %>
			<td class="c"></td>
		<% } %>
	</tr >
<% } %>

<tr align="right">
       <td class="datarow" align="center">������</td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>

       <td class="datarow"><br></td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>

       <td class="datarow"><br></td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>

       <td class="datarow"><br></td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>

       <td class="datarow"><br></td>

       <td class="c"><% z_kvt_sum += z1kvt_sum; %>
       	    			<b><%= Basic.formatNumber(1,9,2,2,z1kvt_sum) %></b></td>
       <td class="c"><% z_kvt_sum += z2kvt_sum;;%>
       	    			<b><%= Basic.formatNumber(1,9,2,2,z2kvt_sum) %></b></td>
       <td class="c"><% z_kvt_sum += z3kvt_sum;; %>
       					<b><%= Basic.formatNumber(1,9,2,2,z3kvt_sum) %></b></td>
       <td class="c"><b><%= Basic.formatNumber(1,9,2,2,z_kvt_sum) %></b></td>

       <td class="datarow"><br></td>
</tr >
</table>











<%	z1 = 0; z2 = 0; z3 = 0; 
	z1_ = 0; z2_ = 0; z3_ = 0;
	z1r = 0; z2r = 0; z3r = 0;
	z1kvt = 0; z2kvt = 0; z3kvt = 0; z_kvt = 0;
	z1kvt_sum = 0; z2kvt_sum = 0; z3kvt_sum = 0; z_kvt_sum = 0; z_kvt_loss = 0;
	z_kvt_sum_loss = 0; z_kvt_razom = 0;
	fval = 1;
%>
<br><br>
<div align="center"><b>1.3. ������ ������� �����������㳿</b></div><br><br>
<table class="datahead" cellspacing="0" cellpadding="0" width="1350">
  <tr align="center"> 
    <td rowspan="5" class="datarow" width="110">��'���<br>�����</td>
    <td rowspan="5" class="datarow" width="120">������������<br>���������</td>
    <td rowspan="5" class="datarow" width="70">����� ���������</td>
    <td colspan="4" class="datarow">ʳ������ �����������㳿, ���&#x00B7;�</td>
    <td colspan="6" class="datarow">������</td>
    <td rowspan="5" class="datarow" width="100">�����</td>
    <td rowspan="5" class="datarow" width="100">�������</td>
  </tr>
  <tr align="center"> 
    <td rowspan="4" class="smalldatarow" width="80">����� 1<br>(�����)</td>
    <td rowspan="4" class="smalldatarow" width="80">����� 2<br>(������)</td>
    <td rowspan="4" class="smalldatarow" width="80">����� 3<br>(������)</td>
    <td rowspan="4" class="smalldatarow" width="100">�������</td>
    <td rowspan="2" class="smalldatarow" width="40">� ���</td>
    <td colspan="4" class="smalldatarow">� ���������������</td>
    <td rowspan="4" class="smalldatarow" width="70">������</td>
  </tr>
  <tr align="center"> 
    <td class="smalldatarow" width="40">����</td>
    <td colspan="3" class="smalldatarow">������ ��.�</td>
  </tr>
  <tr align="center"> 
    <td rowspan="2" class="smalldatarow">%</td>
    <td rowspan="2" class="smalldatarow">%</td>
    <td colspan="3" class="smalldatarow">���&#x00B7;�/�����</td>
  </tr>
  <tr align="center"> 
    <td class="smalldatarow" width="80">����� 1<br>(�����)</td>
    <td class="smalldatarow" width="80">����� 2<br>(������.)</td>
    <td class="smalldatarow" width="80">����� 3<br>(������)</td>
  </tr>

<%	for (int i=0; i<Points.size(); i++) { %>
	
	<tr align="right">
		<% if (i==0) { %>
	       <td class="c" align="left" nowrap rowspan="<%= Points.size() %>"><%= c.getKsName(ks) %></td>
		<% } %>
		<td class="c" align="left" nowrap><%= str[i] %></td>
		<td class="c" align="left"><%= device_id[i] %></td>

		<td class="c"><% z1kvt = cc.getDataDovSaldoByNameDouble(i,"p_qua_1"); z1kvt_sum += z1kvt; %>
					<%= Basic.formatNumber(1,9,2,2,z1kvt) %></td>
		<td class="c"><% z2kvt = cc.getDataDovSaldoByNameDouble(i,"p_qua_2"); z2kvt_sum += z2kvt; %>
					<%= Basic.formatNumber(1,9,2,2,z2kvt) %></td>
		<td class="c"><% z3kvt = cc.getDataDovSaldoByNameDouble(i,"p_qua_3"); z3kvt_sum += z3kvt; %>
					<%= Basic.formatNumber(1,9,2,2,z3kvt) %></td>
		<td class="c"><% z_kvt = z1kvt+z2kvt+z3kvt; %>
       				<%= Basic.formatNumber(1,9,2,2,z_kvt) %></td>

		<td class="c">0,00</td>
		<td class="c"><%= Basic.formatNumber(1,4,2,2,loss_float_a[i]*100) %></td>

		<td class="c"><%= Basic.formatNumber(1,7,2,2,days*loss_fixed_a[i]*14/48) %></td>
		<td class="c"><%= Basic.formatNumber(1,7,2,2,days*loss_fixed_a[i]*22/48) %></td>
		<td class="c"><%= Basic.formatNumber(1,7,2,2,days*loss_fixed_a[i]*12/48) %></td>

		<td class="c"><% z_kvt_loss = days*loss_fixed_a[i]+z_kvt*loss_float_a[i]; z_kvt_sum_loss += z_kvt_loss; %>
					<%= Basic.formatNumber(1,9,2,2,z_kvt_loss) %></td>

       <td class="c"><% z_kvt_razom += z_kvt+z_kvt_loss; %>
					<%= Basic.formatNumber(1,9,2,2,z_kvt+z_kvt_loss) %></td>
       <td class="c"></td>
	</tr >
<% } %>

<tr align="right">
       <td class="datarow" align="center">������</td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>

       <td class="c"><b><% z_kvt_sum += z1kvt_sum; %>
       	    			<%= Basic.formatNumber(1,10,2,2,z1kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z2kvt_sum;;%>
       	    			<%= Basic.formatNumber(1,10,2,2,z2kvt_sum) %></b></td>
       <td class="c"><b><% z_kvt_sum += z3kvt_sum;; %>
       					<%= Basic.formatNumber(1,10,2,2,z3kvt_sum) %></b></td>
       <td class="c"><b><%= Basic.formatNumber(1,10,2,2,z_kvt_sum) %></b></td>

       <td class="datarow"><br></td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>
       <td class="datarow"><br></td>
       <td class="c"><b><%= Basic.formatNumber(1,9,2,2,z_kvt_sum_loss) %></b></td>
       <td class="c"><b><%= Basic.formatNumber(1,9,2,2,z_kvt_razom) %></b></td>
       <td class="datarow"><br></td>
</tr >
</table>
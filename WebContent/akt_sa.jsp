<%@ page pageEncoding="Windows-1251"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<jsp:useBean id="aa" scope="page" class="ua.datapark.audit._Akt"/>
<jsp:useBean id="d" scope="page" class="ua.datapark.audit._Dogovor"/>
<jsp:useBean id="dl" scope="page" class="ua.datapark.audit._DogovorLoss"/>
<%@ page import="ua.datapark.commons.Basic" %>
<%@ page import="ua.datapark.audit.Point" %>
<%@ page import="ua.datapark.audit.DogovorLoss" %>
<%@ page import="ua.datapark.audit.Dogovor" %>
<%@ page import="java.util.*;" %>
<%	//обязательные параметры
	String ks = request.getParameter("ks");
	String obl = request.getParameter("obl");
	if (ks==null && obl==null) { %>не указан объект<br><%  }
	String point = request.getParameter("point");
	if (point==null) { %>не указана точка<br><%  }

	String day1 = request.getParameter("day1");
	if (day1==null) { %>не указан день 1<br><% }
	String month1 = request.getParameter("month1");
	if (month1==null) { %>не указан месяц 1<br><% }
	String year1 = request.getParameter("year1");
	if (year1==null) { %>не указан год 1<br><% }

	String day2 = request.getParameter("day2");
	if (day2==null) { %>не указан день 2<br><% }
	String month2 = request.getParameter("month2");
	if (month2==null) { %>не указан месяц 2<br><% }
	String year2 = request.getParameter("year2");
	if (year2==null) { %>не указан год 2<br><% }

	if ( (ks==null && obl==null) || point==null 
		|| day1==null || month1==null || year1==null
		|| day2==null || month2==null || year2==null ) { return; }
	
	//определение флага пересчета
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }

	String value = d.loadDogovor(ks,obl,year1+"-"+month1+"-"+day1,year2+"-"+month2+"-"+day2);
	
	if (!value.equals("")) {
		if (value.equals("more_than_2_dogovors")) { %>
			<div style="color: red">Більше двох договорів за цей період!</div>
		<% return; 
		} else {
			if (value.equals("no_dogovors")) { %>
				<div style="color: red">Договір за цей період відсутній!</div>
			<% return; }
		}
	}
	Dogovor dg = d.getDogovor();
	
	ArrayList P = c.getPoints(ks,obl);
	Point[] Points = new Point[P.size()];
	DogovorLoss[] Losses = new DogovorLoss[P.size()];	
	
	for (int i=0; i < P.size(); i++) {
		Point p = (Point)P.get(i);
		dl.loadDogovorLoss(p.point_id,dg.dogov_id);

		Points[i] = p;
		Losses[i] = new DogovorLoss(dl.getDogovorLoss());
	}
		
	
	if (!ks.equals("")) { 
		aa.loadDataAkt(Points, ks, year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2);
	}
		
	long days = Basic.substractDates(year1+"-"+month1+"-"+day1, year2+"-"+month2+"-"+day2);
	double z1 = 0, z2 = 0, z3 = 0; 
	double z1_ = 0, z2_ = 0, z3_ = 0;
	double z1r = 0, z2r = 0, z3r = 0;
	double z1kvt = 0, z2kvt = 0, z3kvt = 0, z_kvt = 0;
	double z1kvt_sum = 0, z2kvt_sum = 0, z3kvt_sum = 0, z_kvt_sum = 0, z_kvt_loss = 0;
	double z_kvt_sum_loss = 0, z_kvt_razom = 0;
	double fval = 1;
	

%>
<% //= cc.getProcessingTime() %>	
<table class="datahead" cellspacing="0" cellpadding="0" style="border: 2px">
<tr align="center"> 
       <td class="datarowakt" rowspan="4">Найменування<br> об'єкту</td>
       <td class="datarowakt" rowspan="4">Номер<br>приладів<br>обліку</td>
       <td class="datarowakt" rowspan="4">Вид<br>енергії<br>(СА, СР,<br>ГР)</td>
       <td class="datarowakt" rowspan="2" colspan="2">Показники<br></>приладів обліку</td>
       <td class="datarowakt" rowspan="4" width="70">Різниця</td>
       <td class="datarowakt" rowspan="4">Розрах.<br> коеф-т</td>
       <td class="datarowakt" rowspan="2" colspan="2">Витрати, кВт&#x00B7;г</td>
       <td class="datarowakt" colspan="3">Втрати</td>
       <td class="datarowakt" rowspan="4">Разом</td>
       <td class="datarowakt" rowspan="4">Примітка<br><span style="font-size: 0.9em; font-weight: normal;">(надходження&nbsp;"+" / віддача&nbsp;"-")</span></td>
</tr>

<tr align="center">
       <td class="smalldatarowakt" rowspan="2">в ЛЕП</td>
       <td class="smalldatarowakt" colspan="2">в трансформаторах</td>
</tr>

<tr align="center">
       <td class="smalldatarowakt" rowspan="2" width="80">поточні</td>

       <td class="smalldatarowakt" rowspan="2" width="80">попередні</td>

       <td class="smalldatarowakt" rowspan="2"></td>
       <td class="smalldatarowakt" rowspan="2">Сумарні</td>

       <td class="smalldatarowakt">змінні</td>
       <td class="smalldatarowakt">постійні<br>Px.x</td>
</tr>

<tr align="center" style="border-bottom: 2px">
       <td class="smalldatarowakt">%</td>
       <td class="smalldatarowakt">%</td>
       <td class="smalldatarowakt">кВт&#x00B7;г/міс.</td>
</tr>


<%	for (int i=0; i<Points.length; i++) { %>
	<tr align="right">
       <td class="c" align="left" nowrap><%= Points[i].point_name %><%= Losses[i].loss_fixed_sa_1 %></td>
       <td class="c"><%= Points[i].device_id %></td>

       <td class="c" align="center">СА</td>

		<% if (aa.getDataAkt2ByName(i,"valid").equals("true")) { %>
			<%
				if (aa.getDataAkt2ByNameDouble(i,"fval")>0) {
			%>
				<td class="c">
				<nobr><%=Basic.formatNumber(1,9,2,2,aa.getDataAkt2ByNameDouble(i,"p_qua_1"))%> (1)</nobr><br>
				<nobr><%=Basic.formatNumber(1,9,2,2,aa.getDataAkt2ByNameDouble(i,"p_qua_2"))%> (2)</nobr><br>
				<nobr><%=Basic.formatNumber(1,9,2,2,aa.getDataAkt2ByNameDouble(i,"p_qua_3"))%> (3)</nobr>
				</td>
			<% } else { %>		
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
		<% } %>

		<% if (aa.getDataAkt1ByName(i,"valid").equals("true")) { %>
			<% if (aa.getDataAkt1ByNameDouble(i,"fval")>0) { %>
				<td class="c"><nobr><%= Basic.formatNumber(1,9,2,2,aa.getDataAkt1ByNameDouble(i,"p_qua_1")) %> (1)</nobr><br>
				<nobr><%= Basic.formatNumber(1,9,2,2,aa.getDataAkt1ByNameDouble(i,"p_qua_2")) %> (2)</nobr><br>
				<nobr><%= Basic.formatNumber(1,9,2,2,aa.getDataAkt1ByNameDouble(i,"p_qua_3")) %> (3)</nobr></td>
			<% } else { %>		
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
		<% } %>

		<% if (aa.getDataDovDiffByName(i,"valid").equals("true")) { %>
			<% if (aa.getDataDovDiffByNameDouble(i,"fval")>0) { %>
				<td class="c"><nobr><%= Basic.formatNumber(1,9,2,2,aa.getDataDovDiffByNameDouble(i,"p_qua_1")) %> (1)</nobr><br>
				<nobr><%= Basic.formatNumber(1,9,2,2,aa.getDataDovDiffByNameDouble(i,"p_qua_2")) %> (2)</nobr><br>
				<nobr><%= Basic.formatNumber(1,9,2,2,aa.getDataDovDiffByNameDouble(i,"p_qua_3")) %> (3)</nobr></td>
			<% } else { %>		
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
		<% } %>
		


		<% if (aa.getDataDovDiffByName(i,"valid").equals("true")) { %>
			<td class="c"><%= Basic.formatNumber(1,9,0,0,aa.getDataDovDiffByNameDouble(i,"fval")) %></td>
			<% if (aa.getDataDovDiffByNameDouble(i,"fval")>0) { %>
				<td class="c"><nobr><% z1kvt = aa.getDataDovSaldoByNameDouble(i,"p_qua_1"); z1kvt_sum += z1kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z1kvt) %> (1)</nobr><br>
				<nobr><% z2kvt = aa.getDataDovSaldoByNameDouble(i,"p_qua_2"); z2kvt_sum += z2kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z2kvt) %> (2)</nobr><br>
				<nobr><% z3kvt = aa.getDataDovSaldoByNameDouble(i,"p_qua_3"); z3kvt_sum += z3kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z3kvt) %> (3)</nobr></td>
				<td class="c"><nobr><% z_kvt = z1kvt+z2kvt+z3kvt; z_kvt_sum += z_kvt; %>
							<%= Basic.formatNumber(1,9,2,2,z_kvt) %></nobr></td>
			<% } else { %>
				<td class="c">0</td>
				<td class="c">0</td>
			<% } %>
		<% } else { %>
			<td class="c">-</td>
			<td class="c">-</td>		
			<td class="c">-</td>		
		<% } %>

		<td class="c">0,00</td>
		<td class="c"><%= Basic.formatNumber(1,4,2,2,Losses[i].loss_fixed_sa_1*100) %></td>

		<td class="c"><nobr><%= Basic.formatNumber(1,7,2,2,days*Losses[i].loss_fixed_sa_1) %> (1)</nobr><br>
					<nobr><%= Basic.formatNumber(1,7,2,2,days*Losses[i].loss_fixed_sa_2) %> (2)</nobr><br>
					<nobr><%= Basic.formatNumber(1,7,2,2,days*Losses[i].loss_fixed_sa_3) %> (3)</nobr></td>
									
		<td class="c"><% z_kvt_loss = days*Losses[i].loss_fixed_sa_1+z_kvt*Losses[i].loss_float_sa_1; z_kvt_sum_loss += z_kvt_loss; 
							z_kvt_razom += z_kvt+z_kvt_loss; %>
					<%= Basic.formatNumber(1,9,2,2,z_kvt+z_kvt_loss) %></td>

					
		<% if (aa.getDataDovDiffByName(i,"valid").equals("true")) { %>
			<td class="c" align="left"><br>
			<nobr></td>
		<% } else { %>
			<td class="c"></td>
		<% } %>
	</tr >
<% } %>

<tr align="right">
       <td class="datarowakt" align="center">Всього</td>
       <td class="datarowakt"><br></td>

       <td class="datarowakt"><br></td>
       
       <td class="datarowakt"><br></td>

       <td class="datarowakt"><br></td>

       <td class="datarowakt"><br></td>

       <td class="datarowakt"><br></td>


       <td class="datarowakt"><br></td>
       <td class="c"><b><%= Basic.formatNumber(1,9,2,2,z_kvt_sum) %></b></td>
       <td class="datarowakt"><br></td>
       <td class="datarowakt"><br></td>
       <td class="datarowakt"><br></td>

       <td class="c"><b><%= Basic.formatNumber(1,9,2,2,z_kvt_razom) %></b></td>

       <td class="datarowakt"><br></td>
</tr >
</table>

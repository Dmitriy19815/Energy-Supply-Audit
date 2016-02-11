<%@ page pageEncoding="Windows-1251"%>
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page import="ua.datapark.commons.Basic" %>
<%	
	//если указан КС - загрузка точек
//	String ks = request.getParameter("ks");
//	if (ks==null || ks.equals("null")) { ks = ""; }
//	String obl = request.getParameter("obl");
//	if (obl==null || obl.equals("null") ) { obl = ""; }

	//инициализация даты
	String current_date = Basic.toDay("");
	String year = current_date.substring(0,4); 
	String month = current_date.substring(5,7);
	String day = current_date.substring(8,10);

	String year1 = current_date.substring(0,4);
	String month1 = current_date.substring(5,7);
	String day1 = current_date.substring(8,10);

	String year2 = current_date.substring(0,4); 
	String month2 = current_date.substring(5,7);
	String day2 = current_date.substring(8,10);	
	
	//определение флага пересчета 
//	String recalc = request.getParameter("recalc");
//	if (recalc==null) { recalc = ""; }

	//определение флага типа страницы
//	String zvit = request.getParameter("zvit");
//	if (zvit==null || zvit.equals("")) { zvit = ""; }
	
//	String point = request.getParameter("point");
//	if (point==null) { point = "0"; }
//	if (point.equals("0")) { recalc = "on"; }
%>
	<script type="text/javascript">
		last_zvit='month';
		full = true;
		ksarr = new Array();
		pointarr = new Array();

		function one_day() {
			document.getElementById('t_dat1').style.display = '';
			document.getElementById('t_dat2').style.display = 'none';
		}
		
		function two_days() {
			document.getElementById('t_dat1').style.display = 'none';
			document.getElementById('t_dat2').style.display = '';
		}
		function points_yes() { document.getElementById('p').style.display = ''; }
		function points_no() { document.getElementById('p').style.display = 'none'; }
		
		function zvit_select() { 
			switch (mform.zvit.value){
				// === 2 === обработка выбора типов отчетов
				case 'month':
				case 'month_graf':
				case 'diam':
					last_zvit = mform.zvit.value; two_days();
					full = true;
					loadPoints(mform.ks.value);
					points_yes();
					break;
					
				case 'select_ks':
				case 'dovid':
				case 'select_saldo':
					last_zvit = mform.zvit.value; two_days();
					mform.point.value='0';
					points_no();
					break;

				case 'total':
					last_zvit = mform.zvit.value; two_days();
					full = false;
					loadPoints(mform.ks.value);
					points_yes();
					break;
					
				case 'day':
				case 'day_graf':
				case 'diad':
					last_zvit = mform.zvit.value; one_day();
					full = true;
					loadPoints(mform.ks.value);
					points_yes();
					break;
				case 'select_ks_day':
					last_zvit = mform.zvit.value; one_day();
					mform.point.value='0';
					points_no();
					break;

				case 'nagr':
				case 'offline':
					last_zvit = mform.zvit.value; two_days();
					full = false;
					loadPoints(mform.ks.value);
					points_yes();
					break;
				// === end of 2 ===
					
				default: mform.zvit.value = last_zvit;
			}
		}

		function subm() {
			start('завантаження...');
			params= "?zvit="+mform.zvit.value+
					"&recalc=on"+
					"&ks="+mform.ks.value+
					"&obl="+mform.obl.value+
					"&point="+mform.point.value+
					"&year="+mform.year.value+
					"&month="+mform.month.value+
					"&day="+mform.day.value+
					"&year1="+mform.year1.value+
					"&month1="+mform.month1.value+
					"&day1="+mform.day1.value+
					"&year2="+mform.year2.value+
					"&month2="+mform.month2.value+
					"&day2="+mform.day2.value;			

			//parent.destination.location.href = "data.jsp"+params;
			//parent.document.getElementById('destination').src = "data.jsp"+params;
			document.getElementById('destination').src = "";
			document.getElementById('destination').src = "data.jsp"+params;
			document.getElementById('printlink').href = "data.jsp"+params+"&print=yes";
		}
		
		function start(msg) {
			document.getElementById("loading").style.background='#FF5555';
			document.getElementById("loading").style.color='white';
			if (msg==null) msg='';
			document.getElementById("loading").innerHTML= msg ;
		}
		function complete() {
			for (var i=1; i<=3; i++) document.getElementById('datach'+i).style.display='none';
			document.getElementById("loading").style.color='white';
			document.getElementById("loading").style.background='#28D228';
			document.getElementById("loading").innerHTML='завершено!';
			timeoutID=setTimeout('complete_2()',1000);
		}
		function complete_2() {
			document.getElementById("loading").innerHTML='';
			document.getElementById("loading").style.background='';
		}
		
		//показ сообщения о смене даты в форме
		prev = '';
		function datareset(sender) { prev = ''; }
		function datafocus(sender) { prev = sender.value; }
		function datachange1(sender) {
			if (sender.value != prev) document.getElementById('datach1').style.display='';
			else document.getElementById('datach1').style.display='none';
		}
		function datachange2(sender) {
			if (sender.value != prev) document.getElementById('datach2').style.display='';
			else document.getElementById('datach2').style.display='none';
		}
		function datachange3(sender) {
			if (sender.value != prev) { document.getElementById('datach3').style.display=''; } 
			else document.getElementById('datach3').style.display='none';
		}
		
		function loadKss() {
			mform.ks.length = 0;
			for (var i=0; i<ksarr.length; i++) {
		        if (document.createElement){
					var newKsOption = document.createElement('OPTION');
		            newKsOption.text = ksarr[i].name;
	    	        newKsOption.value = ksarr[i].id;

	        	    (mform.ks.options.add) ? mform.ks.options.add(newKsOption) : mform.ks.add(newKsOption, null);
		        } else { mform.ks.options[i] = new Option(newKsOption.text, newKsOption.value, false, false); }
			}
		}
		
		function loadPoints(ks_id) {
			mform.point.length = 0;
			if (full) {
		        if (document.createElement) {
					var newPointOption = document.createElement('OPTION');
	    	        newPointOption.text = 'Власне споживання';
    	    	    newPointOption.value = 0;
        	    	(mform.point.options.add) ? mform.point.options.add(newPointOption) : mform.point.add(newPointOption, null);
		        } else { mform.point.options[i] = new Option('Власне споживання', 0, false, false); }
			}

			for (var i=0; i<pointarr.length; i++) {
				if (pointarr[i].ks_id == ks_id ){
			        if (document.createElement){
						var newPointOption = document.createElement('OPTION');
			            newPointOption.text = pointarr[i].name;
	    		        newPointOption.value = pointarr[i].id;

	        		    (mform.point.options.add) ? mform.point.options.add(newPointOption) : mform.point.add(newPointOption, null);
			        } else { mform.point.options[i] = new Option(pointarr[i].name, pointarr[i].id, false, false); }
				}
			}			
		}
	</script>


<form name="mform" method="get" target="destination" action="data.jsp">
<input type="hidden" name="obl" id="obl" value=""/>

<input type="hidden" name="recalc" value="on"/>

<table id="m" width="210" align="center" style="display:none">

<tr>
	<td class="menu" width="210">
		<select name="zvit" class="select" onchange="zvit_select();">
			<option value="-" disabled>1. Споживання за період:</option>
			<option value="month" selected>&nbsp;1.1. Таблиця за період</option>
			<option value="month_graf">&nbsp;1.2. Графік за період</option>
			<option value="diam">&nbsp;1.3. Діаграма за період</option>
			<option value="-" disabled>------------</option>
			<option value="select_ks">&nbsp;1.4. Всього по об'єкту</option>
			<option value="dovid">&nbsp;1.5. Довідка</option>
			<option value="-" disabled>------------</option>
			<option value="select_saldo">&nbsp;1.6. Розподіл сальдо</option>
			<option value="total">&nbsp;1.7. Зрост. підсумок</option>
			<option value="-" disabled>------------</option>
			<option value="-" disabled>2. Споживання за добу:</option>
			<option value="day">&nbsp;2.1. Таблиця за добу</option>
			<option value="day_graf">&nbsp;2.2. Графік за добу</option>
			<option value="diad">&nbsp;2.3. Діаграма за добу</option>
			<option value="-" disabled>------------</option>
			<option value="select_ks_day">&nbsp;2.4. Всього по об'єкту</option>
			<option value="-" disabled>============</option>
			<option value="nagr">3. Макс. навантаження</option>
			<option value="offline">4. Відключення</option>
		</select>		
		
		<table width="100%" align="center"><tr><td height="5"></td></tr></table>

		<table id="t_dat2" width="100%" class="menulight" cellpadding="0" cellspacing="0">
		<tr><td valign="middle" style="padding: 4px">
			<input name="day1" class="input" type="text" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange1(this);" size="2" value="<%= day1 %>" />
			<select name="month1" class="select" onblur="datareset();" onfocus="datafocus(this);" onchange="datachange1(this);">
				<% for (int i=1; i<13; i++) { %>
					<option value="<%= Basic.formatNumber(2,2,0,0,i) %>" <% if (Integer.parseInt(month1) == i) { %>selected<% } %>><%= Basic.monthNameRod(i) %></option>
				<% } %>
			</select>
			<input name="year1" class="input" type="text" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange1(this);" size="4" value="<%= year1 %>">
			<span id="datach1"><font color="red">*</font></span>
			</td>
		</tr>
		<tr><td valign="middle" style="padding: 0px 4px 4px 4px">
			<input name="day2" class="input" type="text" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange2(this);mform.day2.value=this.value" size="2" value="<%= day2 %>">
			<select name="month2" class="select" onblur="datareset();" onfocus="datafocus(this);" onchange="datachange2(this);mform.month2.value=this.value">
				<% for (int i=1; i<13; i++) { %>
					<option value="<%= Basic.formatNumber(2,2,0,0,i) %>" <% if (Integer.parseInt(month2) == i) { %>selected<% } %>><%= Basic.monthNameRod(i) %></option>
				<% } %>
			</select>
			<input name="year2" class="input" type="text" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange2(this);mform.year2.value=this.value" size="4" value="<%= year2 %>">
			<span id="datach2"><font color="red">*</font></span>
		</td></tr>
		</table>

		<table id="t_dat1" width="100%" class="menulight" cellpadding="0" cellspacing="0">
		<tr><td valign="middle" style="padding: 4px">
			<input class="input" type="text" name="day" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange3(this);" size="2" value="<%= day %>">
			<select class="select" name="month" onblur="datareset();" onfocus="datafocus(this);" onchange="datachange3(this);">
				<% for (int i=1; i<13; i++) { %>
					<option value="<%= Basic.formatNumber(2,2,0,0,i) %>" <% if (Integer.parseInt(month) == i) { %>selected<% } %>><%= Basic.monthNameRod(i) %></option>
				<% } %>
			</select>
			<input class="input" type="text" name="year" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange3(this);" size="4" value="<%= year %>">
			<span id="datach3"><font color="red">*</font></span>
		</td></tr>
		</table>

		<table width="100%" align="center"><tr><td height="5"></td></tr></table>
		
		<select name="ks" class="select" onchange="loadPoints(this.value);">
			<option></option>
		</select>
		<table width="100%" align="center"><tr><td height="5"></td></tr></table>

		<div id="p">
		<select name="point" class="select">
			<option></option>
		</select>
		<table width="100%" align="center"><tr><td height="5"></td></tr></table>
		</div>
		
		<table width="100%" class="menulight" cellpadding="0" cellspacing="0">
		<tr>
			<td valign="middle" style="padding: 3px">
				<table width="100%" cellpadding="0" cellspacing="0">
				<tr><td id="loading" valign="middle" style="padding: 3px; font-weight: bold"></td></tr>
				</table>
			</td>		
			<td valign="middle" style="padding: 4px" align="right">
				<input class="input" type="button" onclick="subm();" value=" запит ">
			</td></tr>
		</table>
		
	</td></tr>
</table>

</form>

<script type="text/javascript">
	for (var i=1; i<=3; i++) document.getElementById('datach'+i).style.display='none';
<% for (int i=0; i<c.PointSize(); i++) { %>
	pointarr[<%= i%>]= new Array;
	pointarr[<%= i%>].id ='<%= c.getPointf(i,0) %>';
	pointarr[<%= i%>].name='<%= c.getPointf(i,1) %>';
	pointarr[<%= i%>].ks_id='<%= c.getPointf(i,2) %>';
<% } %>
<% for (int i=0; i<c.KsSize(); i++) { %>
	ksarr[<%= i%>]= new Array;
	ksarr[<%= i%>].id='<%= c.getKSf(i,0) %>';
	ksarr[<%= i%>].name='<%= c.getKSf(i,1) %>';
<% } %>
	loadKss();
	loadPoints(ksarr[0].id);
	mform.zvit.value='month';
	two_days();
	
	document.getElementById('m').style.display='';
</script>


<script type="text/javascript">
		last_zvit='month';
		full = true;
		ksarr = new Array();
		oblarr = new Array();
		oblarr_ks = new Array();
		pointarr = new Array();
		pointarr_ks = new Array();

		function one_day() {
			document.getElementById('t_dat1').style.display = '';
			document.getElementById('t_dat2_1').style.display = 'none';
			document.getElementById('t_dat2_2').style.display = 'none';
			document.getElementById('split').style.display = 'none';
		}
		
		function two_days() {
			document.getElementById('t_dat1').style.display = 'none';
			document.getElementById('t_dat2_1').style.display = '';
			document.getElementById('t_dat2_2').style.display = '';
			document.getElementById('split').style.display = '';
		}
		function points_yes() { document.getElementById('point').style.display = ''; }
		function points_no() { document.getElementById('point').style.display = 'none'; }

		function obls_yes() { document.getElementById('obl').style.display = ''; }
		function obls_no() { document.getElementById('obl').style.display = 'none';
		}
		
		function zvit_select() { 
			switch (document.getElementById('zvit').value){
				// === 2 === обработка выбора типов отчетов
				case 'month':
				case 'month_graf':
				case 'diam':
					last_zvit = document.getElementById('zvit').value; two_days();
					full = true;
					loadPoints(document.getElementById('ks').value);
					points_yes();
					obls_no();
					break;
					
				case 'akt_sa':
				case 'akt_sr':
				case 'akt_gr':
					last_zvit = document.getElementById('zvit').value; two_days();
					document.getElementById('point').value='0';
					points_no();
					obls_yes();
					break;
					
				case 'select_ks':
				case 'select_saldo':
					last_zvit = document.getElementById('zvit').value; two_days();
					document.getElementById('point').value='0';
					points_no();
					obls_no();
					break;

				case 'total':
					last_zvit = document.getElementById('zvit').value; two_days();
					full = false;
					loadPoints(document.getElementById('ks').value);
					points_yes();
					obls_no();
					break;
					
				case 'day':
				case 'day_graf':
				case 'diad':
					last_zvit = document.getElementById('zvit').value; one_day();
					full = true;
					loadPoints(document.getElementById('ks').value);
					points_yes();
					obls_no();
					break;
					
				case 'select_ks_day':
					last_zvit = document.getElementById('zvit').value;
					one_day();
					document.getElementById('point').value='0';
					points_no();
					obls_no();
					break;

				case 'nagr':
				case 'offline':
					last_zvit = document.getElementById('zvit').value; 
					two_days();
					full = false;
					loadPoints(document.getElementById('ks').value);
					points_yes();
					obls_no();
					break;

				case 'dogovor':
					last_zvit = document.getElementById('zvit').value; 
					two_days();
					obls_no();
					document.getElementById('split').style.display = 'none';
					points_no();
					break;					
				default: document.getElementById('zvit').value = last_zvit;
			}
		}

		function subm() {
			start('завантаження...');
			params= "?zvit="+document.getElementById('zvit').value+
					"&recalc=on"+
					"&ks="+document.getElementById('ks').value+
					"&obl="+document.getElementById('obl').value+
					"&point="+document.getElementById('point').value+
					"&year="+document.getElementById('year').value+
					"&month="+document.getElementById('month').value+
					"&day="+document.getElementById('day').value+
					"&year1="+document.getElementById('year1').value+
					"&month1="+document.getElementById('month1').value+
					"&day1="+document.getElementById('day1').value+
					"&year2="+document.getElementById('year2').value+
					"&month2="+document.getElementById('month2').value+
					"&day2="+document.getElementById('day2').value;			

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
			document.getElementById('ks').length = 0;
			
			for (var i=0; i<ksarr.length; i++) {
		        if (document.createElement){
					var newKsOption = document.createElement('OPTION');
		            newKsOption.text = ksarr[i].name;
	    	        newKsOption.value = ksarr[i].id;

	        	    (document.getElementById('ks').options.add) ? document.getElementById('ks').options.add(newKsOption) : document.getElementById('ks').add(newKsOption, null);
		        } else { document.getElementById('ks').options[i] = new Option(newKsOption.text, newKsOption.value, false, false); }
			}
		}

		function loadObls() {
			document.getElementById('obl').length = 0;
			for (var i=0; i<oblarr.length; i++) {
		        if (document.createElement){
					var newOblOption = document.createElement('OPTION');
		            newOblOption.text = oblarr[i].name;
	    	        newOblOption.value = oblarr[i].id;

	        	    (document.getElementById('obl').options.add) ? document.getElementById('obl').options.add(newOblOption) : document.getElementById('ks').add(newOblOption, null);
		        } else { document.getElementById('obl').options[i] = new Option(newOblOption.text, newOblOption.value, false, false); }
			}
		}

		function loadPoints(ks_id) {
			document.getElementById('point').length = 0;
			if (full) {
		        if (document.createElement) {
					var newPointOption = document.createElement('OPTION');
	    	        newPointOption.text = 'Власне споживання';
    	    	    newPointOption.value = 0;
        	    	(document.getElementById('point').options.add) ? document.getElementById('point').options.add(newPointOption) : document.getElementById('point').add(newPointOption, null);
		        } else { document.getElementById('point').options[i] = new Option('Власне споживання', 0, false, false); }
			}

			k = 0;
			pointarr_ks.length = 0;
			for (var i=0; i<pointarr.length; i++) {
				if (pointarr[i].ks_id == ks_id ){
					pointarr_ks[k] = new Array();
					pointarr_ks[k].id = pointarr[i].id;
					pointarr_ks[k].name = pointarr[i].name;
					pointarr_ks[k].ks_id = pointarr[i].ks_id;
					pointarr_ks[k].obl_id = pointarr[i].obl_id;
					k++;
					
			        if (document.createElement){
						var newPointOption = document.createElement('OPTION');
			            newPointOption.text = pointarr[i].name;
	    		        newPointOption.value = pointarr[i].id;

	        		    (document.getElementById('point').options.add) ? document.getElementById('point').options.add(newPointOption) : document.getElementById('point').add(newPointOption, null);
			        } else { document.getElementById('point').options[i] = new Option(pointarr[i].name, pointarr[i].id, false, false); }
				}
			}
			
			document.getElementById('obl').length = 0;
			for (var i=0; i<oblarr.length; i++) {
				var obl_yes = false;
				 
				for (var j=0; j<pointarr_ks.length; j++) {
					if (pointarr_ks[j].obl_id == oblarr[i].id) {
						obl_yes  = true;
					}					
				}
				if (obl_yes){
					if (document.createElement){
						var newOblOption = document.createElement('OPTION');
		        	    newOblOption.text = oblarr[i].name;
		    	        newOblOption.value = oblarr[i].id;
	        	    	(document.getElementById('obl').options.add) ? document.getElementById('obl').options.add(newOblOption) : document.getElementById('obl').add(newOblOption, null);
		        	} else {
				        document.getElementById('obl').options[i] = new Option(newOblOption.text, newOblOption.value, false, false);
			    	}
				}
			}
						
		}
</script>
<table id="m" width="220" align="center" style="display:none">
<tr>
	<td class="menu" width="220">
		<div id="zvit_place">
		<select id="zvit" name="zvit" class="select" onchange="zvit_select();">
			<option value="-" disabled>1. Споживання за період:</option>
			<option value="month" selected>&nbsp;1.1. Таблиця за період</option>
			<option value="month_graf">&nbsp;1.2. Графік за період</option>
			<option value="diam">&nbsp;1.3. Діаграма за період</option>
			<option value="-" disabled>------------</option>
			<option value="select_ks">&nbsp;1.4. Всього по об'єкту</option>
			<option value="-" disabled>------------</option>
			<option value="select_saldo">&nbsp;1.5. Розподіл сальдо</option>
			<option value="total">&nbsp;1.6. Зрост. підсумок</option>
			<option value="-" disabled>------------</option>
			<option value="-" disabled>2. Споживання за добу:</option>
			<option value="day">&nbsp;2.1. Таблиця за добу</option>
			<option value="day_graf">&nbsp;2.2. Графік за добу</option>
			<option value="diad">&nbsp;2.3. Діаграма за добу</option>
			<option value="-" disabled>------------</option>
			<option value="select_ks_day">&nbsp;2.4. Всього по об'єкту</option>
			<option value="-" disabled>------------</option>
			<option value="-" disabled>3. Акти:</option>
			<option value="akt_sa">&nbsp;3.1. Акт СА</option>
			<option value="akt_sr">&nbsp;3.2. Акт СР</option>
			<option value="akt_gr">&nbsp;3.3. Акт ГР</option>
			<option value="-" disabled>============</option>
			<option value="nagr">4. Макс. навантаження</option>
			<option value="offline">5. Відключення</option>
			<%  if ((mode != null) && (mode.equals("admin"))) { %> 
				<option value="-" disabled>============</option>
				<option value="dogovor">Редагування договорів</option>
			<% } %>
		</select>
		</div>
		
		<table><tr><td height="5"></td></tr></table>

		<div id="t_dat1_place">
		<table id="t_dat2_1" class="menulight" cellpadding="0" cellspacing="0">
		<tr><td valign="middle" style="padding: 4px">
			<input id="day1" name="day1" class="input" type="text" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange1(this);" size="2" 
			value="<%= day1 %>" /><select id="month1" name="month1" class="select" onblur="datareset();" onfocus="datafocus(this);" onchange="datachange1(this);">
				<% for (int i=1; i<13; i++) { %>
					<option value="<%= Basic.formatNumber(2,2,0,0,i) %>" <% if (Integer.parseInt(month1) == i) { %>selected<% } %>><%= Basic.monthNameRod(i) %></option>
				<% } %>
			</select><input id="year1" name="year1" class="input" type="text" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange1(this);" size="4" value="<%= year1 %>">
			</td>
			<td width="10" valign="middle"><span id="datach1"><font color="red">*</font></span></td>
		</tr>
		</table>

		<table id="t_dat1" class="menulight" cellpadding="0" cellspacing="0">
		<tr><td valign="middle" style="padding: 4px">
			<input id="day" class="input" type="text" name="day" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange3(this);" size="2"
			value="<%= day %>"><select id="month" class="select" name="month" onblur="datareset();" onfocus="datafocus(this);" onchange="datachange3(this);">
				<% for (int i=1; i<13; i++) { %>
					<option value="<%= Basic.formatNumber(2,2,0,0,i) %>" <% if (Integer.parseInt(month) == i) { %>selected<% } %>><%= Basic.monthNameRod(i) %></option>
				<% } %>
			</select><input id="year" class="input" type="text" name="year" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange3(this);" size="4" value="<%= year %>">
			</td>
			<td width="10" valign="middle"><span id="datach3"><font color="red">*</font></span></td>
		</tr>
		</table>
		</div>

		<div id="t_dat2_place">		
		<table id="t_dat2_2" class="menulight" cellpadding="0" cellspacing="0">
		<tr><td valign="middle" style="padding: 4px">
			<input id="day2" name="day2" class="input" type="text" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange2(this);" size="2" 
				value="<%= day2 %>"><select id="month2" name="month2" class="select" onblur="datareset();" onfocus="datafocus(this);" onchange="datachange2(this);">
				<% for (int i=1; i<13; i++) { %>
					<option value="<%= Basic.formatNumber(2,2,0,0,i) %>" <% if (Integer.parseInt(month2) == i) { %>selected<% } %>><%= Basic.monthNameRod(i) %></option>
				<% } %>
			</select><input id="year2" name="year2" class="input" type="text" onblur="datareset();" onfocus="datafocus(this);" onkeyup="datachange2(this);" size="4" value="<%= year2 %>">
			</td>
			<td width="10" valign="middle"><span id="datach2"><font color="red">*</font></span></td>			
		</tr>
		</table>
		</div>

		<table><tr><td height="5"></td></tr></table>
		
		<div id="ks_place">		
		<select id="ks" name="ks" class="select" onchange="loadPoints(this.value);">
			<option></option>
		</select>
		</div>

		<div id="split"><table><tr><td height="5"></td></tr></table></div>
		<div id="obl_place">		
			<select id="obl" name="obl" class="select"></select>
		</div>

		<div id="point_place">
			<select id="point" name="point" class="select"></select>
		</div>

		<table><tr><td height="5"></td></tr></table>

		<table width="100%" class="menulight" cellpadding="0" cellspacing="0">
		<tr>
			<td id="status_place" valign="middle" style="padding: 3px">
				<table id="status" cellpadding="0" cellspacing="0">
				<tr><td id="loading" valign="middle" style="padding: 3px; font-weight: bold"></td></tr>
				</table>
			</td>		
			<td id="submit_place" valign="middle" style="padding: 4px" align="right">
				<input id="submit" class="input" type="button" onclick="subm();" value=" запит ">
			</td></tr>
		</table>
		
		<div id="admin_place">
			<span id="admin"></span>
		</div>
		
	
	</td></tr>
</table>

<script type="text/javascript"> 
	for (var i=1; i<=3; i++) document.getElementById('datach'+i).style.display='none';
<% for (int i=0; i<c.PointSize(); i++) { %>
	pointarr[<%= i%>]= new Array;
	pointarr[<%= i%>].id ='<%= c.getPointf(i,0) %>';
	pointarr[<%= i%>].name='<%= c.getPointf(i,1) %>';
	pointarr[<%= i%>].ks_id='<%= c.getPointf(i,2) %>';
	pointarr[<%= i%>].obl_id='<%= c.getPointf(i,8) %>';
<% } %>

<%	int ii = 0;  	
for (int i=0; i<c.KsSize(); i++) { 
boolean ks_yes = false; 
for (int j=0; j<c.PointSize(); j++) {
	if (c.getPointf(j,2).equals(c.getKSf(i,0))) {
		ks_yes = true;	
	}
} %>

<% if (ks_yes) {%>
	ksarr[<%= ii %>]= new Array;
	ksarr[<%= ii %>].id='<%= c.getKSf(i,0) %>';
	ksarr[<%= ii %>].name='<%= c.getKSf(i,1) %>';
<%  ii++;
} %>
<% } %>


<%	ii = 0;
for (int i=0; i<c.OblSize(); i++) {
boolean obl_yes = false; 
for (int j=0; j<c.PointSize(); j++) {
	if (c.getPointf(j,8).equals(c.getOblf(i,0))) {
		obl_yes = true;	
	}
} %>

<% if (obl_yes) {%>
	oblarr[<%= ii %>]= new Array;
	oblarr[<%= ii %>].id='<%= c.getOblf(i,0) %>';
	oblarr[<%= ii %>].name='<%= c.getOblf(i,1) %>';
<%  ii++;
} %>
<% } %>

	loadKss();
	loadObls();
	loadPoints(ksarr[0].id);
	document.getElementById('zvit').value='month';
	two_days();
	obls_no();
	
	document.getElementById('m').style.display='';
</script>


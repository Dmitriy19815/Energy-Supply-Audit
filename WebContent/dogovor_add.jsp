<%@ page import="ua.datapark.commons.Basic" %>
<%@ page extends="ua.datapark.jsp.SecureJSP"%>
<%@ page import="ua.datapark.db.DatabaseTon" %>
<%@ page import="ua.datapark.db.DatabaseProps" %>
<jsp:useBean id="dd" scope="page" class="ua.datapark.audit._Dogovor"/>
<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<jsp:useBean id="cc" scope="page" class="ua.datapark.audit.AuditNSI"/>
<%@ page import="ua.datapark.audit.Dogovor" %>
<%@ page import="ua.datapark.audit.Ks" %>
<%@ page import="ua.datapark.audit.Obl" %>
<%@ page import="ua.datapark.audit.DogovorLoss" %>
<%@ page import="java.util.*;" %>
<%@ page language="java" contentType="text/html; charset=Windows-1251" pageEncoding="Windows-1251"%>

<%
	String mode = (String) session.getAttribute("mode");
	String mode_label = "";
	if ((mode!=null) && (mode.equals("admin"))) { 
		mode_label = "режим адміністратора"; 
	} else response.sendRedirect("logon.jsp");

	String state = c.load();
	if (!state.equals("")) {
		response.sendRedirect("logon.jsp");
	}

	String message = request.getParameter("message");
	String store = request.getParameter("store");
	
%>
<DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Договір - Енергоаудит 5.4</title>
	<link rel="icon" href="images/audit.ico" type="image/x-icon" />
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<meta http-equiv="pragma" content="no-cache">
	<style type="text/css">
		body {
			font: normal 0.8em Verdana;
			padding: 10px
		}
		table {
			font: normal 0.9em Verdana;
			border-top: 1px solid #AAAAAA;
			border-right: 1px solid #AAAAAA;
		}
		td {
			border-left : 1px solid #AAAAAA;
			border-bottom : 1px solid #AAAAAA;
			padding: 5px;
		}
		.wh {
			font-weight: bold;
			text-align: right;
			vertical-align: middle;
			padding: 5px;
		}
		.gr {
			vertical-align: middle;
			text-align: center;
			background: #DDDDDD;
			padding: 5px;
		}
		.bt {
			text-align: right;
			vertical-align: middle;
			background: #DDDDDD;
			padding: 5px;
		}	
		.ie {
			font: normal 0.65em Verdana;
			color: #555555;
		}	
		.mess {
			font-weight: bold;
			color: #FF0000;
			border: 1px solid #AAAAAA;
		}	
	</style>
	<script type="text/javascript">
		function yesno() {
			if (confirm('Ви впевнені, що бажаєте зберегти нові параметри?\n\n (примітка: конфігурацію буде оновлено через декілька секунд...)')) {
				mform.submit();				
			} 
		}
	</script>

	<script type="text/javascript"><!--
		ksarr = new Array();
		oblarr = new Array();
		oblarr_ks = new Array();
		pointarr = new Array();
		pointarr_ks = new Array();
		
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
				}
			}

			document.getElementById('obl').length = 0;
			k = 0;
			oblarr_ks.length = 0;
			for (var i=0; i<oblarr.length; i++) {
				var obl_yes = false;
				
				for (var j=0; j<pointarr_ks.length; j++) {
					if (pointarr_ks[j].obl_id == oblarr[i].id) {
						obl_yes  = true;
					}					
				}
				if (obl_yes){
					oblarr_ks[k] = new Array();
					oblarr_ks[k].id = oblarr[i].id;
					oblarr_ks[k].name = oblarr[i].name;
					k++;
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
			loadPoints_obl(oblarr_ks[0].id);			
		}

		function loadPoints_obl(obl_id) {
			document.getElementById('point').length = 0;
			for (var i=0; i<pointarr_ks.length; i++) {
				if (pointarr_ks[i].obl_id == obl_id ){
			        if (document.createElement){
						var newPointOption = document.createElement('OPTION');
			            newPointOption.text = pointarr_ks[i].name;
	    		        newPointOption.value = pointarr_ks[i].id;

	        		    (document.getElementById('point').options.add) ? document.getElementById('point').options.add(newPointOption) : document.getElementById('point').add(newPointOption, null);
			        } else {
				        document.getElementById('point').options[i] = new Option(pointarr_ks[i].name, pointarr_ks[i].id, false, false);
				    }
				}
			}
		}		
	--></script>

</head>
<body>
<form name="mform" method="post" action="dogovor.jsp">

<table cellspacing="0" cellpadding="0">
	<tr><td class="gr">Номер</td>
		<td class="gr">Об'єкт</td>
		<td class="gr">Постачальник</td>
		<td class="gr">Дата підписання</td>
		<td class="gr">Дата початку</td>
		<td class="gr">Дата закінчення</td>
	</tr>
	<tr><td><input type="text" size="6" name="dogovor_nomer" value="" /></td>
		<td><select id="ks" name="ks_id" onchange="loadPoints(this.value);">			</option>
				
			</select>
		</td>
		<td><select id="obl" name="obl_id" onchange="loadPoints_obl(this.value)"></select>
		</td>
		<td><input type="text" size="6" name="dogovor_dat_podpis" value="" /></td>
		<td><input type="text" size="6" name="dogovor_dat_start" value="" /></td>
		<td><input type="text" size="6" name="dogovor_dat_end" value="" /></td>
	</tr>
	<tr><td colspan="7">
		<select style="width: 250px;" size="10" multiple name="point" id="point" disabled></select>
	</td></tr>
	<tr><td class="bt" colspan="7"><input type="submit" value=" зберегти " /></td></tr>
</table>
<input type="hidden" name="store" value="create_dogovor">
</form>

<script type="text/javascript"> 
 
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
	loadPoints(ksarr[0].id);

</script>

</html>

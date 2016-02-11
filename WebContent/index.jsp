<jsp:useBean id="c" scope="session" class="ua.datapark.audit.Audit"/>
<%@ page extends="ua.datapark.jsp.SecureJSP"%>
<%@ page import="ua.datapark.commons.Basic" %>
<%	String state = c.load();
	if (!state.equals("")) {
		response.sendRedirect("logon.jsp");
	}

	String mode = (String) session.getAttribute("mode");
	String mode_label = "";
	if ((mode!=null) && (mode.equals("admin"))) { 
		mode_label = "режим адміністратора"; 
	} else mode = "user";

	//инициализация даты
	String current_date = Basic.toDay("");
	String year = request.getParameter("year");
	if (year==null || year.equals("")) { year = current_date.substring(0,4); }
	String month = request.getParameter("month");
	if (month==null || month.equals("")) { month = current_date.substring(5,7); }
	String day = request.getParameter("day");
	if (day==null || day.equals("")) { day = current_date.substring(8,10); }

	String year1 = request.getParameter("year1");
	if (year1==null || year1.equals("")) { year1 = current_date.substring(0,4); }
	String month1 = request.getParameter("month1");
	if (month1==null || month1.equals("")) { month1 = current_date.substring(5,7); }
	String day1 = request.getParameter("day1");
	if (day1==null || day1.equals("")) { day1 = current_date.substring(8,10); }

	String year2 = request.getParameter("year2");
	if (year2==null || year2.equals("")) { year2 = current_date.substring(0,4); }
	String month2 = request.getParameter("month2");
	if (month2==null || month2.equals("")) { month2 = current_date.substring(5,7); }
	String day2 = request.getParameter("day2");
	if (day2==null || day2.equals("")) { day2 = current_date.substring(8,10); }

	String ks = request.getParameter("ks")!=null ? request.getParameter("ks") : "";
	String obl = request.getParameter("obl") !=null ? request.getParameter("obl") : "";
	String point = request.getParameter("point") !=null ? request.getParameter("point") : "0";

	//определение флага пересчета
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }

	//ЗАГЛУШКА RECALC
	recalc = "on";
	
	//определение флага типа страницы
	String zvit = request.getParameter("zvit");
	if (zvit==null || zvit.equals("")) { zvit = "total"; }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head> 
	<meta http-equiv="Content-Type" content="text/html"> // content="text/html; charset=Windows-1251" 
	<title><%= c.getUmgName() %> :: Енергоаудит 5.4</title>
	<link rel="stylesheet" href="style.css" type="text/css">
	<link rel="icon" href="images/audit.ico" type="image/x-icon">
	<script type="text/javascript">
		function menu_on() {
			document.getElementById('menu').style.display='';	
			document.getElementById('menuhor').style.display='none';	
			document.getElementById('zvit_place').appendChild(document.getElementById('zvit'));
			document.getElementById('t_dat1_place').appendChild(document.getElementById('t_dat2_1'));
			document.getElementById('t_dat2_place').appendChild(document.getElementById('t_dat2_2'));
			document.getElementById('t_dat1_place').appendChild(document.getElementById('t_dat1'));
			document.getElementById('ks_place').appendChild(document.getElementById('ks'));
			document.getElementById('obl_place').appendChild(document.getElementById('obl'));
			document.getElementById('point_place').appendChild(document.getElementById('point'));
			document.getElementById('status_place').appendChild(document.getElementById('status'));
			document.getElementById('submit_place').appendChild(document.getElementById('submit'));
			document.getElementById('admin_place').appendChild(document.getElementById('admin'));
		}
		function menu_on_hor() {
			document.getElementById('menu').style.display='none';	
			document.getElementById('menuhor').style.display='';	
			document.getElementById('zvit_place_hor').appendChild(document.getElementById('zvit'));
			document.getElementById('t_dat1_place_hor').appendChild(document.getElementById('t_dat2_1'));
			document.getElementById('t_dat2_place_hor').appendChild(document.getElementById('t_dat2_2'));
			document.getElementById('t_dat1_place_hor').appendChild(document.getElementById('t_dat1'));
			document.getElementById('ks_place_hor').appendChild(document.getElementById('ks'));
			document.getElementById('obl_place_hor').appendChild(document.getElementById('obl'));
			document.getElementById('point_place_hor').appendChild(document.getElementById('point'));
			document.getElementById('status_place_hor').appendChild(document.getElementById('status'));
			document.getElementById('submit_place_hor').appendChild(document.getElementById('submit'));
			document.getElementById('admin_place_hor').appendChild(document.getElementById('admin'));
		}
		function menu_off() {
			document.getElementById('menu').style.display='none';	
			document.getElementById('menuhor').style.display='none';	
		}
		
		function mess(str) {
			if (str == 'SQL Exception') document.getElementById('mess').innerHTML = 'Помилка під час роботи з БД';
		}
	</script>
</head>
<body>
<table cellspacing="0" cellpadding="0" width="100%" height="100%"> 
<tr><td colspan="2" height="21">
	<table width="100%" style="border-bottom: 1px solid #FFA500">
	<tr>
		<td width="210" class="pad">меню:&nbsp;<a href="javascript:menu_on();">зліва</a>&nbsp;|&nbsp;<a href="javascript:menu_on_hor();">зверху</a>&nbsp;|&nbsp;<a href="javascript:menu_off();">сховати</a></td>
		<td width="110" class="pad"><a target="_blank" id="printlink" href="data.html">версія для друку</a></td>
		<td class="pad" align="right"><span style="font: bold 1.0em Verdana; color: red"><%= mode_label %></span> </td>
		<td style="padding: 3px" align="right"><span id="mess" style="font: bold 1.0em Verdana; color: white; background: red"></span></td>
		<td align="right" class="pad" style="font-size: 1.2em"><%= c.getUmgName() %></td>
		<td width="160" class="pad" align="center" style="border-left: 1px solid #FFA500"><span style="font: bold 1.2em Verdana">Енергоаудит 5.4</span></td>
		<td width="120" class="kolon" align="center"><b><a style="color:white" target="_blank" href="help/">допомога</a>&nbsp;•&nbsp;<a style="color:white" target="_top" href="logon.jsp">вихід</a></b></td>
	</tr>
	</table>
</td></tr>

<form name="mform" method="get" target="destination" action="data.jsp" style="padding: 0px;"><input type="hidden" name="recalc" value="on"/>
<tr id="menuhor" style="display:none">
	<td colspan="2" height="20" width="100%" valign="top" style="background: #FDF0A6; border: 1px solid #DDDDDD;"><%@ include file="menu_hor.jsp" %></td>
</tr>
<tr>
	<td id="menu" valign="top" width="220"><%@ include file="menu.jsp" %></td>
	<td width="90%" valign="top" style="padding: 10px 0px 0px 10px" align="left"><IFRAME onload="complete();" id="destination" WIDTH="100%" HEIGHT="100%" FRAMEBORDER="0" SRC="data.html" align="left"></IFRAME></td>
</tr>
</form>

</table></body></html>
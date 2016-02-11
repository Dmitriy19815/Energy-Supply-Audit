<%@ page pageEncoding="Windows-1251" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 5 Transitional//EN">
<%	//обязательные параметры
	String ks = request.getParameter("ks");
	String obl = request.getParameter("obl");
	if (ks==null && obl==null) { %>не указан объект<br><%  }
	String point = request.getParameter("point");
	if (point==null) { %>не указана точка<br><%  }

	String day1 = request.getParameter("day1");
	String month1 = request.getParameter("month1");
	String year1 = request.getParameter("year1");

	String day2 = request.getParameter("day2");
	String month2 = request.getParameter("month2");
	String year2 = request.getParameter("year2");
	
	if ( (ks==null && obl==null) || point==null ) { return; }

	//определение флага пересчета
	String recalc = request.getParameter("recalc");
	if (recalc==null) { recalc = ""; }
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=Windows-1251">
	<link rel="stylesheet" href="style.css" type="text/css" >
	<script type="text/javascript">
		IE = (document.all); // Internet Explorer
		NC = (document.layers); // Netscape
		Opera = (document.getElementById); // Opera

		function getHeight() { // Получаем высоту рабочей области браузера
			if (IE || Opera) send = document.body.clientHeight;
			if (NC) send = window.innerHeight;
			return send;
		}

		function getWidth() { // Получаем ширину рабочей области браузера
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
<% String params = "?recalc="+recalc+
					"&amp;ks="+ks+
					"&amp;obl="+obl+
					"&amp;point="+point+
					"&amp;year1="+year1+
					"&amp;month1="+month1+
					"&amp;day1="+day1+
					"&amp;year2="+year2+
					"&amp;month2="+month2+
					"&amp;day2="+day2; %>
					
<IFRAME id="iframe" FRAMEBORDER="0" SRC="dovidka_frame.jsp<%= params %>" WIDTH="850" HEIGHT="80%"></IFRAME>
</body>
</html>
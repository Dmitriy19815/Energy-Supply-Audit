<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page extends="ua.datapark.jsp.SecureJSP"%>
<%@ page language="java" contentType="text/html; charset=Windows-1251" pageEncoding="Windows-1251"%>

<%	//инициализация даты
	String year = request.getParameter("year")==null ? "" : request.getParameter("year");
	String month = request.getParameter("month")==null ? "" : request.getParameter("month");
	String day = request.getParameter("day")==null ? "" : request.getParameter("day");

	String year1 = request.getParameter("year1")==null ? "" : request.getParameter("year1");
	String month1 = request.getParameter("month1")==null ? "" : request.getParameter("month1");
	String day1 = request.getParameter("day1")==null ? "" : request.getParameter("day1");

	String year2 = request.getParameter("year2")==null ? "" : request.getParameter("year2");
	String month2 = request.getParameter("month2")==null ? "" : request.getParameter("month2");
	String day2 = request.getParameter("day2")==null ? "" : request.getParameter("day2");

	String ks = request.getParameter("ks")==null ? "" : request.getParameter("ks");
	String obl = request.getParameter("obl")==null ? "" : request.getParameter("obl");
	String point = request.getParameter("point")==null ? "" : request.getParameter("point");

	//определение флага пересчета
	String recalc = request.getParameter("recalc")==null ? "" : request.getParameter("recalc");
	//ЗАГЛУШКА RECALC
	recalc = "on";
	
	//определение флага типа страницы
	String zvit = request.getParameter("zvit")==null ? "month" : request.getParameter("zvit");
	String print = request.getParameter("print")==null ? "" : request.getParameter("print");
%>
				<% if ( zvit.equals("month") ) { %>
					<% if ( 
							!ks.equals("") && 
							!point.equals("") &&
							!day1.equals("") && !month1.equals("") && !year1.equals("") &&
							!day2.equals("") && !month2.equals("") && !year2.equals("") ) { 
						if (!print.equals("yes")) {	%>
							<jsp:include page="month_full.jsp" flush="true" />
						<% } else { response.sendRedirect("month_print.jsp?"+request.getQueryString()); }
					} else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				<% if ( zvit.equals("month_graf") ) { %>
					<% if ( 
							!ks.equals("") && 
							!point.equals("") && 
							!day1.equals("") && !month1.equals("") && !year1.equals("") &&
							!day2.equals("") && !month2.equals("") && !year2.equals("") ) { 
							if (!print.equals("yes")) {
								%><jsp:include page="month_graf_full.jsp" flush="true" /><%
							} else { response.sendRedirect("month_graf_print.jsp?"+request.getQueryString()); }
					} else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				<% if ( zvit.equals("diam") ) { %>
					<% if ( 
							!ks.equals("") && 
							!point.equals("") && 
							!day1.equals("") && !month1.equals("") && !year1.equals("") &&
							!day2.equals("") && !month2.equals("") && !year2.equals("") ) { 
							if (!print.equals("yes")) {
								%><jsp:include page="month_dia_full.jsp" flush="true" /><%
							} else { response.sendRedirect("month_dia_print.jsp?"+request.getQueryString()); }
					 } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				<% if ( zvit.equals("nagr") ) { %>	
					<% if ( 
							!ks.equals("") && 
							!point.equals("") && !point.equals("0") &&
							!day1.equals("") && !month1.equals("") && !year1.equals("") &&
							!day2.equals("") && !month2.equals("") && !year2.equals("") ) { 
							if (!print.equals("yes")) {	
								%><jsp:include page="nagr_full.jsp" flush="true" /><%
							} else { response.sendRedirect("nagr_print.jsp?"+request.getQueryString()); }
					   } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				<% if ( zvit.equals("offline") ) { %>	
					<% if ( 
							!ks.equals("") && 
							!point.equals("") && !point.equals("0") &&
							!day1.equals("") && !month1.equals("") && !year1.equals("") &&
							!day2.equals("") && !month2.equals("") && !year2.equals("") ) { 
							if (!print.equals("yes")) {	
								%><jsp:include page="offline_full.jsp" flush="true" /><%
							} else { response.sendRedirect("offline_print.jsp?"+request.getQueryString()); }
					   } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				<% if ( zvit.equals("day") ) { %>
					<% if ( 
							!ks.equals("") && 
							!point.equals("") &&
							!day.equals("") && !month.equals("") && !year.equals("") ) { 
							if (!print.equals("yes")) {	
								%><jsp:include page="day_full.jsp" flush="true" /><%
							} else { response.sendRedirect("day_print.jsp?"+request.getQueryString()); }
					   } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				<% if ( zvit.equals("day_graf") ) { %>
					<% if ( 
							!ks.equals("") && 
							!point.equals("") && 
							!day.equals("") && !month.equals("") && !year.equals("") ) { 
							if (!print.equals("yes")) {	
								%><jsp:include page="day_graf_full.jsp" flush="true" /><%
							} else { response.sendRedirect("day_graf_print.jsp?"+request.getQueryString()); }
					   } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				<% if ( zvit.equals("diad") ) { %>
					<% if ( 
							!ks.equals("") && 
							!point.equals("") && 
							!day.equals("") && !month.equals("") && !year.equals("") ) { 
							if (!print.equals("yes")) {	
								%><jsp:include page="day_dia_full.jsp" flush="true" /><%
							} else { response.sendRedirect("day_dia_print.jsp?"+request.getQueryString()); }
					   } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				<% if ( zvit.equals("total") ) { %>
					<% if ( 
							!ks.equals("") && 
							!point.equals("") && !point.equals("0") && 
							!day1.equals("") && !month1.equals("") && !year1.equals("") &&
							!day2.equals("") && !month2.equals("") && !year2.equals("") ) { 
							if (!print.equals("yes")) {	
								%><jsp:include page="total_full.jsp" flush="true" /><%
							} else { response.sendRedirect("total_print.jsp?"+request.getQueryString()); }
					   } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				
				
				<% if ( zvit.equals("akt_sa") ) { %>
					<% if ( 
							!ks.equals("") && 
							!day1.equals("") && !month1.equals("") && !year1.equals("") &&
							!day2.equals("") && !month2.equals("") && !year2.equals("") ) { 
							if (!print.equals("yes")) {	
								%><jsp:include page="akt_sa_full.jsp" flush="true" /><%
							} else { response.sendRedirect("akt_sa_print.jsp?"+request.getQueryString()); }
					   } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>

				<% if ( zvit.equals("select_ks") ) { %>
					<% if ( 
							!ks.equals("") && 
							!day1.equals("") && !month1.equals("") && !year1.equals("") &&
							!day2.equals("") && !month2.equals("") && !year2.equals("") ) { 
							if (!print.equals("yes")) {	
								%><jsp:include page="select_ks_full.jsp" flush="true" /><%
							} else { response.sendRedirect("select_ks_print.jsp?"+request.getQueryString()); }
					   } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				<% if ( zvit.equals("select_ks_day") ) { %>
					<% if ( 
							!ks.equals("") && 
							!day.equals("") && !month.equals("") && !year.equals("") ) { 
							if (!print.equals("yes")) {	
								%><jsp:include page="select_ks_day_full.jsp" flush="true" /><%
							} else { response.sendRedirect("select_ks_day_print.jsp?"+request.getQueryString()); }
					   } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				<% if ( zvit.equals("select_saldo") ) { %>
					<% if ( 
							!ks.equals("") && 
							!day1.equals("") && !month1.equals("") && !year1.equals("") &&
							!day2.equals("") && !month2.equals("") && !year2.equals("") ) { 
							if (!print.equals("yes")) {	
								%><jsp:include page="select_saldo_full.jsp" flush="true" /><%
							} else { response.sendRedirect("select_saldo_print.jsp?"+request.getQueryString()); }
					   } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				<% if ( zvit.equals("dogovor") ) { %>
					<% if ( !ks.equals("") && 
							!day1.equals("") && !month1.equals("") && !year1.equals("") &&
							!day2.equals("") && !month2.equals("") && !year2.equals("") ) { 
							 response.sendRedirect("dogovor.jsp?"+request.getQueryString()); 
					   } else { %>
						<table class="datahead" width="300" align="center" style="padding: 10px">
						<tr><td><b>Нема повних даних для запиту</b><br><br></td></tr>
						</table>
					<% } %>
				<% } %>
				
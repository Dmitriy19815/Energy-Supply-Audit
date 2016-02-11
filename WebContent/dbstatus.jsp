<%@ page import="ua.datapark.db.DatabaseTon" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%	
	DatabaseTon dbt = DatabaseTon.getInstance();
	String testConn = dbt.testConn();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>Статус пула з'єднань з БД - Енергоаудит 5.4</title>
	<link rel="icon" href="images/audit.ico" type="image/x-icon" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
			vertical-align: middle;
			border-left : 1px solid #AAAAAA;
			border-bottom : 1px solid #AAAAAA;
			padding: 5px;
		}
		.wh {
			font-weight: bold;
			text-align: right;
		}
		.gr {
			background: #DDDDDD;
		}
		.he {
			font: bold 0.7em Verdana;
		}	
	</style>
</head>
<body>
Статус пула з'єднань до БД (<a href="dbconfig.jsp")>конфігурація</a>)<br><br>

<div style="padding: 5px">Кількість з'єднань</div>
<table cellspacing="0" cellpadding="0">
	<tr><td class="he">з'єднання\значення</td>
		<td class="wh">поточне</td>
		<td class="wh">максимальне</td></tr>
	<tr><td class="wh">активні</td>
		<td class="gr"><%= dbt.getNumActive() %></td>
		<td class="gr"><%= dbt.getMaxActive() %></td></tr>
	<tr><td class="wh">очікуючі</td>
		<td class="gr"><%= dbt.getNumIdle() %></td>
		<td class="gr"><%= dbt.getMaxIdle() %></td></tr>
</table>
<br>

<div style="padding: 5px">Параметри</div>
<table cellspacing="0" cellpadding="0">
	<tr><td class="wh">max wait, mc</td>
		<td class="gr"><%= dbt.getMaxWait() %></td></tr>
	<tr><td class="wh">pool behavior</td>
		<td class="gr"><%= dbt.getBehavior() %></td></tr>
	<tr><td class="wh">connection</td>
		<td class="gr"><%= testConn %></td></tr>
</table>
</body>
</html>

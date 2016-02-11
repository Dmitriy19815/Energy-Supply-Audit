<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Data Connect</title>
</head>
<body>
<font>face="verdana" </font>
<h2>Oracle connection and show table data</h2>
<hr/>
	<form action="show.do" method="post">
		<font face="verdana" size="3">
		Enter Table Name: 
		<input type="text" name="table" /> 
		<input type="submit" value="Show" />
		</font>
	</form>
</body>
</html>
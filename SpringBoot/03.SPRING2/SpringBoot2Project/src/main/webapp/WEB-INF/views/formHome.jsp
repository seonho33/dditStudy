<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>GET 방식의 register 요청</h1>
	<form action="/chapt03/http/register">
		<input type="submit" value="register(GET)">	
	</form>
	<h1>POST 방식의 register 요청</h1>
	<form action="/chapt03/http/register" method="post">
		<input type="submit" value="register(POST)">	
	</form>
	<h1>GET 방식의 modify 요청</h1>
	<form action="/chapt03/http/modify">
		<input type="submit" value="modify(GET)">	
	</form>
	<h1>POST 방식의 modify 요청</h1>
	<form action="/chapt03/http/modify" method="post">
		<input type="submit" value="modify(POST)">	
	</form>
	<h1>POST 방식의 remove 요청</h1>
	<form action="/chapt03/http/remove" method="post">
		<input type="submit" value="modify(POST)">	
	</form>
	<h1>GET 방식의 remove 요청</h1>
	<form action="/chapt03/http/list">
		<input type="submit" value="list(GET)">	
	</form>
</body>
</html>
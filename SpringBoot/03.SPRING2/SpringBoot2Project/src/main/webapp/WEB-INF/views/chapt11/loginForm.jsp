<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>LOGIN</h1>
	<hr/>
	
	<form action="/login" method="post">
		username : <input type="text" name="username"><br>
		password : <input type="text" name="password"><br>
		<input type="checkbox" name="remember-me"/> Remember Me
		<input type="submit" value="로그인">
		<security:csrfInput/>
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>LOGIn</h1>
	<form action="/login" method="post">
		username : <input type="text" name="username"><br>
		password : <input type="text" name="password"><br>
		<input type="submit" value="인증"/>
		<sec:csrfInput/>
	</form>
	
</body>
</html>
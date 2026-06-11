<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>ModelAttribute</h1>
	<hr>

	<p>1) 기본 자료형인 매개변수에 @ModelAttribute 어노테이션을 지정하여 데이터를 전달한다.</p>
	<form action="/chapt06/modelattribute/register01" method="post">
		userId : <input type="text" name="userId"> <br>
	 	password : <input type="text" name="password"> <br>
	 	<input type="submit" value="전송">
	</form>

	<p>2) 자바빈즈 규칙에 맞는 객체는 매개변수로 선언하면 기본적으로 전달한다.</p>
	<form action="/chapt06/modelattribute/register02" method="post">
		userId : <input type="text" name="userId"> <br>
		password : <input type="text" name="password"> <br>
		<input type="submit" value="전송">
	</form>

</body>
</html>
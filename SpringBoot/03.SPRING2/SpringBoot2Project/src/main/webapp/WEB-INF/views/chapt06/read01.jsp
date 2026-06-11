<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>Read03 Result</h3>
	<p>Model에 각 데이터 설정</p>
	userId : ${userId} <br>
	password : ${password } <br>
	userName : ${userName } <br>
	email : ${email } <br>
	birthDay : ${birthDay } <br>
	
	<hr>
	
	<p>member.userId : ${member.userId }</p>
	<p>member.password : ${member.password }</p>
	<p>member.userName : ${member.userName }</p>
	<p>member.email : ${member.email }</p>
	<p>member.birthDay : ${member.birthDay }</p>
	<p>member.dateOfBirth : ${member.dateOfBirth }</p>
	
	<hr>
	
	<p>Model에 특정한 이름으로 설정</p>
	
	<p>user.userId : ${user.userId }</p>
	<p>user.password : ${user.password }</p>
	<p>user.userName : ${user.userName }</p>
	<p>user.email : ${user.email }</p>
	<p>user.birthDay : ${user.birthDay }</p>
	<p>user.dateOfBirth : ${user.dateOfBirth }</p>


</body>
</html>
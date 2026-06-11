<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>Result</h3>
	<p>
		register01 로 꺼낸 데이터 <br>
		
		userId : ${userId } <br>
		password : ${password }
	</p>
	
	<p>
		register02 로 꺼낸 데이터 <br>
		
		member.userId : ${member.userId } <br>
		member.password : ${member.password }
	</p>

	<p>
		RedirectAttributes 로 보낸 데이터 <br>
		msg : ${msg} <br>
	</p>

</body>
</html>
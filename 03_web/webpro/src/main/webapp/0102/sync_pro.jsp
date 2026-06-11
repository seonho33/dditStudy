<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

table {
	border: 2px solid blad;
}

td{
	width:  200px;
	height : 50px;
	text-align: center;
}

.title{
	font-size: 1.5rem;
	background: blue;
	color: white;
}

</style>

</head>
<body>
<% 

request.setCharacterEncoding("UTF-8");

//controller(서블릿) 에서 할일 ============
//입력한 값들을 가져온다..

String userId = request.getParameter("id");
String userName = request.getParameter("name");
String userMail = request.getParameter("mail");

//db연결 - crud처리 - 결과값 받기
//service - dao - mapper이용 -db실행
//실행결과를 - dao - service - controller 로 실행

//결과값을 가지고 view 페이지로 이동
//결과를 출력

%>

<table border = "1">
<tr>
	<td class ="title">아이디</td>
	<td class ="title">이름</td>
	<td class ="title">이메일</td>
</tr>
<tr>
	<td><%= userId %></td>
	<td><%= userName %></td>
	<td><%= userMail %></td>
</tr>

</table>
</body>
</html>
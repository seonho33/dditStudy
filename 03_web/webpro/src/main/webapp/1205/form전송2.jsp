<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
table{
	border : 2px solid blue;
}
td {
	width: 200px;
	height: 100px;
	text-align: center;
}


</style>

</head>
<body>

<h1>JSP : JAVA SERVER PAGE </h1>

<% 
	//request.. 클라이언트 폼에서 입력한 값을 가져온다...
	String userID = request.getParameter("id");
	String userPass = request.getParameter("pass");
	String userAge = request.getParameter("age");
	
	String sfile = request.getParameter("file");
	String gend = request.getParameter("gender");
	String foods[] = request.getParameterValues("like");

	String str = "";
	
	if(foods != null){
	for(String fd : foods){
		str += fd +	"<br>";	
	}}else{
		str = "없음";
	}
	//db연결 crud처리 하고 결과를 hrml로 생성해서 출력
%>

<table border="1">
	<tr>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>성별</th>
		<th>나이</th>
		<th>첨부파일</th>
		<th>좋아하는 음식</th>
	</tr>

	<tr>
		<td><%= userID %></td>
		<td><%= userPass %></td>
		<td><%= gend %></td>
		<td><%= userAge %></td>
		<td><%= sfile %></td>
		<td><%= str%></td>
	</tr>

</table>

</body>
</html>
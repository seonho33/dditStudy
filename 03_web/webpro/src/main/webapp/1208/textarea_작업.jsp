<%@page import="java.lang.annotation.Documented"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
table {
	border: 2px solid gray;
}
td {
	width: 200px;
	height: 50px;
	text-align: center;
}
th {
	width: 80px;
}


</style>

</head>
<body>

<h1>JSP : Java Server Page</h1>

<% 
	//전송된 데이터 받기 - name, inof
	String vname = request.getParameter("name");
	String vinfo = request.getParameter("info");
	
	//db연결, 저장, 삭제, 수정, insert 작업 후 결과를 얻는다
	//결과를 가지고 응답 메세지를 작성한다...
	
	//info 에는 엔터(\r\n)가 포함되어있다
	//td에 출력하기 위해서는 \n을 br테그로 바꿔야한다
	vinfo = vinfo.replaceAll("\n", "<br>");
	
%>

<table border="1">

	<tr>
		<th>이름</th>
		<td><%= vname %></td>
	</tr>

	<tr>
		<th>자기소개</th>
		<td><%= vinfo %></td>
	</tr>

</table>

</body>
</html>
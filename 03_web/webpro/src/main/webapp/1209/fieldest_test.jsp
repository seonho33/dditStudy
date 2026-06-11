<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">


</style>

</head>
<body>

<% 
	String id = request.getParameter("id");
	String name = request.getParameter("name");
%>

<h1>JSP : Java Server Page</h1>

<table border="1">
	<tr>
		<th>아이디</th>
		<td><%= id %></td>
	</tr>

	<tr>
		<th>이름</th>
		<td><%= name %></td>
	</tr>
	
	<tr>
		<th>전화번호</th>
		<td></td>
	</tr>
	
</table>

</body>
</html>
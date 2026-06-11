<%@page import="javax.print.attribute.HashPrintRequestAttributeSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
table {
	border: 2px solid Gray;
	margin: auto;
}

td {
	width: 200px;
	height: 80px;
	text-align: center;
}

th {
	width: 100px;
}

</style>

</head>
<body>

<% 
	//car1과 car2의 전송데이터 값 받기
	String car1 = request.getParameter("car1");
	String cars[] = request.getParameterValues("car2");
	
	
	String str = "";
	if(cars != null){
		for(String car : cars){
			str += car + "<br>";
		}
	}
%>

</body>

<table border="1">
	<tr>
		<th>car1</th>
		<td><%= car1 %></td>
	</tr>
	
	<tr>
		<th>car2</th>
		<td><%= str %></td>
	</tr>
	
</table>

</html>
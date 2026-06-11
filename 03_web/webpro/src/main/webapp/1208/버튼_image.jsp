<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

table {
	border: 2px solid blue;
}
td {
	width: 200px;
	height: 50px;
	text-align: center;
}
th{
	width: 100px;
}


</style>

</head>
<body>

<h1>JSP : Java Server Page</h1>

<% 
	//클라이언트에서 전송시 입력받은 값을 전달받는 문구
	String price = request.getParameter("price");
	String qty = request.getParameter("qty");

	int result = Integer.parseInt(price)*Integer.parseInt(qty);
	
%>

<table border="1">

	<tr>
		<th>가격</th>
		<td><%= price %></td>
	</tr>

	<tr>
		<th>수량</th>
		<td><%= qty %></td>
	</tr>

	<tr>
		<th>총액</th>
		<td><%= result %></td>
	</tr>
	


</table>

</body>
</html>
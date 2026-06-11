<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
h1{
	color: red;
}
table{
	border: 2px solid blue;
}
td{
	width : 300px;
	height: 50px;
	text-align: center;
}
th {
}


</style>
</head>
<body>

<h1>JSP : Java Server Page</h1>
jsp는 서버내에서 동작하는 서버스크립트 언어 <br>
실제 실행되는 java 코드는 보이지않고 <br>
실행된 결과만 html코드로 브라우저에 보여진다 <br>
자바언어를 이용하여 실행되는 코드는 &lt;% %> 기호 사이에 
기술한다. <br>
클라이언트의 form 양식에서 입력된 데이터를 가져와서 <br>
DB와 연결해서 CRUD를 처리하고 결과를 만든다 <br>


<%
	String userID = request.getParameter("id");
	String userPass = request.getParameter("pass");
%>

<table border="1">
	<tr>
		<th>아이디</th>
		<th>비밀번호</th>
	</tr>
	
	<tr>
		<td><%= userID %></td>
		<td><%= userPass %></td>
	</tr>

</table>

</body>
</html>
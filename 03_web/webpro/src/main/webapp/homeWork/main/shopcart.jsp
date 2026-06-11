<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

</script>

</head>
<body>

<% 
	String name = request.getParameter("name");
	String price = request.getParameter("price");
%>
	<p>name : <%=name%></p>
	<p>price : <%=price%></p>


</body>
</html>
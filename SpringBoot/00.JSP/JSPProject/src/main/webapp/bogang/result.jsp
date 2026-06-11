<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	String info = (String)session.getAttribute("SessionInfo");
%>
생년월일 : ${birth}<br>
이름 : ${param.name }<br>
비밀번호 : ${param.pw }<br>
SessionInfo : ${sessionScope.SessionInfo }
</body>
</html>
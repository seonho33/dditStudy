<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>JSTL , c:redirect</h1>
	<p>지정한 페이지로 리 다이렉트 한다.</p>
	<c:redirect url="http://localhost:8080/chapt03/list" />
	<h4>redirect 이후의 코드는 실행되지 않는다</h4>
	
	
</body>
</html>
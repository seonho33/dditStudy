<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Hellow World!</h1>
	<p>The time on the server is ${serverTime }</p>
	
	<!-- 로그인을 하지 않은 경우 -->
	<sec:authorize access="isAnonymous()">
		<a href="/login">로그인</a>
	</sec:authorize>
	
	<!-- 인증이 된 사용자인 경우 -->
	<sec:authorize access="isAuthenticated()">
		<a href="/logout">로그아웃</a>
	</sec:authorize>
	
	
	<h3>MAIN MENU</h3>
	<a href="/security/board/list">Board List</a>
	<a href="/security/notice/list">Notice List</a>
	
</body>
</html>
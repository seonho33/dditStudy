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
	
	<h1>JSTL , c:import</h1>
	<p>특정 URL의 결과를 읽어와서 현재 위치에 삽입한다.</p>
	<c:import url="http://localhost:8080/chapt03/list"/>
	<br>
	
	<p>상대 URL - 절대경로</p>
	<c:import url="/chapt03/list" />
	
	<p>상대 URL - 상대경로</p>
	<c:import url="../../chapt03/list.jsp" />
	
</body>
</html>
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
	<h1>JSTL, C:SET</h1>
	<hr/>
	
	<c:if test="${member.hobbyArray == null }">
		<p>member.hobbyArray == null</p>
	</c:if>
	
	<c:if test="${member.hobbyArray eq null }">
		<p>member.hobbyArray eq null</p>
	</c:if>
	
	<h1>JSTL, c:if</h1>
	<p>test 속성에 true나 false를 값으로 가지는 bool타입의 변수가 올 수 있다.</p>
	<c:if test="${member.foreigner }">
		<p>member.foreigner == true </p>
	</c:if>
	<h1>JSTL, c:when, c:otherwise</h1>588491156
	<c:choose>
		<c:when test="${member.gender == 'M' }">
			<p>남자</p>
		</c:when>
		<c:otherwise>
			<p>여자</p>
		</c:otherwise>
	</c:choose>
	</body>
</html>
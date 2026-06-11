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
	
	<h1>JSTL , c:forEach</h1>
	<c:forEach items="${member.hobbyArray }" var="hobby">
		${hobby } <br>
	</c:forEach>
	
	<h1>JSTL, c:forTokens</h1>
	
	<!-- 
		delims 속성에 지정된 구분자를 사용하여 items 속성에 전달된 문자열을 나누고
		var 속성에 명시한 변수에 나뉘어진 문자열을 지정하낟.
		
	 -->
	 
	 <c:forTokens items="${member.hobby }" delims="," var="hobby" varStatus="vs">
	 	${hobby} <br>
	 </c:forTokens>
	
</body>
</html>
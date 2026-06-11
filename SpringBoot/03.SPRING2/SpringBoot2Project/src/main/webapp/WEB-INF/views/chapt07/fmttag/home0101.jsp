<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h1>FMTTAG</h1>
	<hr>
	<h4>1) type 속성을 지정하거나 pattern 속성을 지정하여 숫자를 형식화한다.</h4>
	
	<p>coin : ${coin }</p>
	<p>number : <fmt:formatNumber value="${coin }" /></p>
	<p>percent : <fmt:formatNumber value="${coin }" type="percent"/></p>
	<p>currency : <fmt:formatNumber value="${coin }" type="currency" /></p>
	<p>pattern : <fmt:formatNumber value="${coin }" pattern="000000.00" /></p>
	
	
</body>
</html>
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
	<p>넘겨받은 문자의 type 속성 형태가 number인 경우</p>
	<p>coin : ${coinNumber }</p>
	<fmt:parseNumber value="${coinNumber }" var="coinNum" />
	<p>coinNum : ${coinNum }</p>
	<hr>
	
	<p>넘겨받은 문자의 type 속성 형태가 currency인 경우</p>
	<p>coin : ${coinCurrency }</p>
	<fmt:parseNumber value="${coinCurrency }" type="currency" var="coinCur"/>
	<p>coinCur : ${coinCur }</p>
	<hr>
	
	<p>넘겨받은 문자의 type 속성 형태가 percent인 경우</p>
	<p>coin : ${coinPercent }</p>
	<fmt:parseNumber value="${coinPercent }" type="percent" var="coinPer"/>
	<p>coinPer : ${coinPer }</p>
	<hr>
	
	<p>넘겨받은 문자의 type 속성 형태가 pattern인 경우</p>
	<p>coin : ${coinPattern }</p>
	<fmt:parseNumber value="${coinPattern }" pattern="0,000.00" var="coinPat"/>
	<p>coinPat : ${coinPat }</p>
	<hr>
	
</body>
</html>
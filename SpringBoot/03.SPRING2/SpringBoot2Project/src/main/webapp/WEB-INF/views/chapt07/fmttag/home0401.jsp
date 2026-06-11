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
	<p>dateStyle 속성을 지정하지 않으면 기본값은 default 이다.</p>
	<p>dateStyle : ${dateValueDefault }</p>
	<fmt:parseDate value = "${dateValueDefault }" type="date" var="dateDefault"/>
	<p>date : ${dateValueDefault }</p>
	<br>
	
	<p>dateStyle 속성을 short로 지정하여 문자열을 Date 객체로 변환한다.</p>
	<p>dateStyle : ${dateValueShort }</p>
	<fmt:parseDate value="${dateValueShort }" type="date" dateStyle="short" var="dateShort" />
	<p>date : ${dateShort }</p>
	<br>
	
	<p>dateStyle 속성을 medium로 지정하여 문자열을 Date 객체로 변환한다.</p>
	<p>dateStyle : ${dateValueMedium }</p>
	<fmt:parseDate value="${dateValueMedium }" type="date" dateStyle="medium" var="dateMedium" />
	<p>date : ${dateMedium }</p>
	<br>
	
	<p>dateStyle 속성을 Long로 지정하여 문자열을 Date 객체로 변환한다.</p>
	<p>dateStyle : ${dateValueLong }</p>
	<fmt:parseDate value="${dateValueLong }" type="date" dateStyle="long" var="dateLong" />
	<p>date : ${dateLong }</p>
	<br>
	
	<p>dateStyle 속성을 Full로 지정하여 문자열을 Date 객체로 변환한다.</p>
	<p>dateStyle : ${dateValueFull }</p>
	<fmt:parseDate value="${dateValueFull }" type="date" dateStyle="full" var="dateFull" />
	<p>date : ${dateFull }</p>
	<br>
	
	<p>pattern을 지정하여 문자열을 Date 객체로 변환한다.</p>
	<p>pattern : ${dateValuePattern }</p>
	<fmt:parseDate value="${dateValuePattern }" type="date" pattern="yyyy-MM-dd HH:mm:ss" var="datePattern" />
	<p>date : ${datePattern }</p>
	<br>
	
</body>
</html>
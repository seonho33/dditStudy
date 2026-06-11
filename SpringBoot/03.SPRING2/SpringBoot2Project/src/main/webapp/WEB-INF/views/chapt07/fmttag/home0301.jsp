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
	<p>type 속성을 date로 지정하여 날짜 포멧팅을 한다.</p>
	<br>
	<p>now : ${now }</p>
	<p>date default : <fmt:formatDate value="${now }" type="date" dateStyle="default" /></p>
	<p>date short : <fmt:formatDate value="${now }" type="date" dateStyle="short" /></p>
	<p>date medium : <fmt:formatDate value="${now }" type="date" dateStyle="medium" /></p>
	<p>date long : <fmt:formatDate value="${now }" type="date" dateStyle="long" /></p>
	<p>date full : <fmt:formatDate value="${now }" type="date" dateStyle="full" /></p>
<br><br>
	
	
	<p>type 속성을 time으로 지정하여 날짜 포멧팅을 한다.</p>
		<br>
	<p>now : ${now }</p>
	<p>date default : <fmt:formatDate value="${now }" type="time" timeStyle="default" /></p>
	<p>date short : <fmt:formatDate value="${now }" type="time" timeStyle="short" /></p>
	<p>date medium : <fmt:formatDate value="${now }" type="time" timeStyle="medium" /></p>
	<p>date long : <fmt:formatDate value="${now }" type="time" timeStyle="long" /></p>
	<p>date full : <fmt:formatDate value="${now }" type="time" timeStyle="full" /></p>
<br><br>
	
	<p>type 속성을 both로 지정하여 날짜와 시간 둘다 포멧팅을 한다.</p>
		<br>
	<p>now : ${now }</p>
	<p>date default : <fmt:formatDate value="${now }" type="both" dateStyle="default" timeStyle="default" /></p>
	<p>date short : <fmt:formatDate value="${now }" type="both" dateStyle="short" timeStyle="short" /></p>
	<p>date medium : <fmt:formatDate value="${now }" type="both" dateStyle="medium" timeStyle="medium" /></p>
	<p>date long : <fmt:formatDate value="${now }" type="both" dateStyle="long" timeStyle="long" /></p>
	<p>date full : <fmt:formatDate value="${now }" type="both" dateStyle="full" timeStyle="full" /></p>
<br><br>
	<!-- 

		y : 년
		M : 월
		d : 일
		H : 시간
		m : 분
		s : 초
		z : 나라 표기 시
		a : 오전/오후 표시

	 -->

	<p>pattern 속성을 지정하여 날짜를 포멧팅한다.</p>
		<br>
	<p>now : ${now }</p>
	<p>pattern : <fmt:formatDate value="${now }" pattern="yyyy-MM-dd HH:mm:ss"/></p>
	<p>pattern : <fmt:formatDate value="${now }" pattern="a h:mm"/></p>
	<p>pattern : <fmt:formatDate value="${now }" pattern="z a h:mm"/></p>
	
	 
	
	
</body>
</html>
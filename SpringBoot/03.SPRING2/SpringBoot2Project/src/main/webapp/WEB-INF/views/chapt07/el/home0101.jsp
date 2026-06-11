<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>str : ${str }</p>
	<p>contains : ${fn:contains(str,'Hello') }</p>
	<p>containsIgnoreCase : ${fn:containsIgnoreCase(str,'hellow') }</p>
	<p>startsWith : ${fn:startsWith(str,'<font>') }</p>
	<p>endsWith : ${fn:endsWith(str,'World!') }</p>
	<p>indexOf : ${fn:indexOf(str,'World!') }</p>
	<p>length : ${fn:length(str) }</p>
	
	
	<p>escapeXml : ${fn:escapeXml(str) }</p>
	<p>replace : ${fn:replace(str,'Hellow', 'Hi') }</p>
	<p>toLowerCase : ${fn:toLowerCase(str) }</p>
	<p>toUpperCase : ${fn:toUpperCase(str) }</p>
	<p>trim : ${fn:trim(str) }</p>
	<p>substring : ${fn:substring(str,7,12) }</p>
	<p>substringAfter : ${fn:substringAfter(str,'World!') }</p>
	<p>substringBefore : ${fn:substringBefore(str,'World!') }</p>
	<p>split : ${fn:split(str,' ') }</p>
	
	<c:set value="${fn:split(str,' ') }" var="strArray" />
	<p>join : ${fn:join(strArray,'-') }</p>
	<p>join : ${fn:join(fn:split(str,' '),'-') }</p>


</body>
</html>
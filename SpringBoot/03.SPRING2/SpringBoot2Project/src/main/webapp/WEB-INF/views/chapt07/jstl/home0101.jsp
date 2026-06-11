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
	
	<!-- c:set을 이용해 Member의 userId를 id라는 변수로 저장한다. -->
	<c:set value="${member.userId }" var="id"/>
	<table border="1">
		<tr>
			<td>member.userId</td>
			<td>${id }</td>
		</tr>
	</table>
	<!-- c:set의 몸체를 이용해 Member의 userId를 memId라는 변수로 지정한다.  -->
	<c:set value="${member.userId }" var="memId"/>
	<table border="1">
		<tr>
			<td>member.userId</td>
			<td>${memId }</td>
		</tr>
	</table>
	
	<!-- c:set의 target을 Member로 지정 후 해당 프로퍼티 중 userId의 값을 'hongkildong'으로 변경한다. -->
	<c:set target="${member }"	property="userId" value="hongkildong"/>
	<table border="1">
		<tr>
			<td>member.userId</td>
			<td>${member.userId }</td>
		</tr>
	</table>
	
	<!-- memId에 저장된 값을 삭제한다. -->
	<c:remove var="memId"/>
	
	<p>memId 변수를 삭제 처리함</p>
	<table border="1">
		<tr>
			<td>member.userId</td>
			<td>${memId}</td>
		</tr>
	</table>
	</body>
</html>
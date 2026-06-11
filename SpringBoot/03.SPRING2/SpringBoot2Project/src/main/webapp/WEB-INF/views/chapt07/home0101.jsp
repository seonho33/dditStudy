<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>1) 자바빈즈 프로퍼티를 조회하는 경우 '속성명.프로퍼티명' 또는 "속성명[키명]"을 지정한다.</p>
	<table border="1">
		<tr>
			<td>\${memberMap.userId }</td>
			<td>${memberMap.userId }</td>
		</tr>
		<tr>
			<td>\${memberMap.password }</td>
			<td>${memberMap.password }</td>
		</tr>
		<tr>
			<td>\${memberMap.email }</td>
			<td>${memberMap["email"] }</td>
		</tr>
		<tr>
			<td>\${memberMap.userName }</td>
			<td>${memberMap["userName"] }</td>
		</tr>
	</table>
</body>
</html>
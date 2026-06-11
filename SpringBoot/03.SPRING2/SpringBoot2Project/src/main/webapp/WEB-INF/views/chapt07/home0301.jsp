<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>4. 표현언어(EL) 을 이용하여 출력</h3>
	<p>4) empty 연산자를 이용한 방법</p>
	<table border="1">
		<tr>
			<td>\${empty emptyMember }</td>	<!-- emptyMember는 null이므로 참 -->
			<td>${empty emptyMember }</td>
		</tr>
		<tr>
			<td>\${empty emptyMember.userId }</td>	<!-- emptyMember는 null이므로 userId가 존재하지 않는다. -->
			<td>${empty emptyMember.userId }</td>
		</tr>
		<tr>
			<td>\${empty member }</td>	<!-- member에는 default 값이 설정되어 있기 때문에 null이 아님 -->
			<td>${empty member }</td>
		</tr>
		<tr>
			<td>\${empty member.userId }</td>	<!-- member의 userId는 기본 값이 설정되어 있기 때문에 null이 아님 -->
			<td>${empty member.userId }</td>
		</tr>
	</table>
</body>
</html>
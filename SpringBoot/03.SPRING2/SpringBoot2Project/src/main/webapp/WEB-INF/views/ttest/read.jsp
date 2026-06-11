<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Read</h1>
<table border="1">
	<tr>
		<td>
			userNo		
		</td>
		<td>
			${member.userNo }
		</td>
	</tr>
	<tr>
		<td>
			userId		
		</td>
		<td>
			${member.userId }
		</td>
	</tr>
	<tr>
		<td>
			userName		
		</td>
		<td>
			${member.userName }
		</td>
	</tr>
	<tr>
		<td>
			regDate		
		</td>
		<td>
		</td>
	</tr>
	<tr>
		<td>
			updDate		
		</td>
		<td>

		</td>
	</tr>
	<c:forEach items="${member.authList }" var="memberAuth">
		<tr>
			<td>
				Auth
			</td>
			<td>
				${memberAuth.auth }
			</td>
		</tr>
	</c:forEach>

</table>

</body>
<script type="text/javascript">


</script>

</html>

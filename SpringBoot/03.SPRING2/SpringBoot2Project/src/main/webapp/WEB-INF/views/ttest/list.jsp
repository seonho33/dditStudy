<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>List</title>
</head>
<body>

<h1>List</h1>

<table border="1">
	<tr>
		<td>
			userNo
		</td>
		<td>
			userId
		</td>
		<td>
			userName
		</td>
		<td>
			regDate
		</td>
		<td>
			updDate
		</td>
	</tr>
	<c:choose>
		<c:when test="${empty memberList }">
			<tr>
				<td colspan="5">
					조회할 데이터가 없습니다.
				</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${memberList }" var="member">
				<tr>
					<td>
						${member.userNo }
					</td>
					<td>
						<a href="/ttest/read?userId=${member.userId }">
							${member.userId }
						</a>
					</td>
					<td>
						${member.userName }
					</td>
					<td>
						<fmt:formatDate value="${member.regDate }" pattern="yy년MM월dd일"/>
					</td>
					<td>
						<fmt:formatDate value="${member.updDate }" pattern="yy년MM월dd일"/>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>



</body>
<script type="text/javascript">


</script>
</html>
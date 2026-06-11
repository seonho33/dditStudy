<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>LIST</h2>
	<a href="/crud/member/register">등록</a>
	
	<table border="1">
		<tr>
			<td align="center" width="60">번호</td>
			<td align="center" width="80">아이디</td>
			<td align="center" width="80">비밀번호</td>
			<td align="center" width="80">사용자명</td>
			<td align="center" width="180">작성일</td>
			<td align="center" width="180">수정일</td>
		</tr>
	<c:choose>
		<c:when test="${empty memberList }">
			<tr>
				<td colspan="4">조회하실 회원정보가 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${memberList }" var="member" varStatus="vs">
				<tr>
					<td align="center">${vs.count }</td>
					<td align="center">
						<a href="/crud/member/read?userNo=${member.userNo}">
							${member.userId }
						</a>
					</td>
					<td align="center">${member.userPw }</td>
					<td align="center">${member.userName }</td>
					<td align="center">
						<fmt:formatDate value="${member.regDate }" pattern="yyyy.MM.dd hh:mm:ss"/>
					</td>
					<td align="center">
						<fmt:formatDate value="${member.updDate }" pattern="yyyy.MM.dd hh:mm:ss"/>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>	
	</table>	


</body>
</html>
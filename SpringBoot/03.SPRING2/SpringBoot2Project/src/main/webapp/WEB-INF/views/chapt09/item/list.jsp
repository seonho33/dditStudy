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
	<a href="/item/register">등록</a>
	
	<table border="1">
		<tr>
			<td align="center" width="80">상품ID</td>
			<td align="center" width="320">상품명</td>
			<td align="center" width="100">가격</td>
			<td align="center" width="80">편집</td>
			<td align="center" width="80">제거</td>
		</tr>
	<c:choose>
		<c:when test="${empty itemList }">
			<tr>
				<td colspan="5">조회할 상품이 없습니다.</td>
			</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${itemList }" var="item" varStatus="vs">
				<tr>
					<td align="center">${item.itemId }</td>
					<td align="center">${item.itemName }</td>
					<td align="center">${item.price}</td>
					<td align="center">
						<a href="/item/modify?itemId=${item.itemId }">상품 편집</a>
					</td>
					<td align="center">
						<a href="/item/remove?itemId=${item.itemId }">상품 제거</a>
					</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>	
	</table>	


</body>
</html>
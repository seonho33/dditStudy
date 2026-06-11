<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Remove</h2>
	<form action="/item/remove" method="post">
		<input type="hidden" name="itemId" value="${item.itemId }">
		<table>
			<tr>
				<td>상품명</td>
				<td>
					<input type="text" name="itemName" value="${item.itemName }" disabled="disabled">
				</td>
			</tr>
			<tr>
				<td>가격</td>
				<td>
					<input type="text" name="price" value="${item.price }" disabled="disabled">
				</td>
			</tr>
			<tr>
				<td>파일</td>
				<td>
					<img src="/item/display?itemId=${item.itemId }" width="210" height="240">
				</td>
			</tr>
			<tr>
				<td>개요</td>
				<td>
					<textarea rows="10" cols="30" name="description"  disabled="disabled">${item.description }</textarea>
				</td>
			</tr>
		</table>
		<div>
			<button type="submit" id="modifyByn">Remove</button>
			<button type="button" id="listBtn" onclick="javascript:location.href='/item/list'">List</button>
		</div>
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

<c:set value="등록" var="name" />

	<h2>Register</h2>
	
	<form action="" method="post" id="">
		<table border="1">
			<tr>
				<td>제목</td>
				<td>
					<input type="text" id="title" name="title" value="">
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>
					<input type="text" id="writer" name="writer" value="">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="10" cols="30" name="content" id="content"></textarea>
				</td>
			</tr>
		</table>
		<div>
			<input type="submit" id="registerBtn" value="등록" />
			<input type="button" id="listBtn" value="목록" />
		</div>
	</form>
</body>
<script type="text/javascript">
</script>

</html>
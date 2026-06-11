<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

	<h2>Register</h2>
	<form action="/testBoard/register" method="post" id="registerForm" >
		<table>
			<tr>
				<td>
					제목
				</td>
				<td>
					<input type="text" name="title" id="title">
				</td>
			</tr>
			<tr>
				<td>
					작성자
				</td>
				<td>
					<input type="text" name="writer" id="writer">
				</td>
			</tr>
			<tr>
				<td>
					내용
				</td>
				<td>
					<textarea rows="5" cols="10" name="content" id="content"></textarea>
				</td>
			</tr>
		</table>
		<button type="button" id="registerBtn">등록</button>
		<button type="button" id="listBtn" >취소</button>
	</form>
</body>
<script type="text/javascript">
$(function(){
	let registerForm = $("#registerForm");
	let registerBtn = $("#registerBtn");
	let listBtn = $("#listBtn");
	
	registerBtn.on("click",function(){
		let title = $("#title").val();
		let writer = $("#writer").val();
		let content = $("#content").val();
		
		if(title.trim().length==0){
			alert("제목을 입력해주세요");
			return false;
		}
		
		if(writer.trim().length==0){
			alert("작성자를 입력해주세요");
			return false;
		}
		
		if(content.trim().length==0){
			alert("내용을 입력해주세요");
			return false;
		}
		
		registerForm.submit();
		
	});
	
	listBtn.on("click",function(){
		location.href="/testBoard/list";
	});
	
})

</script>

</html>
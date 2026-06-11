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

	<h2>Read</h2>
	<table border="1">
		<tr>
			<td>제목</td>
			<td></td>
		</tr>
		<tr>
			<td>작성시간</td>
			<td>
			<fmt:formatDate value="" pattern=""/>
			</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td></td>
		</tr>
		<tr>
			<td>내용</td>
			<td></td>
		</tr>
	</table>
	<div>
		<input type="button" id="modifyBtn" value="수정" />
		<input type="button" id="deleteBtn" value="삭제" />
		<input type="button" id="listbtn" value="목록" />
	</div>
	<form action="" method="" id="delForm">
		<input type="hidden" name="boardNo" value="">
	</form>

</body>
<script type="text/javascript">
$(function(){
	let modifyBtn = $("#modifyBtn");
	let deleteBtn = $("#deleteBtn");
	let listbtn = $("#listbtn");
	let delForm = $("#delForm");
	
	listbtn.on("click",function(){
		location.href = "/crud/board/list"
	});
	
	modifyBtn.on("click",function(){
		delForm.attr("action","/crud/board/modify");
		delForm.attr("method","get");
		delForm.submit();
	});
	
	deleteBtn.on("click",function(){
		if(confirm("정말로 삭제하시겠습니까?")){
			delForm.submit();
		};
	});
})
</script>
</html>
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
			<td>userId</td>
			<td>${member.userId }</td>
		</tr>
		<tr>
			<td>userName</td>
			<td>${member.userName }</td>
		</tr>
		<tr>
			<td>auth - 1</td>
			<td>${member.authList[0].auth }</td>
		</tr>
		<tr>
			<td>auth - 2</td>
			<td>${member.authList[1].auth }</td>
		</tr>
		<tr>
			<td>auth - 3</td>
			<td>${member.authList[2].auth }</td>
		</tr>
	</table>
	<div>
		<input type="button" id="modifyBtn" value="수정" />
		<input type="button" id="deleteBtn" value="삭제" />
		<input type="button" id="listbtn" value="목록" />
	</div>
	<form action="/crud/member/crudRemove" method="post" id="delForm">
		<input type="hidden" name="userNo" value="${member.userNo }">
	</form> 

</body>
<script type="text/javascript">
$(function(){
	let modifyBtn = $("#modifyBtn");
	let deleteBtn = $("#deleteBtn");
	let listbtn = $("#listbtn");
	let delForm = $("#delForm");
	
	listbtn.on("click",function(){
		location.href = "/crud/member/list"
	});
	
	// 수정 버튼 이벤트
	modifyBtn.on("click",function(){
		delForm.attr("action","/crud/member/modify");
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
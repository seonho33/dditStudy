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
	<h1>List</h1>
	
	<table border="1" id="formTable">
			<tr>
				<td>
					유저번호
				</td>
				<td>
					아이디
				</td>
				<td>
					이름
				</td>
				<td>
					등록일
				</td>
				<td>	
					수정일
				</td>
				<td>	
					수정하기
				</td>
				<td>	
					삭제하기
				</td>
			</tr>		
		<c:forEach items="${memberList}" var="member" varStatus="vs">
			<tr>
				<td  align="center">
					${member.userNo }
				</td>
				<td>
					<a href="/testMember/detail?userNo=${member.userNo }">
						${member.userId }
					</a>
				</td>
				<td>
					${member.userName }
				</td>
				<td>
					<fmt:formatDate value="${member.regDate }" pattern="yyyy년 MM월 dd일"/>
				</td>
				<td>
					<fmt:formatDate value="${member.updDate }" pattern="yyyy년 MM월 dd일"/>
				</td>
				<td>
					<button type="button" name="modifyBtn" data-userno="${member.userNo }">수정</button>
				</td>
				<td>
					<button type="button" name="deleteBtn" data-userno="${member.userNo }">삭제</button>
				</td>
			</tr>
		</c:forEach>
	</table>
	<button type="button" id="register">등록하기</button>
</body>
<script type="text/javascript">
$(function(){
	let formTable = $("#formTable");
	let register = $("#register");
	
	register.on("click",function(){
		location.href="/testMember/register"
	})
	
	
	formTable.on("click",function(ev){
		let modifyBtn = ev.target.closest('[name = "modifyBtn"]');
		let deleteBtn = ev.target.closest('[name = "deleteBtn"]');
		
		if(modifyBtn){
			location.href="/testMember/modify?userNo="+modifyBtn.dataset.userno
		}
		
		if(deleteBtn){
			if(confirm("정말로 삭제하시겠습니까?")){
				let userNo = deleteBtn.dataset.userno
				$.ajax({
					url:"/testMember/deleteMember",
					method:"post",
					data:{userNo},
					success:function(){
						alert("삭제완료")
						deleteBtn.closest("tr").remove();
					},
					error:function(err){
						alert("삭제실패")
						console.log(err)
					}
				});
			}
		}
		
	})
})

</script>


</html>
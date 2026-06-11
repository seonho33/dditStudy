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
	<form action="/testBoard/search" id="searchForm">
		<table border="1">
			<tr>
				<td>
					검색어 입력
				</td>
				<td>
					<input type="text" name="searchWord" id="searchWord">
				</td>
				<td>
					<select name="searchType" id="searchType">
						<option value="writer" selected="selected">작성자</option>
						<option value="title">글제목</option>
					</select>
				</td>
				<td>
					<button type="button" id="searchBtn">검색</button>
				</td>
			</tr>
		</table>
	</form>
	<br>
	
	<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>			
			<td>작성자</td>			
			<td>등록일</td>			
		</tr>
		<div id="dataArea">
			<c:choose>
				<c:when test="${empty boardList }">
					<tr>
						<td colspan="4">
							조회할 내용이 없습니다
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach items="${boardList}" var="board" >
						<tr>
							<td>
								${board.boardNo }
							</td>
							<td>
								${board.title }
							</td>
							<td>
								${board.writer }
							</td>
							<td>
								<fmt:formatDate value="${board.regDate }" pattern="yy.MM.dd"/>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</table>
	
</body>
<script type="text/javascript">
$(function(){
	let searchForm = $("#searchForm");
	let searchBtn = $("#searchBtn");
	
	searchBtn.on("click",function(){
		let searchWord = $("#searchWord").val();
		let searchType = $("#searchType").val();
		let str = "";
		
		$.ajax({
			url : "/testBoard/search",
			method : "get",
			data : searchForm.serialize(),
			success : function(dataList){
				
			},
			error : function(err){
				alert("에러발생");
				console.log(err);
			}
			
		})
		
	})
	
})
</script>
</html>
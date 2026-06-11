<%@page import="kr.or.ddit.ch17.vo.BoardFileVO"%>
<%@page import="kr.or.ddit.ch17.vo.BoardVO"%>
<%@page import="kr.or.ddit.ch17.dao.BoardRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH17") %></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<!-- 
							게시판 수정 페이지입니다.
							1. 수정 버튼 클릭 시, 게시글 수정을 진행하기 위해 boardUpdate.jsp로 이동 후 수정 처리를 진행해주세요.
							2. 목록 버튼 클릭 시, 목록 페이지(boardList.jsp)로 이동해주세요. 
						-->
						<% 
						String sno = request.getParameter("no");
						String[] user = (String[])session.getAttribute("SessionInfo");
						
						if(user == null){
							response.sendRedirect("login.jsp?error=3");
						}
						
						BoardRepository boardDao = BoardRepository.getInstance();
						BoardVO bvo = new BoardVO();
						BoardFileVO bfvo = new BoardFileVO();
						
						if(sno != null){
							int no = Integer.parseInt(sno);
							bvo = boardDao.getOnlyBoardById(no);
							bfvo = bvo.getFileVO();
						}
						
						pageContext.setAttribute("bvo", bvo);
						pageContext.setAttribute("bfvo", bfvo);
						%>
						
					 	<h5 class="ddit_chapter">게시판 수정</h5>
						<form action="boardUpdate.jsp" method="post" id="udtForm" enctype="multipart/form-data">
							<input type="hidden" name="no" value="${bvo.no}"/>
							<table class="table table-bordered">
								<tr>
									<td>제목</td>
									<td><input type="text" class="form-control" name="title" id="title" value="${bvo.title }"/></td>
								</tr>
								<tr>
									<td>내용</td>
									<td>
										<textarea class="form-control" rows="8" cols="30" id="content" name="content" >${bvo.content }</textarea>
									</td>
								</tr>
								<tr>
									<td>파일</td>
									<td><input type="file" class="form-control" name="filename"/></td>
								</tr>
								<tr>
									<td>첨부파일 내용</td>
									<td>
										${bfvo.originalFileName }<br/>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<button type="button" class="btn btn-warning" id="udtBtn">수정</button>
										<button type="button" class="btn btn-primary">취소</button>
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
<script type="text/javascript">
$(function(){
	
	let btn = $("button");	
	let udtForm = $("#udtForm")
	
	btn.on("click",function(){
		let goPage	= "";			//클릭한 버튼의 text() 에 따라 goPage 설정
		let elem = $(this).text();
		console.log("버튼 체킁!!! : ", elem);
		
		if(elem =="수정"){
			udtForm.submit();
		};
		if(elem =="취소"){
			goPage = "logout.jsp";
		};
		
		if(goPage != "" && goPage !=null){
			location.href=goPage;
		};
	});
	
})


</script>
	
</body>
</html>
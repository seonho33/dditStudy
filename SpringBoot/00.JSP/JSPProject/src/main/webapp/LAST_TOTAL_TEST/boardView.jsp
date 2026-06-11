<%@page import="java.io.File"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="kr.or.ddit.ch17.vo.BoardFileVO"%>
<%@ page import="kr.or.ddit.ch17.vo.BoardVO"%>
<%@ page import="kr.or.ddit.ch17.dao.BoardRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
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
							게시판 상세보기 페이지 입니다.
							1. 수정 버튼 클릭 시, 수정 페이지(boardUpdateForm.jsp)로 이동합니다.
							2. 삭제 버튼 클릭 시, 해당 게시글이 삭제 처리 될 수 있도록 합니다.
								> "정말로 삭제하시겠습니까?" 알림창이 나타나고, [확인]버튼을 클릭 시 삭제를 처리하기 위해 boardRemove.jsp로 이동하여 처리해주세요.
								> "정말로 삭제하시겠습니까?" 알림창이 나타나고, [취소]버튼을 클릭 시 알림창이 꺼질 수 있게 해주세요.
							3. 목록 버튼 클릭 시, 목록 페이지(boardList.jsp)로 이동합니다.
						-->
						<% 
						BoardRepository boardDao = BoardRepository.getInstance();
						BoardVO bvo = new BoardVO();
						String sno = request.getParameter("no");
						String downloadPath = "";
						
						int no = 0;
						if(sno !=null){
							no = Integer.parseInt(sno);
						}else{
							response.sendRedirect("boardList.jsp");
							return;
						}
						String[] user = (String[])session.getAttribute("SessionInfo");
						String userId = null;
						if(user != null){
							userId = user[0];
						};
						
						bvo = boardDao.getBoardById(no);
						BoardFileVO bfvo = bvo.getFileVO();
						if(bfvo!=null){
						downloadPath = request.getContextPath()+"/resources/images/upload"+File.separator+bfvo.getFileName();
						
						}
						pageContext.setAttribute("userId",userId);
						pageContext.setAttribute("bvo", bvo);
						pageContext.setAttribute("bfvo", bfvo);
						pageContext.setAttribute("downloadPath", downloadPath);
						pageContext.setAttribute("no", no);
						pageContext.setAttribute("user", user);
						%>
						
						<h5 class="ddit_chapter">게시글 상세보기</h5>
						<p class="ddit_text pt-3"></p>
						<table class="table table-bordered">
							<tr>
								<td>제목</td>
								<td>${bvo.title }</td>
							</tr>
							<tr>
								<div>
									<td colspan="2">
									<span>작성자 : ${bvo.writer}</span>
									<span>작성일 : ${bvo.regDate}</span>  
									<span>조회수 : ${bvo.hit}</span>
									</td>
								</div>
							</tr>
							<tr>
								<td colspan="2" style="white-space: pre-wrap;">${bvo.content}</td>
							</tr>
							<tr>
								<td>첨부파일</td>
								<td>
									<c:choose>
										<c:when test="${not empty user}">
											<a href="${downloadPath}" download="${bfvo.originalFileName }">${bfvo.originalFileName}</a>
										</c:when>
										<c:otherwise>
											<a onclick="login()" href="#" >${bfvo.originalFileName}</a>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<button type="button" class="ddit_btn ddit_btn_outline_primary" id="listBtn">목록</button>
									<c:if test="${(bvo.writer eq userId) or (userId eq 'admin') }">
									<button type="button" class="ddit_btn ddit_btn_outline_warning" id="udtBtn">수정</button>
									<button type="button" class="ddit_btn ddit_btn_outline_danger" id="delBtn">삭제</button>
									</c:if>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>

<script type="text/javascript">
	function login(){
		alert("로그인 후 사용할 수 있습니다!");
	};
	
$(function(){
	let btn = $("button");
	
	
	btn.on("click",function(){
		let goPage = "";
		let elem = $(this).text();
		console.log("버튼 체킁!!(elem) : ", elem);
		
		if(elem == "수정"){
			goPage = "boardUpdateForm.jsp?no=${no}";
		};
		
		if(elem == "삭제"){
			goPage = "boardRemove.jsp?no=${no}";
		};
		
		if(elem == "목록"){
			goPage = "boardList.jsp";
		};
		
		if(goPage !=""&&goPage !=null){
			location.href=goPage;
		};
		
	});
	
	
})


</script>
	
</body>
</html>
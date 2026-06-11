<%@page import="kr.or.ddit.ch17.dao.BoardRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
							게시글 삭제를 처리하기 위한 페이지입니다.
							1. 삭제할 게시글 정보를 넘겨받고, 삭제를 진행해주세요.
							2. 삭제 완료 후, 게시판 목록 페이지(boardList.jsp)로 이동해주세요.
						 -->
						 <%
						 String[] user = (String[])session.getAttribute("SessionInfo");
						 if(user == null){
							 response.sendRedirect("login.jsp?error=2");
						 };
						 String sno = request.getParameter("no");
						 BoardRepository boardDao = BoardRepository.getInstance();
						 if(sno != null){
							 int no = Integer.parseInt(sno);
							 boardDao.deleteBoard(no); 
						 }else{
							 response.sendRedirect("login.jsp?error=3");
						 }
						 response.sendRedirect("boardList.jsp");				 
						 %>
						 
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
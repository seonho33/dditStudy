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
							로그아웃을 처리하는 페이지 입니다.
	                    	1. 로그아웃 시, 세션 초기화를 진행해주세요.
	                    	2. 로그아웃 후, 게시판 목록으로 이동합니다.
	                     -->
	                     <% 
	                     String pageNo = request.getParameter("pageNo");

	                     session.removeAttribute("SessionInfo");
	                     
	                     if(pageNo.equals("boardList")){
	                    	 response.sendRedirect("boardList.jsp");
	                     }else if(pageNo.equals("dropbox")){
	                    	 response.sendRedirect("dropbox.jsp");
	                     }else{
	                    	 response.sendRedirect("login.jsp");
	                     }
	                     
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
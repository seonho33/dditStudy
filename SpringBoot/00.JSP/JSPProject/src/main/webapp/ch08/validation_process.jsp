<%@page import="kr.or.ddit.index.IndexRepository"%>
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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH08")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<h5 class="ddit_chapter2">유효성 검사를 위한 스크립트 이벤트</h5>
						<p class="customer_text">입력에 성공했습니다!</p>
						
						<%
							request.setCharacterEncoding("utf-8");
						
							String id = request.getParameter("id");
							String pw = request.getParameter("pw");
							
							String id2 = request.getParameter("id2");
							String pw2 = request.getParameter("pw2");
						%>
							<h5 class="ddit_text2">Javascript 버전</h5>
							<p class="ddit_text2">
								아이디 : <%= id %><br/>
								비밀번호 : <%= pw %><br/>
							</p>
							
							<h5 class="ddit_text2">Jqery 버전</h5>
							<p class="ddit_text2">
								아이디 : <%= id2 %><br/>
								비밀번호 : <%= pw2 %><br/>
							</p>
						
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
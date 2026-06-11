<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@page import="kr.or.ddit.ch07.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.ddit.ch07.MemberDAO"%>
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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH08") %></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<!-- 
	                    	1. 참고 이미지를 참고하여 회원 목록 페이지를 작성해주세요.
	                    		- 목록은 프로필 이미지, 아이디, 이름 항목이 함께 출력될 수 있도록 해주세요.
	                    	2. 현재 로그인 한 사용자의 아이디가 일치하는 목록 데이터는 [본인]을 표시해주세요.
	                    	3. [회원등록] 버튼 클릭 시, 회원가입 페이지로 이동하여 회원을 새롭게 등록할 수 있도록 해주세요.
	                    	4. 각 회원목록의 내용 중 [상세정보] 버튼 클릭 시, 해당 회원의 상세정보 페이지(ch07_test_memberDetail.jsp)로 이동해주세요.
	                     -->
	                     <div class="row">
	                     <%
	                     MemberDAO dao = MemberDAO.getInstance();
	                     String id = request.getParameter("id");
	                     ArrayList<MemberVO> memberList = dao.getMemberList();
	                     for(MemberVO mvo : memberList){
	                     %>
	                     	<div class="col-md-4" style="height: 600px;">
	                     		<div class="card" >
	                     			<div class="card-header">
	                     			<%
	                     				if(mvo.getMem_id().equals(id)){
	                     			%>
	                     			
	                     				<h5>[본인]<%=mvo.getMem_name() %>님의 정보</h5>
	                     			
	                     			<%
	                     				}else{
	                     			%>
	                     				<h5><%=mvo.getMem_name() %>님의 정보</h5>
	                     			<%
	                     				}
	                     			%>
	                     			</div>
	                     			<div class="card-body">
										<img alt="" src="/upload/images/<%=mvo.getFilename()%>" height="300px" width="100%">
	                     				<h5><%=mvo.getMem_id() %></h5>
	                     				<h5><%=mvo.getMem_name() %></h5>
	                     			</div>
	                     			<div class="card-footer">
	                     			<%
	                     				if(mvo.getMem_id().equals(id)){
	                     			%>
	                     			
										<a href="ch07_test_memberDetail.jsp?id=<%=mvo.getMem_id()%>" class="ddit_btn ddit_btn_outline_info">상세정보</a>
	                     			
	                     			<%
	                     				}
	                     			%>
	                     			</div>
	                     		</div>
	                     	</div>
	                     <%
	                     }
	                     %>
	                     </div>
	                     
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
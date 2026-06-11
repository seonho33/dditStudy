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
							1. 참고 이미지를 참고하여 회원 상세정보 페이지를 작성해주세요.
							
							2. 회원 프로필 이미지, 아이디, 비밀번호, 이름, 성별을 출력해주세요.
							
							3. [목록] 버튼 클릭 시, 목록페이지(ch07_test_memberList.jsp)로 이동해주세요.
						 -->
						 
						<%
	                     MemberDAO dao = MemberDAO.getInstance();
	                     String id = request.getParameter("id");
	                     ArrayList<MemberVO> memberList = dao.getMemberList();
	                     for(MemberVO mvo : memberList){
	                    	if(mvo.getMem_id().equals(id)){
						 %>
						<a href="ch07_test_memberList.jsp?id=<%=id %>"  class="ddit_btn ddit_btn_outline_info">목록으로</a>
						 
						<div class="row">
	                     	<div class="col-md-4">
	                     		<div class="card">
	                     			<div class="card-header">
	                     				<h5>[본인]<%=mvo.getMem_name() %>님의 정보</h5>
	                     			</div>
	                     			<div class="card-body">
										<img alt="" src="/upload/images/<%=mvo.getFilename()%>">
	                     				<h5><%=mvo.getMem_id() %></h5>
	                     				<h5><%=mvo.getMem_pw() %></h5>
	                     				<h5><%=mvo.getMem_name() %></h5>
	                     				<h5><%=mvo.getMem_sex() %></h5>
	                     			<%
	  					                   }
	                     				}
	                     			%>
	                     			</div>
	                     		</div>
	                     	</div>
	                     </div>
						 <a href="ch07_test_updateMember.jsp?id<%=id%>" class="ddit_btn ddit_btn_outline_primary"> 수정하기</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
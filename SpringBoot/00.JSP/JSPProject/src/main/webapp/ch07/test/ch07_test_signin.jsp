<%@page import="kr.or.ddit.index.IndexRepository"%>
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
                    		1. 로그인 처리를 진행할 수 있도록 로그인 페이지를 작성해주세요.
                    			아이디 : _____________
                    			비밀번호 : ____________
                    			[ 로그인 ]  [ 회원가입 ]
                    		
                    		2. ch07_test_signin_process.jsp로 입력한 아이디, 비밀번호를 넘겨 로그인을 진행하세요.
                    		   이때, 입력한 계정 정보가 일치하지 않아 에러가 발생 시 에러 메세지를 로그인 페이지에서 출력해주세요.
                    	 -->
                    	 
                    	 <%
                    	 	String error = request.getParameter("error");
                    	 	if(error != null){
                    	 	%>
                    	 	<c:set value="<%=error %>" var="err"></c:set>
							<c:if test="${err == '1' }">
								<div class="alert alert-danger">
									 존재하지 않는 회원입니다!
								</div>
							</c:if>
							<c:if test="${err == '2'}">
								<div class="alert alert-danger">
									파일 크기가 초과되어 회원가입을 진행할 수 없습니다.
								</div>
							</c:if>
							<c:if test="${err == '3' }">
								<div class="alert alert-danger">
									서버에러!
								</div>
							</c:if>
                    	 <%
                    	 	}
                    	 %>
                    	 
                    	 <h3 class="ddit_chapter">로그인</h3>
                    	 <p class="ddit_text pb-3"></p>
                    	 <form action="ch07_test_signin_process.jsp" method="post">
                    	 	아이디 : <input type="text" name="id"/><br/>
                    	 	비밀번호 : <input type="password" name="pw"/><br/>
                    	 	<input type="submit" class="ddit_btn ddit_btn_outline_primary" value="로그인">
                    	 	<a href="ch07_test_signup.jsp" class="ddit_btn ddit_btn_outline_info">회원가입</a>
                    	 </form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
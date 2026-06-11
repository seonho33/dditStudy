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
							로그인 페이지입니다.
							
							1. 회원가입이 없기 때문에 로그인 성공은 아래 계정으로 입력 시, 로그인 성공으로 간주합니다.
							로그인 처리는 login_process.jsp로 계정 정보를 넘겨 처리해주세요.
							- [회원]아이디 : a001, 비밀번호 : a1234 
							- [회원]아이디 : b001, 비밀번호 : b1234
							- [관리자]아이디 : admin, 비밀번호 : adm1234 
							
							3. 잘못된 계정 정보를 입력 후 로그인 진행 시,
							'아이디 및 비밀번호가 일치하지 않습니다.' 라는 알림창을 띄워주세요.
							───────────────────────
						-->

						<%
							String error = request.getParameter("error");
							if(error != null){
								if("1".equals(error)){
								out.println("<div class='alert alert-danger'>");
								out.println("	아이디 및 비밀번호가 일치하지 않습니다!");
								out.println("</div>");
								}
								
								if("2".equals(error)){
									out.println("<div class='alert alert-danger'>");
									out.println("	로그인 후 사용할 수 있습니다!");
									out.println("</div>");								
									}

								if("3".equals(error)){
									out.println("<div class='alert alert-danger'>");
									out.println("	세션이 만료되었습니다 !");
									out.println("</div>");								
									}
								}
						%>

						<h3 class="ddit_chapter">로그인</h3>
						<p class="ddit_text pt-3 pb-3">
							[접속정보]────────────────────<br/>
							[회원] a001/a1234, b001/b1234<br/>
							[관리자] admin/adm1234
						</p>
						<form action="login_process.jsp" method="post" id="loginForm">
						 	<div class="mb-3 row">
								<label for="id" class="col-sm-1 col-form-label">아이디</label>
								<div class="col-sm-11">
									<input type="text" class="form-control" id="id" name="memId">
								</div>
							</div>
						 	<div class="mb-3 row">
								<label for="pw" class="col-sm-1 col-form-label">비밀번호</label>
								<div class="col-sm-11">
									<input type="text" name="memPw" class="form-control" />
								</div>
							</div>
						 	<input type="submit" value="로그인" id="loginBtn" class="ddit_btn ddit_btn_outline_primary"/><br/>
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
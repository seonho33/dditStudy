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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH04")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<h1>페이지 이동방식 테스트</h1>
						
						<%
						String err = request.getParameter("err");
						if(err != null){
						%>
							<p class="customer_text pt-2">
								<font color="red">
									이동방식을 선택								
								</font>
							</p>
						
						
						<%	
						}
						%>
						
						<form action="/ch04/form.do" method="post">
							<div>
								<label for="type" class="form-label">이동방식</label>
								<select name="type" class="form-control">
									<option value="">--선택--</option>
									<option value="forward">포워딩</option>
									<option value="redirect">리다이렉트</option>
								</select>
							</div>
							<div class="mb-3">
								<label for="memId" class="form-label">아이디</label>
								<input type="text" class="form-control" id="memId" name="id">
							</div>
							<div class="mb-3">
								<label for="memPw" class="form-label">비밀번호</label>
								<input type="text" class="form-control" id="memPw" name="pw">
							</div>
							<div class="mb-3">
								<label for="memName" class="form-label">이름</label>
								<input type="text" class="form-control" id="memName" name="name">
							</div>
							<button type="submit" class="ddit_btn ddit_btn_outline_primary">로그인</button>
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
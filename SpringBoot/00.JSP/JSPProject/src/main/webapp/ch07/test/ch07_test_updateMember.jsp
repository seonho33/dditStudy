<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.ddit.ch07.MemberDAO"%>
<%@page import="kr.or.ddit.ch07.MemberVO"%>
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
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">

						<%
						String id = request.getParameter("id");
						MemberVO mvo = new MemberVO();
						MemberDAO dao = MemberDAO.getInstance();
						ArrayList<MemberVO> memberList = dao.getMemberList();
						mvo = dao.getMember(id);
						%>
						
						<form action="" id="updateForm" method="post" enctype="multipart/form-data">
						아이디 		<input type="text" name="id" id="id" required="required"/><br/>
						비밀번호 		<input type="password" name="pw" id="pw" required="required"><br/>
						이름  		<input type="text" name="name" id="name" required="required"><br/>
						성별			<input type="radio" name="gender" value="M">남자
									<input type="radio" name="gender" value="G">여자<br/>
						프로필 이미지 	<input type="file" name="filename" multiple="multiple"><br/>
						
						<input type="button" onclick="btn_update()" value="가입하기" class="ddit_btn ddit_btn_outline_primary">
						<a href="ch07_test_memberList.jsp?id=<%=id %>"  class="ddit_btn ddit_btn_outline_info">뒤로가기</a>
						</form>
						
					</div>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">

const btn_update = () =>{
	const udf = document.querySelector("#updateForm")
	cons

	console.log(udf)
}

</script>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
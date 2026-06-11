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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH07")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<form action="fileupload06_process.jsp" method="post" enctype="multipart/form-data">
							아이디 : 
							<input type="text" name="id" style=""><br/>
							비밀번호 : 
							<input type="text" name="pw"><br/>
							성별 : 
							<input type="radio" name="gender" value="M" checked="checked">남자
							<input type="radio" name="gender" value="G">여자<br/>
							첨부파일 : 
							<input type="file" name="filename" multiple="multiple"/><br/>
							<input type="submit" value="파일올리기">
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
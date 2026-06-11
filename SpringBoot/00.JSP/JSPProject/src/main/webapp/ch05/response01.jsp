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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH05")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<form action="response01_process.jsp" method="post">
							<div class="mb-3">
								<label for="id" class="form-Label">아이디</label>
								<input type="text" class="form-control" id="id" name="id">
							</div>
							<div class="mb-3">
								<label for="pw" class="form-Label">비밀번호</label>
								<input type="text" class="form-control" id="pw" name="pw">
							</div>
							<input type="submit" class="btn btn-primary" value="전송">
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
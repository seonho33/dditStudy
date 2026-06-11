<%@page import="java.util.Date"%>
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
					<%
						//헤더 정보는 여러 KEY를 가지고 다양한 정보를 제공합니다.
						//Refresh 응답 헤더는 페이지가 완전히 로드된 후 지정된 시간이 지나면
						//웹 브라우저가 페이지를 새로 고치거나 리다이렉션 하도록 지시할 수 있습니다.
						//HTML에서 사용하는 것과 동일하게 말이죠.
						
						//Refresh <meta http-equiv="refresh" content="....">와 같이
						//meta 태그를 활용해서 설정할 수 있습니다.
						//Refresh : '<time>','<time>,url=<url>','<time>; url=<url>'
						//			의 형태로도 활용할 수 있습니다
						//ex) '5; url=https://example.comn'의 현태로 값을 설정
						//		이와같은 형태라면 setIntHeader()가 아닌 setHeader()를 활용
						response.setIntHeader("Refresh",3);
					%>
						<%= new Date() %>

					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
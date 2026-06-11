<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib uri="jakarta.tags.core" prefix="c"%>
	<%@taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH17")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<p class="customer_text">java 문자열 검색</p>
			<!-- 설정된 문자열에 검색 문자열 java가 포함되었는지 확인하도록 fn: contains 태그를 작성합니다 -->
						<p class="ddit_text">
							Hello, Java Server Page! => ${fn:contains("Hello, Java Server Page!","java") }
						</p>
						<p class="ddit_text">
							Hello, Java Server Page! => ${fn:containsIgnoreCase("Hello, Java Server Page!","java") }
						</p>
						<p class="customer_text pt-3">java문자열 시작과 끝</p>
						<p class="ddit_text">
							Hello, Java ServerPage! =>${fn:startsWith("Hello,Java Server Page!","H") }
						</p>
						<p class="ddit_text">
							Hello, Java ServerPage! =>${fn:endsWith("Hello,Java Server Page!","ge!") }
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
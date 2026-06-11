<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib uri="jakarta.tags.core" prefix="c"%>
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
						<h5 class="ddit_chapter2">browser 변수 값 설정</h5>
						
						<!-- hd 변수에 변수 값으로 header를 설정하도록 태그 작성 -->
						<c:set value="${header}" var="hd"/>
						<p class="ddit_text pt-3">
							User-Agent : <c:out value="${hd['User-Agent']}"><br></c:out>
							Host : <c:out value="${hd['Host'] }"/><br>
							Accept : <c:out value="${hd['Accept'] }"/><br>
							Accept-Language : <c:out value="${hd['Accept-Language'] }"/><br>
							Referer : <c:out value="${hd['Referer'] }"/><br>
							Connection : <c:out value="${hd['Connection'] }"/><br>
							Cache-Control : <c:out value="${hd['Cache-Control'] }"/><br>
						</p>
						
						<c:set var="userAgent" value="${header['User-Agent']}"/>
						<p class="ddit_text">
							userAgent : <c:out value="${userAgent }"/><br>
						</p>
						
						<h5 class="ddit_text2">browser 변수 값 제거 후</h5>
						<c:remove var="userAgent"/>
						<p class="ddit_text">
							userAgent : <c:out value="${userAgent }"/>
						</p>
						
						<h5 class="ddit_chapter2">cookie 값</h5>
						<p class="ddit_text">${cookie.JSESSIONID.value}</p>

					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
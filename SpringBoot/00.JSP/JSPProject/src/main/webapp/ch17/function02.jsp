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
						<p class="customer_text"># basic text</p>
						<!-- 
							substring 함수를 이용하여 해당 문자열을 특정 범위 내의 문자로 자른다.
							0123456789
							Hello, Java Server Pages!
							
							0<=x<n
						 -->
						
						<p class="ddit_text pb-3">Hello, Java Server Pages!</p>
						<c:set value="${fn:substring('Hello, Java Server Page!',0,6) }" var="subText"/>
						<p class="ddit_text"># substring result(String, 0, 6)</p>
						<c:out value="${subText}"/><br>
						<c:set value="${fn:split('Hello, Java Server Pages!',' ')}" var="texts"/>
						<p class="ddit_text pt-3"># split & length result</p>
						<c:forEach items="${texts }" var="text">
							<c:out value="${text }"/><br/>
						</c:forEach>
						<c:forEach begin="0" end="${fn:length(texts) -1 }" var="i" step="1">
							<p>texts[${i }]=${texts[i]}</p>
						</c:forEach>
						
						<p class="ddit_text"># join result</p>						
						<!-- 분리된 문자열과'-'을 연결하도록 fn:join 태그를 작성합니다. -->
						<p>
							<c:out value="${fn:join(texts,'-') }"/>
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
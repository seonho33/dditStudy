<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.ddit.index.IndexVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>
<style>
.my {
	font-weight: bold;
	color: green;
}
table td{
	text-align: center;
}
</style>

<body>
	<%@ include file="/module/header2.jsp"%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH03") %></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<!-- 
							문제 풀어보기)
							1) 리스트에 000호 반 학생 이름을 모두 넣고 Core 태그 set에 저장한 후, 전체를 출력
							2) 전체 출력을 4명씩 끊어서 출력해주세요.
								이름 이름 이름 이름
								이름 이름 이름 이름
								...
							3) 4명씩 끊어서 출력할 때, 본인의 이름은 '본인'으로 출력해주세요.
							   '본인' 글자를 출력 시, 굵은 글씨와 색깔은 녹색으로 출력해주세요.				 
						-->
						<%
							List<String> nList = new ArrayList<String>();
							nList.add("박명수");
							nList.add("유재석");
							nList.add("정형돈");
							nList.add("정준하");
							nList.add("노홍철");
							nList.add("하동훈");
							nList.add("길성준");
							nList.add("조세호");
							nList.add("양세형");
							nList.add("양세찬");
							nList.add("조현준");
							nList.add("남창희");
							nList.add("이상우");
							nList.add("우상이");
							int cnt = nList.size();
						%>
						<h5 class="ddit_chapter">CH03_test</h5>
						<p class="ddit_text pt-3"></p>
						
						<c:set value="<%=nList %>" var="list"/>
						<c:set value="<%=cnt %>" var="cnt"/>
						
						<p class="customer_text">전체 출력 ----------</p>
						<c:out value="<%=nList %>"/>
						
						<p class="ddit_text pt-3"></p>
						
						<p class="customer_text">4명씩 끊어서 출력 ----------</p>
						<table class="table table-bordered">
							<tr>
							<c:forEach items="${list }" var="name" varStatus="vs">
							  	<!-- 방법 1 -->
	<%-- 						  	<c:set value="<span>${name }</span>" var="nm"/> --%>
	<%-- 						  	<c:if test="${name == '조현준' }"> --%>
	<%-- 						  		<c:set value="<span id=my><b>본　인</b></span>" var="nm"/> --%>
	<%-- 						  	</c:if> --%>
	<%-- 						  	<c:out escapeXml="false" value="${nm }"/> --%>
								
								<!-- 방법 2 -->
								<c:if test="${name == '조현준' }">
							  		<td class="my">본　인</td>
							  	</c:if>
								<c:if test="${name != '조현준' }">
									<td>${name }</td>
								</c:if>
	
								<!-- 
									현재 count가 4로 나눴을 때 나머지가 0인 경우는 4명의 이름을 출력했을 때니까 tr 태그를 닫는다.
									이때, count가 cnt(list 총 count)로 나눴을 때 나머지가 0보다 크다면 마지막 index가 아니므로 다시 tr을 열고 준비한다.  
								-->
								<c:if test="${vs.count % 4 == 0 }">
									</tr>
									<c:if test="${vs.count % cnt > 0 }">
										<tr>
									</c:if>
								</c:if>
								<!-- 
									마지막 줄의 td를 찍을 때 나머지 공간을 비어 있는 td로 채울 때 해당 조건을 이용한다.
								 -->
								<c:if test="${vs.count % cnt == 0 }">
									<c:forEach begin="1" end="${4 - cnt % 4 }">
										<td></td>
									</c:forEach>
								</c:if>
							</c:forEach>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
<script type="text/javascript">
$(function(){
	var flag = true;	
	setInterval(() => {
		if(flag){
			$(".my").css("transform", "scale(1.2)");
			flag = false;
		}else{
			$(".my").css("transform", "scale(1)");
			flag = true;
		}
		console.log("실행됨?");
	}, 500);
});
</script>
</html>
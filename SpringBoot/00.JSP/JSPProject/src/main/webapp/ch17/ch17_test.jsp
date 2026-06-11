<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
						<!-- 
							1) 304호 학생 이름 모두를 저장하고, 전체 학생의 이름들을 출력해주세요.
							2) 학생의 각 성씨별 카운트를 출력해주세요.
							
							'김'씨 00명
							'홍'씨 00명
							'박'씨 00명 ...
							김보라,한소희,노태호,도선호,김아영,김지현,임채은,최민영,손우승,박진아,이윤진,이용로,오수아,임경호
							김씨, 노씨, 도씨, 박씨, 손씨, 이씨, 오씨, 임씨, 최씨, 한씨
							3) JSTL을 활용해서 출력해주세요
						 -->
						 <p class="ddit_text pb-3" style="color: green">첫번째 방법 - JSTL 과 카운팅 변수를 선언한 방법</p>
						<c:set value="${fn:split(('김보라,한소희,노태호,도선호,김아영,김지현,임채은,최민영,손우승,박진아,이윤진,이용로,오수아,임경호'),',')}" var="texts"/>
						<c:set value="0" var="kimCount"/>
						<c:set value="0" var="RoCount"/>
						<c:set value="0" var="DoCount"/>
						<c:set value="0" var="pakCount"/>
						<c:set value="0" var="sonCount"/>
						<c:set value="0" var="leeCount"/>
						<c:set value="0" var="ohCount"/>
						<c:set value="0" var="lemCount"/>
						<c:set value="0" var="chaCount"/>
						<c:set value="0" var="hanCount"/>
						<c:forEach items="${texts}" var="text" varStatus="vs">
							<c:choose>
								<c:when test="${fn:startsWith(text,'김')}">
									<c:set value="${kimCount+1}" var="kimCount"/>
								</c:when>
								<c:when test="${fn:startsWith(text,'노')}">
									<c:set value="${RoCount+1}" var="RoCount"/>
								</c:when>
								<c:when test="${fn:startsWith(text,'도')}">
									<c:set value="${DoCount+1}" var="DoCount"/>
								</c:when>
								<c:when test="${fn:startsWith(text,'박')}">
									<c:set value="${pakCount+1}" var="pakCount"/>
								</c:when>
								<c:when test="${fn:startsWith(text,'손')}">
									<c:set value="${sonCount+1}" var="sonCount"/>
								</c:when>
								<c:when test="${fn:startsWith(text,'오')}">
									<c:set value="${ohCount+1}" var="ohCount"/>
								</c:when>
								<c:when test="${fn:startsWith(text,'이')}">
									<c:set value="${leeCount+1}" var="leeCount"/>
								</c:when>
								<c:when test="${fn:startsWith(text,'임')}">
									<c:set value="${lemCount+1}" var="lemCount"/>
								</c:when>
								<c:when test="${fn:startsWith(text,'최')}">
									<c:set value="${chaCount+1}" var="chaCount"/>
								</c:when>
								<c:when test="${fn:startsWith(text,'한')}">
									<c:set value="${hanCount+1}" var="hanCount"/>
								</c:when>
							</c:choose>
							
							<table class="table table-bordered">
								<tr>
									<th>김</th>
									<th>노</th>
									<th>도</th>
									<th>박</th>
									<th>손</th>
									<th>오</th>
									<th>이</th>
									<th>임</th>
									<th>최</th>
									<th>한</th>
								</tr>
								<tr>
									<td>${kimCount}</td>
									<td>${RoCount}</td>
									<td>${DoCount}</td>
									<td>${pakCount}</td>
									<td>${sonCount}</td>
									<td>${ohCount}</td>
									<td>${leeCount}</td>
									<td>${lemCount}</td>
									<td>${chaCount}</td>
									<td>${hanCount}</td>
								</tr>
							</table>
							<br>
						</c:forEach>
						
						<p class="ddit_text pb-3"> 두번째 방법 - 컬렉션 map과 JSTL을 활용한 방법</p>
						
						<% 
							String[] arrList = {
									"김보라",
									"한소희",
									"노태호",
									"도선호",
									"김아영",
									"김지현",
									"임채은",
									"최민영",
									"손우승",
									"박진아",
									"이윤진",
									"이용로",
									"오수아",
									"임경호"
							};
							Map<String, Object> nameMap = new HashMap<>();
						%>
						<c:set value="<%=arrList %>" var="nameList"/>
						<c:set value="<%=nameMap %>" var="nameMap"/>
						<c:forEach items="${nameList}" var="nm">
							<c:choose>
								<c:when test="${!nameMap.containsKey(fn:substring(nm,0,1))}">
									<c:set value="${nameMap.put(fn:substring(nm,0,1),1) }" var="${name }"/>
								</c:when>
								<c:when test="${nameMap.containsKey(fn:substring(nm,0,1))}">
									<c:set value="${nameMap.put(fn:substring(nm,0,1),nameMap.get(fn:substring(nm,0,1)+1))}"/>
								</c:when>
							</c:choose>
						</c:forEach>
						<c:forEach items="${nameMap}" var="nm" varStatus="vs">
							${nm.key} 성을 가진 사람 : ${nm.value} 명
						</c:forEach>
								
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH03")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<h5 class="ddit_chapter">1. JSTL 반복문(일반적인 for문)</h5>
						<p class="ddit_text">변수 k가 1부터 10까지 1씩 증가하도록 JSTL의 Core태그 반복문 작성</p>
						<!--
							반복문을 작성하기 위해서는 c:forEach 태그를 활용할 수 있습니다.
							반복의 형태는 일반적인 for문과 향상된 for문이 있는데 해당 문제는 일반적인
							for문의 형태를 활용합니다.
							
							var: 변수 설정
							begin: 시작 값
							end: 끝 값
							step: 증감 값
						  -->
						
						<c:forEach var="k" begin="1" end="10" step="1">
							<!-- 
								# JSTL 에서 값을 출력하거나 선언된 값을 사용할 때 EL(Expression Language)
								- JSTL을 개발한 개발자들의 의도는 기존에 사용하고 있었던 스크립틀릿 자체에 불편함을 누구보다
								  느끼고 있었습니다. 코드의 가독성이 떨어지고, HTML과 Java 코드의 혼합으로 인해 코드를 확인할 때
								  피로도가 가중되고 있었죠.
								  그래서 코드를 좀 더 깔끔하고 가독성 및 간결함을 유지할 수 있게 EL을 사용할 수 있도록 하였습니다.
								- EL 표현식을 활용하면 HTML 코드 사이에 Java 로직이 섞여 코드를 작성하더라도 읽기 쉽고
								  직관적입니다. 긜고 스크립틀릿을 활용하여 코드를 작성 시, Null Safety 측면에서의 방지가
								  많아야했습니다. 일일이 코드에 if와 같은 조건 형태를 체크해야 했죠.
								  하지만 EL은 NullPointerException 과 같은 에러가 구문상에 발생하더라도 null 에러가 발생하지 않고
								  빈 문자열을 그대로 출력합니다.
								- EL은 var 속성에 명시한 변수를 그대로 출력하기도 하고, 내장 객체, Java Bean으로 등록된 객체에서의
								  getter 메서드를 자동으로 호출하여 출력해줍니다. (member.getName()>member.name) 
							 -->
							<c:out value="${k}"/> <!-- 출력은 c:out 태그를 활용 -->
						</c:forEach>
						<div>
							<h5 class="ddit_chapter">2. 스크립틀릿과 표현문을 활용한 출력</h5>
							<p class="ddit_text">스크립틀릿 영역 내, str 변수 선언 및 초기화 후 출력</p>
							<% 
								//스크립틀릿 영역에서는 자바 코드를 작성할 수 있습니다.
								//문자열 타입의 str 변수를 선언하고 임의의 문자열로 초기화합니다.
								String str = "스크립틀릿으로 선언한 개똥이";
							%>
						
							<%= str %>						
						</div>
						<div>
							<h5 class="ddit_chapter">3. JSTL 저장 및 출력문</h5>
							<p class="ddit_text">JSTL을 활용해 str 변수에 문자열을 저장 후 출력</p>
							<!-- 
								값을 저장하는 행위는 곧 '변수 선언 및 초기화'와 같습니다.
								c:set 태그는 지정한 변수에 값을 저장할 때 사용합니다.
								var: 변수명
								value: 초기화 할 값
							 -->
							
							<c:set var="str" value="Core태그로 선언한 개똥이"></c:set>
							<c:out value="${str}"></c:out>
						</div>
							
							<h5 class="ddit_chapter">4. 스크립틀릿과 표현문을 활용한 출력</h5>
							<p class="ddit_text">스크립틀릿 영역 내, list 변수 선언 및 초기화 후 출력</p>
							<%
								List<String> list = new ArrayList<>();
								list.add("개똥이");
								list.add("김철수");
								list.add("메뚜기");
								
								request.setAttribute("list", list);
							%>
							<%= list %>
						<div>
							<h5 class="ddit_chapter">
								5. JSTL을 활용해 list 변수에 리스트 저장 후, 출력(향상된 for문)
							</h5>						
							<p class="ddit_text">
								스크립틀릿 영역 내 선언한 list 데이터를 JSTL 반복문을 활용해 출력
							</p>
							<table class="table table-bordered">
								<tr>
									<td>index</td>
									<td>count</td>
									<td>value</td>
									<td>current</td>
									<td>first 여부</td>
									<td>last 여부</td>
								</tr>
								<!-- 
									Collection List에 담긴 총 3개의 문자열을 향상된 for문 형태로 작성
									c:forEach 태그를 이용하여 향상된 for문 형태를 구성할 수 있다.
									var : 변수명
									items : 반복 가능한(Iterable) 객체
									 - Collection, Iterator, Enumeration, Array 등
									 varStatus : 반복의 상태 정보(순서, 횟수, 시작, 마지막 등)
									 - index : 0부터 시작하는 인덱스
									 - count : 1부터 시작하는 횟수
									 - first : 현재 반복이 첫번째인지 여부
									 - last : 현재 반복이 마지막인지 여부
									 - current : 현재 반복에서 처리중인 항목
								 -->
								<c:forEach items="${list}" var="item" varStatus="vs">
									<tr>
										<td>${vs.index }</td>
										<td>${vs.count }</td>
										<td>${item}</td>
										<td>${vs.current }</td>
										<td>${vs.first }</td>
										<td>${vs.last }</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						<div>
							<h5 class="ddit_chapter">6. JSTL 조건문(if-else)</h5>
							<p class="ddit_text">
								변수 k가 1부터 10까지 1씩 증가하도록 JSTL 반복문(짝수)
							</p>
							<c:forEach var="k" begin="1" end="10" step="1">
								<!-- 1부터 10 사이의 값 중, 짝수만 출력 -->
								<c:if test="${k % 2 == 0}">
									<c:out value="${k }"></c:out>
								</c:if>
							</c:forEach>
						</div>
						<div>
							<h5 class="ddit_chapter">7. JSTL 조건문(if-else if-else)</h5>
							<p class="ddit_text">현재 가지고있는 money 금액에 따른 조건부 출력</p>
							<!-- 
								홍길동은 현금 5,000원을 가지고있다.
								현금이 0원 이하면 '무일푼'을 출력하고 5,000원 이상 10,000원 미만인 경우
								'커피 한잔의 여유 가능!'을 출력하고, 그 외에 조건이라면 '밥 먹자!'를 출력
							 -->
							<c:set var="money" value="5000"></c:set>
							홍길동이 가지고 있는 현재 금액 : ${money }
							<br>
							<div style="border: 1px solid black; display:inline-block;">
							<c:choose>
								<c:when test="${money<=0 }">
									무일푼
								</c:when>
								<c:when test="${money>=5000 && money<10000 }">
									커피 한잔의 여유 가능!
								</c:when>
								<c:otherwise>
									밥 먹자!
								</c:otherwise>
							</c:choose>	
							</div>
							
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
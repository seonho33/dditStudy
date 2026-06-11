<%@page import="java.util.HashSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c" %>
	
<!DOCTYPE html>
<html lang="en">

<head>
<%@include file="/module/headPart.jsp"%>
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
						
						<!-- 
							문제 풀어보기
							1) 리스트에 304호 반 학생 이름을 모두 넣고 Core 태그 set에 저장한 후,
							   전체를 출력해 주세요.
							2) 전체 출력을 4명씩 끊어서 출력해 주세요.
									이름 이름 이름 이름
									이름 이름 이름 이름
									이름 이름 이름 이름
									이름 이름 이름 이름
							3) 4명씩 끊어서 출력할 때, 본인의 이름은 '본인' 으로 출력해 주세요.
							- '본인' 글자를 출력 시, 굵은 글씨와 글자 색은 녹색으로 출력해 주세요.
									이름 이름 이름 이름
									이름 이름 이름 이름
									이름 본인 이름 이름
									이름 이름 이름 이름
						 -->
						<%
							Set<String> setList = new HashSet<>();
							setList.add("노태호");
							setList.add("김보라");
							setList.add("한소희");
							setList.add("임채은");
							setList.add("김아영");
							setList.add("도선호");
							setList.add("최민영");
							setList.add("이용로");
							setList.add("이윤진");
							setList.add("박진아");
							setList.add("손우승");
							setList.add("임경호");
							setList.add("오수아");
							setList.add("김지현");
							
							int cnt = setList.size();
							
							request.setAttribute("setList", setList);
							request.setAttribute("cnt", cnt);
						%>
						
						<h5 class="ddit_chapter">전체 출력----</h5>
						<c:out value="setList"></c:out>
						
						<table class="table table-bordered">
							<tr>
								<c:forEach items="${setList}" var="name" varStatus="vs">
									<c:if test="${name=='도선호'}">
										<td class="my" style="color:green; font-weight: 700">본 인</td>
									</c:if>									 
									<c:if test="${name!='도선호'}">
										<td>${name}</td>
									</c:if>
									<!-- 
										4명씩 끊었을 때 tr과 tr/ 을 어떤 정책을 가지고 핸들링 할지
										
										현재 count 가 4로 나눴을 때 나머지가 0인 경우는 4명의 이름을 출력했을 때니까
										tr 태그를 닫는다.
										이때, count가 cnt(list 총 count)로 나눴을 때 나머지가 0보다
										크다면 마지막 index가 아니므로 다시 tr을 열고 준비한다.
									 -->
									
									<c:if test="${vs.count%4==0}">
										</tr>
										<c:if test="${vs.count%cnt>0 }">
											<tr>
										</c:if>
									</c:if>
									<!-- 
										마지막 줄의 td를 찍었을 때 나머지 공간을 비어있는 td로 채울 때
										해당 조건을 이용한다.
									 -->
									 <c:if test="${vs.count%cnt==0 }">
									 	<c:forEach begin="1" end="${4-cnt%4}">
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
</html>
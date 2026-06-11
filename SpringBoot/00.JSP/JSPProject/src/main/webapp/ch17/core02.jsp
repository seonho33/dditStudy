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
						<h5 class="ddit_chapter2">JSTL 마법의 숫자 예측기</h5>
						
					<!-- 
						전설의 대 마법사인 엘리니아의 수장인 태호 대마법사가 살고있습니다.
						태호마법사는 1~100 사이의 숫자를 이용해 마법을 부릴수 있는데요.
						입력한 숫자가 3과 4의 공배수일때는 '완벽한 균형'의 수 마법이 동작합니다.
						입력한 숫자가 5의 배수이지만 10의 배수가 아닐 때는 '황금빛 마력'의 수 마법이 동작합니다.
						입력한 숫자가 50을 넘었을 때는 '최대치'의 힘을 발휘합니다!
					 -->
					 
					 	<form action="" method="get">
							<label for="magicNumber">1~100 사이의 숫자를 입력하세요!</label>					 	
							<input type="number" id="magicNumber" name="num"
								min="1" max="100" required="required">
							<input type="submit" value="마법 분석하기">
					 	</form>
						
						<c:if test="${param.num != null and param.num !='' }">
							<div class="result">
								<h2> 입력된 숫자 : ${param.num }</h2>
								<p class="ddit_text">⊙마법의 속성 분석 ::::::::::::</p>
								<ul>
									<li>
										<!-- 속성1: '완벽한 균형'(3과 4의 공배수) -->
										<c:choose>
											<c:when test="${param.num%3 ==0 and param.num%4 ==0 }">
												<span class="ddit_text">🪄'완벽한 균형'의 수!(3과 4의 공배수)</span>
											</c:when>
											<c:otherwise>
												<span class="ddit_text">🪄'불완전한' 진동!</span>
											</c:otherwise>
										</c:choose>
									</li>
									<li>
										<c:choose>
											<c:when test="${param.num%5==0 and param.num%10!=0 }">
												<span class="ddit_text">'황금빛 마력'을 가진 수!(5의배수, 10의 배수는 아님!)</span>
											</c:when>
											<c:otherwise>
												<span class="ddit_text">🪄'평범한' 에너지!</span>
											</c:otherwise>
										</c:choose>
									</li>
									<li>
										<c:choose>
											<c:when test="${param.num>50 }">
												<span class="ddit_text">🪄'최대치'의 힘을 발휘!(50보다 큰 수!)</span>
											</c:when>
											<c:otherwise>
												<span class="ddit_text">🪄'힘'을 아끼고 있는 수...</span>
											</c:otherwise>
										</c:choose>
									</li>
								</ul>
							</div>
						</c:if>
						
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
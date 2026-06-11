<%@page import="java.net.URI"%>
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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH05") %></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<!-- 
							문제를 풀어봅시다.
							
							1. ch05_test.jsp에서 전송받은 모든 데이터를 taglib를 이용하여 출력해주세요.
							
							[출력 예시]
							아이디 : a001
							비밀번호 : 1234
							이름 : 홍길동
							성별 : 남자
							핸드폰번호 : 010-1234-1234
							주소 : 대전시 중구 오류동 123
							
							2. 출력을 완료했으면, 5초뒤에 www.naver.com 홈페이지로 이동시켜주세요.
							-1) 헤더를 이용한 방법
							-2) 스크립트를 이용한 방법
							
							두가지 방법 모두 또는 두개중에 한개를 선택해서 구현해주세요.
						 -->
						 <h1>CH05 TEST RESULT</h1>
						<h5>RESULT</h5>						 
						<table class="table table-bordered">
							<tr>
								<td>아이디</td>
								<td><c:out value="${param.id}"/></td>
							</tr>
							<tr>
								<td>비밀번호</td>
								<td><c:out value="${param.pw}"/></td>
							</tr>
							<tr>
								<td>이름</td>
								<td><c:out value="${param.name}"/></td>
							</tr>
							<tr>
								<td>성별</td>
								<td><c:out value="${param.Gender eq 'M' ? '남자' : '여자'}"/></td>
							</tr>
							<tr>
								<td>핸드폰</td>
								<td><c:out value="${param.ph}"/></td>
							</tr>
							<tr>
								<td>주소</td>
								<td><c:out value="${param.addr}"/></td>
							</tr>
						</table>
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

						
/*						
						//Header 방식
						response.setHeader("Refresh","5; url=https://naver.com");
 */						
					%>
				<script>
				     /* setTimeout 방식 */
					setTimeout(() => {
						location.href="https://www.naver.com";
					}, 5000);
				</script>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
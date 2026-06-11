<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH01") %></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<%
					// 페이지 이동방식 선택 타입에 따라서 scope에 담겨 오는 방법이 다르므로, 두가지 방식으로 꺼낸다.
					String pstatus = (String) request.getParameter("status");
					String astatus = (String) request.getAttribute("status");
					if(pstatus != null){
						%>
						<c:set value="<%=pstatus %>" var="stat"/>
						<%
					}
					if(astatus != null){
						%>
						<c:set value="<%=astatus %>" var="stat"/>
						<%
					}
				%>
				<div class="row">
					<!-- 
						문제 풀어보기)
						1. 서버로 값을 전송하기 위해 타입 선택 영역과 횟수 입력란을 작성해주세요.
							- 타입은 select 태그 활용
								> 총 3가지의 값을 option으로 설정
								> 'type 선택'의 값은 ""
								> '포워딩'의 값은 "forward"
								> '리다이렉트'의 값은 "redirect"
							- 횟수 입력란은 input text 활용
						2. 서버로 전송하기 위한 url은 '/send.do'로 설정해주세요.
						3. 서버는 서블릿을 만들어 사용해주세요.
						4. 타입을 아무것도 선택하지 않고 서버로 전송 시, 다시 send.jsp 페이지로 이동 후 '타입을 선택해주세요.' 메세지를 출력해주세요.
							> 참고 이미지 002.jpg 참고
						
						# 포워딩 선택 시
						5. 타입 포워딩을 선택 후, 횟수 4를 초과하는 경우 '횟수는 4번을 초과할 수 없습니다.' 메세지를 출력해주세요.
							> 참고 이미지 > 포워딩 선택 시 > 003.jpg 참고
						6. 타입 포워딩을 선택 후, 횟수 3를 입력 후 전송 시, 결과 페이지(result.jsp)로 포워딩을 진행해주세요.
						   결과 페이지(result.jsp)로 포워딩 되어 이동 후, 키보드 'F5'를 눌러 새로고침 되었을 때 방금 요청했던 요청이 재요청되면서
						   횟수가 증가함에 따라 이미지를 완성시켜주세요.
						7. 새로고침 횟수가 횟수에 입력한 숫자 3번을 넘는 경우, 입력횟수, 현재횟수, '현재 상태 : 횟수 사용 완료! 이미지 완성!'을 출력해주세요.
						8. 횟수 4초과되지 않는 범위 안에서 새로고침 할 때마다 입력한 횟수 만큼의 이미지를 완성시켜주세요.
						
						# 리다이렉트 선택 시
						9. 타입 리다이렉트 선택 후, 횟수 4 초과되지 않는 범위 안에서 요청 시, 입력한 횟수 만큼의 완성된 이미지를 만들어주고, 
						   입력횟수, '현재 상태 : 횟수 사용 완료! 이미지 완성!'을 출력해주세요.
							> 참고 이미지 > 리다이렉트 선택 시 > 012.jpg 참고
					 -->
				
					<c:if test="${stat eq 'emp' }">
						<div class="alert alert-danger" role="alert">
						  타입을 선택해주세요!
						</div>
					</c:if>
					<c:if test="${stat eq 'over' }">
						<div class="alert alert-danger" role="alert">
						  횟수는 4번을 초과할 수 없습니다!
						</div>
					</c:if>
				
					<div class="col-md-12">
						<form action="/send.do" method="post">
							<div class="mb-3">
								<label for="id" class="form-label">타입</label>
								<select class="form-control" name="type">
									<option value="">type 선택</option>
									<option value="forward">포워딩</option>
									<option value="redirect">리다이렉트</option>
								</select>
							</div>
							<div class="mb-3">
								<label for="pw" class="form-label">Max 횟수</label>
								<input type="text" class="form-control" id="number" name="number">
							</div>
							<input class="btn btn-primary" type="submit" value="전송"/>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
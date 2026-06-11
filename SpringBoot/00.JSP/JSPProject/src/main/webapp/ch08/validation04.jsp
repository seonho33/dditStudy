<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH08")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<h5 class="ddit+chapter2">유효성 검사를 위한 스크립트 이벤트</h5>
						


						<p class="ddit_text pt-3 pb-1">테스트 시, 입력 데이터를 입력 후 테스트</p>
						<form action="validation04_process.jsp" name="member" method="post">
							아이디 : <input type="text" name="id"/><br/>
							비밀번호 : <input type="text" name="pw"/><br/>
							이름 : <input type="text" name="name"/><br/>
							연락처 : <select name="phone1">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="019">019</option>
									</select> -
									<input type="text" name="phone2" maxlength="4" size="4"/>-
									<input type="text" name="phone3" maxlength="4" size="4"> 
							이메일 : <input type="text" name="email"/><br/>
							<input type="button" value="전송" onclick="CheckMember()"/>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>

<script>


//자바 스크립트 onsubmit 이벤트
function CheckMember(){
	// 정규 표현식 사용하기
	// - 정규 표현식은 특정한 규칙을 가진 문자열의 집합을 표현하는데 사용하는 형식으로
	// 문자열의 특정 형태를 찾아내기 위해 패턴으로 표현한 수식이다.
	
	// i : 문자열의 대문자와 소문자를 구별하지 않고 검출
	// g : 문자열 내의 모든 패턴을 검출
	// m : 문자열에 줄 바꿈 행이 있는지 검출

	// 아이디는 영문 대문자와 소문자, 한글, 한글의 자음과 모음만 검사하도록 정규 표현식 작성
	let regExpId = /^[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$/;
	
	// 비밀번호는 숫자만 검사하도록 정규 표현식을 작성
	let regExpPw = /^[0-9]*$/;
	
	// 이름은 한글만 검사하도록 정규 표현식 작성
	let regExpName = /^[가-힣]*$/;
	
	// 전화번호는 전화번호 형태(숫자)인지 검사하도록 정규 표현식 작성
	let regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/;
	
	// 이메일은 이메일 형식인지 검사하도록 정규 표현식 작성
	// 처음 시작이 숫자, 영소대문자이고 특수문자 '-_/.' 이 나올수도 있고 그 다음에 숫자, 영소대문자
	// 가 나오는데 특수문자와 숫자, 영소대문자의 형태 그룹이 0개이상 나온다.
	// '@' 를 기준으로 앞 입력 형식과 같으면서 0번이상 반복될 수 있음.
	// 마지막 텍스트에는 \. 특수문자 .을 표현하기 위해 이스케이프로 .이 반드시 나와야하고 영소대문자 2~3 자리가
	// 끝에 나온다.
	let regExpEmail = 
	/^[0-9a-zA-Z]([-_/.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_/.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
	let form = document.member;
	let id = form.id.value;
	let pw = form.pw.value;
	let name = form.name.value;
	let phone = form.phone1.value + "-" + form.phone2.value + "-" + form.phone3.value;
	let email = form.email.value;
	
	if(!regExpId.test(id)){
		alert("아이디는 영문 대문자와 소문자, 한글, 한글의 자음과 모음으로 작성해주세요!");
		form.id.select();
		return false;
	}
	if(!regExpPw.test(pw)){
		alert("비밀번호는 숫자만 입력해주세요!");
		form.pw.select();
		return false;
	}
	if(!regExpName.test(name)){
		alert("이름흔 한글만 입력해주세요!");
		form.name.select();
		return false;
	}
	if(!regExpPhone.test(phone)){
		alert("핸드폰 번호 형식에 맞춰 입력해주세요!")
		return false;
	}
	if(!regExpEmail.test(email)){
		alert("이메일 형식에 맞춰 입력해주세요!")
		return false;
	}
	form.submit();
}

</script>

</html>
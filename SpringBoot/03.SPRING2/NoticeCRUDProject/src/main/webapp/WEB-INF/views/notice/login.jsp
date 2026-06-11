<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./lModule/headerPart.jsp" %>
<body class="hold-transition ${bodyText }">
	<div class="login-box">
		<div class="card">
			<div class="card-body login-card-body">
				<h2 class="login-box-msg"><b>DDIT</b> BOARD</h2>
	
				<form action="/notice/loginCheck.do" method="post" id="signForm" >
					<div class="input-group mb-3">
						<input type="text" class="form-control login" name="memId" id="memId" placeholder="아이디를 입력해주세요">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-user"></span>
							</div>
						</div>
						<span class="error invalid-feedback" style="display:block;">${errors.memId }</span>
					</div>
					<div class="input-group mb-3">
						<input type="password" class="form-control login" name="memPw" id="memPw" placeholder="비밀번호를 입력해주세요">
						<div class="input-group-append">
							<div class="input-group-text">
								<span class="fas fa-lock"></span>
							</div>
						</div>
						<span class="error invalid-feedback" style="display:block;">${errors.memPw }</span>
					</div>
					<div class="row">
						<div class="col-8">
							<div class="icheck-primary">
								<input type="checkbox" id="remember"> 
								<label for="remember"> Remember Me </label>
							</div>
						</div>
						<div class="col-4">
							<button type="button" class="btn btn-dark btn-block" id="signinBtn">로그인</button>
						</div>
						<div class="col-12 text-center">
							<span class="error invalid-feedback mt-3 mb-3" style="display:block;">${message }</span>
						</div>
					</div>
				</form>
				<p class="mb-1">
					<a href="/notice/forget.do">아이디 & 비밀번호 찾기</a>
				</p>
				<p class="mb-0">
					<a href="/notice/signup.do" class="text-center">회원가입</a>
				</p>
			</div>
		</div>
	</div>

	<%@ include file="./lModule/footerPart.jsp" %>
</body>
<script type="text/javascript">
$(function(){
	let body = $("body");
	let signinBtn = $("#signinBtn");	//로그인 버튼
	let signForm = $("#signForm");
	let error = $(".error");
	let login = $(".login");
	
	// # 현상에 의한 조치
	// 템플릿 CSS와 SweetAlert의 Css가 충돌이 나므로, 아래 이벤트로 조치
	let classs = body.attr("class");
	
	if(classs.match("swal2-height-auto")){
		body.removeClass("swal2-height-auto")
	}
	
	//  로그인 버튼 클릭 이벤트
	signinBtn.on("click",function(){
		let memIdVal = $("#memId").val();
		let memPwVal = $("#memPw").val();
		
		if(isBlank(memIdVal)){
			error.eq(0).html("아이디를 입력해 주세요!");
			return false;
		}
		
		if(isBlank(memPwVal)){
			error.eq(1).html("비밀번호를를 입력해 주세요!");
			return false;
		}
		
		signForm.submit();
		
	});
	
	//아이디, 비밀번호 입력란에 키보드 이벤트 핸들링
	login.on("keydown click",function(eve){
		error.html("");
		
		// CapsLock 핸들링
		// 자바 스크립트에서는 getModifierState 메서드를 통해서만 가능하지만, 제이쿼리는 객체에 형식화에 의해서
		// originalEvent 안에 들어있는 getModifierState를 통해서 진행해야합니다.
		if(eve.originalEvent.getModifierState('CapsLock')){
			error.eq(2).html("CapsLock이 켜져있습니다.");
		}
		
		// Enter를 눌렀을 때
		if(event.keyCode == 13){
			signForm.submit();
		}
	});
});

function isBlank(name){
	return (name==null||name.trim()=="");
}

function isNotBlank(name){
	return !(name==null||name.trim()=="");
}


</script>

</html>

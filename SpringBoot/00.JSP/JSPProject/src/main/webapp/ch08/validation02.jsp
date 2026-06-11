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
						


						<p class="ddit_text pt-3 pb-1">자바스크립트 Version</p>
						<form action="validation_process.jsp" name="loginForm" method="post">
							아이디 : <input type="text" name="id" /><br/>
							비밀번호 : <input type="text" name="pw" /><br/>
							<input type="button" value="전송" onclick="CheckLogin()"/>
						</form>

						<p class="ddit_text pt-3 pb-1">jQuey Version</p>
						<form action="validation_process.jsp" id="loginForm2" method="post">
							아이디 : <input type="text" name="id2" id="id2"/><br/>
							비밀번호 : <input type="text" name="pw2" id="pw2" /><br/>
							<input type="button" id="loginBtn" value="전송"/>
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
function CheckLogin(){

	let form = document.loginForm;	// loginForm Element
	
	//입력한 아이디 값의 길이를 이용해 특정 범위내에서만 입력 할 수 있도록 제한
	if(form.id.value.length < 4 || form.id.value.length > 12){
		alert("아이디는 4~12자 이내로 입력 가능합니다!");
		form.id.select();	//id칸으로 focus 이동
		return false;
	}
	
	// 입력한 비밀번호 값의 길이를 이용해 특정 범위 내에서만 입력 할 수 있도록 제한	
	if(form.pw.value.length<4){
		alert("비밀번호는 4자 이상 입력해야 합니다!");
		form.pw.focus();
		return false;
	}
	
	// 폼 태그를 활용한 서버 전송(서브밋)
	form.submit();

}


/* 제이쿼리 ready function은 document가 전부 읽히고 나서 이후에 실행될 영역이다.  */
$(function(){
	let loginBtn = $("#loginBtn");	// 로그인 버튼 Element
	let loginForm2 = $("#loginForm2");
	
	loginBtn.on("click",function(){
		let id2 = $("#id2").val();
		let pw2 = $("#pw2").val();
		
		if(id2.length < 4 || id2.length > 12){
			alert("아이디는 4~12자 이내로 입력 가능합니다!");
			$("#id2").focus();
			return false;
		}
		
		if(pw2.length<4){
			alert("비밀번호는 4자리 이상으로 입력 가능합니다!");
			$("#pw2").select();		//focus()와 select()는 기능은 비슷하지만 select()로 하면 선택된상태로 이동되고
									//focus()는 텍스트의 마지막부분에 커서가 이동한당
			return false;
		}
		
		loginForm2.submit();
	})
	
});

</script>

</html>
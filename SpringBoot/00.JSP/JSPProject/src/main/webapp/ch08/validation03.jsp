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
	
	let id = form.id.value;
	let pw = form.pw.value;
	
	if(id==null||id==""){
		alert("아이디를 입력해주세요!");
		form.id.focus();
		return false;
	}
	
	//내가 입력한 아이디를 'a0001' -> a,0,0,0,1
	for(let i=0; i<id.length; i++){
		
		//입력한 아이디를 하나하나씩 끊어줌
		let ch = id.charAt(i);
		
		//숫자 0=52 숫자 9=61 A=65 Z=90 a=97 z=122
		//97~122 사이의 범위에서만 가능함
		//if조건은 모든 조건이 참
		if(!(ch>='a' && ch <='z')){
			alert("아이디는 영문 소문자로만 입력 가능합니다!");
			form.id.select();
			return false;
		}
	}

	if(pw==null||pw==""){
		alert("비밀번호를 입력해주세요!");
		form.pw.select();
		return false;
	}else{
		//숫자가 아닌값 입력시 true
		if(isNaN(pw)){
			alert("비밀번호는 숫자로만 입력 가능합니다!");
			form.pw.select();
			return false;
		}
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
		
		if(id2 == null||id2==""){
			alert("아이디를 입력해주세요!");
			$("#id2").select();
			return false;
		}else{
			for(let i=0; i<id2.length; i++){
				let ch=id2.charAt(i);
				
				if(!(ch>='a'&&ch<='z')){
					alert("아이디는 영문 소문자로만 입력 가능합니다!");
					$("#id2").focus();
					return false;
				}
			}
		}
		
		if(pw2 ==null||pw2==""){
			alert("비밀번호를 입력해주세요!");
			$("#pw2").select();
			return false;
		}else{
			if(isNaN(pw2)){
				alert("비밀번호는 숫자로만 입력 가능합니다!");
				$("#pw2").select();
				return false;
			}
		}
		loginForm2.submit();
	});
});

</script>

</html>
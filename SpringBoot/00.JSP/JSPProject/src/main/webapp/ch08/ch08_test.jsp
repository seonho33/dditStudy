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
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH08") %></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<h5 class="ddit_chapter2">유효성 검사를 위한 스크립트 이벤트</h5>
						
						<!-- 
							문제 풀어보기
							- 각 항목별 입력 데이터가 정규 표현식과 일치하는지 여부에 따라 메세지를 표시해주세요.
							- 테스트에 통과 시, id가 'success'로 설정된 출력란에 '통과하셨습니다'라고 출력해주세요. 
							
							정규식 테스트 URL : https://regexr.com
						-->
						<p class="ddit_text pt-3">ch08_test</p>
						<form action="ch08_test_process.jsp" method="post" id="frm">
							<div class="mb-3 row">
								<label for="quest1" class="col-sm-12 col-form-label">
									문제1) 숫자만 입력하되, 7-12자리까지만 입력 받을 수 있게 설정해주세요.
								</label>
								<div class="col-sm-12">
									<input type="text" class="form-control" id="quest1" name="quest1"/>
									<p class="ddit_text" id="err_quest1"></p>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="quest2" class="col-sm-12 col-form-label">
									문제2) 시작은 영소문자 'abc'이고 영소대문자 8-12자리까지만 입력 받을 수 있게 설정해주세요.
								</label>
								<div class="col-sm-12">
									<input type="text" class="form-control" id="quest2" name="quest2"/>
									<p class="ddit_text" id="err_quest2"></p>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="mem_id" class="col-sm-12 col-form-label">
									문제3) 아이디는 영소문자로 시작하고 영소문자, 숫자 8-16자로 설정해주세요.
								</label>
								<div class="col-sm-12">
									<input type="text" class="form-control" id="mem_id" name="mem_id"/>
									<p class="ddit_text" id="err_id"></p>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="mem_pw" class="col-sm-12 col-form-label">
									문제4) 비밀번호는 영대문자로 시작하고 영문 대소문자, 숫자, 특수문자 8~16자로 설정해주세요. (조건에 부합하는 문자들이 꼭 다 들어있지 않아도 됨)
								</label>
								<div class="col-sm-12">
									<input type="text" class="form-control" id="mem_pw" name="mem_pw"/>
									<p class="ddit_text" id="err_pw"></p>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="mem_name" class="col-sm-12 col-form-label">
									문제5) 이름은 한글 2-5글자로 설정해주세요.
								</label>
								<div class="col-sm-12">
									<input type="text" class="form-control" id="mem_name" name="mem_name"/>
									<p class="ddit_text" id="err_name"></p>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="mem_phone" class="col-sm-12 col-form-label">
									문제6) 핸드폰번호는 아래의 형식에 맞춰 설정해주세요.<br/>
									      첫번째 자리 : 011,016,017,019,070,010만 가능하게 해주세요.<br/>
									      두번째 자리 : 숫자 3자리 또는 숫자 4자리로 설정해주세요.<br/>
									      세번째 자리 : 숫자 4자리로 설정해주세요.<br/>
									      예시) 010-1234-1234, 016-123-1234
								</label>
								<div class="col-sm-12">
									<input type="text" class="form-control" id="mem_phone" name="mem_phone" onkeyup="Checking(this.id)"/>
									<p class="ddit_text" id="err_phone"></p>
								</div>
							</div>
							<p class="ddit_text pt-3" id="success"></p>
							<input class="ddit_btn ddit_btn_outline_primary" type="button" id="sendBtn" onclick="Checking(this.id)" value="전송"/>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
<script type="text/javascript">


let quest11=false;
let quest22=false;
let quest33=false;
let quest44=false;
let quest55=false;
let quest66=false;

const err_quest1 = document.querySelector("#err_quest1");
const err_quest2 = document.querySelector("#err_quest2");
const err_id = document.querySelector("#err_id");
const err_pw = document.querySelector("#err_pw");
const err_quest1 = document.querySelector("#err_quest1");
const err_quest1 = document.querySelector("#err_quest1");

function Checking(ev){

let regExpquest1 = /^[0-9]{7,12}$/;
let regExpquest2 = /^(abc[a-zA-Z]{5,9})$/;
let regExpquest3 = /^([a-z][0-9a-z]{7,15})$/;
// let regExpquest4 = /^([A-Z]\S{7,15})$/;
let regExpquest4 = /^[A-Z][^ㄱ-힣]{7,15}$/;
let regExpquest5 = /^[가-힣]{2,5}$/;
let regExpquest6 = /^((010)|(016)|(017)|(019)|(070)|(011))-\d{3,4}-\d{4}$/;
	
let form = document.querySelector("#frm");

let quest1 = form.quest1.value;
let quest2 = form.quest2.value;
let quest3 = form.mem_id.value;
let quest4 = form.mem_pw.value;
let quest5 = form.mem_name.value;
let quest6 = form.mem_phone.value;

let msg = "";



/* 
	switch (ev) {
	case "quest1":
		if(regExpquest1.test(quest1)){
			msg = "정상!";
			err_quest1.style.color = "green";
			err_quest1.innerHTML = msg;
			quest11 = true;
		}else{
			msg = "숫자만 입력하되, 7-12자리까지만 입력 받을 수 있게 설정해주세요.";
			err_quest1.style.color = "red";
			err_quest1.innerHTML = msg;
			quest11 = false;
		}
		
		break;
	case "quest2":
		if(regExpquest2.test(quest2)){
			msg = "정상!";
			err_quest2.style.color = "green";
			err_quest2.innerHTML = msg;
			quest22 = true;
		}else{
			msg = "시작은 영소문자 abc고 영소대문자 8-12자리까지만 입력 받을 수 있게 설정해주세요.";
			err_quest2.style.color = "red";
			err_quest2.innerHTML = msg;
			quest22 = false;
		}
		
		break;
	case "mem_id":
		if(regExpquest3.test(quest3)){
			msg = "정상!";
			err_id.style.color = "green";
			err_id.innerHTML = msg;
			quest33 = true;
		}else{
			msg = "아이디는 영소문자로 시작하고 영소문자,숫자 8~16자로 설정해주세요.";
			err_id.style.color = "red";
			err_id.innerHTML = msg;
			quest33 = false;
		}
		
		break;
	case "mem_pw":
		if(regExpquest4.test(quest4)){
			msg = "정상!";
			err_pw.style.color = "green";
			err_pw.innerHTML = msg;
			quest44 = true;

		}else{
			msg = "비밀번호는 영대문자로 시작하고 영문 대 소문자, 숫자, 특수문자 8~16자로 설정해주세요.";
			err_pw.style.color = "red";
			err_pw.innerHTML = msg;
			quest44 = false;
		}
		
		break;
	case "mem_name":
		if(regExpquest5.test(quest5)){
			msg = "정상!";
			err_name.style.color = "green";
			err_name.innerHTML = msg;
			quest55 = true;

		}else{
			msg = "이름은 한글 2~5글자로 설정해주세요.";
			err_name.style.color = "red";
			err_name.innerHTML = msg;
			quest55 = false;
		}
		
		break;
	case "mem_phone":
		if(regExpquest6.test(quest6)){
			msg = "정상!";
			err_phone.style.color = "green";
			err_phone.innerHTML = msg;
			quest66 = true;

		}else{
			msg = "핸드폰 번호의 첫번째 자리는 011,016,017,019,070,010 으로 시작하고 두번째 자리는 숫자 3자리 또는 숫자 4자리로 시작하고 세번째 자리는 숫자 4자리로 설정해주세요. 예시) 010-1234-1234,016-123-1234";
			err_phone.style.color = "red";
			err_phone.innerHTML = msg;
			quest66 = false;
		}
		
		break;

	default:
		break;
	}
 */
 
 
	if(quest11&&quest22&&quest33&&quest44&&quest55&&quest66){
		msg = "통과하셨습니다!";
		success.innerHTML = msg;
	}else{
		success.innerHTML = "";
	}
}

</script>
</html>
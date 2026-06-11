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
						<h5 class="ddit_chapter2">유효성 검사를 위한 스크립트 이벤트</h5>
						
						<p class="ddit_text pt-3 pb-1">무작정 테스트해보기</p>
						<form action="validation_process.jsp" id="testForm" method="post">
							아이디 : <input type="text" name="id" id="testId"/><br/>
							비밀번호 : <input type="text" name="pw" id="testPw"/><br/>
							<input type="button" id="testBtn" value="전송"/>
						</form>

						<p class="ddit_text pt-3 pb-1">자바스크립트 onsubmit</p>
						<form action="validation_process.jsp" name="loginForm" method="post"
						onsubmit="return submitEvent()" >
							아이디 : <input type="text" name="id" /><br/>
							비밀번호 : <input type="text" name="pw" /><br/>
							<input type="submit" value="전송"/>
						</form>

						<p class="ddit_text pt-3 pb-1">jQuey Form을 이용한 submit</p>
						<form action="validation_process.jsp" id="loginForm2" method="post">
							아이디 : <input type="text" name="id2" id="id2"/><br/>
							비밀번호 : <input type="text" name="pw2" id="pw2" /><br/>
							<input type="submit" value="전송"/>
						</form>

						<p class="ddit_text pt-3 pb-1">jQuey button을 이용한 click</p>
						<form action="validation_process.jsp" id="loginForm3" method="post">
							아이디 : <input type="text" name="id2" id="id3"/><br/>
							비밀번호 : <input type="text" name="pw2" id="pw3" /><br/>
							<input type="button" id="sendBtn" value="전송"/>
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
function submitEvent(){
	console.log("자바스크립트 이벤트 핸들러 실행...!");
	
	//document 안에 구성된 name 속성을 이용해 값 가져오기(id, pw)
	let id = document.loginForm.id.value;
	let pw = document.loginForm.pw.value;
	
	if(id == null || id == ""){
		alert("아이디가 누락되었습니다!");
		return false;
	}
	if(pw == null || pw == ""){
		alert("비밀번호가 누락되었습니다!")
		return false;
	}
	//현재 동작시킨 이벤트는 submit 이벤트를 포함하고 있는 이벤트
	//그렇기 때문에 Form 태그를 활용한 이벤트를 별도로 줄 필요가 없습니다.
}


/* 제이쿼리 ready function은 document가 전부 읽히고 나서 이후에 실행될 영역이다.  */
$(function(){
	
	//jquey button 태그를 이요한 click----------
	let sendBtn =$("#sendBtn");
	let loginForm3 = $("#loginForm3");
	
	//버튼 태그를 testBtn 변수에 담는다.
	let testBtn = $("#testBtn");
	
	//jQuey form 태그를 이용한 submit --------------
	let loginForm2 = $("#loginForm2");
	
	// 변수로 설정된 태그 객체를 Click 이벤트 핸들러 생성
	// 무작정 테스트 해보기
	testBtn.on("click",function(){
		let testId = $("#testId").val();	//아이디값
		let testPw = $("#testPw").val();	//패스워드값
		
		//유효성 검사
		/*if(testId ==null && testId =="")*/
		//조건문 작성법은 다양한 방법으로 작성할 수 있다.
		//아이디가 입력되었는지 입력되지 않았는지를 체크하기 위해서 null과 공백 체크에 대한 조건문 작성은
		//위와같은 방식으로 할 수 있습니다.
		//두 작성법의 속도차이는 미미하고, 가독성의 차이말고는 없다
		//하지만 내가 비교할 때 조건의 대상을 명시적으로 작성하고싶다면 전자의 방법으로 작성해야 합니다.
		//if(!testId)는 null, 공백, undefined, NaN 등등을 체크합니다.
		if(!testId){
			alert("아이디를 입력해주세요!");
			// 이와같은 return; 문은 boolean 타입의 true, false 값 중 default 에 해당하는 false를
			// 리턴하는것처럼 보이지만, 실제로는 'undefined'를 리턴합니다.
			// 그렇기 때문에 해당 함수를 종료햐기 위한 false 를 명확하게 리턴합니다.
			return false;
		}
		if(!testPw){
			alert("비밀번호를 입력해주세요!");
			return false;
		}
		
		$("#testForm").submit();

	});
	
	
	//jQuey form 을 이용한 submit
	loginForm2.submit(function(){
		//해당 이벤트가 곧 submit 이벤트이기 때문에 해당 이벤트를 block 한다.
		
		//우리가 submit 이벤트 자체를 핸들링 하기 위해서 submit 이벤트를 작성합니다.
		//이때, submit 이벤트 자체를 block 하기 위해서 preventDefault() 구문을 작성합니다.
		//순수한 마음에서 block 했지만, 여기서 크나큰 오류가 발생합니다.
		//submit 이벤트를 살리면서 loginForm2.submit() 이벤트가 실행되고 다시
		//preventDefault() 가 실행됩니다
		//그렇게 되면 메모리에 stack 이 쌓이면서 결국 서버가 터져버립니다.
		//그래서 submit 이벤트 자체를 핸들링할거라면 block 이벤트가 아닌 return false 와 같은
		//이벤트로 상황에 맞게 이벤트를 구성할 수 있어야합니다.
		
		/* event.preventDefault(); */
		console.log("jQuey 이벤트 핸들러 실행!")
		
		let id = $("#id2").val();
		let pw = $("#pw2").val();
		
		if(id==null||id==""){
			alert("아이디가 누락되었습니다!");
			return false;
		}
		if(pw==null||pw==""){
			alert("비밀번호가 누락되었습니다!");
			return false;
		}
		
		/* loginForm2.submit(); */
	})
	
	
	//jQuey button 을 이용한 click
	//.on("click",function()) 내부에서 발생하는 return false;는 단순히 함수 종료를 넘어 브라우저의
	// 기본 동작 및 버블링을 막습니다.
	// 버블링 : 자식 요소 클릭 시 , 해당 클릭 이벤트가 부모 요소, 그 위의 조상 요소들까지 차레대로 전달되는
	//        과정을 이야기합니다
	sendBtn.on("click", function(){
		let id = $("#id3").val();
		let pw = $("#pw3").val();
		
		if(id==null||id==""){
			alert("아이디가 누락되었습니다!");
			return false;
		}
		
		if(pw==null||pw==""){
			alert("비밀번호가 누락되었습니다!")
			return false;
		}
		loginForm3.submit();
	});
	
});

</script>

</html>
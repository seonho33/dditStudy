<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>9. Ajax 방식 요청 처리</h1>

	<hr>

	<form>
		userId : <input type="text" id="userId"><br> password : <input
			type="text" id="password"><br>
	</form>

	<p>1) 객체 타입의 JSON 요청 데이터 @RequestBody 어노테이션을 지정하여 자바빈즈 매개변수로 처리한다.</p>
	<button type="button" id="registerBtn01">요청</button>

	<p>2) 객체 타입의 JSON 요청 데이터는 문자열 매개변수로 처리한다.</p>
	<button type="button" id="registerBtn02">요청</button>

	<p>3) 요청 URL에 쿼리 파라미터를 붙여서 전달하면 큰 문자열 매개변수로 처리한다.</p>
	<button type="button" id="registerBtn03">요청</button>

	<p>4) 객체 배열 타입의 JSON 요청 데이터를 자바빈즈 요소를 가진 리스트 컬렉션 매개변수에 @RequestBody
		어노테이션을 지정하여 처리한다.</p>
	<button type="button" id="registerBtn04">요청</button>

	<p>5) 중첩된 객체 타입의 JSON 요청 데이터를 @RequestBody 어노테이션을 지정하여 중첩된 자바빈즈
		매개변수로 처리한다.</p>
	<button type="button" id="registerBtn05">요청</button>

	<p>6) 중첩된 객체 타입의 JSON 요청 데이터를 @RequestBody 어노테이션을 지정하여 중첩된 자바빈즈
		매개변수로 처리한다.</p>
	<button type="button" id="registerBtn06">요청</button>

</body>

<script type="text/javascript">
$(function() {

	// $.ajax() 에서 활용되는 기본적인 속성
	// - url : 목적지 주소를 설정합니다.
	// - type or method : method 방식을 설정합니다.
	// - contentType : 요청 Mime Type을 설정합니다.
	// - headers : 요청 header 정보를 설정합니다.
	// - data : 요청으로 보낼 데이터를 설정합니다.
	// - dataType : 응답으로 받을 데이터타입(MimeType)을 설정합니다.
	//				jQuery ajax 에서 dataType 속성을 설정하지 않으면, ContentType을 보고 dataType을 에측함.
	// - success : 요청에 대한 실패 callback
	// - error : 요청에 대한 실패 callback
	// - async : 요청을 동기/ 비동기로 처리할지 설정(기본은 true, false 설정 시 동기 이벤트가 됨) :: 권장사항 X
	// - timeout : 요청이 실패가 되기까지 기다릴 최대 시간(밀리초), 실패 시 에러로 간주
	// - beforeSend : 요청이 전송되기 전에 호출되는 callback
	//				  이후 스프링 시큐리티 진행 시, csrf token 을 정송할 때 헤더 설정값으로 사용함

	let registerBtn01 = $("#registerBtn01");
	let registerBtn02 = $("#registerBtn02");
	let registerBtn03 = $("#registerBtn03");
	let registerBtn04 = $("#registerBtn04");
	let registerBtn05 = $("#registerBtn05");
	let registerBtn06 = $("#registerBtn06");

	registerBtn01.on("click", function() {
		console.log("registerBtn01 Click...!");

		let userId = $("#userId").val();
		let password = $("#password").val();
		let userObject = {
			userId : userId,
			password : password
		};

		// 비동기 방식 요청
		// JSON.stringify() : JSON 객체를 문자열로 변경(JSON 객체의 형태를 띄고있는 문자열로 변경됨)
		// 데이터를 쉽고 빠르게 전송할 수 있도록 JSON 객체 형태를 문자열로 직렬화해서 전송합니다.
		// 1) 객체 타입의 JSON  요청 데이터 @RequestBody 어노테이션을 지정하여 자바빈즈 매개변수로 처리한다.
		$.ajax({
			url : "/chapt05/ajax/register01",
			type : "post",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(userObject),
			success : function(result) {
				console.log(result);
				if (result == "SUCCESS") {
					alert(result);
				}
			},
			error : function(error, status, thrown) {
				console.log(error);
				console.log(status);
				console.log(thrown);
			}
		});
	});

	registerBtn02.on("click", function() {
		console.log("registerBtn02 Click...!");

		let userId = $("#userId").val();
		let password = $("#password").val();
		let userObject = {
			userId : userId,
			password : password
		};

		$.ajax({
			url : "/chapt05/ajax/register02",
			type : "post",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(userObject),
			success : function(result) {
				console.log(result)
				if (result == "SUCCESS") {
					alert(result);
				}
			},
			error : function(error, status, thrown) {
				console.log(error);
				console.log(status);
				console.log(thrown);
			}

		});
	});

	registerBtn03.on("click", function() {
		console.log("registerBtn03 Click...!");

		let userId = $("#userId").val();
		let password = $("#password").val();
		let userObject = {
			userId : userId,
			password : password
		};

		$.ajax({
			url : "/chapt05/ajax/register03/" + userId + "?password="
					+ password,
			type : "post",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(userObject),
			success : function(result) {
				console.log(result)
				if (result == "SUCCESS") {
					alert(result);
				}
			},
			error : function(error, status, thrown) {
				console.log(error);
				console.log(status);
				console.log(thrown);
			}
		});
	});
	
	registerBtn04.on("click",function(){
		let userObjectArray=[
			{userId : "name01", password : "pw1"},
			{userId : "name02", password : "pw2"}
		]
		
		$.ajax({
			url : "/chapt05/ajax/register04",
			type : "post",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(userObjectArray),
			success : function(result) {
				console.log(result)
				if (result == "SUCCESS") {
					alert(result);
				}
			},
			error : function(error, status, thrown) {
				console.log(error);
				console.log(status);
				console.log(thrown);
			}
		});
	});
	
	registerBtn05.on("click",function(){
		let userId = $("#userId").val();
		let password = $("#password").val();
		let userObject = {
				userId : userId,
				password : password,
				address : {
					postCode : "010989",
					location : "Daejeon"
				}
		};
		
		$.ajax({
			url : "/chapt05/ajax/register05",
			type : "post",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(userObject),
			success : function(result) {
				console.log(result)
				if (result == "SUCCESS") {
					alert(result);
				}
			},
			error : function(error, status, thrown) {
				console.log(error);
				console.log(status);
				console.log(thrown);
			}
		});
	});
	
	registerBtn06.on("click",function(){
		let userId = $("#userId").val();
		let password = $("#password").val();
		let userObject = {
				userId : userId,
				password : password,
				cardList : [
					{no : "12345", validMonth : "20260311"},					
					{no : "56789", validMonth : "20260312"},					
				]
		};
		
		$.ajax({
			url : "/chapt05/ajax/register06",
			type : "post",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(userObject),
			success : function(result) {
				console.log(result)
				if (result == "SUCCESS") {
					alert(result);
				}
			},
			error : function(error, status, thrown) {
				console.log(error);
				console.log(status);
				console.log(thrown);
			}
		});
	});
});
</script>
</html>
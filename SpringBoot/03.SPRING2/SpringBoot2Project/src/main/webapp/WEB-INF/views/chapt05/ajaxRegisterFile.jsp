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
	<h1>10.파일 업로드 Ajax 방식 요청 처리</h1>
	<hr>

	<p>Ajax 방식으로 전달한 파일 요소값을 스프링 MVC가 지원하는 MultipartFile 매개변수로 처리한다.</p>
	<p>
		Open File 을 통해서 이미지 파일을 선택합니다 <br> 선택한 이미지 파일을 서버로 업로드 후, 업로드가
		성공했을 때 'OK' 라는 결과를 받아오빈다. 업로드 했던 파일 데이터를 이용해 이미지 썸네일 및 파일 정보를 출력합니다.
	</p>
	<div>
		<input type="file" id="inputFile"><br>
		<hr>
		<div id="view"></div>
		<img id="preview" width="500px" src="">
	</div>


</body>

<script type="text/javascript">
	$(function() {
		let inputFile = $("#inputFile");

		//Open File 을 통해서 파일 선택 시
		inputFile.on("change", function(event) {
			console.log("change event...!");

			let files = event.target.files;
			let file = files[0];

			console.log(file);

			// 이미지 파일을 선택 했을 때
			if (isImageFile(file)) {
				// 파일이 포함된 데이터라면 FormData() 객체를 생성하여 데이터 전송 준비를 합니다.
				let formData = new FormData();
				formData.append("file", file);

		// formData는 key/value 형식으로 데이터가 저장됩니다.
		// dataType : 응답(response) 데이터를 내보낼 때 보내줄 데이터 타입
		// processData : 데이터 파라미터를 data라는 속성으로 넣는데, jQuery가 데이터를
		//				 문자열로 변환하려고 하는걸 막기위해 false로 설정(기본값은 true)
		//				 비동기 방식이면서 일반 데이터를 보낼 때에는 해당 속성의 값이 기본적으로 
		//				 Json 문자열 또는 URL 인코딩된 상태로 넘어가므로 상관없지만,
		//				 파일은 binary가 넘어가므로, 해당 설정을 false로 두어 변환을 방지합니다.

		// contentType : Content-type 을 설정 시, 사용하는데 해당 설정의 기본값은
		//				 'application/x-www-form-urlencoded; charset=utf-8 입니다.
		//				 하여, 기본값으로 또는 직접 설정한 media type 으로 나가지
		//				 않고 'multipart/form-data' 형식 이면서
		//				 boundary 이후 요청본문에 데이터를 기반으로 만들어질 HashKey가 포함된
		//				 경계 문자열로 나갈 수 있도록 설정을 false 합니다.
		// request 요청에서 Content-type을 확인해보면 'multipart/form-data;boundary===WebKitForm...''
		// 와 같은 값으로 전송된것을 확인할 수 있습니다.

				$.ajax({
					url : "/chapt05/ajax/uploadFile",
					type : "post",
					contentType : false,
					processData : false,
					data : formData,
					dataType : "json",
					success : function(result) {
						console.log(result);

	// javascript 와 jQuery 에서의 Scope 및 Closure 정책
	// 기본적으로 Event 란 스크립트 내부의 클릭(Click), 변경(Change)
	// 등과 같은 이벤트를 지칭합니다.
	// 해당 이벤트가 실행되면 메모리의 스택에 이벤트가 할당됩니다.
	// 우리가 현재 만든 Change 이벤트로 마찬가지로 메모리 스택에 이벤트가 등록되어 있습니다.
	// 그리고 해당 이벤트 내, ajax 비동기 이벤트로 같이 올라가 있습니다.
	// 하지만, Change이벤트가 끝나면 Change에서 사용하고있는 Event 객체는 사라집니다.
	// 그리고 Change이벤트 내 비동기 이벤트만 남게 되는 셈이죠
	// 여기서 다양한 상황이 벌어질 수 있습니다. Change 이벤트 내 선언한 local variable 파라미터를
	// 가용할 수 있느냐 또는 Event 객체를 ajax 이벤트 내에서 재활용 할 수 있느냐가 포커스입니다.
	// 순수 네이티브 Dom 이벤트 객체를 기준 정책 사항으로 이벤트를 들여다보면 이미 끝난 Event 객체에
	// 데이터를 재활용하기란 불가능 합니다. (요즘은? 브라우저마다 정책사항, 캐시 등 강한지라, 클라이언트마다 달라질 수 있습니다.)
	// jQuery 에서는 내부 이벤트에서 가용할 여러 값들을 랩핑하여 가지고 있으려고 하기 때문에 재활용하는데는 문제 없습니다.
	// 그렇다면 어떻게 사용하는게 바람직 할까요? 그래서 이를 해결하기 위해 유능한 사람들이 권장하는 내용이 있습니다.
	// 네이티브 Dom 환경이든 jQuery 환경이든 상관없이, 비동기 콜백함수(ajax의 success, setTimeout의 콜백 등)
	// 내에서 데이터를 안전하게 사용하려면 이벤트가 발생할 때 데이터를 로컬변수에 미리 추출하여 저장하고,
	// 이 변수를 클로저(Closure)를 통해 재활용 하는 방식이 가장 권장하는 방법이라고 공유합니다.
	// (그렇기 때문에 개발자는 문서, 책도 읽어보면서 여러 사례를 접하는것도 물론 중요하지만, 여러분들이
	// 격게될 도메인 환경에서 터득하는 지혜와 같은 여러 상황들을 피부로 느끼면서 경험하는게 좋습니다.)
					
					console.log("local variable history");
					console.log("event : " + event.target.files);
					console.log("files : " + files);
					console.log("file : " + file);
					
					if(result.status == "200 OK"){
						let html = `
								<table border="1">
									<tr>
										<th>파일명</th>
										<td>\${result.data.fileName}</td>
									</tr>
									<tr>
										<th>파일크기</th>
										<td>\${result.data.fileSize}</td>
									</tr>
									<tr>
										<th>파일타입</th>
										<td>\${result.data.fileType}</td>
									</tr>
								</table>
						`;
						$("#view").html(html)
						
						let reader = new FileReader();
						reader.onload = function(e){
							$("#preview").attr("src", e.target.result)
						};
						// 피미지 파일의 binary data를 Base64 인코딩 설정으로 문자열을 만들어 추출
						reader.readAsDataURL(file);
					};
					
					},
					error : function(error, status, thrown) {
						console.log(error);
						console.log(status);
						console.log(thrown);
					}
				})
			} else {
				alert("이미지 파일만 선택 가능합니다..")
			}

		});

	});
	function isImageFile(file) {
		// .pop() : 배열의 마지막 요소 꺼내기
		let ext = file.name.split(".").pop().toLowerCase(); // 파일명에서 확장자를 가져온다.
		// $.inArray : 배열 검색 함수
		// 자바 스크립트의 Array.prototype.indexOf()와 유사형
		// 확장자 중 이미지에 해당하는 확장자가 아닌 경우 포함되어있는 문자가 없으니까 -1을 리턴

		return ($.inArray(ext, [ "jpg", "jpeg", "png", "gif" ]) === -1) ? false
				: true;
	}
</script>
</html>
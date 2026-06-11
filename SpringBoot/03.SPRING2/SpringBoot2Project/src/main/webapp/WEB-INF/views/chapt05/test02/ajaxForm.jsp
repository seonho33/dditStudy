<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<body>
	<div class="container">
		<div class="row mt-5">
			<div class="col-md-4">
				<div class="card">
					<div class="card-header">
						<h3>비동기 방식의 요청으로 아래 데이터 전송하기</h3>
					</div>
					<div class="card-body">
						<p>
							파일을 업로드 합니다.<br /> 비동기 요청을 이용해 파일을 서버로 업로드 하고 서버로부터 전달받은 업로드 한
							파일의 파일명,크기,ContentType을 출력해주세요. 이때, 이미지 파일인 경우라면 썸네일을 함께 출력하고
							일반적인 파일이라면 파일명만 출력해주세요.
						</p>
						<input type="file" id="inputFile" />
					</div>
				</div>
			</div>
			<div class="col-md-8">
				<div class="row" id="res"></div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		let inputFile = $("#inputFile");

		inputFile.on("change", function(ev) {
			console.log("inputFile 이벤트 시작됨!");

			//local variable
			let file = ev.target.files[0];

			let formData = new FormData();
			formData.append("file", file);

			$.ajax({
				url : "/chapt05/test02/upload",
				type : "post",
				contentType : false,
				processData : false,
				data : formData,
				dataType : "json",
				success : function(result) {
					console.log(result);
					let html = ``;
					if (result.code == "200 OK") {
						if (isImageFile(file)) {
							let reader = new FileReader();
							reader.onload = function(e){
								html += `
									<div class="col-md-3">
										<div class="card">
											<div class="card-header">
												<h5>\${result.fileName}</h5>
											</div>
											<div class="card-body">
												<img src="\${e.target.result}" width="100%"/>
											</div>
											<div class="card-body">
												<p>파일 크기 : \${result.fileSize}</p>
												<p>파일 타입 : \${result.contentType}</p>
											</div>	
										</div>
									</div>`;
							
								//.append() : html 변수에 담긴 html 영역을 차례차례 붙입니다.
								$("#res").append(html);
							}
							reader.readAsDataURL(file);
						} else {
							html += `
								<div class="col-md-3">
									<div class="card">
										<div class="card-header">
											<h5>\${result.fileName}</h5>
										</div>
										<div class="card-body">
											<p>파일 크기 : \${result.fileSize}</p>
											<p>파일 타입 : \${result.contentType}</p>
										</div>	
									</div>
								</div>`;
							$("#res").append(html);
						}
					}
				},
				error : function(error, status, thrown) {
					console.log(error);
					console.log(status);
					console.log(thrown);
				}

			})

		})

	})
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
<%@ page language='java' contentType='text/html; charset=UTF-8'
	pageEncoding='UTF-8'%>
<%@ taglib uri="jakarta.tags.core" prefix='c'%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>Insert title here</title>
<link rel='stylesheet'
	href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css'
	integrity='sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN'
	crossorigin='anonymous'>
<script
	src='https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js'></script>
</head>
<body>
	<div class="container">
		<h1 class="mt-3">비동기 이벤트를 활용한 파일 핸들링 연습</h1>

		<div class="row mt-5">
			<div class="col-md-12">
				<div class="card">
					<div class="card-header">
						<h5>정렬 할 타입을 선택해주세요.</h5>
						<select class='form-control' id='selectImgType'>
							<option value='all'>전체</option>
							<option value='jpg'>JPG</option>
							<option value='png'>PNG</option>
							<option value='gif'>GIF</option>
						</select>
					</div>
					<div class="card-body">
						<div class='row' id='imageArea'>
							<c:choose>
								<c:when test="${empty imageFileList }">
									<h1>이미지 파일이 존재하지 않습니다.</h1>
								</c:when>
								<c:otherwise>
									<c:forEach items="${imageFileList }" var="imageFile">
										<div class="col-md-3">
											<div class="card">
												<div class="card-header">${imageFile }</div>
												<div class="card-body">
													<img
														src="${pageContext.request.contextPath }/resources/test02/image/${imageFile}"
														style="width: 200px; height: 100px; " />
												</div>
												<div class="card-footer">
													<a class="btn btn-primary" href="${pageContext.request.contextPath }/resources/test02/image/${imageFile}" download>다운로드</a>
												</div>
											</div>
										</div>
									</c:forEach>

								</c:otherwise>
							</c:choose>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
$(function(){
	
	let imageArea = $("#imageArea");
	let selectImgType = $("#selectImgType");
	
	selectImgType.on("change",function(e){
		console.log("실행됨")
		let typeP = e.target.value;
		let html = ``;
		
		$.ajax({
			url : "/chapt05/test02/typeResult",
			type : "get",
			data : {
				typeP : typeP
			},
			dataType : "json",
			success : function(result,status,xhr){
				console.log("result체킁:",result);
				if(result.length>0){
					result.forEach(file=>{
							html += `
								<div class="col-md-3">
									<div class="card">
										<div class="card-header">\${file }</div>
										<div class="card-body">
											<img
												src="${pageContext.request.contextPath }/resources/test02/image/\${file}"
												style="width: 200px; height: 100px;" />
										</div>
										<div class="card-footer">
											<a class="btn btn-primary" href="${pageContext.request.contextPath}/resources/test02/image/\${file}" download>다운로드</a>
										</div>
									</div>
								</div>
									`
					})
				}else{
					html = `
					<h1>이미지 파일이 존재하지 않습니다.</h1>
						`
				}
				
				imageArea.html(html);
			},
			error : function(error,status,thrown){
				console.log(error);
				console.log(status);
				console.log(thrown);
			}
			
			})
	
	})
	
	
})


</script>
</html>
































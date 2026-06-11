<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./nModule/headerPart.jsp" %>
<body class="hold-transition sidebar-mini">
	<div class="wrapper">
		<%@ include file="./nModule/header.jsp" %>

		<div class="content-wrapper">
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>마이페이지</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">User Profile</li>
							</ol>
						</div>
					</div>
				</div>
			</section>
			
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-3">
			
							<div class="card card-dark card-outline">
								<div class="card-header">
									<div class="card-title">
										<h4>내정보</h4>
									</div>
								</div>
								<div class="card-body">
									<div class="position-relative">
										<img id="profileImg" src="${member.memProfileimg }" alt="Photo 1" class="img-fluid">
										<div class="ribbon-wrapper ribbon-lg">
											<div class="ribbon bg-success text-lg">Profile</div>
										</div>
									</div>
									<div class="row mt-4">
										<div class="col-md-4 text-bold">아이디</div>
										<div class="col-md-8">${member.memId }</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">비밀번호</div>
										<div class="col-md-8">PROTECTED</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">이름</div>
										<div class="col-md-8">${member.memName }</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">성별</div>
										<div class="col-md-8">
										<c:if test="${member.memGender eq 'M' }">남자</c:if>
										<c:if test="${member.memGender eq 'F' }">여자</c:if>
										</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">이메일</div>
										<div class="col-md-8">${member.memEmail }</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">전화번호</div>
										<div class="col-md-8">${member.memPhone }</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">주소</div>
										<div class="col-md-8">${member.memAddress1 }${member.memAddress2 }</div>
									</div>
									<div class="row mt-2">
										<div class="col-md-4 text-bold">가입일</div>
										<div class="col-md-8">${member.memRegdate }</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-9">
							<div class="card card-dark card-outline">
								<form class="form-horizontal" action="/notice/profileUpdate.do" method="post" id="profileUdtForm" enctype="multipart/form-data">
								<input type="hidden" name="memNo" value="${member.memNo }">
									<div class="card-header">
										<div class="row">
											<div class="col-md-10">
												<h4>내정보 수정</h4>
											</div>
											<div class="col-md-2" align="right">
												<button type="submit" class="btn btn-info">수정하기</button>
											</div>
										</div>
									</div>
									<div class="card-body">
										<div class="tab-content">
											<div class="tab-pane active">
												<div class="form-group row">
													<label class="col-sm-2 col-form-label">프로필 이미지</label>
													<div class="col-md-10">
														<br/>
														<div class="custom-file">
															<input type="file" class="custom-file-input" name="imgFile" id="imgFile"> 
															<label class="custom-file-label" for="imgFile">프로필 이미지를 선택해주세요</label>
														</div>										
													</div>
												</div>
												<div class="form-group row">
													<label for="memId" class="col-sm-2 col-form-label">아이디</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="memId" name="memId" value="${member.memId }" placeholder="아이디를 입력해주세요.">
													</div>
												</div>
												<div class="form-group row">
													<label for="memPw" class="col-sm-2 col-form-label">비밀번호</label>
													<div class="col-sm-10">
														<input type="password" class="form-control" id="memPw" name="memPw" value="${member.memPw }" placeholder="아이디를 입력해주세요.">
													</div>
												</div>
												<div class="form-group row">
													<label for="memName" class="col-sm-2 col-form-label">이름</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="memName" name="memName" value="${member.memName }" placeholder="비밀번호를 입력해주세요.">
													</div>
												</div>
												<div class="form-group row">
													<label for="" class="col-sm-2 col-form-label">성별</label>
													<div class="col-sm-10">
														<div class="icheck-primary d-inline">
															<input type="radio" id="memGenderM" name="memGender" value="M" <c:if test="${member.memGender eq 'M' }">checked</c:if>> 
															<label for="memGenderM">남자</label>
														</div>
														<div class="icheck-primary d-inline">
															<input type="radio" id="memGenderF" name="memGender" value="F" <c:if test="${member.memGender eq 'F' }">checked</c:if>> 
															<label for="memGenderF">여자</label>
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label for="memEmail" class="col-sm-2 col-form-label">이메일</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="memEmail" name="memEmail" value="${member.memEmail }" placeholder="이메일을 입력해주세요.">
													</div>
												</div>
												<div class="form-group row">
													<label for="memPhone" class="col-sm-2 col-form-label">전화번호</label>
													<div class="col-sm-10">
														<input type="text" class="form-control" id="memPhone" name="memPhone" value="${member.memPhone }" placeholder="전화번호를 입력해주세요.">
													</div>
												</div>
												<div class="input-group mb-3">
													<label for="" class="col-sm-2 col-form-label">주소</label>
													<div class="col-sm-10">
														<div class="input-group mb-3">
															<input type="text" class="form-control" id="memPostcode" name="memPostcode" value="${member.memPostcode }" placeholder="우편번호를 입력해주세요"> 
															<span class="input-group-append">
																<button type="button" class="btn btn-secondary btn-flat" onclick="DaumPostcode()">우편번호 찾기</button>
															</span>
														</div>
														<div class="input-group mb-3">
															<input type="text" class="form-control" id="memAddress1" name="memAddress1" value="${member.memAddress1 }" placeholder="주소를 입력해주세요">
														</div>
														<div class="input-group mb-3">
															<input type="text" class="form-control" id="memAddress2" name="memAddress2" value="${member.memAddress2 }" placeholder="상세주소를 입력해주세요">
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
		<%@ include file="./nModule/footer.jsp" %>

		<aside class="control-sidebar control-sidebar-dark">
		</aside>
	</div>
	<%@ include file="./nModule/footerPart.jsp" %>
</body>
<script type="text/javascript">
$(function(){
	let imgFile = $("#imgFile");
	
   //프로필 이미지 선택 이벤트
   let idCheckBtn = $("#idCheckBtn");
   let error = $(".error");   //error 메세지 출력 class
   let idCheckFlag = false;   //중복확인 flag(true: 중복체크완료, false: 중복체크 미완료!)
   
   imgFile.on("change", function(event){
         let file = event.target.files[0]; //선택한 파일 가져오기
         
         
         // 이미지 파일 검증
         if(isImageFile(file)){
            let reader = new FileReader();
            reader.onload = function(e){
               $("#profileImg").attr("src", e.target.result)
            }
            reader.readAsDataURL(file);
         }else{
            sweetAlert("error", "이미지 파일을 선택해주세요!")
         }
   });
})
// 이미지 파일인지 체크
function isImageFile(file){
   let ext = file.name.split(".").pop().toLowerCase(); //파일명에서 확장자를 가져온다
   return ($.inArray(ext,["jpg","jpeg","png","gif"])=== -1)? false : true

}

</script>
</html>

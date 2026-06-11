<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<body>
	<div class="container">
		<div class="row mt-3">
			<div class="col-md-8">
				<div class="card">
					<div class="card-header">
						<h3>1. 동기 방식의 요청으로 아래 폼 데이터 전송하기</h3>
					</div>
					<div class="card-body">
						<form action="/chapt05/test02/insert" method="post" enctype="multipart/form-data">
							<div class="mb-3 row">
								<label for="id" class="col-sm-2 col-form-label">프로필</label>
								<div class="col-sm-10">
									<input type="file" class="form-control" name="attachFile">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="id" class="col-sm-2 col-form-label">아이디</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="id" name="userId">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="id" class="col-sm-2 col-form-label">비밀번호</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="pw" name="password">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="id" class="col-sm-2 col-form-label">이름</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="name" name="userName">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="gender" class="col-sm-2 col-form-label">성별</label>
								<div class="col-sm-10">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="gender" id="genderM" value="M" checked="checked">
										<label class="form-check-label" for="genderM">남자</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="gender" id="genderG" value="F">
										<label class="form-check-label" for="genderG">여자</label>
									</div>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="phone" class="col-sm-2 col-form-label">연락처</label>
								<div class="col-sm-3">
									<select class="form-select mb-3" name="phone">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="019">019</option>
									</select>
								</div>-
								<div class="col-sm-3">
									<input type="text" class="form-control" id="phone2" name="phone2" maxlength="4" size="4">
								</div>-
								<div class="col-sm-3">
									<input type="text" class="form-control" id="phone3" name="phone3" maxlength="4" size="4">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="email" class="col-sm-2 col-form-label">이메일</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="email" name="email">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="addressPostCode" class="col-sm-2 col-form-label">우편번호</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="addressPostCode" name="addressPostCode">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="addressLocation" class="col-sm-2 col-form-label">기본주소</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="addressLocation" name="addressLocation">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="addressDetail" class="col-sm-2 col-form-label">상세주소</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="addressDetail" name="addressDetail">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="introduction" class="col-sm-2 col-form-label">자기소개</label>
								<div class="col-sm-10">
									<textarea rows="10" cols="50" id="introduction" name="introduction" wrap="soft" placeholder="가입 인사를 입력해주세요."></textarea>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="attachFileList" class="col-sm-2 col-form-label">첨부파일</label>
								<div class="col-sm-10">
									<input type="file" class="form-control" name="attachFileList" id="attachFileList" multiple="multiple">
								</div>
							</div>
							<input class="btn btn-primary" type="submit" value="가입하기"/>
						</form>
					</div>
				</div>
			</div>
			<div class="col-md-4"></div>
		</div>
	</div>
</body>
</html>
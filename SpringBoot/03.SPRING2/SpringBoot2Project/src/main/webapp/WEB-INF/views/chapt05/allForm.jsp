<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"/>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
.col-form-label{
	font-size: 18px;
}
</style>
<body>
	<!-- 
문제01) 회원가입 양식을 만들고 서버로 전송해주세요.

	항목			|		name						|		value
────────────────────────────────────────────────────────────────────────────────────────────
	아이디		|	userId							|
	비밀번호		|	password						|
	이름			|	userName						|
	이메일		|	email							|
	생년월일		|	dateOfBirth						|
	성별			|	gender							|	남자(male), 여자(female)
	개발자 여부	|	developer						|	개발자(Y), 비개발자(null)
	외국인 여부	|	foreigner						|	외국인(true), 내국인(false)
	국적			|	nationality						|	대한민국(korea), 독일(germany), 캐나다(canada), 미국(usa)
	소유차량		|	cars, carArray, carList			|	BMW,AUDI,VOLVO,JEEP
	취미			|	hobby, hobbyArray, hobbyList	|	운동(sports),독서(book),영화감상(movie),음악감상(music)
	우편번호		|	postCode						|		
	주소			|	location						|
	카드1-번호		|	no								|
	카드1-유효년월	|	validMonth						|	날짜 데이터 
	카드2-번호		|	no								|
	카드1-유효년월	|	validMonth						|	날짜 데이터
	소개			|	introduction					|
────────────────────────────────────────────────────────────────────────────────────────────
** 사용 변수 및 타입은 자유

문제02) 입력한 데이터를 '/chapt05/test/result' 로 전송해주세요. (result.jsp는 'chapt05/test/result.jsp')
	 -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8 pt-5 pb-5">
				<div class="card">
					<div class="card-header">
						<h3>회원가입 페이지</h3>
					</div>
					<div class="card-body">
						<form action="/chapt05/test/result" method="post">
							<div class="mb-3 row">
								<label for="userId" class="col-sm-2 col-form-label">아이디</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="userId" name="userId">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="password" class="col-sm-2 col-form-label">비밀번호</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="password" name="password">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="userName" class="col-sm-2 col-form-label">이름</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="userName" name="userName">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="email" class="col-sm-2 col-form-label">이메일</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="email" name="email">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="dateOfBirth" class="col-sm-2 col-form-label">생년월일</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="dateOfBirth" name="dateOfBirth">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="gender" class="col-sm-2 col-form-label">성별</label>
								<div class="col-sm-10">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="gender" id="genderM" checked> 
										<label class="form-check-label" for="genderM"> 남자 </label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="gender" id="genderF"> 
										<label class="form-check-label" for="genderF"> 여자 </label>
									</div>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="developer" class="col-sm-2 col-form-label">개발자 여부</label>
								<div class="col-sm-10">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox" name="developer" id="developer" value="Y"> 
										<label class="form-check-label" for="developer">개발자</label>
									</div>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="foreigner" class="col-sm-2 col-form-label">외국인 여부</label>
								<div class="col-sm-10">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox" name="foreigner" id="foreigner" value="true"> 
										<label class="form-check-label" for="foreigner">외국인</label>
									</div>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="nationality" class="col-sm-2 col-form-label">국적</label>
								<div class="col-sm-10">
									<select class="form-select" name="nationality" aria-label="Default select example">
										<option value="korea">대한민국</option>
										<option value="germany">독일</option>
										<option value="canada">캐나다</option>
										<option value="usa">미국</option>
									</select>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="carArray" class="col-sm-2 col-form-label">소유차량</label>
								<div class="col-sm-10">
									<select class="form-select" name="carArray" multiple="multiple" aria-label="Default select example">
										<option value="" selected>--선택--</option>
										<option value="BMW">BMW</option>
										<option value="AUDI">AUDI</option>
										<option value="VOLVO">VOLVO</option>
										<option value="JEEP">JEEP</option>
									</select>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="developer" class="col-sm-2 col-form-label">취미</label>
								<div class="col-sm-10">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox" id="hobbyChk1" name="hobbyList" value="sports"> 
										<label class="form-check-label" for="hobbyChk1">운동</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox" id="hobbyChk2" name="hobbyList" value="book"> 
										<label class="form-check-label" for="hobbyChk2">독서</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox" id="hobbyChk3" name="hobbyList" value="music"> 
										<label class="form-check-label" for="hobbyChk3">음악감상</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox" id="hobbyChk4" name="hobbyList" value="movie"> 
											<label class="form-check-label" for="hobbyChk4">영화감상</label>
									</div>
								</div>
							</div>
							<div class="mb-3 row">
								<label for="postCode" class="col-sm-2 col-form-label ">우편번호</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="postCode" name="address.postCode">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="location" class="col-sm-2 col-form-label">주소</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="location" name="address.location">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="no1" class="col-sm-2 col-form-label">카드1 (번호)</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="no1" name="cardList[0].no">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="validMonth1" class="col-sm-2 col-form-label">카드1 (유효년월)</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="validMonth1" name="cardList[0].validMonth">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="no2" class="col-sm-2 col-form-label">카드2 (번호)</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="no2" name="cardList[1].no">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="validMonth2" class="col-sm-2 col-form-label">카드2 (유효년월)</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="validMonth2" name="cardList[1].validMonth">
								</div>
							</div>
							<div class="mb-3 row">
								<label for="introduction" class="col-sm-2 col-form-label">자기소개</label>
								<div class="col-sm-10">
									<textarea class="form-control" id="introduction" name="introduction"></textarea>
								</div>
							</div>
					<div class="card-footer">
						<button type="submit" class="btn btn-sm btn-primary">등록</button>
					</div>
						</form>				
					</div>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
</body>
</html>
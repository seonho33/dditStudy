<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Register Form</h1>
	<hr/>

	<h4>1. 컨트롤러 메서드 매개변수</h4>
	<hr/>

	<p> 1) URL 경로 상의 쿼리 파라미터 정보로부터 요청 데이터를 취득할 수 있다. </p>
	<a href="/chapt05/register?userId=hongkd&password=1234">요청</a>
	<hr>

	<p>2) HTML Form 필드명과 컨트롤러 매개변수명이 일치하면 요청 데이터를 취득 할 수 있다.</p>
	<form action="/chapt05/register01" method="post">
		userId: <input type="text" name="userId">
		password: <input type="text" name="password">
		coin: <input type="text" name="coin">
		<button>등록</button>
	</form> <br>
	
	<h4>2. 요청 데이터 처리 어노테이션</h4>
	<hr>
	
	<p>1) URL 경로 상의 경로변수가 여러개일때 @PathVariable 어노테이션을 사용하여 특정한 경로 변수명을 지정해준다.</p>
	<a href="/chapt05/register/hongkd/100">요청</a>

	<p>2) @RequestParam 어노테이션을 사용하여 특정한 HTML Form 의 필드명을 지정하여 요청을 처리한다.</p>
	<form action="/chapt05/register0201" method="post">
		userId: <input type="text" name="userId">
		password: <input type="text" name="password">
		coin: <input type="text" name="coin">
		<button>등록</button>
	</form> <br>
	
	<h4>3. 요청 처리 자바빈즈</h4>
	<hr>
	
	<p>1) 폼 텍스트 필드 요소값을 자바빈즈 매개변수로 기본 데이터 타입인 정수 타입 매개변수로 처리한다.</p>
	<form action="/chapt05/beans/register01" method="post">
		userId: <input type="text" name="userId">
		password: <input type="text" name="password">
		coin: <input type="text" name="coin">
		<button>요청하기</button>
	</form> <br>	

	<h4>4. Date타입 처리</h4>
	<hr>
	
	<p>1) 쿼리 파라미터(dateOfBirth=1234)로 전달받은 값은 Date 타입으로 데이터를 받을 수 있는가?</p>
	<a href="/chapt05/registerByGet01?userId=hongkd&dateOfBirth=1234"> 요청</a>
	
	<p>2) 쿼리 파라미터(dateOfBirth=2026-03-09)로 전달받은 값은 Date 타입으로 데이터를 받을 수 있는가?</p>
	<a href="/chapt05/registerByGet01?userId=hongkd&dateOfBirth=2026-03-09"> 요청</a>

	<p>3) 쿼리 파라미터(dateOfBirth=20260309)로 전달받은 값은 Date 타입으로 데이터를 받을 수 있는가?</p>
	<a href="/chapt05/registerByGet01?userId=hongkd&dateOfBirth=20260309"> 요청</a>

	<p>4) 쿼리 파라미터(dateOfBirth=2026/03/09)로 전달받은 값은 Date 타입으로 데이터를 받을 수 있는가?</p>
	<a href="/chapt05/registerByGet01?userId=hongkd&dateOfBirth=2026/03/09"> 요청</a>

	<p>5) 쿼리 파라미터(dateOfBirth)로 전달받은 값은 Member 객체를 이용한 Date 타입의 데이터를 받을 수 있는가?</p>
	<form action="/chapt05/registerByGet02" method="post">
		userId: <input type="text" name="userId">
		dateOfBirth: <input type="text" name="dataOfBirth">
		<button>요청하기</button>
	</form> <br>
	
	<h4>5. @DateTimeFormat 어노테이션</h4>
	<hr>
	
	<p>1) Member 매개변수와 폼 방식 요청 전달받은 값이 날짜 문자열 형식으로 설정 시, Date 타입으로 받는가?</p>
	<form action="/chapt05/registerByGet03" method="post">
		userId: <input type="text" name="userId">
		dateOfBirth: <input type="text" name="dateOfBirth">
		<button>요청하기</button>
	</form> <br>
	
	<h4>6. 폼 방식 요청 처리</h4>
	<hr>
	
	<p>1) 폼 텍스트 필드 요소값, 비밀번호 필드 요소값을 기본 자바빈즈 매개변수로 처리한다.</p>
	<form action="/chapt05/registerMemberuserId" method="post">
		userId : <input type="text" name="userId">
		password : <input type="password" name="password">
		<button>요청하기</button>
	</form> <br>
	
	<p>2) 폼 라디오 버튼 요소값을 기본 데이터 타입인 문자열 타입 매개변수로 처리한다.</p>
	<form action="/chapt05/registerRadio" method="post">
		<input type="radio" name="gender" value="male" checked="checked"> Male <br>
		<input type="radio" name="gender" value="male"> Female
		<input type="submit" value="요청하기"><br>
	</form><br>
	
	
	<p>3) 폼 셀렉트 박스 요소값을 기본 데이터 타입인 문자열 타입 매개변수로 처리한다.</p>
	<form action="/chapt05/registerSelect" method="post">
		nationality : <br>
		<select name="nationality">
			<option value="korea">대한민국</option>
			<option value="germany">독일</option>
			<option value="austrailia">호주</option>
			<option value="canada">캐나다</option>
			<option value="usa">미국</option>
		</select>
		<input type="submit" value="요청하기"><br>
	</form><br>
	
	<p>4) 복수 선택이 가능한 폼 셀렉트 박스 요소값을 기본 데이터 타입인 문자열 타입 매개변수, 문자열 배열 타입 매개변수, 문자열 요소를 가진 리스트 컬렉션 타입 매개변수로 처리한다.</p>
	
	<form action="/chapt05/registerMultiSelect01" method="post">
		cars : <br>
		<select name="cars" multiple="multiple">
			<option value="kia">KIA</option>
			<option value="bmw">BMW</option>
			<option value="audi">AUDI</option>
			<option value="volvo">VOLVO</option>
		</select><br>
		carArray : <br>
		<select name="carArray" multiple="multiple">
			<option value="kia">KIA</option>
			<option value="bmw">BMW</option>
			<option value="audi">AUDI</option>
			<option value="volvo">VOLVO</option>
		</select><br>
		carList : <br>
		<select name="carList" multiple="multiple">
			<option value="kia">KIA</option>
			<option value="bmw">BMW</option>
			<option value="audi">AUDI</option>
			<option value="volvo">VOLVO</option>
		</select>
		<input type="submit" value="요청하기"><br>
	</form><br>
	
	<p>5) 폼 체크박스 요소값을 기본 데이터 타입인 문자열 매개변수, 문자열 배열 타입 매개변수, 문자열 요소를 가진 리스트 컬렉션 타입 매개변수로 처리한다.</p>
	<form action="/chapt05/registerCheckbox01" method="post">
		hobby : <br>
		<input type="checkbox" name="hobby" value="sports"> Sport<br>
		<input type="checkbox" name="hobby" value="music"> Music<br>
		<input type="checkbox" name="hobby" value="movie"> Movie<br>
		hobbyArray : <br>
		<input type="checkbox" name="hobbyArray" value="sports"> Sport<br>
		<input type="checkbox" name="hobbyArray" value="music"> Music<br>
		<input type="checkbox" name="hobbyArray" value="movie"> Movie<br>
		hobbyList : <br>
		<input type="checkbox" name="hobbyList" value="sports"> Sport<br>
		<input type="checkbox" name="hobbyList" value="music"> Music<br>
		<input type="checkbox" name="hobbyList" value="movie"> Movie<br>
		<input type="submit" value="요청하기"><br>
	</form>	
	
	<p>6) 폼 체크박스 요소값을 기본 데이터 타입인 문자열 타입 매개변수, 불리언 타입 매개변수로 처리한다.</p>
	<form action="/chapt05/registerCheckbox04" method="post">
		developer : <br>
		<input type="checkbox" name="developer" value="Y"> <br>
		foreigner : <br>
		<input type="checkbox" name="foreigner" value="true"><br>
		<input type="submit" value="요청하기"><br>
	</form>
	
	<p>7) 폼 텍스트 필드 요소값을 중첩된 자바빈즈 매개변수로 처리한다.</p>
	<form action="/chapt05/registerUserAddress" method="post">
		postCode : <input type="text" name="address.postCode"><br>
		location : <input type="text" name="address.location"><br>
		<input type="submit" value="요청하기"><br>
	</form>
	
	<p>8) 폼 텍스트 필드 요소값을 중첩된 자바빈즈 매개변수로 처리한다.</p>
	<form action="/chapt05/registerUserCardList" method="post">
		카드1-번호 : <input type="text" name="cardList[0].no"><br>
		카드1-유효년월 : <input type="text" name="cardList[0].validMonth"><br>
		카드2-번호 : <input type="text" name="cardList[1].no"><br>
		카드2-유효년월 : <input type="text" name="cardList[1].validMonth"><br>
				<input type="submit" value="요청하기"><br>
	</form>
	
	<p>9) 폼 텍스트 영역 요소값을 기본 데이터 타입인 문자열 타입 매개변수로 처리한다.</p>
	<form action="/chapt05/registerTextArea" method="post">
		introduction : <br>
		<textarea rows="6" cols="50" name="introduction"></textarea>		
		<input type="submit" value="요청하기">
	</form>
	
	<h4>8. 파일 업로드 폼 방식 요청 처리</h4>
	<hr>
	
	<p>1) 파일 업로드 폼 파일 요소값과 텍스트 필드 요소값을 MultipartFile 매개변수와 자바빈즈 매개변수로 처리한다.</p>
	<form action="/chapt05/registerFile03" method="post" enctype="multipart/form-data">
		userId : <input type="text" name="userId"><br>
		password : <input type="text" name="password"><br>
		<input type="file" name="picture"><br>
		<input type="submit" value="요청하기"><br>
	</form>
	
	<p>2) 파일 업로드 폼 파일 요소값과 텍스트 필드 요소값을 FileMember 타입의 자바빈즈 매개변수로 처리한다.</p>
	<form action="/chapt05/registerFile04" method="post" enctype="multipart/form-data">
		userId : <input type="text" name="userId"><br>
		password : <input type="text" name="password"><br>
		<input type="file" name="picture"><br>
		<input type="submit" value="요청하기"><br>
	</form>

	<p>3) 여러개의 파일 업로드 폼 파일 요소값을 여러 개의 MultipartFile 매개변수로 처리한다.</p>
	<form action="/chapt05/registerFile05" method="post" enctype="multipart/form-data">
		userId : <input type="text" name="userId"><br>
		password : <input type="text" name="password"><br>
		<input type="file" name="picture"><br>
		<input type="file" name="picture2"><br>
		<input type="submit" value="요청하기"><br>
	</form>

	<p>4) 여러개의 파일 업로드 폼 파일 요소값을 MultipartFile 타입의 요소를 가진 리스트 컬렉션 타입 매개변수로 처리한다.</p>
	<form action="/chapt05/registerFile06" method="post" enctype="multipart/form-data">
		userId : <input type="text" name="userId"><br>
		password : <input type="text" name="password"><br>
		<input type="file" name="pictureList"><br>
		<input type="file" name="pictureList"><br>
		<input type="submit" value="요청하기"><br>
	</form>

	<p>5) 여러개의 파일 업로드 폼 파일 요소값과 텍스트 필드 요소값을 MultiFileMember 타입의 자바빈즈 매개변수로 처리한다.</p>
	<form action="/chapt05/registerFile07" method="post" enctype="multipart/form-data">
		userId : <input type="text" name="userId"><br>
		password : <input type="text" name="password"><br>
		<input type="file" name="pictureList[0]"><br>
		<input type="file" name="pictureList[1]"><br>
		<input type="submit" value="요청하기"><br>
	</form>

	<p>5) 번과 동일한 URL로 요청 진행.</p>
	<form action="/chapt05/registerFile07" method="post" enctype="multipart/form-data">
		userId : <input type="text" name="userId"><br>
		password : <input type="text" name="password"><br>
		<input type="file" name="pictureList" multiple="multiple"><br>
		<input type="submit" value="요청하기"><br>
	</form>
	
</body>
</html>
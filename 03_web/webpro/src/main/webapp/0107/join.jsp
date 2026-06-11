<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style type="text/css">
.container input[type="text"],input[type="date"],input[type=password]{
	width :200px;
}
.container input[type="button"]{
	margin-bottom: 5px;
}
#add1,#add2{
	width : 500px;
}
</style>
<script type="text/javascript" src="../js/memberJoin.js"></script>

</head>
<body>

<div class="container mt-3">
  <h2>회원가입</h2>
  <form id="ff">
  
    <div class="mb-3 mt-3">
      <label for="id">아이디:</label>
      <input type="button" value="중복검사" id="idcheck" class="btn btn-warning btn-sm">
      <input type="text" class="form-control" id="id" placeholder="Enter id" name="mem_id">
      <span id="idspan"></span>
    </div>
    <div class="mb-3">
      <label for="pass">Password:</label>
      <input type="password" class="form-control" id="pass" placeholder="Enter password" name="mem_pass">
    </div>
    <div class="mb-3 mt-3">
      <label for="name">이름:</label>
      <input type="text" class="form-control" id="name" placeholder="Enter name" name="mem_name">
    </div>
    <div class="mb-3 mt-3">
      <label for="zip"></label><br>
		<input type="button" onclick="" class="btn btn-warning btn-sm" value="우편번호 찾기" id="zipb"><br>
		<input type="text" class="form-control" id="zip" placeholder="Enter zip" name="mem_zip">
    </div>
    <div class="mb-3 mt-3">
      <label for="add1">주소:</label>
      <input type="text" class="form-control" id="add1" placeholder="Enter add" name="mem_add1">
    </div>
    <div class="mb-3 mt-3">
      <label for="add2">상세주소:</label>
      <input type="text" class="form-control" id="add2" placeholder="Enter add" name="mem_add2">
    </div>
    <div class="mb-3 mt-3">
      <label for="bir">생일:</label>
      <input type="date" class="form-control" id="bir" placeholder="Enter bir" name="mem_bir">
    </div>
    <div class="mb-3 mt-3">
      <label for="hp">전화번호:</label>
      <input type="text" class="form-control" id="hp" placeholder="Enter hp" name="mem_hp">
    </div>
    <div class="mb-3 mt-3">
      <label for="mail">메일주소:</label>
      <input type="text" class="form-control" id="mail" placeholder="Enter mail" name="mem_mail">
    </div>
    
    <button type="button" class="btn btn-primary btn-lg" id="send">가입하기</button>
    <span id="joinspan"></span>
  </form>
</div>


</body>
</html>
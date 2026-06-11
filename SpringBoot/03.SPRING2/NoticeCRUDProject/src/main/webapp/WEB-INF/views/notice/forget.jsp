<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./lModule/headerPart.jsp" %>
<body class="hold-transition">
	<div class="row mt-5">
		<h3 class="text-white">아이디 & 비밀번호 찾기</h3>
	</div>
	<div class="row mt-3">
		<div class="col-md-6">
			<div class="card card-outline card-primary">
				<div class="card-header text-center">
					<p class="h4">
						<b>아이디찾기</b>
					</p>
				</div>
				<div class="card-body">
					<p class="login-box-msg">아이디 찾기는 이메일, 이름을 입력하여 찾을 수 있습니다.</p>
					<form action="" method="post">
						<div class="input-group mb-3">
							<input type="text" class="form-control" name="" id="memEmail" placeholder="이메일을 입력해주세요.">
						</div>
						<div class="input-group mb-3">
							<input type="text" class="form-control" name="" id="memName" placeholder="이름을 입력해주세요.">
						</div>
						<div class="input-group mb-3">
							회원님의 아이디는 [<font id="id" color="red" class="h4"></font>] 입니다.
						</div>
						<div class="row">
							<div class="col-12">
								<button type="button" class="btn btn-primary btn-block" id="idFindBtn">아이디찾기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="card card-outline card-primary">
				<div class="card-header text-center">
					<p href="" class="h4">
						<b>비밀번호찾기</b>
					</p>
				</div>
				<div class="card-body">
					<p class="login-box-msg">비밀번호 찾기는 아이디, 이메일, 이름을 입력하여 찾을 수 있습니다.</p>
					<form action="" method="post">
						<div class="input-group mb-3">
							<input type="text" class="form-control" id="memId" name="" placeholder="아이디를 입력해주세요.">
						</div>
						<div class="input-group mb-3">
							<input type="text" class="form-control" id="memEmail2" name="" placeholder="이메일을 입력해주세요.">
						</div>
						<div class="input-group mb-3">
							<input type="text" class="form-control" id="memName2" name="" placeholder="이름을 입력해주세요.">
						</div>
						<div class="input-group mb-3">
							회원님의 비밀번호는 [<font id="pw" color="red" class="h4"></font>] 입니다.
						</div>
						<div class="row">
							<div class="col-12">
								<button type="button" class="btn btn-primary btn-block" id="pwFindBtn">비밀번호찾기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="col-md-12 mt-3">
			<div class="card card-outline card-secondary">
				<div class="card-header text-center">
					<h4>MAIN MENU</h4>
					<button type="button" class="btn btn-secondary btn-block" id="loginBtn">로그인</button>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="./lModule/footerPart.jsp" %>
</body>
<script type="text/javascript">
	let idFindBtn = $("#idFindBtn");
	let pwFindBtn = $("#pwFindBtn");
	let loginBtn = $("#loginBtn");
	
	idFindBtn.on("click",function(){
		let memEmail = $("#memEmail").val();
		let memName = $("#memName").val();
		
		if(memName == null || memName.trim() ==""){
			sweetAlert("error","이름을 입력해주세요!");
			return false;
		}
		if(memEmail == null || memEmail.trim() ==""){
			sweetAlert("error","이메일을 입력해주세요!");
			return false;
		}
		
		let data = {
				memEmail, memName
		}
		
		$.ajax({
			url : "/notice/idForget.do",
			type : "post",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(data),
			success : function(result){
				$("#id").html(result);
			},
			error : function(error,status,thrown){
				console.log(error);
				console.log(status);
				console.log(thrown);
				
				if(status == "error"){
					sweetAlert("error","정보가 일치하지 않거나 잘못된 요청입니다!");
					$("#id").html("잘못된 요청");
					}
				}
			})
			
		})
		
	pwFindBtn.on("click",function(){
		let memEmail = $("#memEmail2").val();
		let memName = $("#memName2").val();
		let memId = $("#memId").val();
		
		if(memId == null || memId.trim() ==""){
			sweetAlert("error","아이디를 입력해주세요!");
			return false;
		}
		if(memName == null || memName.trim() ==""){
			sweetAlert("error","이름을 입력해주세요!");
			return false;
		}
		if(memEmail == null || memEmail.trim() ==""){
			sweetAlert("error","이메일을 입력해주세요!");
			return false;
		}
		
		let data = {
				memEmail, memName, memId
		}
		
		$.ajax({
			url : "/notice/pwForget.do",
			type : "post",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(data),
			success : function(result){
				$("#pw").html(result);
			},
			error : function(error,status,thrown){
				console.log(error);
				console.log(status);
				console.log(thrown);
				
				if(status == "error"){
					sweetAlert("error","정보가 일치하지 않거나 잘못된 요청입니다!");
					$("#pw").html("잘못된 요청");
					}
			}
		
		})
		
	})


</script>
</html>

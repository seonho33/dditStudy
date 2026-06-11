<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ include file="./lModule/headerPart.jsp" %>
<body class="hold-transition ${bodyText }">
   <div class="register-box">
      <div class="card card-outline card-danger mt-4 mb-4" id="card-signup">
         <div class="card-header text-center">
            <a href="" class="h1"><b>DDIT</b>BOARD</a>
         </div>
         <div class="card-body">
            <p class="login-box-msg">회원가입</p>
            
            <form action="/notice/signup.do" method="post" id="signupForm" enctype="multipart/form-data">
               <div class="input-group mb-3 text-center">
                  <img class="profile-user-img img-fluid img-circle" id="profileImg"
                     src="/resources/dist/img/AdminLTELogo.png" alt="User profile picture"
                     style="width: 150px; height:150px; object-fit:cover;">
               </div>
               <div class="input-group mb-3">
                  <label for="inputDescription">프로필 이미지</label> 
               </div>
               <div class="input-group mb-3">
                  <div class="custom-file">
                     <input type="file" class="custom-file-input" name="imgFile" id="imgFile" multiple="multiple"> 
                     <label class="custom-file-label" for="imgFile">프로필 이미지를 선택해주세요</label>
                  </div>
               </div>
               <div class="input-group mb-3">
                  <label for="inputDescription">프로필 정보</label> 
               </div>
               <div class="input-group mb-3">
                  <input type="text" class="form-control" id="memId" name="memId" value="${member.memId }" placeholder="아이디를 입력해주세요"> 
                  <span class="input-group-append">
                     <button type="button" class="btn btn-secondary btn-flat" id="idCheckBtn">중복확인</button>
                  </span>
                  <span class="error invalid-feedback" style="display:block;">${errors.memId }</span>
               </div>
               <div class="input-group mb-3">
                  <input type="text" class="form-control" id="memPw" name="memPw" placeholder="비밀번호를 입력해주세요">
                  <span class="error invalid-feedback" style="display:block;">${errors.memPw }</span>
               </div>
               <div class="input-group mb-3">
                  <input type="text" class="form-control" id="memName" name="memName" value="${member.memName }" placeholder="이름을 입력해주세요">
                  <span class="error invalid-feedback" style="display:block;">${errors.memName }</span>
               </div>
               <div class="input-group mb-3">
                  <div class="form-group clearfix">
                     <div class="icheck-primary d-inline">
                        <input type="radio" id="memGenderM" name="memGender" value="M" checked="checked">
                        <label for="memGenderM">남자</label>
                     </div>
                     <div class="icheck-primary d-inline">
                        <input type="radio" id="memGenderF" name="memGender" value="F">
                        <label for="memGenderF">여자</label>
                     </div>
                  </div>
               </div>
               <div class="input-group mb-3">
                  <input type="text" class="form-control" id="memEmail" name="memEmail" placeholder="이메일을 입력해주세요">
               </div>
               <div class="input-group mb-3">
                  <input type="text" class="form-control" id="memPhone" name="memPhone" placeholder="전화번호를 입력해주세요">
               </div>
               <div class="input-group mb-3">
                  <input type="text" class="form-control" id="memPostcode" name="memPostcode"> 
                  <span class="input-group-append">
                     <button type="button" class="btn btn-secondary btn-flat" onclick="DaumPostcode()">우편번호 찾기</button>
                  </span>
               </div>
               <div class="input-group mb-3">
                  <input type="text" class="form-control" id="memAddress1" name="memAddress1" placeholder="주소를 입력해주세요">
               </div>
               <div class="input-group mb-3">
                  <input type="text" class="form-control" id="memAddress2" name="memAddress2" placeholder="상세주소를 입력해주세요">
               </div>
               <div class="input-group mb-3">
                  <div id="map" style="width:100%; height:300px; display:none;"></div>
               </div>
               <div class="row">
                  <div class="col-8">
                     <div class="icheck-primary">
                        <input type="checkbox" id="memAgree" name="memAgree" value="Y">
                        <label for="memAgree"> 개인정보 사용을 동의해주세요 <a href="#">개인정보방침</a></label>
                     </div>
                  </div>
                  <div class="col-4">
                     <button type="button" class="btn btn-dark btn-block" id="signupBtn">가입하기</button>
                  </div>
                  <button type="button" class="btn btn-secondary btn-block mt-4">뒤로가기</button>
               </div>
            </form>
         </div>
      </div>
   </div>

   <%@ include file="./lModule/footerPart.jsp" %>
</body>
<script src="//t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7900655c474b6d0cd386100dc626b777&libraries=services"></script>
<script type="text/javascript">
$(function(){
   
   // 정규표현식 유효성 검사 설정
   let regExpId = /^[a-z0-9]{4,12}$/; //아이디는 영소문자, 숫자 조합으로 4~12 설정
   let regExpPw = /^[^가-힣]{4,12}$/; // 비밀번호는 영소대문자, 숫자, 특수문자 조합으로 4~12자 설정
   let regExpName = /^[가-힣]{2,5}$/; // 이름은 한글로 2~5자 설정
   let memAddress2 = $("#memAddress2");
   let signupBtn = $("#signupBtn");
   let signupForm = $("#signupForm");
   let memIdForm = $("#memId");
   
   
   //프로필 이미지 선택 이벤트
   let imgFile = $("#imgFile");
   let idCheckBtn = $("#idCheckBtn");
   let error = $(".error");   //error 메세지 출력 class
   let idCheckFlag = false;   //중복확인 flag(true: 중복체크완료, false: 중복체크 미완료!)
   
	memIdForm.on("change",function(){
        let err = $(".error")[0];
		idCheckFlag = false;
        $(err).html("");
	});
   
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
   
   //아이디 중복확인 버튼 이벤트
   idCheckBtn.on("click",function(){
      console.log("아이디 중복확인 클릭...!");
      
      let memId = $("#memId").val();
      
      if(memId == null || memId == ""){
         sweetAlert("error", "아이디를 입력해주세요!");
         return false;
      }else{
         if(!regExpId.test(memId)){
            error.eq(0).html("아이디는 영소문자,숫자 조합으로 4~12자 입력해주세요!");
            return false;
         }
      }
      
      // 아이디 중복체크 진행
      $.ajax({
         url : "/notice/idCheck.do",
         type : "post",
         data : JSON.stringify({memId : memId}),
         contentType: "application/json;charset=utf-8",
         success : function(result){
            // Client > Server 아이디 전송 (아이디 사용여부를 확인)
            // EXIST , NOTEXIST (EXIST : 이미 사용중인 아이디, NOTEXIST : 사용 가능한 아이디)
            let err = $(".error")[0];
            if(result == "NOTEXIST"){
               sweetAlert("success", "사용 가능한 아이디입니다!");
               $(err).html("사용 가능한 아이디입니다!").css("color","green");
               idCheckFlag = true; //중복확인 완료
            }else{
               sweetAlert("error", "이미 사용중인 아이디입니다!");
               $(err).html("이미 사용중인 아이디입니다!").css("color","red");
               idCheckFlag = false; //중복확인 미완료
            }
         },
         error: function(error, status, thrown){
            console.log(error);
            console.log(status);
            console.log(thrown);
         }
      })
   });
   
   memAddress2.focusout(function(){
      let address1 = $("#memAddress1").val();
      let address2 = $("#memAddress2").val();
      
      if( address1 != null || address1 != ""){
         var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
         mapContainer.style.display ="block";
          mapOption = {
              center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
              level: 3 // 지도의 확대 레벨
          };  

      // 지도를 생성합니다    
      var map = new kakao.maps.Map(mapContainer, mapOption); 

      // 주소-좌표 변환 객체를 생성합니다
      var geocoder = new kakao.maps.services.Geocoder();

      // 주소로 좌표를 검색합니다
      geocoder.addressSearch(address1 + " " + address2 , function(result, status) {

          // 정상적으로 검색이 완료됐으면 
           if (status === kakao.maps.services.Status.OK) {

              var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

              // 결과값으로 받은 위치를 마커로 표시합니다
              var marker = new kakao.maps.Marker({
                  map: map,
                  position: coords
              });

              // 인포윈도우로 장소에 대한 설명을 표시합니다
              var infowindow = new kakao.maps.InfoWindow({
                  content: '<div style="width:150px;text-align:center;padding:6px 0;">HOME</div>'
              });
              infowindow.open(map, marker);

              // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
              map.setCenter(coords);
          } 
      });   
      
      $("#card-signup").css("top", "140px");
      
      }
   });
   
   //회원가입 버튼 이벤트
   signupBtn.on("click",function(){
	   let memFile = $("#imgFile")[0].files[0];	// 프로필 사진 데이터
	   let memId = $("#memId").val();
	   let memPw = $("#memPw").val();
	   let memName = $("#memName").val();
	   let memPostcode = $("#memPostcode").val();
	   let memAddress1 = $("#memAddress1").val();
	   let agreeFlag = true;	// 개인정보 동의 flag(체크 : true, 해제 : false)
	   
	   for(let i = 1; i<error.length; i++){
		   error.eq(i).html("");
	   }
	   
	   if(memFile == null || memFile.size == 0){
		   sweetAlert("error","프로필 이미지를 선택해 주세요!");
		   return false;
	   }
	   
	   if(isBlank(memId)){
		   sweetAlert("error","아이디를 입력해 주세요")
	   }else{
		   if(!regExpId.test(memId)){
			   error.eq(0).html("아이디는 영소문자, 숫자 조합으로 4~12자 입력해주세요").css("color","red");
			   return false;
		   }
	   }
	   
	   if(isBlank(memPw)){
		   sweetAlert("error","비밀번호를 입력해주세요!")
		   return false;
	   }else{
		   if(!regExpId.test(memPw)){
			   sweetAlert("error","비밀번호 양식을 지켜주십시오");
			   error.eq(1).html("비밀번호는 영소문자, 숫자 조합으로 4~12자 입력해주세요").css("color","red");
			   return false;
		   }
	   }
	   
	   if(isBlank(memName)){
		   sweetAlert("error","이름을 입력해주세요!")
		   return false;
	   }else{
		   if(!regExpId.test(memPw)){
			   error.eq(2).html("이름은 한글로 2~5자 입력해주세요!").css("color","red");
			   return false;
		   }
	   }
	   
	   if(isBlank(memPostcode)){
		   sweetAlert("error","우편번호를 입력해주세요!")
		   return false;
	   }
	   
	   if(isBlank(memAddress1)){
		   sweetAlert("error","기본주소를 입력해주세요!")
		   return false;
	   }
	   
	   //개인정보 동의 검증
	   let memAgree = $("#memAgree").is(":checked");
	   if(!memAgree){
		   agreeFlag=false;
	   }
	   
	   if(agreeFlag){
		   if(idCheckFlag){
			   signupForm.submit();
		   }else{
			   sweetAlert("error","아이디 중복체크를 해주세요!");
		   }
	   }else{
		   sweetAlert("error","개인정보 동의를 체크해주세요")
	   }
	   
   })
   
});

// 이미지 파일인지 체크
function isImageFile(file){
   let ext = file.name.split(".").pop().toLowerCase(); //파일명에서 확장자를 가져온다
   return ($.inArray(ext,["jpg","jpeg","png","gif"])=== -1)? false : true

}



function DaumPostcode() {
    new kakao.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }


            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('memPostcode').value = data.zonecode;
            document.getElementById("memAddress1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("memAddress2").focus();
        }
    }).open();
}

function isBlank(name){
	return (name==null||name.trim()=="");
}

function isNotBlank(name){
	return !(name==null||name.trim()=="");
}


</script>
</html>

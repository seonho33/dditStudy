/**
 * 
 */

const insertMember = async (url,head,data) =>{
	
	const res = await fetch(url,{
		method:"post",
		headers:head,
		body:data
	})
	const result = await res.json();
	console.log(result);
	document.querySelector("#joinspan").innerHTML = result['flag'];
	if(result['flag']=="가입성공"){
		document.querySelector("#joinspan").style.color = "blue";
		alert("가입성공")
	}else{
		document.querySelector("#joinspan").style.color = "red";
		alert("가입실패")
	}
}

window.onload = () =>{
	
	//가입하기 버튼 클릭
	document.querySelector("#send").addEventListener('click',function(){

		vff = document.querySelector("#ff");
		vfd = new FormData(vff);
		console.log(vfd);
		
		fdata = Object.fromEntries(vfd); //{mem_id:idVale, ...,k : v}
		console.log(fdata);
		
		//서버로 전송
		fdata = JSON.stringify(fdata);
		fhead = {"Content-type" : "application/json;charset=utf-8"}
		url = "http://localhost/webpro/InsertMember.do"
		
		insertMember(url,fhead,fdata)
		
	})
	
	
	
	//우편번호 찾기- 번호검색버튼
	document.querySelector("#zipb").addEventListener('click',function(){
		window.open("zipSerch.jsp","우편번호","width=500 height =400 top=100 left=200")
	})
		
	
	//입력 데이터 검증 체크 - text 항복의 이벤트를 줌
	idText = document.querySelector("#id");
	idText.addEventListener('keyup',function(){
		
		//입력한 id값
		vid=document.querySelector("#id").value.trim();
		
		//입력규칙 - 정규식
		idReg = /^[a-z][a-zA-Z0-9]{3,7}$/
		
		//입력한 id값이 규칙에 맞는지 안맞는지 체크 test는 true or false를 반환함
		if(idReg.test(vid)){
			idText.style.border = "3px solid blue";
			btnId.disabled =false;	//활성화
		}else{
			idText.style.border = "3px solid red";
			btnId.disabled =true;	//비활성화
		}
	})
	
	
	
	//아이디 중복검사 버튼
	btnId = document.querySelector("#idcheck");
	
	//btnId.onclick = () =>{}
	btnId.addEventListener('click', ()=>{
		
		//입력한 값 가져오기
		idValue = document.querySelector("#id").value.trim();
		
		if(idValue.length < 1){
			alert("아이디를 입력하세요")
			return;
		}
/*		
		//서버전송
		fetch("http://localhost/webpro/CheckId.do?id="+idValue)
		.then(res =>{
			return res.json();
		})
		.then(data=>{
			console.log(data)
		})
		.catch(err =>{
			console.log(err);
		})
*/

		btnIdPro();
		
	})
}	//window.onload

btnIdPro = async() =>{
	try{
	//서버전송
	const res = await fetch("http://localhost/webpro/CheckId.do?id="+idValue);
	
	const data = await res.json();
	console.log(data);
	
	document.querySelector("#idspan").innerHTML = data['flag'];
	if(data['flag']=="사용가능"){
		document.querySelector("#idspan").style.color = "blue";
		idText.style.border = "3px solid blue";
		
	}else{
		document.querySelector("#idspan").style.color = "red";
		idText.style.border = "3px solid red";
	}
	}catch(err){
		console.log(err);
	}
}

function sample6_execDaumPostcode() {
    new daum.Postcode({
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

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}

/*
<input type="text" id="sample4_postcode" placeholder="우편번호">
<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
<input type="text" id="sample4_roadAddress" placeholder="도로명주소">
<input type="text" id="sample4_jibunAddress" placeholder="지번주소">
<span id="guide" style="color:#999;display:none"></span>
<input type="text" id="sample4_detailAddress" placeholder="상세주소">
<input type="text" id="sample4_extraAddress" placeholder="참고항목">

*/
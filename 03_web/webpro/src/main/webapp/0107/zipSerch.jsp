<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
.ziptr:hover{
	cursor: pointer;
}
</style>
<script type="text/javascript">

//jsp에서는 ${}는 특별한 기능이 있다 = el태그
//jsp에서는 백틱으로 사용하는 템플릿 리터럴을 \${}로 표현해야함..
//el태그를 비활성화 시키기위해서 isELIgnored="false"를 기술해야함

//검색결과에서 한줄을 선택한다
//ziptr검색- 이벤트 핸들러 작성
//실행중에 새롭게 생긴 요소는 위임방식으로 처리한다
window.onload =()=>{
	res = document.querySelector("#result")
	res.addEventListener('click',function(ev){
		console.log(ev.target.closest(".ziptr"));
	
		vtr = ev.target.closest(".ziptr");
		
		vtd= vtr.children;	//모든 자식 가져오기 - HTMLCollection으로 리턴함(유사배열)
		//vtd[0] .. vtd[1]...
		
		//arrtd = [...vtd];	//펼침문법을 이용해서 유사배열 vtd를 배열로 바꾼다
		arrtd = Array.from(vtd);	//Array 객체를 이용해서 유사배열 vtd를 배열로 변환
		
		zip = arrtd[0].innerText;
		addr = arrtd[1].innerText;
		
		//부모창에
		opener.document.querySelector("#zip").value = zip;
		opener.document.querySelector("#add1").value = addr;
		
		window.close();
	})
}

const zipSearch = () =>{
	//입력한 동 이름 가져오기
	dongValue = document.querySelector("#dong").value.trim();
	
	if(dongValue.length<1){
		alert("동 이름을 입력하세요.")
		return;
	}
	
	//서버전송
	dongPro();
	
}

const dongPro = async () =>{
	
	try {
	//서블릿->service->dao->mapper,db
	//mapper -> dao -> service ->controller ->view ->async await
	const res = await fetch("http://localhost/webpro/DongSelect.do?dong=" + dongValue);
	
	//역직렬화 서버에서 받은 데이터를 script 객체로 변환
	const datas = await res.json();
	
	let code = `<table border='1' class="table table-dark table-hover">
				<tr><td>우편번호</td>
					<td>주소</td>
					<td>번지</td></tr>`;
	
	datas.forEach(data=>{
		//bunji가 undefined일 경우 공백으로 처리	
		//null 병합 연산자 or if문 이용...
		
		code +=`<tr class="ziptr"><td>${data['zipcode']}</td>
					<td>${data['sido']}${data['gugun']}${data['dong']}</td>
					<td>${data['bunji']??""}</td></tr>`
		
	})
	code += "</table>";
	
	document.querySelector("#result").innerHTML = code;
	
	console.log(datas);
	
	} catch (e) {
		console.log(e)
	}
}

</script>

</head>
<body>
	<form>
		<h3>우편번호 찾기</h3>
		동이름 입력
		<input type="text" id="dong" class="form-control">
		<input type="button" value="검색" onclick="zipSearch()" class="btn btn-warning btn-sm">
	</form>
	<div id="result"></div>

</body>
</html>
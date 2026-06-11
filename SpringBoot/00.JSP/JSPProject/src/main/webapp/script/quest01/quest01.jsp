<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital">SCRIPT TEST - Quest01</h1>
			<p class="services_text">스크립트 이벤트를 활용해 문제를 해결할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<h5 class="ddit_chapter">스크립트 첫번째 문제!</h5>
						<p class="ddit_text pt-3 pb-2">테이블 각 영역을 클릭했을 때, 해당 공간에 입력된 텍스트를 결과 출력란에 출력해주세요.</p>
						<table class="table table-bordered table-hover" width="100%">
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
							<tr>
								<td>10</td>
								<td>네이버웍스 비정기 업데이트 소식</td>
								<td>관리자</td>
								<td>2022-11-16</td>
								<td>1455</td>
							</tr>
							<tr>
								<td>9</td>
								<td>네이버웍스 일부 기능의 사양 변경 및 종료 안내</td>
								<td>관리자</td>
								<td>2022-11-15</td>
								<td>234</td>
							</tr>
							<tr>
								<td>8</td>
								<td>[프로모션 공지] 네이버웍스 X 워크플레이스 결합 서비스 신규 가입 20%추가 할인(~12.31)</td>
								<td>관리자</td>
								<td>2022-11-14</td>
								<td>23444</td>
							</tr>
							<tr>
								<td>7</td>
								<td>[중요] 네이버웍스 V3.5 정기 업데이트 소식</td>
								<td>관리자</td>
								<td>2022-11-13</td>
								<td>12466</td>
							</tr>
							<tr>
								<td>6</td>
								<td>[프로모션 사전 공지] 네이버웍스 X 워크플레이스 결합 서비스 20% 추가 할인</td>
								<td>관리자</td>
								<td>2022-11-12</td>
								<td>111</td>
							</tr>
							<tr>
								<td>5</td>
								<td>드라이브 서비스 DB 업그레이드 작업 사전 안내</td>
								<td>관리자</td>
								<td>2022-11-11</td>
								<td style="color: ">2233</td>
							</tr>
						</table>
						<div class="col-md-12 stretch-card grid-margin">
							<div class="card">
								<div class="card-body">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="checkbox" id="chk" value="Y"> 
										<label class="form-check-label" for="chk">append 여부</label>
									</div>
									<h6>선택한 td안에 있는 글자를 아래 출력란에 출력해주세요!</h6>
									<p id="output" class="ddit_text text-danger" style="color: red">출력란</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
<script type="text/javascript">
$(function(){
	
	let td = $("td");
	let elem = null;	// 클릭한 td element 저장소
	let html = "";		// td에 단일 출력인지 append 출력인지에 따라 text저장소
	let disp = $("#output");
	let chk = $("#chk");
	
	//append 여부 체크박스가 변경되었을 때
	chk.on("change",function(){
		html="";	//초기화
	});
	
	//td 를 눌렀을 때 이벤트 작성
	td.on("click",function(){
		console.log("td click!");
		elem = $(this);	// 여기서 this는 내가 클릭한 td element
		// 체크 됐을때는 'Y'가 넘어온다. 
		let chkVal = $("#chk:checked").val();
		if(chkVal == 'Y'){	//append 여부 체크 O
			html += elem.text() + "<br/>";
			
		}else{	//append 여부 체크 X
			html = "";
			//텍스트를 핸들링 하기위한 p태그 설정
			html += "<p class='ddit_text' id='p'>"+elem.text()+"</p>";
			html += "<button class='ddit_btn ddit_btn_outline_warning' id='udtBtn'>수정</button>";
			html += "<button class='ddit_btn ddit_btn_outline_danger' id='delBtn'>삭제</button>";
		}
		disp.html(html);
		// 1. td영역 안에있는 텍스트를 가져온다
		
		// 2. 가져온 텍스트를 하위에 버튼 2개를 생성한다.
		
		// 3. 가져온 텍스트와 생성한 버튼이 출력란에 출력된다.
		
	});
	
	disp.on("click","#udtBtn",function(){
		console.log("udtBtn Click..!");
		
		let text = $(this).text();	// 수정 버튼 text
		
		//최초의 수정버튼 text는 '수정' 버튼, 그런데 이후에 수정버튼을 누르면
		// '수정' 텍스트가 '확인' 텍스트로 변경됨
		 if(text=="수정"){
			 //출력란에 적혀있는 텍스트를 가져온다.
			 let pText = disp.find("#p").text();
			 //input type='text'의 형태로 변경하고 value를 pText의 값으로 설정한다.
			 disp.find("#p").html("<input type'text' class='form-control' id='pText' value='"+pText+"'/>")
			 $(this).text("확인");	//버튼 텍스트를 수정에서 확인으로 변경
		 }else{	//확인버튼을 클릭했을 때 동작
			 // input 입력 요소에 value인 text를 가져와서 p태그에 출력
			 // output 공간에 p태그로 구성된 element 요소안이 input 으로 구성되어 있었는데
			 // input value 의 값을 꺼내서 output 공간에 p태그에 일반적인 text로 변경
			disp.find("#p").html(disp.find("#pText").val());
		 	//수정된 텍스트가 있는 p태그 내의 텍스트를 가져와 td요소를 클릭 했을 때 담아놨던 element 에 출력한다.
		 	elem.html(disp.find("#p").text());
			 
			 $(this).text("수정");
			 
			 html="";//담아놨던 텍스트 초기화
		 }
	});

	disp.on("click","#delBtn",function(){
		console.log("delBtn Click..!");
		
		disp.find("#p").html("");	// 출력된 p태그 초기화
		elem.html("");				// 선택된 elemnet 초기화
		
	});
	
});

/* 
//자바 스크립트 형태로 변환
//output 엘리멘트 안에 동적으로 만들어진 버튼(udtBtn,delBtn)을 클릭했을 때 이벤트 생성
disp.addEventListener("click",function(ev){
	if(ev.target && ev.target.id == "udtBtn"){
		let udtBtn 	= ev.target;
		let text 	= udtBtn.textContent;
	}
	
	if(ev.target && ev.target.id =="delBtn"){
		//
		disp.innerText = "";
	}
});
*/

</script>
</html>
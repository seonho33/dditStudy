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
			<h1 class="services_taital">SCRIPT TEST - Quest02</h1>
			<p class="services_text">스크립트 이벤트를 활용해 문제를 해결할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<h5 class="ddit_chapter">스크립트 두번째 문제!</h5>
						<p class="ddit_text pt-3 pb-2">
							각 학생들의 자리를 서로 바꿔주세요. 첫번째 학생을 선택했을 때 선택된 영역을 확인할 수 있도록 배경색을 변경해주세요.<br/>
							두번째 학생을 선택했을 때 첫번째 학생과 자리를 변경 후, 선택된 학생들의 내역을 출력해주세요.
						</p>
						<caption>앞(SEM PC 자리)</caption>
						<table class="table table-bordered" style="text-align:center; font-size:24px;">
							<tr height="80px">
								<td width="10%"></td>
								<td width="10%">정준하</td>
								<td width="10%">노홍철</td>
								<td width="10%">박나래</td>
								<td width="20%"></td>
								<td width="10%">전현무</td>
								<td width="10%">유재석</td>
								<td width="10%">길성준</td>
								<td width="10%">하하</td>
							</tr>
							<tr height="80px">
								<td>김연아</td>
								<td>김희선</td>
								<td>손연재</td>
								<td>박명수</td>
								<td></td>
								<td>아이유</td>
								<td>홍길동</td>
								<td>홍길순</td>
								<td>김철수</td>
							</tr>
							<tr height="80px">
								<td>데프콘</td>
								<td>강호동</td>
								<td>이승기</td>
								<td>박상민</td>
								<td></td>
								<td>김영철</td>
								<td>서장훈</td>
								<td>민경훈</td>
								<td></td>
							</tr>
							<tr height="80px">
								<td>도선호</td>
								<td>대장금</td>
								<td>홍해인</td>
								<td>백현우</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
						
						<h5 class="ddit_chapter">History : <span id="process"></span></h5>
						<p class="ddit_text pt-3 pb-2"></p>
						<button type="button" class="ddit_btn ddit_btn_outline_primary" id="clickBtn">출력</button>
						<div class="row pt-3">
							<h5 class="ddit_chapter">결과</h5>
							<div class="col-md-12 pt-3" id="output"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
<script type="text/javascript">

$(function(){

	let td = $("td");			//elements 설정
	let elem = null;			//선택된 Element 를 담을 공간
	let output = $("#output");	// 현재 바뀐 자리가 출력될 공간
	let clickBtn = $("#clickBtn");	// 출력 실행버튼
	let disp = $("#process");	//출력창

	let first = null;			//elementBox
	let text = "";				//nameBox
	let check =false;
	
	td.on("click",function(){
		
		let html="";
		elem = $(this);
		
		if(elem.text()==null||elem.text()==""){
			if(first){
			first.css("background-color", "");
			first=null;
			}
			text="";
			check=false;
			html="<p class='ddit_text' id='p' style='color : red'>빈 공간은 선택할 수 없습니다!</p>"
			disp.html(html);
			return false;
		}
		
		if(!check){
		
			first = elem;
			text = elem.text();
			
			html +="<p class='ddit_text' id='p'>"+elem.text()+"님과<p>";
			elem.css("background-color", "yellow");
			
			check=true;
			
		}else{
			html += "<p class='ddit_text' id='p'>"+text+"님과 "+elem.text()+"님을 변경합니다<p>";
			
			first.html(elem.text());
			elem.html(text);

			first.css("background-color", "");
			
			check=false;
		}
		disp.html(html);
	
	});
	
	//출력 버튼 클릭시(현재 앉은 자리 출력 위한 이벤트)
	clickBtn.on("click",function(){
		output.html("");
		let tds = document.getElementsByTagName("td");
		
		let html = "<table class='table table-bordered' style='text-align:center; font-size:24px;'><tr>";
		//index를 1부터 시작이므로 길이만큼 같은 조건으로 반복문을 돌리고 td요소를 가져올 때는
		//1부터 시작하므로 0 부터 시작할수 있는 index의 계산법으로 한다.
		for(let i=1; i<tds.length;i++){
			if(tds[i-1].innerText=="도선호"){
				html +="<td width='10%'><marquee><font color='blue'>"+ 
						tds[i-1].innerText +"</font></marquee></td>";
			}else{
				html +="<td width='10%'>" + tds[i-1].innerText + "</td>";
			}
			
			if(i%9==0&&i<tds.length){
				html += "</tr><tr>"
			}
		}
		html +="</tr></table>";
		output.html(html);
	});


})
/* 		td.on("click",function(){
		
		elem = $(this);
		
		if(elem.text()==null||elem.text()==""){
			html="";
			first=null;
			text="";
			check=false;
			html="<p class='ddit_text' id='p' style='color : red'>빈 공간은 선택할 수 없습니다!</p>"
			disp.html(html);
		}else{
			html="";
			if(!check){
			console.log("td click!",elem.text());
			html += elem.text()+"님과 ";
			disp.html("<p class='ddit_text' id='p'>"+html+"<p>");
			first = elem;
			text = elem.text();
			
			check=true;
			
			}else{
			html += elem.text()+"님을 변경합니다";
			disp.html("<p class='ddit_text' id='p'>"+html+"<p>");
			html = "";
			
			first.html(elem.text());
			elem.html(text);
			
			check=false;
			}
		}
	}); */
</script>
</body>
</html>
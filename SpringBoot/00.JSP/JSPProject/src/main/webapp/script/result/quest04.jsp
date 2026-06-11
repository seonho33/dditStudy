<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	
	<!-- 선정 후 출력할 Modal -->
	<div class="modal fade" tabindex="-1" role="dialog" id="result-modal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">결과!!</h5>
				</div>
				<div class="modal-body text-center" style="padding:20px 20px 20px 20px">
					<font color="red" style="font-size:24px;">너로 정했다!! 🎉🎉🎉</font><br/>
					<h5>문제를 풀어볼까요?</h5>
					<h3 id="result-name"></h3>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital">SCRIPT TEST - Quest04</h1>
			<p class="services_text">스크립트 이벤트를 활용해 문제를 해결할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<h5 class="ddit_chapter">스크립트 네번째 문제!</h5>
						<p class="ddit_text pt-3 pb-2">진행률이 100% 되는동안 랜덤하게 학생이 선정되고 선정된 학생을 표시합니다.</p>
						<div class="content-left wow fadeInLeft" data-wow-delay=".3s">
							<div class="table-responsive">
								<caption>앞(SEM PC 자리)</caption>
								<table class="table table-bordered text-center" style="font-size:24px;">
									<tr height="80px">
										<td width="12%">임영은</td>
										<td width="12%"></td>
										<td width="12%">신동근</td>
										<td width="12%">박성현</td>
										<td width="4%"></td>
										<td width="12%"></td>
										<td width="12%"></td>
										<td width="12%">이은휴</td>
										<td width="12%">임효비</td>
									</tr>
									<tr height="80px">
										<td>김수정</td>
										<td>빈다예</td>
										<td></td>
										<td>이혜진</td>
										<td></td>
										<td>김데레사</td>
										<td>하지수</td>
										<td>김서현</td>
										<td></td>
									</tr>
									<tr height="80px">
										<td></td>
										<td>이지은</td>
										<td>김현진</td>
										<td>이나리</td>
										<td></td>
										<td>김경희</td>
										<td>강지현</td>
										<td>박시은</td>
										<td>김진솔</td>
									</tr>
									<tr height="80px">
										<td></td>
										<td>윤여범</td>
										<td>김준혁</td>
										<td>한이혜지</td>
										<td></td>
										<td>김미선</td>
										<td>장우석</td>
										<td></td>
										<td></td>
									</tr>
								</table>
								<hr/>
								<div class="progress" style="height: 40px;">
									<div class="progress-bar progress-bar-striped" id="myBar" role="progressbar" aria-valuenow="60" aria-valuemin="0"
										aria-valuemax="100" style="width: 1px; height: 40px;">
										<span class="sr-only">60% Complete</span>
									</div>
								</div>
								<br/>
								<h4 id="txt" style="font-size: 16px;"></h4>
								<button type="button" onclick="SeatMoveEvent()" style="padding:12px;border:none;cursor:pointer;">출력</button>
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
//학생 랜덤 추첨기 만들어보기
//var i = 0;
var myArray = [
	"임영은",	"신동근",	"박성현",	"이은휴",	"임효비",	"김수정",	"빈다예",	"이혜진",	"김데레사",
	"하지수",	"김서현",	"이지은",	"김현진",	"이나리",	"김경희",	"강지현",	"박시은",	"김진솔",
	"윤여범",	"김준혁",	"한이혜지","김미선","장우석"
];

var cnt = 0;		// myArray에서 이름을 꺼낼때 사용하는 index
var seat = 0;		// show를 위한 index(td에 index를 배정할 때)
var myBar;			// 프로그래스바 Element
var seatMove;		// interval 이벤트 변수(시작, 중지를 위함)
var width = 0;		// 프로그래스바 %길이

var td = $("td");	// 자리에 해당하는 td
var txt = $("#txt");// 진행 내용

// 자리 이동 이벤트
function SeatMoveEvent() {
	myBar = document.getElementById("myBar");
	seatMove = setInterval(move, 200);
}

// 이동 이벤트
function move() {
	td.css("background-color", "white");	// 처음에 선택된 자리를 흰색으로 초기화
	if (width >= 100) {	// 프로그레스바 100% 도달!(show는 끝났어 이제 결과 출력해!)
		cnt = Math.floor(Math.random() * myArray.length);	// 0~학생 수
		// 학생 이름이 들어있는 배열 공간에서 결정된 index 값을 넣어 선택된 학생의 이름 꺼내기
		txt.html(myArray[cnt]);	// 결과 출력
		
		var tds = document.getElementsByTagName("td");	// 자리 전부 가져오기
		
		// 자리들 중, 해당 index와 일치하는 자리를 노란색 배경으로 바꾼다.
		// 그래야 랜덤으로 선정하는 효과처럼 보이기 때문에
		for(var j = 0; j < tds.length; j++){
			if(tds[j].innerText == myArray[cnt]){	// 테이블 td의 이름과 이름집합 배열의 이름이 같을때
				tds[j].style.backgroundColor = "yellow";	// 최종 선택된 학생의 이름에 노란색 보여
			}
		}
		
		// 자리 선정되었으니까 자리 이동 이벤트 중지!
		clearInterval(seatMove);	// setInterval 이벤트 종료
		width = 0;				// 프로그래스바 0% 초기화
		myBar = null;			// 프로그래스바 Element 초기화
		seatMove = null;		// 이벤트 초기화
		
		// 모달에 결과 출력하기
		$("#result-name").html(myArray[cnt] + "님!");
		$("#result-modal").modal("show");
	} else {	// 프로그레스바가 100%를 달성하기까지의 show
		// Math.floor : 반올림하여 주어진 숫자보다 작거나 같은 가장 큰 정수
		seat = Math.floor(Math.random() * 36);	// 0~자리 수
		
		console.log(cnt + " : " + seat);
		// 랜덤으로 선정된 자리 번호를 td들 중 일치하는 td요소의 스타일 변경
		$("td:eq("+seat+")").css("background-color", "yellow");
		
		// 프로그레스바 증가
		width++;	
		myBar.style.width = width + "%";
		myBar.innerHTML = width + "%";
		
		// 프로그래스바 증가에 따른 진행 현황 출력
		if(width == 10)
			txt.html("※ Creating system logs.");
		if(width == 12)
			txt.html("※ A system log is being created.");
		if(width == 14)
			txt.html("※ We are in the process of setting up system log output.");
		if(width == 16)
			txt.html("※ Setting up for system log output...");
		if(width == 18)
			txt.html("※ System log output settings completed");
		if(width == 20)
			txt.html("※ The system is selecting students.");
		if(width == 22)
			txt.html("※ The system is placing students.");
		if(width == 24)
			txt.html("※ Positions are being selected based on the students placed.");
		if(width == 26)
			txt.html("※ After selecting seats, we are mapping the classes and preparing to relocate students after mapping is completed.");
		if(width == 52)
			txt.html("※ Once placement is complete, students will be verified.");
		if(width == 54)
			txt.html("※ Verification complete!");
		if(width == 56)
			txt.html("※ The system is setting a random function");
		if(width == 58)
			txt.html("※ The system is testing by outputting random numbers based on a random function.");
		if(width == 60)
			txt.html("※ Test completed!");
		if(width == 65)
			txt.html("※ 시스템 설정 및 학생 배치가 완료 되었습니다! ");
		if(width == 70)
			txt.html("※ 시스템에서 배정한 랜덤 시스템을 가동중입니다....!");
		if(width == 80)
			txt.html("※ 랜덤 시스템이 학생을 선정하였습니다!");
		if(width == 90)
			txt.html("※ 선정된 학생을 출력 하기 위해 준비중입니다!");
		if(width == 95)
			txt.html("※ 시스템 안정화중...!");
	}
}
</script>
</html>
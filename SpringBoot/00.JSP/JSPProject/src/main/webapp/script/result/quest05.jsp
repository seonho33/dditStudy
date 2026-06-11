<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>
<style>
.pc td {
	height: 100px;
	padding-top: 24px;
}
</style>
<body>
	<%@ include file="/module/header2.jsp"%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital">SCRIPT TEST - Quest05</h1>
			<p class="services_text">스크립트 이벤트를 활용해 문제를 해결할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<!-- 
							피시방 사장이 되어, 손님을 받는다.
							1) 손님이 이용할 PC를 선택하고 이름, 이용시간을 설정 후 등록을 진행한다.
								> 이때, 이용 시간으로 설정되어 있는 시간만큼 타이머가 해당 PC자리에 설정된다.
								> 실시간 이용 시간은 해당 PC자리인 td 요소에 출력한다.
							2) 이용중인 PC를 종료 버튼을 클릭 하면 타이머가 설정되어 있는 PC가 종료되고
								아래 매출현황에 이용시간 만큼의 매출이 기록된다.
								> 이용 시간에 따른 매출 내용은 'resTbody'에 출력한다.
							
							*** 손님을 받을 때마다 PC 이용 현황판은 이용 시간만큼 타이머가 동시에 동작해야한다.
						 -->
						<h5 class="ddit_chapter">스크립트 다섯번째 문제!</h5>
						<p class="ddit_text pt-3 pb-2">PC방 사장님이 되어 손님을 받아주세요.</p>
					</div>
					<div class="col-md-4">
						<div class="card">
							<div class="card-header"></div>
							<div class="card-body">
								<table class="table table-bordered">
									<tr>
										<td width="30%">PC번호</td>
										<td id="pcNo">PC를 선택해주세요.</td>
									</tr>
									<tr>
										<td>이름</td>
										<td id="pcUser"><input type="text" class="form-control" id="userName"/></td>
									</tr>
									<tr>
										<td>시간</td>
										<td id="pcTime"><input type="number" class="form-control" id="useTime" min="1" max="12"/></td>
									</tr>
								</table>
								<p class="ddit_text2" id="selectPc"></p>
							</div>
							<div class="card-footer">
								<button type="button" class="ddit_btn ddit_btn_outline_primary" id="addBtn">등록</button>
							</div>
						</div>
					</div>
					<div class="col-md-8">
						<table class="table table-bordered pc">
							<tr align="center">
								<td data-ord="1">PC-1</td>
								<td data-ord="2">PC-2</td>
								<td data-ord="3">PC-3</td>
								<td data-ord="4">PC-4</td>
								<td data-ord="5">PC-5</td>
								<td data-ord="6">PC-6</td>
								<td data-ord="7">PC-7</td>
								<td data-ord="8">PC-8</td>
							</tr>
							<tr align="center">
								<td data-ord="9">PC-9</td>
								<td data-ord="10">PC-10</td>
								<td data-ord="11">PC-11</td>
								<td data-ord="12">PC-12</td>
								<td data-ord="13">PC-13</td>
								<td data-ord="14">PC-14</td>
								<td data-ord="15">PC-15</td>
								<td data-ord="16">PC-16</td>
							</tr>
							<tr align="center">
								<td data-ord="17">PC-17</td>
								<td data-ord="18">PC-18</td>
								<td data-ord="19">PC-19</td>
								<td data-ord="20">PC-20</td>
								<td data-ord="21">PC-21</td>
								<td data-ord="22">PC-22</td>
								<td data-ord="23">PC-23</td>
								<td data-ord="24">PC-24</td>
							</tr>
							<tr align="center">
								<td data-ord="25">PC-25</td>
								<td data-ord="26">PC-26</td>
								<td data-ord="27">PC-27</td>
								<td data-ord="28">PC-28</td>
								<td data-ord="29">PC-29</td>
								<td data-ord="30">PC-30</td>
								<td data-ord="31">PC-31</td>
								<td data-ord="32">PC-32</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4">
						<div class="card">
							<div class="card-header">이용 안내</div>
							<div class="card-body">
								<ul>
									<li>1시간 이용 시 1,000원 입니다.</li>
									<li>이용 후, 의자를 꼭 넣어주세요.</li>
									<li>화장실은 입구 오른쪽 끝입니다.</li>
									<li>각 흡연실, 비흡연실 구역이 나뉘어져있습니다.</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-md-8">
						<div class="card">
							<div class="card-header">매출 현황</div>
							<div class="card-body">
								<table class="table table-bordered">
									<thead>
										<tr>
											<th>번호</th>
											<th>PC 번호</th>
											<th>이용 시간</th>
											<th>금액</th>
										</tr>
									</thead>
									<tbody id="resTbody">
									</tbody>
								</table>
							</div>
							<div class="card-footer">
								<h5>총 매출 : <font id="total"></font></h5>
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
	let selectPc = $("#selectPc");	// pc 선택 시 출력할 내역 영역
	var addBtn = $("#addBtn");	// 등록 버튼
	var close = $(".close");	// 종료 버튼
	var resTbody = $("#resTbody");	// 매출 집계 tBody
	var usePcArray = [];	// 사용중인 PC 목록
	var ord = 0;
	var selectEle = null;
	var ordCnt = 1;	// 매출 현황 순서
	var totalArr = [];
	var totalCnt = 0;
	
	$(".pc").on("click", "td", function(){
		// pc 선택 시, 선택 영역을 알 수 있도록 배경 색을 snow로 설정했는데 설정된 배경색 초기화
		$(".pc").find("td").css("background-color", "white");
		selectEle = $(this);
		ord = $(this).data("ord");
		var classNames = $(this).prop("class");
		if(classNames.includes("use")){	// 현재 사용중
			var usePc = usePcArray[ord-1];
		}else{	// 미 사용중
			$("#pcNo").text("PC-"+ord);
		}
		selectPc.text(selectEle.text() + "가 선택되었습니다!");
		selectEle.css("background-color", "skyblue");
	});
	
	addBtn.on("click", function(){
		var userName = $("#userName").val();
		var useTime = $("#useTime").val();

		// PC 선택 시 들어간 색깔 초기화
		$(".pc").find("td").css("background-color", "white");
		// 선택 시 내역 출력 초기화
		selectPc.text("");
		
		if(selectEle == null){
			alert("PC를 선택해주세요!");
			$("#userName").select();
			return;
		}
		
		if(userName == null || userName == ""){
			alert("이름을 입력해주세요!");
			return false;
		}
		
		if(useTime == null || useTime == ""){
			alert("시간을 입력해주세요!");
			return false;
		}
		
		if(useTime > 12){
			useTime = 12;
		}
		
		var useTime = parseInt(useTime) * 60 * 60;
		var data = {
			pcUser : userName,
			pcTime : useTime,
			pcUseTime : useTime
		};
		
		usePcArray[ord-1] = data;
		selectEle.addClass("use");
		selectEle.css("background-color", "snow");
	});
	
	$(".pc").on("click", ".close", function(){
		var html = "";
		var pcOrd = $(this).parent().data("ord");	// 종료한 PC번호
		console.log($(this).parent().data("ord"));
		if(confirm("PC-"+pcOrd + " 종료 하시겠습니까?")){
			html += "<tr>";
			html += "	<td>"+(ordCnt++)+"</td>";
			html += "	<td>PC-"+pcOrd+"</td>";
			html += "	<td>"+Math.floor(usePcArray[pcOrd-1].pcTime / 3600)+"시간</td>";
			html += "	<td>"+(Math.floor(usePcArray[pcOrd-1].pcTime / 3600) * 1000)+"원</td>";
			html += "</tr>";
			resTbody.append(html);
			
			$("td[data-ord='"+pcOrd+"']").html("PC-"+pcOrd).css("background-color", "white");
			totalArr[totalCnt++] = (Math.floor(usePcArray[pcOrd-1].pcTime / 3600) * 1000);
			usePcArray[pcOrd - 1] = null;
			
			total(totalArr);
		}
	});
	
	setInterval(() => {
		for (var i = 0; i < 32; i++) {
			if(usePcArray[i] != null){
				var html = "<p>PC-"+(i+1)+"</p>";
				html += "<p>";
				html += usePcArray[i].pcUser + "<br/>";
				var pTime = usePcArray[i].pcUseTime;
				html += flowTime(pTime);
				usePcArray[i].pcUseTime = pTime - 1;
				html += "</p>";
				html += "<button class='ddit_btn btn-sm ddit_btn_outline_danger close'>종료</button>"
				$(".pc td:eq("+i+")").html(html);
			}
		}
	}, 1000);
});

function total(totalData){
	let sum = 0;
	console.log(totalData);
	for(let i = 0; i < totalData.length; i++){
		sum += totalData[i];
	}
	$("#total").html(sum+"원");
}

function flowTime(time){
	var timeStr = "";
	h = Math.floor(time / 3600);
	var ts = time % 3600;
	m = Math.floor(ts / 60);
	s = Math.floor(ts % 60);
	s = s < 10 ? "0" + s : s;
	timeStr = h+":"+m+":"+s;
	return timeStr
}
</script>
</html>
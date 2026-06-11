<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital">SCRIPT TEST - Quest03</h1>
			<p class="services_text">스크립트 이벤트를 활용해 문제를 해결할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<!-- 내용을 입력해주세요 -->
						<%
							request.setCharacterEncoding("UTF-8");
							String dataArr = request.getParameter("dataArr");
							String countArr = request.getParameter("countArr");
							
							String[] datas = dataArr.split(",");
							String[] counts = countArr.split(",");
						%>
						<c:set value="<%=datas %>" var="datas"/>
						<c:set value="<%=counts %>" var="counts"/>
						
						<div class="row">
							<div class="col-md-4">
								<div class="card">
									<div class="card-header card-primary">
										주문표
									</div>
									<div class="card-body">
										<table class="table table-bordered">
											<tr>
												<th>음료</th>
												<th>가격</th>
												<th>수량</th>
											</tr>
											<c:set value="0" var="total"/>
											<c:forEach items="${datas }" var="data" varStatus="vs">
												<tr>
													<td>${fn:split(data,"_")[0] }</td>
													<td>${fn:split(data,"_")[1] }</td>
													<td>${counts[vs.index] }</td>
												</tr>
												<c:set value="${total + (fn:split(data, '_')[1] * counts[vs.index]) }" var="total"/>
											</c:forEach>
											<tr>
												<td></td>
												<td colspan="2">total : ${total }</td>
											</tr>
										</table>
									</div>
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
	// 카페 포스기기 만들어보기
	// 포스 메뉴판을 보고 메뉴를 추가하여 주문한 내역과 금액을 출력해보자
	var dataArr = new Array();	// 주문시 음료를 저장할 배열 공간
	var countArr = new Array();	// 주문시 저장한 음료의 카운트 수 배열 공간
	
	// elements 설정
	var td = $("td");
	var orderTable = $("#order-table");
	var total = $("#total");		// 총 금액
	var frm = $("#frm");			// 주문 완료 후, 전송하기 위한 Form
	var orderBtn = $("#orderBtn");	// 주문하기 버튼
	var dArr = $("#dArr");			// 데이터 배열 저장 공간
	var cArr = $("#cArr");			// 음료 카운트 배열
	
	td.on("click", function(){
		var price = 0;				// 금액
		var dataFlag = false;		// 음료 주문 여부
		var html = "";
		var orderMenu = $(this).find("p").text();
		var orderPrice = $(this).find("code").text();
		
		if(orderMenu == ""){
			alert("빈 공간은 주문할 수 없습니다!");
			return false;
		}
		
		if(dataArr.length == 0){	// 음료를 저장할 공간이 0일때
			dataArr.push(orderMenu + "_" + orderPrice);	// 주문명_금액으로 배열에 넣는다
			countArr.push(1);
		}else{						// 이미 저장된 데이터가 있을 때
			// 음료를 저장하기 위한 dataArr 길이 만큼 반복문을 돌린다
			// 같은 음료를 주문할 시 새로운 공간에 데이터를 추가하는게 아니라 
			// 같은 음료의 카운트를 증가시킨다.
			for(var i = 0; i < dataArr.length; i++){
				if(orderMenu == dataArr[i].split("_")[0]){
					countArr[i]++;		// 주문한 음료 순번의 카운트 증가
					dataFlag = true;	// 주문한 음료가 있을때 flag 변경(스위칭)
					break;
				}else{
					countArr.push(1);
				}
			}
			if(dataFlag == false){	// 새로운 주문 시
				dataArr.push(orderMenu + "_" + orderPrice);
			}
		}
		
		// 주문표를 dataArr길이만큼 다시 초기화해준다
		for(var i = 0; i < dataArr.length; i++){
			html += "<tr class='menu'>";
			html += "	<td style='font-size:9px;'>";
			html += "		" + dataArr[i].split("_")[0];
			html += "	</td>";
			html += "	<td style='font-size:9px;'>";
			html += "		" + countArr[i];
			html += "	</td>";
			html += "	<td style='font-size:9px;'>";
			html += "		" + dataArr[i].split("_")[1]
			html += "	원</td>";
			html += "</tr>";
			price += parseInt(dataArr[i].split("_")[1]) * countArr[i];
		}
		
		orderTable.html(html);
		total.html(price);
	});
	
	orderBtn.on("click", function(){
		dArr.val(dataArr);
		cArr.val(countArr);
		frm.submit();
	});
});
</script>
</html>
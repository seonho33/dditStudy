<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>Remove</h2>
	<form action="/item2/modify" method="post" id="item">
		<input type="hidden" name="itemId" value="${item.itemId }">
		<table>
			<tr>
				<td>상품명</td>
				<td>
					<input type="text" name="itemName" value=${item.itemName } disabled="disabled">
				</td>
			</tr>
			<tr>
				<td>가격</td>
				<td>
					<input type="text" name="price" value="${item.price }" disabled="disabled">
				</td>
			</tr>
			<tr>
				<td>파일</td>
				<td>
					<div class="uploadedList" ></div>
				</td>
			</tr>
			<tr>
				<td>개요</td>
				<td>
					<textarea rows="10" cols="30" name="description" disabled="disabled">${item.description }</textarea>
				</td>
			</tr>
		</table>
		<div>
			<button type="submit" id="remove">remove</button>
			<button type="button" id="listBtn" onclick="javascript:location.href='/item2/list'">List</button>
		</div>
	</form>
</body>
<script type="text/javascript">
$(function(){
	let itemId = "${item.itemId}";

	// 페이지가 로드되면서 동시에 uploadedList 영역에 비동기로 업로드한 파일 목록을 출력
	$.getJSON("/item2/getAttach/" + itemId, function(list){
		$(list).each(function(){
			let data = this;	// 서버로부터 전송받은 목록안에 들어있는 업로드 경로 포함 + 파일명!
			
			let str = "";
			if(checkImageType(data)){
				str = "<div>";
				str += "	<a href='/item2/displayFile?fileName=" + data + "'>";
				str += "	<img src='/item2/displayFile?fileName="
							+getThumbnailName(data)+"' target='_blank'/>";
				str += "	</a>";
				str += "</div>";
			}else{
				str = "<div>";
				str += "	<a href='/item2/displayFile?fileName="+data+"'>";
				str += "		"+ getOriginalName(data);
				str += "	</a>";
				str += "</div>";
			}
			$(".uploadedList").append(str);
		})
	});
	
		// 이미지 파일인지 확인
		function checkImageType(fileName){
			let pattern = /jpg|gif|png|jpeg/i;
			return fileName.match(pattern);	// 패턴과 일치하면 ture (너 이미지구나?)
		}
		
		// 임시 파일로 썸네일 이미지 만들기
		function getThumbnailName(fileName){
			let front = fileName.substr(0,12);	// /2026/03/20 폴더
			let end = fileName.substr(12);		// 뒤 파일명
			
			console.log("front : " + front);
			console.log("end : " + end);
			
			return front + "s_" + end;
		}
		
		//
		function getOriginalName(fileName){
			if(checkImageType(fileName)){
				return;
			}
			let idx = fileName.indexOf("_")+1;
			return fileName.substr(idx);
		}

})

</script>
</html>
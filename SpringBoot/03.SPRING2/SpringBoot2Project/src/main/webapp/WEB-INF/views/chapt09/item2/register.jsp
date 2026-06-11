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
	<h2>Register</h2>
	<form action="/item2/register" method="post" enctype="multipart/form-data" id="item">
		<table>
			<tr>
				<td>상품명</td>
				<td>
					<input type="text" name="itemName">
				</td>
			</tr>
			<tr>
				<td>가격</td>
				<td>
					<input type="text" name="price">
				</td>
			</tr>
			<tr>
				<td>파일</td>
				<td>
					<input type="file" id="inputFile">
					<div class="uploadedList" id="dataArea"></div>
				</td>
			</tr>
			<tr>
				<td>개요</td>
				<td>
					<textarea rows="10" cols="30" name="description"></textarea>
				</td>
			</tr>
		</table>
		<div>
			<button type="submit" id="registerBtn">Register</button>
			<button type="button" id="listBtn" onclick="javascript:location.href='/item2/list'">List</button>
		</div>
	</form>
</body>
<script type="text/javascript">
$(function(){
	let inputFile = $("#inputFile");
	let item = $("#item");
	
	item.submit(function(){
		let that = $(this);
		let str = "";
		let lists = $(".uploadedList a");
		if(lists.length>0){
			$(".uploadedList a").each(function(index){
				let value = $(this).attr("href");
				value = value.substr(28);		//?fileName='다음에 오는 값
						
				str += "<input type ='hidden' name='files[" + index + "]' value='"+ value +"'>";
			});
			
			that.append(str);
		}else{
			alert("파일 1개이상 업로드 해주세요");
			return false
		}
	})
	
	// Open File 을 통해 파일을 선택 했을 때,
	inputFile.on("change",function(ev){
		console.log("inputFile 실행!",inputFile);
		
		let files = ev.target.files;	//event.target!
		let file = files[0];			//내가 선택한 파일 1개
		
		let formData = new FormData();
		formData.append("file",file);
		
		$.ajax({
			url : "/item2/uploadFile",
			type : "post",
			contentType : false,
			processData : false,
			data : formData,
			dataType : "text",
			success : function(data){
				console.log("ajaXXX 데이타넘어옴! daga : ",data)
				
				let str = "";
				if(checkImageType(data)){
					str = "<div>";
					str += "	<a href='/item2/displayFile?fileName="+encodeURIComponent(data)+"'>";
					str += "	<img src='/item2/displayFile?fileName="
								+encodeURIComponent(getThumbnailName(data))+"' target='_blank'/>";
					str += "	</a>";
					str += "	<span style='border:1px solid black'>X</span>";
					str += "</div>";
				}else{
					str = "<div>";
					str += "	<a href='/item2/displayFile?fileName="+encodeURIComponent(data)+"'>";
					str += "		"+ getOriginalName(data);
					str += "	</a>";
					str += "	<span style='border:1px solid black'>X</span>";
					str += "</div>";
				}
				$(".uploadedList").append(str);
			},
			error: function(error,status,thrown){
				console.log(error);
				console.log(status);
				console.log(thrown);
			}
		})
		// 'X' 버튼 이벤트
		$(".uploadedList").on("click","span",function(){
			$(this).parent("div").remove();
		})
		
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

})

</script>
</html>
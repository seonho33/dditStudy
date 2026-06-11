<%@page contentType="text/html; charset=UTF-8"  language="java" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>File Upload 예제</title>
</head>

<body>

    <h3>서블릿3부터 지원하는 Part 인터페이스를 이용한 파일업로드</h3>
    <form method="post" action="/ServletTest/upload.do" enctype="multipart/form-data">
        파일선택: <input type="file" name="uploadFile"/>
        전송자: <input type="text" name="sender">
        <button id = "btnSubmit" type="button" value="Upload">전송버튼</button>
    </form>
    
<script type="text/javascript">
window.onload = () =>{
	document.querySelector("#btnSubmit").addEventListener('click',(ev)=>{
		
		const fileInput = document.querySelector("input[name=uploadFile]");
		
		const formData = new FormData();
		formData.append('uploadFile',fileInput.files[0]);
		formData.append('sender',document.querySelector("input[name=sender]").value);
		
		const options = {
			method : 'POST',
			body: formData
		};
		
		fetch('upload.do',options)
			.then((resp)=>{
				if(!resp.ok){
					throw new Error(`http Error! Status : ${resp.status}`)
				}
				
				return resp.text();
				
			})
			.then((resp)=>{
				console.log(resp);
			});
	});		
}
    
</script>
    
</body>
</html>
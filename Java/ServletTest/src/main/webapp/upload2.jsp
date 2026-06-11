<%@page contentType="text/html; charset=UTF-8"  language="java" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>File Upload 예제</title>
</head>

<body>
   <h3>아파치 자카르타 프로젝트의 fileupload 모듈을 이용한 파일업로드</h3>
    <form method="post" action="upload2" enctype="multipart/form-data">
        파일선택: <input type="file" name="uploadFile" multiple="multiple"/>
        전송자: <input type="text" name="sender">
        수신자: <input type="text" name="receiver">
        <input type="submit" value="Upload"/>

    </form>
    
    <script type="text/javascript">
    	// 파일이 변경될 경우에 선택한 파일정보 가져오기
    	const fileEl = document.querySelector("input[name=uploadFile]");
    	fileEl.addEventListener('change', fileSelected, false);
    	function fileSelected(){
    		console.log('파일정보', fileEl.files[0]);
    	}
    	
    </script>

    <br>
    <hr>

    <h3>서블릿3부터 지원하는 Part 인터페이스를 이용한 파일업로드</h3>
    <form method="post" action="/ServletTest/upload.do" enctype="multipart/form-data">
        파일선택: <input type="file" name="multiPartServlet"/>
        전송자: <input type="text" name="sender">
        <input type="submit" value="Upload"/>
    </form>
</body>
</html>
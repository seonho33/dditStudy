<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>학생 등록 폼</title>
</head>
<body>
    <h2>👩‍🎓 학생 정보 입력하기</h2>
    
    <!-- 
    요청URI : /student/insert
    요청파라미터 : request{stuName=홍길동,stuAge=20,stuMajor=컴퓨터공학과}
    요청방식 : post
     -->
    <form action="/student/insert" method="post">
        
        <p>
            이름 : <input type="text" name="stuName" placeholder="홍길동" required>
        </p>
        <p>
            나이 : <input type="number" name="stuAge" placeholder="20" required>
        </p>
        <p>
            전공 : <input type="text" name="stuMajor" placeholder="컴퓨터공학과">
        </p>
        
        <button type="submit">서버로 데이터 전송하기 (Submit!)</button>
        
    </form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>등록 결과</title>
</head>
<body>
    <h2>🎉 학생 등록이 완료되었습니다!</h2>
    
    <ul>
        <li>등록된 이름: <b>${std.stuName}</b></li>
        <li>등록된 나이: <b>${std.stuAge}</b> 세</li>
        <li>등록된 전공: <b>${std.stuMajor}</b></li>
    </ul>

    <a href="/student/form">돌아가기</a>
</body>
</html>
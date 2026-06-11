<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록</title>
</head>
<body>
	<!-- 
	요청URI : /ServletExam/products/insert.do
	요청파라미터 : request{pid=P001,pname=개똥이,price=1200}
	요청방식 : post
	-->
	<form action="<%=request.getContextPath() %>/products/insert.do" 
	method="post">
		<table border="1">
	        <tr>
	            <td>상품 ID:</td>
	            <td><input type="text" name="pid" placeholder="P001" required /></td>
	        </tr>
	        <tr>
	            <td>상품명:</td>
	            <td><input type="text" name="pname" required /></td>
	        </tr>
	        <tr>
	            <td>가격:</td>
	            <td><input type="number" name="price" value="0" /></td>
	        </tr>
	    </table>
	    <input type="submit" value="상품 등록">
	</form>
</body>
</html>
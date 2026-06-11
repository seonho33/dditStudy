<%@page import="kr.or.ddit.index.IndexRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<%@ include file="/module/headPart.jsp"%>
</head>

<body>
	<%@ include file="/module/header2.jsp"%>
	
	<div class="services_section layout_padding">
		<div class="container">
			<h1 class="services_taital"><%=IndexRepository.getChapter("CH06")%></h1>
			<p class="services_text">각 쳅터별 내용을 확인할 수 있습니다.</p>
			<div class="services_section_2">
				<div class="row">
					<div class="col-md-12">
						<form action="form03_process.jsp" name="member" method="post">
							아이디 :  <input type="text" id="id" name="id"/>
									<input type="button" value="중복확인"><br/>
							비밀번호 :	<input type="password" id="pw" name="pw"/><br/>
							이름 :	<input type="text"	 id="name" name="name"><br/>
							연락처 :	<select name="phone1">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="019">019</option>
									</select> -
								   <input type="text" id="phone2" name="phone2" maxlength="4" size="4"/>-
								   <input type="text" id="phone3" name="phone3" maxlength="4" size="4"/><br/>
							성별 :	<input type="radio" id="gender" name="gender" value="M"checked="checked"> 남자
								   <input type="radio" id="gender2" name="gender" value="G"/>여자<br/>
							취미 : <input type="checkbox" id="hobby1" name="hobby1" checked="checked"/>독서
								<input type="checkbox" id="hobby2" name="hobby2"/>운동
								<input type="checkbox" id="hobby3" name="hobby3"/>영화감상<br/>
							자기소개 : <textarea rows="10" cols="50" name="comment" wrap="hard"></textarea><br/>
							<input type="submit" value="전송">
							<input type="reset" value="초기화">
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/module/footer.jsp"%>
	<%@ include file="/module/footerPart.jsp"%>
	
</body>
</html>
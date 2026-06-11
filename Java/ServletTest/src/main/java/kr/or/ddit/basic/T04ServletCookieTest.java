package kr.or.ddit.basic;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class T04ServletCookieTest extends HttpServlet{
	
	/*
	쿠키정보를 다루기 위한 예제..stateless를 극복하기위해..
	(웹 서버와 브라우저는 애플리케이션이 사용되는 동안 필요한 정보를 쿠키를 통해 공유하여 상태를 유지함.)
	
	1. 구성요소
	  - 이름
	  - 값
	  - 유효시간(초)
	  - 도메인 : ex) www.somehost.com, .somehost.com
	  - 경로 : 쿠키를 공유할 기준경로
	  
	2. 동작방식
	  - 쿠키생성단계 : 생성한 쿠키를 응답메시지의 헤더에 저장하여 브라우저에 전송한다.
	  - 쿠키저장단계 : 브라우저는 응답헤더에 포함된 쿠키정보를 쿠키저장소에 보관한다.
	  - 쿠키전송단계 : 브라우저는 저장한 쿠키정보를 요청이 있을 때마다 웹 서버에 전송한다.
	  			   웹 서버는 이 쿠키정보를 사용하여 필요한 작업을 수행한다.
	  
	 */

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//setCookieExam(req, resp);	//	쿠키정보 생성 예제
		//readCookieExam(req,resp);	//	쿠키정보 읽기 예제
		deleteCookieExam(req,resp);	//	쿠키정보 삭제 예제
		
	}
	
	private void deleteCookieExam(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	/*	
		사용중인 쿠키정보를 삭제하는 방법...
		
		1. 사용중인 쿠키정보를 가져온다. => getCookes() 메서드 이용
		2. 쿠키 객체의 최대 지속시간을 0으로 설정한다.
		3. 설정한 쿠키객체를 응답헤더에 추가하여 전송한다.
	*/	
		
		//////////////////////////////////////////////
		
		Cookie[] cookies = req.getCookies();
		
		/////////////////////////////////////////////
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html");
		
		PrintWriter out = resp.getWriter();
		String title = "쿠키정보 삭제 예제";
		
		out.print("<!DOCTYPE html><html><head><title>" + title
				  + "</title></head>"
				  + "<body>"
				);
		if(cookies !=null) {
			out.print("<h2>" + title + "</h2>");
			
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("userId")) {
					// 쿠키삭제 처리하기
					cookie.setMaxAge(0);
					resp.addCookie(cookie);
					
					out.print("<p>삭제한 쿠키 : " + cookie.getName() + "</p>");
				}else {
				out.print("<p>name : " + cookie.getName() + "</p>");
				out.print("<p>value : " + URLDecoder.decode(cookie.getValue(),"UTF-8") + "</p>");
				out.print("<hr>");}
			}
		}else {
			out.print("<h2> 쿠키정보가 없습니다. </h2>");
		}
		out.print("</body></html>");
	}

	private void readCookieExam(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		Cookie[] cookies = req.getCookies();
		
		/////////////////////////////////////
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html");
		
		PrintWriter out = resp.getWriter();
		String title = "쿠키정보 읽기 예제";
		
		out.print("<!DOCTYPE html><html><head><title>" + title
				  + "</title></head>"
				  + "<body>"
				);
		if(cookies !=null) {
			out.print("<h2>" + title + "</h2>");
			
			for(Cookie cookie : cookies) {
				out.print("<p>name : " + cookie.getName() + "</p>");
				out.print("<p>value : " + URLDecoder.decode(cookie.getValue(),"UTF-8") + "</p>");
				out.print("<hr>");
			}
		}else {
			out.print("<h2> 쿠키정보가 없습니다. </h2>");
		}
		out.print("</body></html>");
	}

	private void setCookieExam(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		// 쿠키 생성하기
		Cookie userId =
				new Cookie("userId", req.getParameter("userId"));
		// 쿠키값에 한글을 사용시 인코딩 처리를 해준다.
		Cookie name = new Cookie("name", URLEncoder.encode(req.getParameter("name"),"UTF-8"));
	
		// 쿠키 소멸시간 설정(초단위) => 지정하지 않으면 브라우저 종료할 때
		//						   쿠키정보가 삭제처리 됨.
		userId.setMaxAge(60*60*24);	// 24시간동안 유효
		userId.setHttpOnly(true);	// javaScript를 통한 접근 금지
									// (XSS 공격 대비)
		
		name.setMaxAge(60*60*48);	// 48시간동안 유효
		
		///////////////////////////////////////////////////
		
		// 응답헤더에 쿠키 정보 추가하기
		resp.addCookie(userId);
		resp.addCookie(name);
		
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html");
		
		PrintWriter out = resp.getWriter();
		
		String title = "쿠키설정 예제";
		
		out.print("<!DOCTYPE html><html><head><title>" + title
				+ "</title></head>"
				+ "<body>"
				+ "<h1 align=\"center\">" + title + "</h1>"
				+ "<ul>"
				+ "<li><b>ID</b>: "
				+ req.getParameter("userId") + "</li>"
				+ "<li><b>이름</b>: "
				+ req.getParameter("name") + "</li>"
				+ "</ul>"
				+ "</body>"
				+ "</html>"
				);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req,resp);
	}
}

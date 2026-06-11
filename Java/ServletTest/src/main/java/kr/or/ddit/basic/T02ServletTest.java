package kr.or.ddit.basic;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class T02ServletTest extends HttpServlet {
/*
 	서블릿 동작 방식에 대하여...
 	
 1. 클라이언트가 URL을 통해 HTTP 요청메세지를 서블릿 컨테이너로 전송한다.
 
 2. 서블릿 컨테이너는 web.xml에 정의된 url패턴 정보를 확인하여 어떤 서블릿을 통해
 	서비스를 제공할지를 검색한다.(로딩이 안된 경우에는 생성하여 로딩함. 로딩시 init()메서드 호출됨..)
 	
 3. 서블릿 컨테이너는 요청을 처리할 개별 스레드 객체를 생성하여 해당 서블릿 객체의
 	service() 메서드를 호출한다.
 	(이때 HttpServletRequest 및 HttpServletResponse 객체를 생성하여 넘겨준다.)
 	
 4. service() 메서드는 메서드타입을 체크하여 적절한 메서드를 호출한다.
 	(doGet, doPost, doPut, doDelete 등)
 	
 5. 요청 처리가 완료되면(요청에 대한 응답처리가 끝나면) HttpServeltRequest 및 HttpServletResponse 객체는 소멸된다.
 
 6. 컨테이너로부터 서블릿이 제거되는 경우에는 제거되기 전 destoroy() 메서드가 호출된다.
 	
 get방식? -url치기,a태그?
 	
 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// Requsest 객체의 주요 메서드 호출하기
		System.out.println("getCharacterEncoding() : " + req.getCharacterEncoding());
		System.out.println("getContentLength() : " + req.getContentLength());
		System.out.println("getQueryString() : " + req.getQueryString());
		System.out.println("getProtocol() : " + req.getProtocol());
		System.out.println("getMethod() : " + req.getMethod());
		System.out.println("getRequestURI() : " + req.getRequestURI());	//프로젝트이름/url패턴
		System.out.println("getRemoteAddr() : " + req.getRemoteAddr());	
		System.out.println("getRemotePort() : " + req.getRemotePort());
			
		/////////////////////////////////
		
		// Post방식으로 넘어오는 Body 데이터를 처리할 인코딩 정보 설정하기
		// req.setCharacterEncoding("UTF-8");
		
		String name = req.getParameter("name");
		System.out.println("name => " + name);
		
		// 요청객체 정보 저장하기
		req.setAttribute("tel", "5555-6666");
		req.setAttribute("addr", "대전시 중구 오류동");
		
		// 요청객체 정보 꺼내기
		System.out.println(req.getAttribute("tel"));
		System.out.println(req.getAttribute("addr"));
		
		////////////////////////////////////
		//응답 메시지 생성하기
		
		//응답 메시지 인코딩 정보 설정
		//(Content-type: 의 ;charset=UTF-8 로 세팅하는것)
		resp.setCharacterEncoding("UTF-8");
		
		//응답 메시지의 컨텐트 타입 설정
		resp.setContentType("text/plain");
		
		PrintWriter out = resp.getWriter();
		
		out.println("name => " + name);
		out.println("addr => " + req.getAttribute("addr"));
		out.println("tel => " + req.getAttribute("tel"));
		
		out.println("(서블릿)컨텍스트 경로 => " + req.getContextPath());
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		doGet(req, resp);
	}
}

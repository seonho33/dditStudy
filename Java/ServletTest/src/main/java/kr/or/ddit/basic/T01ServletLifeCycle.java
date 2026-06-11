package kr.or.ddit.basic;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class T01ServletLifeCycle extends HttpServlet {
	
	public T01ServletLifeCycle() {
		System.out.println("T01ServletLifeCycle 생성자 호출됨");
	}
	
	@Override
	public void init() throws ServletException {
		// 초기화 코드 작성...
		System.out.println("init() 메서드 호출됨");
	}
	
	@Override
	protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
		
		// 실제적인 요청에 대한 작업이 수행되는 지점...(일종의 main()메서드 역할)
		
		System.out.println("service() 메서드 호출됨");
		
		super.service(arg0, arg1);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 메서드 방식이 GET 방식인 경우 호출됨...
		
		System.out.println("doGet() 호출됨.");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 메서드 방식이 POST 방식인 경우 호출됨...
		
		System.out.println("doPost() 메서드 호출됨.");
	}
	
	@Override
	public void destroy() {
		// 객체 소멸시(컨테이너로부터 서블릿 객체 제거시) 필요한 코드 작성...
		System.out.println("destory() 메서드 호출됨.");
		
	}
}

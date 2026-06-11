package kr.or.ddit.basic;

import java.io.IOException;
import java.util.Date;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

public class T07ServletFilter implements Filter{
	/*
		서블릿 필터에 대하여...
		
		1. 사용 목적
		- 클라이언트의 요청을 수행하기 전에 요청을 가로채 필요한 작업을 수행할 수 있다.
		- 클라이언트에 응답정보를 제공하기 전에 응답을 가로채 필요한 작업을 수행할 수 있다.
		
		2. 사용 예
		-. 인증 필터
		-. 데이터 압축 필터
		-. 인코딩 필터
		-. 로깅 및 감사처리 필터
		-. 이미지 변환 필터 등
		
	*/	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// 초기화 관련 기능 작성....
		System.out.println("[T07ServletFilter] init() 호출됨.");
	}
	
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain fc)
			throws IOException, ServletException {
		System.out.println("[T07ServletFilter] doFilter() 시작.");
		
		// 클라이언트의 IP주소 및 포트번호 접근시간정보 출력하기
		String ipAddr = req.getRemoteAddr();
		System.out.println("IP주소 : " + ipAddr
							+ "\n포트번호 : " + req.getRemotePort()
							+ "\n현재 시간 : " + new Date().toString());
		
		//필터체인 실행
		fc.doFilter(req, resp);
		
		System.out.println("[T07ServletFilter] doFilter() 끝.");
	}
	
	@Override
	public void destroy() {
		System.out.println("[T07ServletFilter] destroy() 호출됨.");
	}
	
}

package kr.or.ddit.jwt.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/*
	[JWT 를 활용한 BLOG 만들기]
	
	1. JWT 를 활용한 BLOG를 만들기 위한 설정
	
		1) 라이브러리 추가(pom.xml)
		 - JSP 사용을 위한 라이브러리 설정
		 - 파일 핸들링을 위한 라이브러리 설정
		 - 기타 라이브러리(썸네일, StringUtils 등) 설정
		 
		2) 프로퍼티스 설정(application.properties)
		 - 포트 설정
		 - log4j level 설정
		 - jsp 설정
		 - 파일 설정
		 - 데이터베이스 설정
		 - mybatis 설정
		 - jwt 설정
		 
		3) DB 및 Mybatics 설정
		 - 쿼리 그룹핑을 위한 Mapper xml 설정(mybatis/mapper/blank_Mapper.xml)
		 - 테이블 준비 (blogmember, blogmember_auth, blog, blogfile)
		 
	2. JWT 를 활용한 BLOG를 만들기 위한 페이지 설정
		
		1) 페이지 설정을 위한 컨트롤러 작성
		 - BlogController 클래스 작성
		 
			1-1) 로그인 페이지 작성(blogLogin())
		 	1-2) 회원가입 페이지 작성(blogRegister())
		 	1-3) Blog 목록 페이지 작성(blogList())
		 	1-4) Blog 상세보기 페이지 작성(blogDetail())
	
	3. 파일 설정
	 	
	 	1) 파일 Config 설정
	 		- FileConfiguration 클래스 작성
	 		
	4. 시큐리티 적용
	
		1) 라이브러리 추가(pom.xml)
		 - 시큐리티 라이브러리 설정
		2) 시큐리티 Config 작성
		 - Security Config 클래스 작성
		 
	5. JWT를 활용한 Blog CRUD 만들기
	
		1) BLOG 로그인
		 - 블로그 로그인 화면 컨트롤러 만들기 (BlogController)
		 - 블로그 로그인 화면 컨트롤러 메소드 만들기(blogLogin:get)
		 - 블로그 로그인 화면 만들기 (blog/login.jsp)
		 - 여기까지 하고 확인
		 
		2) BLOG 회원가입
		 - 블로그 회원가입 화면 컨트롤러 메소드 만들기 (blogRegister:get)
		 - 블로그 회원가입 화면 만들기 (blog/register.jsp)
		 - 여기까지 만들고 확인
		 
		3) BLOG 회원가입 기능
		 - 블로그 회원가입 기능 컨트롤러 메소드 만들기 (blogRegissterProcess:post)
		 - 블로그 회원가입 기능 서비스 인터페이스 메소드 만들기
		 - 블로그 회원가입 기능 서비스 클래스 메소드 만들기
		 - 블로그 회원가입 기능 Mapper 인터페이스 만들기
		 - 블로그 회원가입 기능 Mapper xml 쿼리 만들기
		 - 여기까지 만들고 확인
		
		
		
*/

@Controller
@RequestMapping("/blog")
public class BlogController {
	
	// 로그인 페이지
	@GetMapping("/login")
	public String blogLogin() {
		return "blog/login";
	}
	
	
	// 회원가입 페이지
	@GetMapping("/register")
	public String blogRegister() {
		return "blog/register";
	}
	
	
	// 목록 페이지
	@GetMapping("/list")
	public String blogList() {
		return "blog/list";
	}
	
	
	// 상세보기 페이지
	@GetMapping("/detail/{blogNo}")
	public String blogDetail() {
		return "blog/detail";
	}
	
}
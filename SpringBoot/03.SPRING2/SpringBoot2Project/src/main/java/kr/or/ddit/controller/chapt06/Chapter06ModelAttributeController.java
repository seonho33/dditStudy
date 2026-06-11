package kr.or.ddit.controller.chapt06;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.vo.Member;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chapt06/modelattribute")
public class Chapter06ModelAttributeController {
	
	/*
	
		3. @ModelAttribute 어노테이션
			-@ModelAttribute 는 전달받은 매개변수를 강제로 Model에 담아서 전달하도록 할 때 사용합니다.
	
	*/
	@GetMapping("/form")
	public String registerForm() {
		
		return "chapt06/modelAttributeForm";
	}
	
	
	//@ModelAttribute 어노테이션이 서버로 전달된 매개변수 각각의 값들을 자동 전달한다.
	@PostMapping("/register01")
	public String register01(
			@ModelAttribute("userId") String userId,
			@ModelAttribute("password") String password
			) {
		log.info("register01() 실행...!");
		log.info("userId : " + userId);
		log.info("password : " + password);
		
		
		return "chapt06/result";
	}

	
	// 규칙이 잘 구성된 자바빈즈 클래스 객체라면 Model, 어노테이션 없이도 결과 페이지로 데이터가 전달된다.
	@PostMapping("/register02")
	public String register02(Member member) {
		
		log.info("register01() 실행...!");
		log.info("userId : " + member.getUserId());
		log.info("password : " + member.getPassword());
		
		return "chapt06/result";
	}
}

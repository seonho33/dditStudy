package kr.or.ddit.controller.chapt06;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.vo.Member;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chapt06/ra")
public class Chapter06ReadirectAttributeController {
	/*
		4.RedirectAttribute 타입
			- RedirectAttribute 는 일회성으로 데이터를 전달하는 용도로 사용된다.
	*/

	@GetMapping("/registerForm")
	public String registerForm() {
		return "chapt06/raForm";
	}
	
	@PostMapping("/register")
	public String register(Member member, RedirectAttributes ra) {
		log.info("register() 실행...!");
		log.info("member.userId : " + member.getUserId());
		
		//일회성 메시지 전달
		ra.addFlashAttribute("msg","SUCCESS!");
		
		return "redirect:/chapt06/ra/result";
	}
	
	@GetMapping("/result")
	public String result() {
		
		return "chapt06/result";
	}
}

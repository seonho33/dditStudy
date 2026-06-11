package kr.or.ddit.controller.chapt11.login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class LoginController {
	
	@GetMapping("/login")
	public String loginForm() {
		return "chapt11/loginForm";
	}
	
	@GetMapping("/logout")
	public String logoutForm() {
		return "chapt11/logoutForm";
	}
}

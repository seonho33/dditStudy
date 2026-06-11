package kr.or.ddit.controller.notice;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {
	
	@GetMapping("/login.do")
	public String login() {
		return "conn/login";
	}
}

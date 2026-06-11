package kr.or.ddit.security;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommonController {
	
	@GetMapping("/accessError")
	public String accessDenied(Authentication auth, Model model) {
		log.info("## CommonController.accessDenied() 실행...!!	##");
		log.info("## authentication 정보 ---------------------	##");
		if(auth !=null) {
			log.info("## auth : "+auth);
		}
		model.addAttribute("msg","ACCESS DENIED ERROR");
		return "chapt11/accessError";
	}
}

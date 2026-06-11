package kr.or.ddit;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


// 어노테이션이 있는 클래스는 스프링이 브라우저의 요청을 받아들이는 컨트롤러라고 인지해서
// 자바 빈(Java Bean) 으로 등록해서 관리합니다.
// @Controller
// - 전통적인 스프링의 컨트롤러 어노테이션
// - 해당 클래스는 '컨트롤러'를 담당해! 라고 알려줍니다.
//
// @Controller 어노테이션은 사용자의 요청이 진입하는 지점이고, 요청에 따라
// 처리를 결정하며 사용자에게 view를 응답으로 내보냅니다.!
@Controller
public class HomeController {
	
	
	@GetMapping({"/","/main.do"})
	public String home(Model model) {
		model.addAttribute("msg","Hello Spring Boot!");
		return "home";
	}
}

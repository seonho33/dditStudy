package kr.or.ddit.controller.chapt06;

import java.util.Calendar;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.vo.Member;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chapt06")
public class Chapter06Controller {

	/*
	 * [6장 : 데이터 전달자 모델]
	 * 
	 * 1. 모델 객체 - Model 객체는 컨트롤러(Controller)에서 뷰(View)로 데이터를 전달하는데 사용되는 인터페이스이며, MVC
	 * 패턴의 'Model'을 담당한다 - Model을 통해 웹 애플리케이션 화면에 보여줄 데이터를 담믄 역할을 한다. - Model은 Map의
	 * 형태와 비슷하며, Key/value 로 값을 설정할 수 있다. 값을 설정하기 위해서는 addAttribute() 메소드를 활용한다.
	 * 
	 * 2. 모델을 통한 데이터 전달 - Model 객체를 통해서 다양한 데이터를 뷰(View) 에 전달할 수 있다.
	 * 
	 */
	@GetMapping("/read01")
	public String read01(Model model) {
		log.info("read01() 실행...!");

		// 1. 회원정보 각각을 model 에 담아서 전달
		model.addAttribute("userId", "hongkd");
		model.addAttribute("password", "1234");
		model.addAttribute("email", "aaa@ccc.com");
		model.addAttribute("userName", "홍길동");
		model.addAttribute("birthDay", "2026-03-13");

		// 2. 회원정보가 들어있는 Member 객체를 만들고 model에 값으로만 전달
		Member member = new Member();
		member.setUserId("hongkildong");
		member.setPassword("12345");
		member.setEmail("ccc@ddd.com");
		member.setUserName("홍길순");
		member.setBirthDay("2026-03-10");

		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, 2025);
		cal.set(Calendar.MONTH, 10);
		cal.set(Calendar.DAY_OF_MONTH, 10);

		member.setDateOfBirth(cal.getTime());
		model.addAttribute(member);

		// 3. model 에 key, value 설정 후 전달
		model.addAttribute("user", member);

		return "chapt06/read01";
	}

}

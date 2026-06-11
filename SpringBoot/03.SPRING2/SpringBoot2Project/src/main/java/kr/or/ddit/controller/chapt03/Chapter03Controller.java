package kr.or.ddit.controller.chapt03;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping("/chapt03")
public class Chapter03Controller {
	/*
	* [3장 : 컨트롤러 요청 매핑]
	* 
	* 1. 요청 경로 매핑
	* 
	* - @RequestMapping 의 value 속성에 요청 경로를 설정한다.
	* - 요청 경로는 반드시 설정해야 하는 필수 정보이다.
	* - 속성이 하나일 때는 속성명을 생략할 수 있다.(default는 value)
	* - 컨트롤러의 클래스 레벨과 메소드 레벨로 지정할 수 있다.
	* - 클래스 레벨로 요청 경로를 지정하면 메소드 레벨에서 지정한 경로의 기본경로로 취급된다
	* - 클레스 레벨의 요청 경로에 메소드 레벨의 요청경로를 덧붙인 형태가 최종 경로가 된다.
	* 
	*/
	
	//로깅 객체 생성
	private static final Logger log = LoggerFactory.getLogger(Chapter03Controller.class);
	
	//return 타입이 명시되어있지 않은 void 타입일 때는 컨트롤러 메서드가 응답으로 제공할 페이지 정보가 존재하지
	//않습니다. 이때, 경로에 매핑된 "/chapt03/register' 요청 경로를 이용하여 jsp 페이지를 찾기 시작합니다.
	// /WEB-INF/views/chapt03/register.jsp 를 찾고 해당 경로에 위치한 파일이 있다면 경과를 응답으로 만들어 전달합니다...?
	@RequestMapping(value="/register",method=RequestMethod.GET)
	public void registerForm() {
		log.info("registerForm() 실행...!!");
	}
	
	@RequestMapping(value="/modify",method=RequestMethod.GET)
	public void modifyForm() {
		log.info("modifyForm() 실행...!!");
	}
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public void list() {
		log.info("list() 실행...!!");
	}
	
	/*	
		2. 경로 패턴 매핑
		
		 - 요청 경로를 동적으로 표현이 가능한 경로 패턴을 지정할 수 있다.
		 - URL 경로 상의 변하는 값을 경로 변수로 취급한다.
		 - 경로 변수에 해당하는 값을 파라미터변수에 설정할 수 있다.
	*/	
	
	//경로상의 포함된 파라미터를 받기 위해서는 경로상에 포함되어있는 동적 데이터의 위치에 중괄호를 이용해
	// 받고자하는 변수명과 같은 키를 설정하고, @PathVariable 어노테이션을 이용해 받고자 하는 해당 타입의 파라미터 변수를 설정합니다!
	@RequestMapping(value="/read/{boardNo}",method=RequestMethod.GET)
	public String read(@PathVariable int boardNo) {
		log.info("read() 실행...!");
		log.info("Chapter03Controller.read->boardNo : " + boardNo);
		
		return "chapt03/read";
	}
	
	/*
	 * 3. HTTP 메소드 매핑
	 * 
	 * - method 속성을 사용하여 HTTP 메소드를 매핑 조건으로 지정할 수 있다.
	 * - 화면으로 응답하는 경우에는 HTTP 메소드로 GET 방식과 POST 방식 등을 사용할 수 있다.
	 * 
	*/
	@RequestMapping(value= "/formHome" , method = RequestMethod.GET)
	public String formHome() {
		log.info("formHome()실행...!");
		return "formHome";
	}
	
	@RequestMapping(value="/http/register", method= RequestMethod.GET)
	public String registerFormHttp() {
		log.info("registerFormHttp()실행...!");
		return "successs";
	}
	
	@RequestMapping(value="/http/register", method= RequestMethod.POST)
	public String registerHttp() {
		log.info("registerFormHttp()실행...!");
		return "success";
	}
	
	@RequestMapping(value="/http/modify", method= RequestMethod.GET)
	public String modifyFormHttp() {
		log.info("modifyHttp()실행...!");
		return "success";
	}
	
	@RequestMapping(value="/http/modify", method= RequestMethod.POST)
	public String modifyHttp() {
		log.info("modifyHttp()실행...!");
		return "success";
	}
	@RequestMapping(value="/http/remove", method= RequestMethod.GET)
	public String removeFormHttp() {
		log.info("remove()실행...!");
		return "success";
	}
	@RequestMapping(value="/http/remove", method= RequestMethod.POST)
	public String removeHttp() {
		log.info("remove()실행...!");
		return "success";
	}
	
}

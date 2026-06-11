package kr.or.ddit.controller.chapt07;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.vo.Member;

@Controller
@RequestMapping("/chapt07/jsp")
public class Chapter07JSPController {
	/*
	 * [ 7장: JSP ]
	 * 
	 * 		1. 커스텀 태그 라이브러리
	 * 
	 * 			- 스크립트 요소가 많아지면 많아질수록 JSP 코드는 복잡해진다.
	 * 			이 문제를 해결하는 한 가지 방법은 커스텀 태그를 사용하는 것이다.
	 * 			커스텀 태그를 사용하면 뷰를 표시하기 위한 로직을 공통화하거나, 표현하기 복잡한 로직을 캡슐화 할 수 있어서 JSP의 구현 코드를 간결하게 만들수 있다.
	 * 			그리고, 커스텀 태그를 모아 놓은 것을 커스텀 태그 라이브러리라고 한다.
	 * 
	 * 			# 대표적인 태그 라이브러리
	 * 			- JSTL(JavaServer Pages Standard Tag Library)
	 * 			- spring-form JSP Tag Library
	 * 			- spring JSP Tag Library
	 * 			- spring Security JSP Tag Library
	 * 
	 * 		2. 표현언어 (EL)
	 * 
	 * 			- JSP는 EL(Expression Language)이라는 표현 언어를 사용해 값의 참조, 출력, 연산을 할 수 있다.
	 * 			- EL식은 ${...} 또는 #{...} 형식으로 작성한다.
	 * 
	 * 			# EL을 사용하여 객체를 조회하는 방법은 다음과 같다.
	 * 			- 자바빈즈 프로퍼티를 조회하는 경우 "속성명.프로퍼티명"을 지정한다.
	 * 			- List나 배열 요소를 조회하는 경우 "속성명[요소위치]"를 지정한다.
	 * 			- Map 요소를 조회하는 경우 "속성명.프로퍼티명" 또는 "속성명[프로퍼티명]"을 지정한다.
	 * 
	 *			# 사용 가능한 연산자
	 * 			- EL에서는 다음과 같은 연산자를 사용할 수 있다.
	 * 
	 * 			# 산술 연산자
	 * 				+	|	-	|	*	|	/(div)	|	%(mood)
	 * 			────────────────────────────────────────────────
	 * 			더하기	|	뺴기	|	곱하기|	나누기	|	나머지
	 * 			────────────────────────────────────────────────
	 * 
	 * 			# 비교 연산자
	 * 				연산자	|	설명
	 * 			────────────────────────────────────────
	 * 			==(eq)		|	같은 값인지 비교한다
	 * 			!=(ne)		|	다른 값인지 비교한다
	 * 			<=(le)		|	왼쪽이 작거나 같은 값인지 비교한다
	 * 			>=(ge)		|	왼쪽이 크거나 같은 값인지 비교한다
	 * 			<(lt)		|	왼쪽이 작은 값인지 비교한다
	 * 			>(gt)		|	왼쪽이 큰 값인지 비교한다
	 * 			────────────────────────────────────────
	 * 
	 * 			# empty 연산자
	 * 			- null이거나 공백(문자열의 경우 공백 문자)인지 비교
	 * 		
	 * 			[true 조건:::]
	 * 			- null 값, 빈 문자열(""), 길이가 0인 배열, 빈 collection
	 * 
	 * 			# 논리 연산자
	 * 			연산자		|	설명
	 * 			──────────────────────────────────────────────────────────────────────────────────────────────
	 * 			&&(and)		|	두 피연산자 모두 true이면 bool true를 반환하고, 그렇지 않으면 false를 반환한다.
	 * 			||(or)		|	두 피연산자 중 하나 또는 모두 true이면 bool true를 반환하고, 그렇지 않으면 false를 반환한다.
	 * 			!(not)		|	해당 피연산자의 의미를 반대로 바꾼다
	 * 			────────────────────────────────────────────────────────────────────────────────────────────── 
	 */
	// 1) 자바빈즈 프로퍼티를 조회하는 경우 '속성명.프로퍼티명' 또는 "속성명[키명]"을 지정한다.
	@GetMapping("/home0101")
	public String home0104(Model model) {
		Map<String, String> memberMap = new HashMap<String, String>();
		memberMap.put("userId", "hong");
		memberMap.put("password", "4321");
		memberMap.put("email", "mm123@n.com");
		memberMap.put("userName", "홍길순");
		
		// memberMap이라는 키를 정확하게 명시했기 때문에, jsp페이지에서 명시된 키로 데이터를 출력할 수 있다.
		model.addAttribute("memberMap", memberMap);
		return "chapt07/home0101";
	}
	
	// 2) 산술 연산자 사용
	@GetMapping(value="/home0201")
	public String home0201(Model model) {
		int coin = 100;
		model.addAttribute("coin", coin);
		return "chapt07/home0201";
	}
	
	// 3) 비교 연산자 사용
	@GetMapping(value="/home0202")
	public String home0202(Model model) {
		int coin = 1000;
		String userId = "hongkd";
		
		model.addAttribute("coin", coin);
		model.addAttribute("userId", userId);
		
		return "chapt07/home0202";
	}
	
	// 4) empty 연산자 사용
	@GetMapping(value="/home0301")
	public String home0301(Model model) {
		// 아무것도 보내지 않았을 때는 null일 테니까, empty가 참
		Member emptyMember = null;
		model.addAttribute("emptyMember", emptyMember);
		
		// Member 객체엔 기본값으로 설정되어 있는 필드들이 있기 때문에 null 아님
		// Member 객체에 기본값으로 설정된 필드가 없다하더라도 new 연산자를 통해서 객체가 만들어졌기 때문에 객체 자체는 null 아님
		Member member = new Member();
		model.addAttribute("member", member);
		return "chapt07/home0301";
	}
	
	// 5) 논리 연산자 사용
	@GetMapping(value="/home0401")
	public String home0401(Model model) {
		int coin = 1000;
		String userId = "hongkd";
		Member member = new Member();
		
		model.addAttribute("coin", coin);
		model.addAttribute("userId", userId);
		model.addAttribute("member", member);
		return "chapt07/home0401";
	}
	
}



















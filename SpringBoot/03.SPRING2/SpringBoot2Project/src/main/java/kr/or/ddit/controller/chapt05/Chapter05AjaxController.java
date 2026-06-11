package kr.or.ddit.controller.chapt05;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.vo.Address;
import kr.or.ddit.vo.Card;
import kr.or.ddit.vo.Member;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chapt05/ajax")
public class Chapter05AjaxController {
	
	/*
		9. Ajax 방식 요청 처리
		
		비동기 통신을 이용한 데이터 처리는 과거에 사용했던 json/xml 형식의 데이터를 주고받던 형식에서 
		현재는 json 형식의 데이터를 주고 받는 형식으로 자리잡았습니다.
		클라이언트에서 서버로 비동기 통신 시, ContentType 설정과 header 설정을 통해서 내가
		원하는 데이터를 전송하고 응답으로 받을 수 있습니다.
		
		#  동기(Synchronous) 방식 vs 비동기 (Asynchronous) 방식
		- 두 방식을 비교하기 위해서는 '작업 순서'의 관점에서 보면 쉽습니다!
		
		# 동기 방식이란?
		- 클라이언트에서 서버로 요청을 보내면 해당 요청 작업이 완전히 끝날 때 까지 브라우저는 기다렸다가
		결과를 받고 다음 작업을 이행할 수 있는 방식입니다.
		- 예) 소희가 스타벅스 서대전점에 들어가 직원에게 라떼 한잔을 주문합니다 (요청)
			 그럼 직원이 소희가 주문한 라떼를 정성껏 만들어서 소희에게 가져다 줍니다.
			 여기서 직원이 라떼를 만들때까지 다른 손님의 주문을 받거나 다른일을 하지 못합니다
			 이렇게 진행하게 되는것은 동기방식입니다
			 
		# 비동기 방식이란?
		- 클라이언트에서 서버로 요청을 보내면 해당 요청 작업이 끝나기를 기다리지 않고 즉시 다음 작업을 시작할 수 있는
		방식입니다.
		- 예) 보라가 오사카 커피점에서 직원에게 라떼를 주문합니다(요청)
			  그럼 직원이 라떼주문을 받고 잠시 기다리라고 한뒤 다음 손님의 주문을 받거나 다른 사람의 오더를 처리합니다 
	*/

	//Ajax 방식 요청 처리 페이지
	@GetMapping("/registerForm")
	public String ajaxRegisterForm() {
		log.info("ajaxRegisterForm() 실행...!");
		return "chapt05/ajaxRegisterForm";
	}

	// 1) 객체 타입의 JSON  요청 데이터 @RequestBody 어노테이션을 지정하여 자바빈즈 매개변수로 처리한다.
	
	@ResponseBody
	@PostMapping("/register01")
	public ResponseEntity<String> ajaxRegister01(
			Member member){
		log.info("ajaxRegister01() 실행...!");
		
		// 비동기 요청 시, 데이터를 객체로 받기 위해서는 요청 본문에 담겨 넘어온 데이터를 바인딩 할 수 있도록
		// @RequestBody 어노테이션을 붙여 데이터를 전송합니다.
		log.info("member.userId" + member.getUserId());
		log.info("member.password" + member.getPassword());
		
		return new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		
	}
	
	@ResponseBody
	@PostMapping("/register02")
	public ResponseEntity<String> ajaxRegister02(
			@RequestBody Map<String, String> param
			){
		log.info("ajaxRegister02() 실행...!");
		//요청 본문에서 데이터가 바인딩 되지 않아 userId가 객체의 문자열 그대로 나오거나 에러가 발생합니다.
		// > userId : {"userId" : "hondkd","password" : "1234"}
		// 400 Bad_request Error 발생
		// 단일 요청 파라미터를 받으려면 Collection Map 의 형태로 하되, @RequestBody 어노테이션을 붙여 사용한다.
		// 또는 객체로 데이터를 받는다.
		
//		log.info("userId : " + userId);
//		log.info("password : " + password);
		log.info("userId : " + param.get("userId"));
		log.info("password : " + param.get("password"));
		return new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		
	}
	
	@ResponseBody
	@PostMapping("/register03/{userId}")
	public ResponseEntity<String> ajaxRegister03(
			@PathVariable String userId , String password
			){
		log.info("ajaxRegister03() 실행...!");
		// userId는 요청 경로상에 포함된 파라미터인 {userId} 로 부터 값을 매핑하고있습니다.
		// password는 쿼리스트링에 담겨있는 데이터이기 때문에 요청 헤더에 값이 담겨져 온다.
		// 그렇기 때문에 어노테이션 없이 기본 데이터 타입으로도 값을 매핑 할 수 있습니다.
		// 2번에서 진행했던 내용처럼 요청 본문에 담겨져 오는 데이터를 기본 데이터타입 또는 @RequestBody 어노테이션이
		// 설정된 기본 데이터 타입이라 할지라도 데이터 바인딩이 이루어지지 않으므로 @RequestBody 어노테이션이 붙은
		// 객체 또는 Map 으로 데이터를 바인딩 할 수 있습니다.
		log.info("userId : " + userId);
		log.info("password : " + password);
		return new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
	}
	
	
//	4) 객체 배열 타입의 JSON 요청 데이터를 자바빈즈 요소를 가진 리스트 컬렉션 매개변수에 @RequestBody 
//	어노테이션을 지정하여 처리한다.
	@ResponseBody
	@PostMapping("/register04")
	public ResponseEntity<String> ajaxRegister04(
			@RequestBody List<Member> memberList
			){
		
		log.info("register04() 실행...!");
		for(Member member : memberList) {
			log.info("userId : " + member.getUserId());
			log.info("Password : " + member.getPassword());
		}
		
		return new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
	}
	
//	5) 중첩된 객체 타입의 JSON 요청 데이터를 @RequestBody 어노테이션을 지정하여 중첩된 자바빈즈
//	매개변수로 처리한다.
	@ResponseBody
	@PostMapping("/register05")
	public ResponseEntity<String> ajaxRegister05(
			@RequestBody Member member
			){
		
		log.info("register04() 실행...!");
		log.info("userId : " + member.getUserId());
		log.info("Password : " + member.getPassword());
		
		Address address = member.getAddress();
		
		if(address!=null) {
			log.info("postCode : " + address.getPostCode());
			log.info("Location : " + address.getLocation());
		}
		
		
		return new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
	}
	
//	6) 중첩된 객체 타입의 JSON 요청 데이터를 @RequestBody 어노테이션을 지정하여 중첩된 자바빈즈
//	매개변수로 처리한다.
	@ResponseBody
	@PostMapping("/register06")
	public ResponseEntity<String> ajaxRegister06(
			@RequestBody Member member
			){
		
		log.info("register06() 실행...!");
		log.info("userId : " + member.getUserId());
		log.info("password : " + member.getPassword());
		
		List<Card> cardList = member.getCardList();
		
		if(cardList !=null&& cardList.size()>0) {
			for(int i =0;i<cardList.size();i++) {
				Card card = cardList.get(i);
				log.info("no : " + card.getNo());
				log.info("ValidMonth : " + card.getValidMonth());
			}
		}
		
		return new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
	}
}

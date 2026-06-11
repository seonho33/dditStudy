package kr.or.ddit.controller.chapt05;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.vo.Member;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/ch")
public class Chapter05Controller2 {
	// result 페이지에서 넘긴 모든 데이터를 value에 설정된 영문 값이 아닌 한글로 변환 후 출력해주세요
	// > result.jsp 페이지에서 출력은 JSTL과 EL로 출력해주세요.
	//
	// 현재 메서드인 result() 안에서도 전달받은 모든 데이터를 아래 규격에 맞춰 출력해주세요
	/*
	 * [아래 결과처럼 출력해주세요.]
	 * 
	 * 유저 ID : a001 패스워드 : 1234 이름 : 조현준 E-Mail : wh-guswns123@hanmail.net 생년월일 : 어떤
	 * 날짜 규격이든 날짜 데이터면 됨 성별 : 남자 or 여자 개발자 여부 : 개발자 or 비개발자 외국인 여부 : 외국인 or 내국인 국적 :
	 * 대한민국 or 캐나다 or 호주 소유차량 : 수유차량 없음 or AUDI, BMW or AUDI, BMW, VOLVOL 취미 : 취미 없음
	 * or 운동 영화시청 or 운동 영화시청 음악감상 우편번호 : 123456 주소 : 대전광역시 종구 오류동 112 카드1(번호) :
	 * 1451-1234-1234-1234 카드1(유효년월) : 어떤 날짜 규격이든 날짜 데이터면 됨 카드2(번호) :
	 * 1451-1234-1234-1234 카드2(유효년월) : 어떤 날짜 규격이든 날짜 데이터면 됨 소개 : 반갑습니다!
	 */
	
	@GetMapping("/test/allForm")
	public String testAllForm() {
		log.info("테스트 폼");
		return "chapt05/test/allForm2";
	}
	
	@PostMapping("/test/result2")
	public String result(Model model, Member member) {
		
		model.addAttribute("memberVO",member);
		
		return "chapt05/test/result2";
	}
}

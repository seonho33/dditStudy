package kr.or.ddit.controller.chapt07;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chapt07/fmttag")
public class Chapter07FMTController {
	
	/*
		5.숫자 및 날짜 포멧팅 처리 태그
			- 숫자 및 날짜의 포멧팅 관련 태그입니다.
			- 문자열을 숫자로, 문자열을 날짜로 변형하여 사용합니다.
			
			1) <fmt:formatNumber>
			-숫자를 형식화 합니다
			
			속성		| 	타입					|	설명
			--------------------------------------------------------
			value	|	String of Number	|	서식에 맞춰 출력할 숫자
			type	|	String				|	어떤 서식으로 출력할 지를 정한다.
			pattern	|	String				|	직접 숫자를 출력할 서식을 지정한다.
			var		|	String 				|	포멧팅한 결과를 지정할 변수 이름
			
			**	type 속성	 : number 일 경우 숫자 형식으로, percent 일 경우 % 형식으로, currency 일 경우
			*			   통화 형식으로 출력한다. 기본값은 number이다. currency 는 속해있는 국가코드에 맞는
			*			   통화 형식이 부여된다
			*	2) <fmt:parseNumber>
			*	- 문자열을 숫자로 변환한다.
			*
			*	속성		|	타입		|	설명
			*---------------------------------------------------------------
			*value		|	String	|	파싱할 문자열
			*type		|	String	|	value 속성의 문자열 타입을 지정
			*pattern	|	String	|	파싱할 때 직접 사용할 서식을 지정한다
			*var		|	String	|	파싱한 결과를 저장할 변수 이름을 지정한다
			*
			***	type 속성 : number, percent, currency가 올 수 있다.
			*
			* 3) <fmt: formatDate>
			* - Date 객체를 문자열로 변환한다.
			*
			* 속성		|	타입					|	설명
			* ----------------------------------------------------------------
			* value		|	java.util.date		|	포멧팅할 날짜 및 시간 값
			* type		|	String				|	날짜, 시간 또는 둘 다 포멧팅 할 지의 여부를 지정한다.
			* dateStyle	|	String				|	날짜에 대해 미리 정의된 포멧팅 스타일을 지정한다.
			* timeStyle	|	String				|	시간에 대해 미리 정의된 포멧팅 스타일을 지정한다.
			* pattern	|	String 				|	파싱할 때 직접 사용할 서식을 지정한다.
			* var		|	String				|	파싱한 결과를 저장할 변수 이름을 지정한다.
			* 
			* ** type 속성 : time, date, both 중 한가지 값을 가질 수 있으며, 기본값은 date이다.
			* dateStyle 속성 : default, short, medium, long, full 중 한가지 값을 가질 수 있으며, 기본값 default
			* timeStyle 속성 : default, short, medium, long, full 중 한가지 값을 가질 수 있으며, 기본값 default
			*
			*
			* 4) <fmt : parseDate>
			*  - 문자열을 Date 객체로 변환한다
			*  
			* 속성		|	타입					|	설명
			* ----------------------------------------------------------------
			* value		|	java.util.date		|	포멧팅할 날짜 및 시간 값
			* type		|	String				|	날짜, 시간 또는 둘 다 포멧팅 할 지의 여부를 지정한다.
			* dateStyle	|	String				|	날짜에 대해 미리 정의된 포멧팅 스타일을 지정한다.
			* timeStyle	|	String				|	시간에 대해 미리 정의된 포멧팅 스타일을 지정한다.
			* pattern	|	String 				|	파싱할 때 직접 사용할 서식을 지정한다.
			* var		|	String				|	파싱한 결과를 저장할 변수 이름을 지정한다.
			* 
			* ** type 속성 : time, date, both 중 한가지 값을 가질 수 있으며, 기본값은 date이다.
			* dateStyle 속성 : default, short, medium, long, full 중 한가지 값을 가질 수 있으며, 기본값 default
			* timeStyle 속성 : default, short, medium, long, full 중 한가지 값을 가질 수 있으며, 기본값 default

	*/
	
	//1) type 속성을 지정하거나 pattern 속성을 지정하여 숫자를 형식화한다. (formatNumber)
	
	@GetMapping("/home0101")
	public String home0101(Model model) {
		int coin = 100;
		model.addAttribute("coin", coin);
		return "chapt07/fmttag/home0101";
	}

	//2) 특정 type의 형식을 가지고있는 문자열이 숫자를 띄고있는 문자라면, type속성을 맞춰 숫자로 파싱 할 수 있다.
	@GetMapping("/home0201")
	public String home0201(Model model) {
		String coin1 = "1000";		// type number
		String coin2 = "₩1000";		// type currency
		String coin3 = "1000%";		// type percent
		String coin4 = "1,000.25";	// pattern
		
		model.addAttribute("coinNumber", coin1);
		model.addAttribute("coinCurrency", coin2);
		model.addAttribute("coinPercent", coin3);
		model.addAttribute("coinPattern", coin4);
		
		return "chapt07/fmttag/home0201";
	}
	
	// 3) 각 type 속성을 지정해 시간을 포멧팅한다.
	@GetMapping("/home0301")
	public String home0301(Model model) {
		Date date = new Date();
		model.addAttribute("now",date);
		return "chapt07/fmttag/home0301";
	}
	
	
	// 4) dateStyle 속성을 지정하지 않으면 기본값은 default 이고, dateStyle 속성을 각 스타일로 지정하여
	// 문자열을 Date 객체로 변환한다.
	@GetMapping("/home0401")
	public String home0401(Model model) {
		
		String dateValueDefault = "2020. 10. 20.";
		String dateValueShort = "20. 2. 1.";
		String dateValueMedium = "2020. 2. 1.";
		String dateValueLong = "2019년 2월 1일 (금)";
		String dateValueFull = "2019년 2월 1일 금요일";
		
		String dateValuePattern = "2022-02-01 15:00:24";
		
		model.addAttribute("dateValueDefault", dateValueDefault);
		model.addAttribute("dateValueShort", dateValueShort);
		model.addAttribute("dateValueMedium", dateValueMedium);
		model.addAttribute("dateValueLong", dateValueLong);
		model.addAttribute("dateValueFull", dateValueFull);
		model.addAttribute("dateValuePattern", dateValuePattern);
		
		return "chapt07/fmttag/home0401";
	}
	
	
}

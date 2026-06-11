package kr.or.ddit.controller.chapt07;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.vo.Member;

@Controller
@RequestMapping("/chapt07/jstl")
public class Chapter07JSTLController {

	/*
		3. 표준 태그 라이브러리 (JSTL)
			-많은 개발자들이 JSP 에서 코드를 깔끔하게 작성하기 위해서 커스텀 태그를 만들어왔는데,
			이런 중복되는 노력을 없애기 위해서 나온것이 바로 JSTL입니다.
			
			1)Core 태그 라이브러리
			
			요소			|		설명
---------------------------------------------------------------------------------------
		<c:out>			|	JSPWriter에 값을 적절하게 처리한 후에 출력한다.
		<c:set>			|	JSP 에서 사용할 변수를 설정한다.(setter)
		<c:remove>		|	설정한 변수를 제거한다
		<c:catch>		|	예외를 처리한다	
		<c:it>			|	조건을 지정하고 지정된 조건과 일치하는 처리 내용을 구현한다.
		<c:choose>		|	여러 조건을 처리할 때 사용한다.
		<c:when>		|	여러 조건을 지정하고 지정한 조건과 일치하는 처리 내용을 구현한다.
						|	<c:choose> 요소에서 사용한다.
		<c:otherwise>	|	<c:when> 요소에서 지정한 조건에 일치하지 않을때 처리할 내용을 구현한다.
		<c:forEach>		|	컬렉션이나 배열의 각 항목을 처리할 때 사용한다.
		<c:forTokens>	|	구분자로 구분된 각각의 토큰을 처리할 때 사용한다.	
		<c:import>		|	URL을 사용하여 다른 자원을 삽입한다.
		<c:url>			|	URL을 재작성한다.
		<c:redirect>	|	지정한 URL에 리다이렉트한다.
		<c:param>		|	파라미터를 지정한다
---------------------------------------------------------------------------------------
		
		[ taglib 지시자 사용 :: <%@ taglib uri="jakarta.tags.core" prefix="c" &>]
		
		2) fmt 태그 라이브러리
			
			요소			|		설명
---------------------------------------------------------------------------------------
	<fmt:formatNumber>	|	숫자를 형식화한다.
	<fmt:parseNumber>	|	문자열을 숫자로 변환한다.
	<fmt:formatDate>	|	Date 객체를 문자열로 변환한다.
	<fmt:parseDate>		|	문자열을 Date 객체로 변환한다.
---------------------------------------------------------------------------------------
	
		3) function 태그 라이브러리
		
			요소			|		설명
---------------------------------------------------------------------------------------
${fn:contains}			|	지정한 문자열이 포함되어있는지 확인한다.
${fn:containsIgoreCase}	|	지정한 문자열이 대문자/소문자를 구분하지 않고 포함되어있는지 판단한다.
${fn:statsWirh}			|	지정한 문자열로 시작하는지 판단한다.
${fn:indexOf}			|	지정한 문자열이 처음으로 나왔을 때의 인덱스를 구한다.
${fn:length}			|	컬렉션 또는 배열의 요소 갯수, 문자열 길이를 구한다
${fn:escapeXml}			|	지정한 문자열을 XML구문으로 해석되지 않도록 이스케이프한다.
${fn:replace}			|	문자열을 치환한다
${fn:toLowerCase}		|	문자열을 소문자로 변환한다.	
${fn:toUpperCase}		|	문자열을 대문자로 변환한다.
${fn:trim}				|	문자열을 trim 한다.
${fn:substring}			|	지정한 범위에 해당하는 문자열을 잘라낸다.
${fn:substringAfter}	|	지정한 문자열에 일치하는 이후의 문자열을 잘라낸다.
${fn:substringBefore}	|	지정한 문자열에 일치하는 이전의 문자열을 잘라낸다.
${fn:join}				|	문자열 배열을 결합해서 하나의 문자열을 만든다.
${fn:split}				|	문자열을 구분자로 분할해서 문자열 배열을 만든다.
---------------------------------------------------------------------------------------
	
	[taglib 지시자 사용 :: <%@ taglib uri="jakarta.tags.function" prefix="fn" &> ]
	*/
	
	//1) 코어태그의 default, target 등 속성을 활용하여 값을 저장 및 변경할 수 있다.
	//1) c:remove를 이용해 c:set에 저장된 변수의 값을 삭제할 수 있다
	@GetMapping("home0101")
	public String home0101(Model model) {
		
		Member member = new Member();
		member.setUserId("hongk0101");
		model.addAttribute("member",member);
		return "chapt07/jstl/home0101";
	}
	
	//c:if, c:when, c:otherwise
	@GetMapping("/home0201")
	public String home0201(Model model) {
		Member member = new Member();
		member.setForeigner(true);
		member.setGender("M");
		model.addAttribute("member",member);
		return "chapt07/jstl/home0201";
	}
	
	//c:forEach, c:forTokens
	@GetMapping("/home0301")
	public String home0301(Model model) {
		Member member = new Member();
		
		// forTokens test
		String hobby = "Music, Movie";
		member.setHobby(hobby);
		
		
		//forEach test
		String[] hobbyArray = {"Music","Movie"};
		member.setHobbyArray(hobbyArray);
		model.addAttribute("member",member);
		return "chapt07/jstl/home0301";
	}
	
	// c:import
	@GetMapping("/home0401")
	public String home0401(Model model) {
		return "chapt07/jstl/home0401";
	}

	// c:redirect
	@GetMapping("/home0501")
	public String home0501(Model model) {
		return "chapt07/jstl/home0401";
	}
	
}


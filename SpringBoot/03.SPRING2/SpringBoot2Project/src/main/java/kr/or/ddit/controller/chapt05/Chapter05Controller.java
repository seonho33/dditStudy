package kr.or.ddit.controller.chapt05;

import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.Address;
import kr.or.ddit.vo.Card;
import kr.or.ddit.vo.FileMember;
import kr.or.ddit.vo.Member;
import kr.or.ddit.vo.MultiFileMember;

@Controller
@RequestMapping("/chapt05")
public class Chapter05Controller {

	/*
	 * [5장 : 컨트롤러 요청 처리]
	 * 
	 * 클라이언트로부터 들어온 요청을 컨트롤러 메소드의 매개변수 영역에서 다양한 데이터 타입으로 데이터를 바인딩 할 수 있습니다. 이와같은 데이터
	 * 타입은 다양한 어노테이션을 통해서도 요청처리를 담당합니다.
	 * 
	 * 1. 컨트롤러 메서드 매개변수 -Model : 이동 대상에 전달할 데이터를 가지고있는 인터페이스 -RedirectAttributes : 리
	 * 다이렉트 대상에 전달할 데이터를 가지고있는 인터페이스 -자바빈즈 클래스 : 요청 파라미터를 가지고있는 자바빈즈 클래스
	 * -MultipartFile : 멀티파트 요청을 사용해 업로드 된 파일 정보를 가지고있는 인터페이스 -BindingResult : 도메인
	 * 클래스의 입력값 검증 결과를 가지고있는 인터페이스 -Locale : 클라이언트 Locale Principal : 클라이언트 인증을 위한
	 * 사용자 정보를 가지고있는 인터페이스
	 *
	 */
	private static final Logger log = LoggerFactory.getLogger(Chapter05Controller.class);

	// 요청 처리 페이지
	@GetMapping("/main")
	public String registerForm() {
		log.info("registerForm()실행...!");
		return "chapt05/registerForm";
	}

	// 1) URL 경로 상의 쿼리 파라미터 정보로부터 요청 데이터를 취득 할 수 있다.

	@GetMapping("/register")
	public String registerByParameter(String userId, String password) {
		log.info("registerByParameter() 실행...!");
		log.info("Chapter05Controller.registerByParmeter->userId :" + userId);
		log.info("Chapter05Controller.registerByParmeter->password :" + password);
		return "chapt05/success";
	}

	// 2) HTML Form 필드명과 컨트롤러 매개변수명이 일치하면 요청 데이터를 취득할 수 있다.
	@PostMapping("/register01")
	public String register01(String password, String userId, int coin) {
		log.info("register01() 실행...!");
		log.info("Chaper05Controller.registerByParameter->password : " + password);
		log.info("Chaper05Controller.registerByParameter->id : " + userId);
		log.info("Chaper05Controller.registerByParameter->coin : " + coin);

		return "chapt05/success";

	}

	/*
	 * 2. 요청 데이터 처리 어노테이션
	 * 
	 * - @PathVariable : URL 에서 경로 변수값을 가져오기 위한 어노테이션 - @RequestParam : 요청 파라미터 값을
	 * 가져오기 위한 어노테이션 - @RequestHeader : 요청 헤더값을 가져오기 위한 어노테이션 - @RequestBody : 요청 본문
	 * 내용을 가져오기 위한 어노테이션 - @CookieValue : 쿠키 값을 가져오기 위한 어노테이션
	 */

	// 1) RUL 경로상의 변수가 여러개일때, @PathVariable 어노테이션을 사용하여 특정한 경로 변수명을 지정해준다.
	@GetMapping("/register/{userId}/{coin}")
	public String registerByPath(@PathVariable String userId, @PathVariable int coin) {
		log.info("registerByPath()실행..!");
		log.info("Chapter05Controller.registerByPath->userId : " + userId);
		log.info("Chapter05Controller.registerByPath->coin : " + coin);

		return "chapt05/success";
	}

	// 2) @RequestParam 어노테이션을 사용하여 특정한 HTML Form 의 필드명을 지정하여 요청을 처리한다.
	@PostMapping("/register0201")
	public String register0201(@RequestParam(name = "userId") String username,
			@RequestParam(name = "pw", defaultValue = "9999") String password, int coin) {
		log.info("register0201()실행..!");
		log.info("Chapter05Controller.registerByPath->userId : " + username);
		log.info("Chapter05Controller.registerByPath->password : " + password);
		log.info("Chapter05Controller.registerByPath->coin : " + coin);

		return "chapt05/success";

	}

	@GetMapping("/")
	public String register0202(@RequestHeader("Accept") String accept, @RequestHeader("User-Agent") String userAgent,
			@RequestHeader HttpHeaders headers, @CookieValue("JSESSIONID") String sessionId) {
		log.info("register0202() 실행...!");
		log.info("## 낱개의 헤더 정보 출력하기 ------");
		log.info("accept : " + accept);
		log.info("userAgent : " + userAgent);

		log.info("## 반복문을 이용해서 헤더 정보 모두 출력하기-----");
		Set<String> sets = headers.headerNames();
		Iterator<String> ite = sets.iterator();
		while (ite.hasNext()) {
			String key = ite.next();
			log.info("[헤더정보]" + key + " : " + headers.get(key));
		}

		// JSESSIONID 정보 가져오기
		log.info("sessionId : " + sessionId);

		return "chapt05/success";
	}

	/*
	 * 3. 요청 처리 자바빈즈
	 */

	@PostMapping("/beans/register01")
	public String registerJavaBeans01(Member member, int coin) {
		log.info("registerJavaBeans01() 실행...!");
		// 동기방식의 요청으로 들어온 데이터를 Member와 같은 객체로 받는 경우, 별다른 어노테이션 없이도 클라이언트로
		// 부터 넘긴 name 의 key가 매개변수로 설정된 Member 클래스의 필드와 같다면 데이터가 바인딩된다.
		// 그리고 전달받은 데이터 중 , member 클래스 안에도 coin 이라는 필드가 존재하고, 파라미터 변수도 coin 으로
		// 같기 때문에 이름이 같은 key가 존재한다면 모두 데이터 바인딩이 진행된다.
		log.info("member.userId : " + member.getUserId());
		log.info("member.password : " + member.getPassword());
		log.info("member.userName : " + member.getUserName());
		log.info("member.userId : " + member.getUserId());
		log.info("member.Coin : " + member.getCoin());

		return "chapt05/success";
	}

	/*
	 * 4. Date 타입 처리 - 스프링 MVC는 Date 타입의 데이터를 처리하는 여러 방법을 제공한다.
	 *
	 * 1) 쿼리 파라미터(deateOfBirth) 로 전달받은 값은 Date 타입으로 테이터를 받을 수 있는가?
	 */
	@GetMapping("registerByGet01")
	public String registerByGet01(String userId, Date dateOfBirth) {
		log.info("registerBy() 실행...!");
		log.info("member.userId : " + userId);
		log.info("dateOfBirth : " + dateOfBirth);
		// Date 타입의 데이터는 기본적으로 '26/03/09' 와 같은 '/'의 형태가 포함된 데이터만 받을 수 있습니다.
		// 하지만 , Date 타입의 데이터를 직접 받는것 보다 특정 형식을 갖춘 문자열의 날짜 데이터를 받는게 더 효과적!
		log.info("registerBy() 실행...!");

		return "chapt05/success";
	}

	@PostMapping("registerByGet02")
	public String registerByGet02(Member member) {
		log.info("registerBy() 실행...!");
		log.info("userId : " + member.getUserId());
		log.info("dateOfBirth" + member.getDateOfBirth());

		return "chapt05/success";
	}

	/*
	 * 5. @DateTimeFormat 어노테이션 - @DatetimeFormat 어노테이션의 pattern 속성값에 원하는 날짜형식을 지정할
	 * 수 있다.
	 */
	@PostMapping("/registerByGet03")
	public String registerByGet03(String userId, @DateTimeFormat(pattern = "yyyyMMdd") Date dateOfBirth) {

		log.info("registerByGet03() 실행...!");
		log.info("userId : " + userId);
		log.info("dateOfBirth : " + dateOfBirth);

		return "chapt05/success";
	}

	/*
	 * 6. 폼 방식 요청 처리 6-1)폼 텍스트 필드 요소값, 비밀번호 필드 요소값을 기본 자바빈즈 매개변수로 처리한다.
	 */
	@PostMapping("/registerMemberuserId")
	public String registerMemberUserId(Member member) {
		log.info("registerMemberuserId() 실행");
		log.info("member.userId : " + member.getUserId());
		log.info("member.password : " + member.getPassword());

		return "chapt05/success";
	}

	/*
	 * 6-2)폼 라디오 버튼 요소값을 기본 데이터 타입인 문자열 타입 매개변수로 처리한다.
	 * 
	 */
	@PostMapping("/registerRadio")
	public String registerRadio(String gender) {
		log.info("registRadio() 실행...!");
		log.info("gender : " + gender);
		return "chapt05/success";
	}

	@PostMapping("/registerSelect")
	public String registerSelect(String nationality) {
		log.info("registerSelect() 실행...!");
		log.info("nationality : " + nationality);
		return "chapt05/success";
	}

	@PostMapping("/registerMultiSelect01")
	public String registerMultiSelect01(String cars, String[] carArray,
			@RequestParam(required = false) List<String> carList) {
		log.info("registerMultiSelect01 실행...!");
		log.info("cars : " + cars);
		if (carArray != null) {
			log.info("carArray : " + carArray);
			log.info("carArray.length : " + carArray.length);
			for (int i = 0; i < carArray.length; i++) {
				log.info("carArray[" + i + "] : " + carArray[i]);
			}
		} else {
			log.info("carArray is null");
		}
		if (carList != null && carList.size() > 0) {
			log.info("carList : " + carList);
			log.info("carList.size() : " + carList.size());
			for (int i = 0; i < carList.size(); i++) {
				log.info("carList.get(" + i + ") : " + carList.get(i));
			}
		} else {
			log.info("carList is null");
		}
		return "chapt05/success";
	}

	@PostMapping("/registerCheckbox01")
	public String registerCheckbox01(String hobby, String[] hobbyArray,
			@RequestParam(required = false) List<String> hobbyList) {
		log.info("registerCheckbox() 싫애...!");

		// 기본 문자열 데이터 타입으로 출력
		// 여러개의 체크된 데이터를 기본 데이터 타입으로 받는 경우 'sports, movie' 와 같이 ',' 를 기준으로
		// 하나의 문장의 값이 들어온다
		log.info("hobby : " + hobby);

		// 문자열 배열 타입으로 출력
		log.info("hobbyArray :" + hobbyArray);
		if (hobbyArray != null) {
			log.info("hobbyArray.length : " + hobbyArray.length);
			for (int i = 0; i < hobbyArray.length; i++) {
				log.info("hobbyArray[" + i + "] : " + hobbyArray[i]);
			}
		} else {
			log.info("hobbyArray is null");
		}
		if (hobbyList != null && hobbyList.size() > 0) {
			log.info("hobbyList : " + hobbyList);
			log.info("hobbyList.size() : " + hobbyList.size());
			for (int i = 0; i < hobbyList.size(); i++) {
				log.info("hobbyList.get(" + i + ") : " + hobbyList.get(i));
			}
		} else {
			log.info("hobbyList is null");
		}
		return "chapt05/success";
	}

	@PostMapping("/registerCheckbox04")
	public String registerCheckbox04(@RequestParam(defaultValue = "N") String developer, boolean foreigner) {

		log.info("registerCheckbox04() 실행...!");
		// 값이 존재하면 value 속성 안에 들어있는 값이 넘어오고 값이 존재하지 않으면 null 이 반환된다.
		// 이때, null은 받는 데이터타입 String 타입의 기본 default 값이 매핑된다
		log.info("developer : " + developer);
		// 개인정보 동의와 같은 기능(스위칭역할) 을 만들때 사용합니다.
		// 체크된 값이 존재하면 value 속성에 설정된 true 가 넘어오고, 체크된 값이 존재하지 않으면 false가 넘어옵니다.
		// 여기서도 마찬가지로 ture 의 반대는 false 이지만 클라이언트 쪽에서 넘어오는 데이터가 없다면
		// 받는 데이터 타입인 boolean 의 default 값 false가 매핑됩니다.
		log.info("foreigner : " + foreigner);

		return "chapt05/success";
	}

	@PostMapping("/registerUserAddress")
	public String registerUserAddress(Member member) {
		log.info("registerUserAddress() 실행..>!");

		Address address = member.getAddress();
		if (address != null && address.getPostCode().length() != 0 && address.getLocation().length() != 0) {
			log.info("member.postCode : " + address.getPostCode());
			log.info("member.location : " + address.getLocation());
			log.info("member.address : " + address);
		} else {
			log.info("address is null");
		}
		return "chapt05/success";
	}

	@PostMapping("/registerUserCardList")
	public String registerUserCardList(Member member) {
		log.info("registerUserCardList() 실행...!");

		List<Card> cardList = member.getCardList();

		if (cardList != null && cardList.size() > 0) {
			log.info("cardList.size() : " + cardList.size());
			for (int i = 0; i < cardList.size(); i++) {
				Card card = cardList.get(i);
				log.info("card.no : " + card.getNo());
				log.info("card.validMonth : " + card.getValidMonth());
			}
		} else {
			log.info("cardList is null");
		}
		return "chapt05/success";
	}

	// 9) 폼 텍스트 영역 요소값을 기본 데이터 타입인 문자열 타입 매개변수로 처리한다.
	@PostMapping("/registerTextArea")
	public String registerTextArea(Member member) {
		log.info("registerTextArea() 실행...!");
		log.info("introduction : " + member.getIntroduction());

		return "chapt05/success";
	}

	// ---------------------지금까지 배운거 종합 테스트------------------------

	@GetMapping("/test/allForm")
	public String testAllForm() {
		log.info("testAllForm() 실행...!");
		return "chapt05/test/allForm";
	}

	@PostMapping("/test/result")
	public String result(Member member, Model model) {
		// 전체 폼 페이지에서 넘겨받은 데이터 모두를 콘솔에 출력해 주세요.
		// chapt05/test 폴더 아래있는 result.jsp 로 전달해주세요
		// result 페이지에서 넘긴 모든 데이터를 value에 설정된 영문값이 아닌 한글로 변환후 출력해주세요
		// > result.jsp 페이지에서 출력은 JSTL 과 EL로 해주세요.
		//
		// 현재 메서드인 result() 안에서도 전달받은 모든 데이터를 아래 규격에 맞춰 출력해주세요

		// [아래 결과처럼 출력해주세요.]
		//
		// 유저 ID : a001
		// 패스워드 : 1234
		// 이름 : 조현준
		// E-Mail : wh-guswns123@hanmail.net
		// 생년월일 : 어떤 날짜 규격이든 날짜 데이터면 됨
		// 성별 : 남자 or 여자
		// 개발자 여부 : 개발자 or 비개발자
		// 외국인 여부 : 외국인 or 내국인
		// 국적 : 대한민국 or 캐나다 or 호주
		// 소유차량 : 수유차량 없음 or AUDI, BMW or AUDI, BMW, VOLVOL
		// 취미 : 취미 없음 or 운동 영화시청 or 운동 영화시청 음악감상
		// 우편번호 : 123456
		// 주소 : 대전광역시 종구 오류동 112
		// 카드1(번호) : 1451-1234-1234-1234
		// 카드1(유효년월) : 어떤 날짜 규격이든 날짜 데이터면 됨
		// 카드2(번호) : 1451-1234-1234-1234
		// 카드2(유효년월) : 어떤 날짜 규격이든 날짜 데이터면 됨
		// 소개 : 반갑습니다!

		List<Card> cardList = member.getCardList();

		model.addAttribute("memberVO", member);

		log.info("유저 ID : " + member.getUserId());
		log.info("패스워드 : " + member.getPassword());
		log.info("이름 : " + member.getUserName());
		log.info("E-Mail : " + member.getEmail());
		log.info("생년월일 : " + member.getDateOfBirth());

		if (member.getGender().equals("male")) {
			log.info("성별 : 남자");
		} else {
			log.info("성별 : 여자");
		}

		if (member.getDeveloper() != null && member.getDeveloper().equals("Y")) {
			log.info("개발자 여부 : 개발자");
		} else {
			log.info("개발자 여부 : 비 개발자");
		}

		if (member.isForeigner()) {
			log.info("외국인 여부 : 외국인");
		} else {
			log.info("외국인 여부 : 내국인");
		}

		if (member.getNationality().equals("korea")) {
			log.info("국적 : 대한민국");
		} else if (member.getNationality().equals("germany")) {
			log.info("국적 : 독일");
		} else if (member.getNationality().equals("canada")) {
			log.info("국적 : 캐나다");
		} else if (member.getNationality().equals("usa")) {
			log.info("국적 : 미국");
		}

		if (member.getCarArray() != null && member.getCarArray().length != 0) {
			for (int i = 0; i < member.getCarArray().length; i++) {
				log.info("소유차량 : " + member.getCarArray()[i]);
			}
		} else {
			log.info("소유차량 없음");
		}

		if (member.getHobbyList() != null && member.getHobbyList().size() != 0) {
			for (String hobby : member.getHobbyList()) {
				switch (hobby) {
				case "sports":
					log.info("취미 : 운동");
					break;
				case "book":
					log.info("취미 : 독서");
					break;
				case "movie":
					log.info("취미 : 영화감상");
					break;
				case "music":
					log.info("취미 : 음악감상");
					break;
				default:
					break;
				}
			}
		} else {
			log.info("취미 없음");
		}

		log.info("우편번호 : " + member.getAddress().getPostCode());
		log.info("주소 : " + member.getAddress().getLocation());
		log.info("카드1-번호 : " + cardList.get(0).getNo());
		log.info("카드1-유효연월 : " + cardList.get(0).getValidMonth());
		log.info("카드2-번호 : " + cardList.get(1).getNo());
		log.info("카드2-유효연월 : " + cardList.get(1).getValidMonth());
		log.info("소개 : " + member.getIntroduction());

		return "chapt05/test/result";
	}

	/*
	 * 8. 파일 업로드 폼 방식 요청 처리
	 * 
	 * 파일 업로드를 설정하기 위해서는 form 태그 내, method 방식은 'POST' 로 설정하고 encType을
	 * 'multipart/form-data'로 설정합니다. 클라이언트에서 서버로 파일 데이터를 전송 시, 스프링 부트 내 내장된 톰캣 서블릿
	 * 컨테이너의 제약 사항을 이용해 검토를 진행합니다. 업로드 가능한 최대 파일 크기를 넘었는지, 요청 전체의 최대 크기를 넘었는지 등등 설정된
	 * 제약사항 안에서 검토를 진행합니다.
	 * 
	 * -파일 업로드 설정 > application.properties 파일 내, 업로드 파일 용량 설정
	 * 
	 * - IOUtils 사용과 파일 핸들링을 위한, pom.xml 내 의존 라이브러리 추가 > commons-io,
	 * commons-fileupload 라이브러리 의존 관계 등록 : 해당 라이브러리는 파일 업로드시 필요로 하는 기능을 가지고 있는 객체
	 * 사용을 위함
	 ** 
	 * 파일 업로드 설정 - max-file-size : 업로드 가능한 최대 파일 크기(기본값은 1MB) - max-request-size :
	 * 요청 전체의 최대 크기(파일 + 파라미터 포함, 기본값은 10MB) - file-size-threshold : 파일 디스크에 기록되는 크기
	 * 임계값을 지정합니다. (기본값은 0) - location : 업로드 된 파일이 저장될 디렉토리를 지정합니다. 지정하지 않으면 임시
	 * 디렉토리가 사용
	 *
	 */

	// 1) 파일 업로드 폼 파일 요소값과 텍스트 필드 요소값을 MultipartFile 매개변수와 자바빈즈 매개변수로 처리한다.
	@PostMapping("/registerFile03")
	public String registerFile03(Member member, MultipartFile picture) {
		log.info("registerFile03() 실행...!");
		log.info("userId : " + member.getUserId());
		log.info("password : " + member.getPassword());

		// 기본적으로 파일 데이터를 바인딩 하기 위해서는 MultipartFile 타입으로 데이터를 바인딩 할 수 있습니다.
		log.info("originalFileName : " + picture.getOriginalFilename()); // 파일명
		log.info("size : " + picture.getSize()); // 파일크기
		log.info("ContentType : " + picture.getContentType()); // 파일 MimeType

		return "chapt05/success";
	}

	// 2) 파일 업로드 폼 파일 요소값과 텍스트 필드 요소값을 FileMember 타입의 자바빈즈 매개변수로 처리한다.
	@PostMapping("/registerFile04")
	public String registerFile04(FileMember fileMember) {
		log.info("registerFile04() 실행...!");
		log.info("userId : " + fileMember.getUserId());
		log.info("password : " + fileMember.getPassword());

		MultipartFile picture = fileMember.getPicture();

		// 기본적으로 파일 데이터를 바인딩 하기 위해서는 MultipartFile 타입으로 데이터를 바인딩 할 수 있습니다.
		log.info("originalFileName : " + picture.getOriginalFilename()); // 파일명
		log.info("size : " + picture.getSize()); // 파일크기
		log.info("ContentType : " + picture.getContentType()); // 파일 MimeType

		return "chapt05/success";
	}

	// 3) 여러개의 파일 업로드 폼 파일 요소값을 여러 개의 MultipartFile 매개변수로 처리한다.
	@PostMapping("/registerFile05")
	public String registerFile05(String userId, String password, MultipartFile picture, MultipartFile picture2) {
		log.info("registerFile05() 실행...!");
		log.info("userId : " + userId);
		log.info("password : " + password);

		// 기본적으로 파일 데이터를 바인딩 하기 위해서는 MultipartFile 타입으로 데이터를 바인딩 할 수 있습니다.
		log.info("originalFileName : " + picture.getOriginalFilename()); // 파일명
		log.info("size : " + picture.getSize()); // 파일크기
		log.info("ContentType : " + picture.getContentType()); // 파일 MimeType

		log.info("originalFileName : " + picture2.getOriginalFilename()); // 파일명
		log.info("size : " + picture2.getSize()); // 파일크기
		log.info("ContentType : " + picture2.getContentType()); // 파일 MimeType

		return "chapt05/success";
	}

	// 4) 여러개의 파일 업로드 폼 파일 요소값을 MultipartFile 타입의 요소를 가진 리스트 컬렉션 타입 매개변수로 처리한다.
	@PostMapping("/registerFile06")
	public String registerFile06(String userId, String password, List<MultipartFile> pictureList) {
		
		// 일반 데이터와 파일 데이터를 받을 때, Collection 데이터 타입으로 데이터를 받을 때 차이가 발생합니다.
		// (객체가 아닌 단일 List 타입으로 받는 경우)
		// 일반 데이터를 Collection 타입으로 받기 위해서는 @RequestParam 어노테이션을 붙여 데이터를 바인딩 합니다.
		// 파일 데이터를 Collection 타입으로 받기 위해서는 @RequestParam 어노테이션의 사용 여부와 관계 없이
		// List 컬렉션으로 데이터를 바인딩 할 수 있습니다.
		// 여기서 MultipartFile 타입을 List 와 같은 컬렉션으로 받을 때, 클라이언트에서 보내는 name 설정이 중요한
		// 포인트가 됩니다.
		// 기본적으로 중첩된 자바빈즈 객체에 데이터를 바인딩 하기 위해서는 List 타입의 대해서면 exam[index].field
		// 와 같은 형태로 구성하여 객체에 데이터를 바인딩 했습니다.
		// 하지만, 파일 타입에 해당하는 MultipartFile 타입인 경우라면 exam 의 형태로만 설정 후 전송해야 데이터가
		// 바인딩 됩니다.
		// 데이터를 전송했을 때 보냈던 pictureList[], pictureList[1]과 같이 설정 후 보낸다면 Spring MVC는
		// pictureList[0], pictureList[1]과 같은 이름으로 받는것처럼 인식됩니다.
		// 그렇기 때문에 pictureList 이름으로 설정해야만 데이터를 받을수 있습니다
		// (파일의 형태가 이러니 꼭 참고!!)
		log.info("registerFile06() 실행...!");
		log.info("userId : " + userId);
		log.info("password : " + password);

		for (int i = 0; i < pictureList.size(); i++) {
			MultipartFile picture = pictureList.get(i);
			log.info("originalFileName : " + picture.getOriginalFilename()); // 파일명
			log.info("size : " + picture.getSize()); // 파일크기
			log.info("ContentType : " + picture.getContentType()); // 파일 MimeType
		}
		return "chapt05/success";
	}

	
	//5) 여러개의 파일 업로드 폼 파일 요소값과 텍스트 필드 요소값을 MultiFileMember 타입의 자바빈즈 매개변수로 처리한다.
	@PostMapping("/registerFile07")
	public String registerFile07(MultiFileMember multiFileMember) {
		log.info("registerFile06() 실행...!");
		
		// 자바빈즈 클래스 객체 내, Collection 타입으로 받는 경우에는 name 의 값을 index 처리 하거나 하지 않아도
		// 받을 수 있습니다. pictureList or pictureList[0]와 같이 설정한다 하더라도 데이터를 바인딩 할 수 
		// 있습니다. 자바빈즈 내부 컬렉션은 multiFileMember 클래스에 필드인 List<MultipartFile> pictureList
		// 로 자바빈즈 바인딩 규칙에 따라 필드명 or 필드명[index] 형태로 찾을 수 있기 때문입니다.
		log.info("userId : " + multiFileMember.getUserId());
		log.info("password : " + multiFileMember.getPassword());

		List<MultipartFile> pictureList = multiFileMember.getPictureList();
		
		for (int i = 0; i < pictureList.size(); i++) {
			MultipartFile picture = pictureList.get(i);
			log.info("originalFileName : " + picture.getOriginalFilename()); // 파일명
			log.info("size : " + picture.getSize()); // 파일크기
			log.info("ContentType : " + picture.getContentType()); // 파일 MimeType
		}
		return "chapt05/success";
	}

}
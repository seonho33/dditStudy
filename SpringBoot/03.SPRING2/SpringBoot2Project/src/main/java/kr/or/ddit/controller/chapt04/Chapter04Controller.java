package kr.or.ddit.controller.chapt04;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.controller.chapt03.Chapter03Controller;
import kr.or.ddit.vo.Member;

@Controller
@RequestMapping("/chapt04")
public class Chapter04Controller {

    private final Chapter03Controller chapter03Controller;
	
	/*
	*	[4장 : 컨트롤러 응답]
	*
	*	컨트롤러 응답은 각 컨트롤러에 만들어진 메서드를 통해 String, ModelAndView, View, AbstractView
	*	등등과 같은 타입으로 페이지 정보가 리턴됩니다. 이와같은 메서드가 어떤 데이터 타입으로 응답을 하느냐에
	*	따라 페이지 정보를 응답으로 전달하거나 데이터를 응답으로 전달할 수 있습니다.
	*
	*	1. void 타입
	*		-호출하는 URL과 동일한 뷰 이름을 나타내기 위해 사용합니다.
	*/
	private static final Logger log = LoggerFactory.getLogger(Chapter04Controller.class);

    Chapter04Controller(Chapter03Controller chapter03Controller) {
        this.chapter03Controller = chapter03Controller;
    }
	
	//요청 경로(/chapt04/goHome0101)와 같은 동일한 뷰(/chapt04/goHome00101.jsp 를 가리킨다.
	
	@GetMapping("/goHome0101")
	public void goHome0101() {
		log.info("goHome0101() 실행...!");
	}

	@GetMapping("/sub/goHome0102")
	public void goHome0102() {
		log.info("goHome0102() 실행...!");
	}
	
	/*
	
	* 2. String 타입
	* 	- 뷰 파일의 경로와 파일 이름을 나타내기 위해 사용한다.
	*/

	@GetMapping("/goHome0201")
	public String goHome0201() {
		log.info("goHome0201()실행...!");
		return "chapt04/home0201";
	}
	
	
	@GetMapping("/goHome0202")
	public String goHome0202() {
		log.info("goHome0202()실행...!");
		return "chapt04/sub/home0202";
	}
	
	//반환값이 redirect: 로 시작하면 리다이렉트를 실행한다
	@GetMapping("/sub/goHome0203")
	public String goHome2023() {
		log.info("goHome0203()실행...!");
		return "redirect:/chapt04/goHome0202?dd";
	}
	
	/*
	*	3. 자바빈즈 클래스 타입(VO)
	*
	*	- JSON  객체 타입의 데이터를 만들어서 반환하는 용도로 사용한다.
	*	- @ResponseBody를 지정하지 않으면 HTTP 404에러가 발생한다.
	*	 : 응답으로 나가는 문자열의 정보가 데이터가 아닌 페이지 정보로 인식되기 때문에 404 에러가 발생한다
	*	- @ResponseBody가 객체를 리턴하여 객체를 응답데이터로 보내는 역할을 합니다.
	*	- @ResponseBody의 리턴 default 데이터 형식은 json 입니다.
	*	- @ResponseBody 대신에 @RestController를 이용하여 대체할 수 있습니다.
	*
	*	*** @ResponseBody가 없다면, ViewResolver가 잡아 페이지를 처리하는 것처럼 반응해서 404 에러 발생!
	*/
	@GetMapping("/goHome0301")
	@ResponseBody
	public Member goHome0301() {
		log.info("goHome0301()실행...!");
		return new Member();
	}
	/*
	
	*	4. 컬렉션 List 타입
	*
	*	-JSON 객체 배열 타입의 데이터를 만들어서 반환하는 용도로 사용한다.
	*/
	@ResponseBody
	@GetMapping("/goHome0401")
	public List<Member> goHome0401(){
		log.info("goHome0401실행...!!!!");
		
		List<Member> list = new ArrayList();
		Member member1 = new Member();
		Member member2 = new Member();
		list.add(member1);
		list.add(member2);
		
		return list;
	}
	
	/*
	
	*	5. 컬렉션 Map 타입
	*
	*	- Map 형태의 컬렉션 자료를 JSON 객체 타입의 데이터로 만들어서 반환하는 용도로 사용한다.
	*/
	
	@ResponseBody
	@GetMapping("/goHome0501")
	public Map<String, Member> goHome0501(){
		log.info("goHome0501() 실행...!");
		
		Map<String, Member> map = new HashMap<>();
		Member member1 = new Member();
		Member member2 = new Member();
		
		map.put("key1", member1);
		map.put("key2", member2);
		
		return map;
	}
	
	/*
		6. ResponseEntitiy<Void> 타입
		
			- response 할 때 HTTP 헤더 정보와 내용을 가공하는 용도로 사용한다.
			
			# @ResponseBody와 ResponseEntity
			@ResponseBody는 Http응답 본문을 만들어 응답을 내보내주는 역할을 한다.
			ResponseEntity는 응답본문, 헤더, 상태코드를 컨트롤 할 수 있다.
			ResponseEntity는 HttpEntity를 상속받고 있는데, HttpEntity는 응답 본문을 컨트롤 할 수 있도록 Body(응답 본문), HttpHeaders를 필드로 설정되어 있다
	*
	*/
	
	//200 OK 상태코드를 전송한다.
	//Void 클래스는 인스턴스화 할 수 없는 자리 표시자 클래스이고, 응답 본문에 응답으로 제공할 데이터가
	//없을때 사용할 수 있습니다. 그렇기 때문에 특정 값을 변경하거나 헤더 정보와 같은
	//특정 데이터 1개만 변경할 때 용이합니다.
	@GetMapping("/goHome0601/{num}")
	public ResponseEntity<Void> goHome0601(@PathVariable int num){
		log.info("goHome0601() 실행...!!!");
		
		//랜덤 수 1~10 범위에 숫자를 생성합니다.
		//경로 상에 포함된 파라미터는 num의 수가 랜덤으로 만든 수 보다 클 떄 200OK를 전송하고
		//그렇지 않으면 400Bad Request를 전송합니다.
		//이때, Void 타입이므로 응답 본문에 응답으로 제공할 데이터가 없고 상태코드와 헤더정보만 설정 가능
		
		ResponseEntity<Void> entity = null;
		int rand = new Random().nextInt(10)+1;
		
		//경로상에 포함시킨 숫자 num이 랜덤으로 만들어진 수 보다 큰 경우, 상태코드 OK를 전송, 그렇지 않으면
		//Bad_Request를 전송 합니다.
		if(num>rand) {
			entity = new ResponseEntity<>(HttpStatus.OK);	//200 OK
		}else {
			entity = new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	/*
		7. REsponseEntity<String> 타입
		
		- response 할 때 HTTP 헤더 정보와 문자열 데이터를 전달하는 용도로 사용한다.
	
	*/
	//SUCCESS 메세지와 200OK 상태코드를 전송한다로
	@GetMapping("/goHome0701")
	public ResponseEntity<String> goHome0701(){
		log.info("goHome0701() 실행...!!!");
		return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	}
	
	/*
	
	*	8. ResponseEntity<자바 빈즈 클래스> 타입
	*		-response 할 때 HTTP 헤더 정보와 객체 데이터를 전달하는 용도로 사용한다.
	*/
	@GetMapping("/goHome0801")
	public ResponseEntity<Member> goHome0801(){
		log.info("goHome0801() 실행...!");
		Member member = new Member();
		return new ResponseEntity<>(member,HttpStatus.OK);
	}
	
	/*
		9. ResponseEntity<List> 타입
			-response 할 때 HTTP 헤더 정보와 객체 배열 데이터를 전달하는 용도로 사용한다.
			
	*/
	@GetMapping("/goHome0901")
	public ResponseEntity<List<Member>> goHome0901(){
		log.info("goHome0901()실행...!");
		List<Member> list = new ArrayList<>();
		Member member1 = new Member();
		Member member2 = new Member();
		list.add(member1);
		list.add(member2);
		return new ResponseEntity<List<Member>>(list, HttpStatus.OK);
	}
	
	/*
		10. ResponseEntity<Map> 타입
			-response 할 때 HTTP 헤더 정보와 객체 데이터를 Map 형태로 전달하는 용도로 사용한다.
	*/
	@GetMapping("/goHome1001")
	public ResponseEntity<Map<String,Member>> goHome1001(){
		log.info("goHome1001 실행...!");
		Map<String, Member> map = new HashMap<>();
		Member member1 = new Member();
		Member member2 = new Member();
		map.put("key1", member1);
		map.put("key2", member2);
		return new ResponseEntity<Map<String,Member>>(map, HttpStatus.OK);
	}
	
	/*
		11. ResponseEntity<byte[]> 타입
			-response 할 때 HTTP 헤더 정보와 바이너리 파일 데이터를 전달하는 용도로 사용한다.
			-파일을 처리하기 위해서 의존 라이브러리인 commons-io 를 추가한다. (pom.xml)
			
			무료/유료 이미지 다운로드 홈페이지를 사용해보면 이미지 미리보기 또는 미리보기 후 다운로드를 할 수 있는
			기능이 제공됩니다. 이와같은 리턴 타입의 형태를 설정해서 내보내는 것과 같습니다.
	 */
	@ResponseBody
	@GetMapping("/goHome1101")
	public ResponseEntity<byte[]> goHome1101(){
		log.info("goHome1101() 실행...!");
		InputStream in = null;
		ResponseEntity<byte[]> entity=null;
		
		
		// byte 배열의 바이너리 데이터를 이용한 썸네일 이미지를 생성하기 위해서는 브라우저에 내장된 Core 엔진이
		// 인식할 수 있는 헤더 정보를 제공해야 합니다. 헤더 정보에 설정된 ContentType과 상태코드, 그리고 응답본문에
		// 설정된 데이터를 기반으로 이미지 썸네일을 만들 수 있습니다.
		HttpHeaders headers = new HttpHeaders();
		try {
			//물리적인 위치에서 파일을 읽어온다
			in= new FileInputStream("D:/upload/default.png");
			headers.setContentType(MediaType.IMAGE_PNG);
			
			//응답 본문에 데이터로 제공하기 위해서는 byte[]에 해당하는 바이너리 데이터가 필요합니다.
			// byte[]의 바이너리 데이터를 제공하기 위해 IOUtils.toByteArray(in)를 이용합니다.
			// IOUtils.toByteArray(in)은 읽은 파일 데이터를 byte[]로 변환해줍니다.
			// 이미지 썸네일을 생성하기 위해서 상태코드는 201(Create)를 응답 상태코드로 설정합니다.
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers, HttpStatus.CREATED);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			try {
				in.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return entity;
	}
	
	@ResponseBody
	@GetMapping("/goHome1102")
	public ResponseEntity<byte[]> goHome1102(){
		
		log.info("goHome1102() 실행함...!");
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		String fileName="20260309_DDIT_File.jpg";
		HttpHeaders headers = new HttpHeaders();
		
		try {
			in = new FileInputStream("D:/upload/default.png");
			
			// 헤더 정보로 ContentType 설정을 2진 바이너리 데이터를 처리할 수 있도록 APPLICATION_OCTET_STREAM 으로
			// 설정합니다. 여기서 APPLICATION_OCTET_STREAM의 OCTET은 8비트, 즉 1바이트를 의미합니다.
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			
			// 파일을 다운로드 하기 위해서는 브라우저가 파일을 어떻게 처리할지가 필요한데 이때, 필요한 설정값이
			// 'Content_Disposition' 이라는 헤더 설정 값입니다.
			// new String (fileName.getBytes("UTF-8"), "ISO-8859-1")은 다운로드 시 응답으로 나갈 파일명에 한글이
			// 포함되어 있는 경우 브라우저가 한글을 인식하고 다운로드가 진행 될 수 있도록 파일을 'UTF-8' 형식의 바이너리로
			// 변경 후 , 'ISO-8859-1'로 변경해 응답으로 내보냅니다.
			headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""+new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers,HttpStatus.CREATED);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				in.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return entity;
	}
	
}

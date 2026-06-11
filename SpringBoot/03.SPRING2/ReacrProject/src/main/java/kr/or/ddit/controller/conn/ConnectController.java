package kr.or.ddit.controller.conn;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.IBlogMemberService;
import kr.or.ddit.vo.BlogMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/react")
public class ConnectController {
	
	@Autowired
	private IBlogMemberService service;
	
	
	@PostMapping("/checkId.do")
	public ResponseEntity<String> checkId(
			@RequestBody Map<String, String> param
			){
		
		log.info("ConnectController.checkId -> memId : "+ param.get("memId"));
		ServiceResult result = service.checkId(param.get("memId"));

		return ResponseEntity.status(HttpStatus.OK).body(result.toString());
	}
	
	@PostMapping("/signup.do")
	public ResponseEntity<String> signup(BlogMemberVO memberVO){
		log.info("ConnectController.signup -> memberVO : " + memberVO.toString());
		ResponseEntity<String> entity = null;
		ServiceResult result = service.signup(memberVO);
		if(result.equals(ServiceResult.OK)) {
			entity = ResponseEntity.status(HttpStatus.OK).body(result.toString());
		}else {
			entity = ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
		}
		return entity;
	}
	
	@PostMapping("/signin.do")
	public ResponseEntity<String> signin(
			@RequestBody BlogMemberVO memberVO
			){
		
		log.info("ConnectController.signin -> memberVO : "+ memberVO);
		String token = service.signin(memberVO);

		return ResponseEntity.status(HttpStatus.OK).body(token);
	}
}

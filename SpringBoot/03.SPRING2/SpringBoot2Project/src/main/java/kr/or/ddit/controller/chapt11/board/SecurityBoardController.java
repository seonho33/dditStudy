package kr.or.ddit.controller.chapt11.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/security/board")
public class SecurityBoardController {

	@Autowired
	private PasswordEncoder pe;
	
	@PostConstruct
	public void init() {
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
		log.info("########" + pe.encode("1234"));
	}
	
	// 목록 화면
	@PreAuthorize("permitAll()")
	@GetMapping("/list")
	public String boardList() {
		return "chapt11/board/list";
	}
	
	// 등록 화면
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
	@GetMapping("register")
	public String boardRegister() {
		return "chapt11/board/register";
	}
	
	
}

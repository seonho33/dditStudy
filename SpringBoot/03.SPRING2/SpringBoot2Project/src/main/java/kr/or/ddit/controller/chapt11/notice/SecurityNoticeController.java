package kr.or.ddit.controller.chapt11.notice;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/security/notice")
public class SecurityNoticeController {

	// 목록 화면
	@GetMapping("/list")
	@PreAuthorize("permitAll()")
	public String noticeList() {
		return "chapt11/notice/list";
	}
	
	// 등록 화면
	@GetMapping("register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String noticeRegister() {
		return "chapt11/notice/register";
	}
	
	
}

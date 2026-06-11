package kr.or.ddit.controller.notice;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice")
public class NoticePageController {

	
	@PreAuthorize("hasRole('ROLE_MEMBER')")
	@GetMapping("/list.do")
	public String list() {
		return "notice/list";
	}
}

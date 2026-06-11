package kr.or.ddit.controller.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.INoticeService;
import kr.or.ddit.vo.notice.NoticeVO;

@CrossOrigin(origins = "*")
@Controller
@RequestMapping("/api/react/notice")
public class NticeAPIController {

	
	@Autowired
	private INoticeService noticeService;
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')")
	@ResponseBody
	@PostMapping("/list")
	public ResponseEntity<List<NoticeVO>> noticeList(){
		List<NoticeVO> noticeList = noticeService.selectNoticeList();
		return new ResponseEntity<List<NoticeVO>>(noticeList, HttpStatus.OK);
	}
	
}

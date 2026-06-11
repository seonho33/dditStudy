package kr.or.ddit.notice.web;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.notice.service.INoticeService;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.ServiceResult;

@Controller
@RequestMapping("/notice")
public class NoticeInsertController {
	
	@Autowired
	private INoticeService noticeService;
	
	//일반 게시판 목록 요청
	@GetMapping("/form.do")
	public String noticeInsertForm() {
		return "notice/form";
	}
	
	@PostMapping("/InsertForm.do")
	public String noticeInsert(NoticeVO noticeVO, Model model) {
		
		String goPage = ""; 
		Map<String, Object> errors = new HashMap<>();
		
		if(StringUtils.isBlank(noticeVO.getNoticeTitle())) {
			errors.put("noticeTitle", "제목을 입력해주세요!");
		}
		if(StringUtils.isBlank(noticeVO.getNoticeContent())) {
			errors.put("noticeContent","내용을 입력해주세요!");
		}
		
		if(errors.size()>0) {
			model.addAttribute("error",errors);
			model.addAttribute("noticeVO",noticeVO);
			goPage = "notice/form";
			return goPage;
		}
		
		noticeVO.setNoticeWriter("a001");
		ServiceResult result = noticeService.insertNotice(noticeVO);
		model.addAttribute("noticeVO",noticeVO);
		if(result.equals(ServiceResult.OK)) {
			goPage = "redirect:/notice/detail.do?noticeNo="+noticeVO.getNoticeNo();
		}else {
			model.addAttribute("noticeVO",noticeVO);
			goPage="notice/form";
		}
		
		return goPage;
	}
	
}

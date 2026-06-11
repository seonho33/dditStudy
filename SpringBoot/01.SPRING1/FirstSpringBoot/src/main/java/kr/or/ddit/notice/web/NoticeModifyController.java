package kr.or.ddit.notice.web;

import kr.or.ddit.notice.service.INoticeService;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.ServiceResult;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice")
public class NoticeModifyController {
	
	@Autowired
	private INoticeService noticeService;
	
	@GetMapping("/update.do")
	public String noticeUpdateForm(int noticeNo,Model model) {
		
		NoticeVO noticeVO = noticeService.selectNotice(noticeNo); 
		
		model.addAttribute("update","update");
		model.addAttribute("noticeVO",noticeVO);
		
		return "notice/form";
	}
	
	@PostMapping("/update.do")
	public String noticeUpdate(NoticeVO noticeVO, Model model) {
		String goPage="";
		ServiceResult result = noticeService.updateNotice(noticeVO);
		if(result.equals(ServiceResult.OK)) {
			goPage = "redirect:/notice/detail.do?noticeNo="+noticeVO.getNoticeNo();
		}else {
			model.addAttribute("noticeVO",noticeVO);
			model.addAttribute("update","update");
			goPage = "notice/form";
		}
		
		return goPage;
	}
	
	@PostMapping("/delete.do")
	public String deleteNotice(int noticeNo) {
		String goPage ="";
		
		ServiceResult result;
		
		result = noticeService.deleteNotice(noticeNo);
		
		if(result.equals(ServiceResult.OK)){
			goPage = "redirect:/notice/list.do";
		}else {
			goPage = "redirect:/notice/detail.do?noticeNo"+noticeNo;
		}
		
		return goPage;
	}
}

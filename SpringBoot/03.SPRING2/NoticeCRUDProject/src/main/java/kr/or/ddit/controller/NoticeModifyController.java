package kr.or.ddit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.INoticeService;
import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeModifyController {

	
	@Autowired
	private INoticeService noticeService;
	
	// 수정 페이지 요청
	@GetMapping("/update.do")
	public String noticeUpdateForm(int boNo, Model model) {
		NoticeVO noticeVO = noticeService.selectNotice(boNo);
		
		model.addAttribute("notice",noticeVO);
		model.addAttribute("status","u");
		
		return "notice/form";
	}
	
	// 수정 기능 요청
	@PostMapping("/update.do")
	public String noticeUpdate(NoticeVO noticeVO, Model model,RedirectAttributes ra) {
		String goPage = "";
		ServiceResult result = noticeService.updateNotice(noticeVO);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message","수정이 완료되었습니다!");
			goPage = "redirect:/notice/detail.do?boNo=" + noticeVO.getBoNo();
		}else {
			model.addAttribute("message","수정에 실패하였습니다!");
			model.addAttribute("notice",noticeVO);
			model.addAttribute("status","u");
			goPage = "notice/form";
		}
		
		return goPage;
	}
	
	// 삭제 기능 요청
	@PostMapping("/delete.do")
	public String noticeDelete(int boNo, Model model,RedirectAttributes ra) {
		String goPage = "";
		ServiceResult result = noticeService.deleteNotice(boNo);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message","삭제가 완료되었습니다!");
			goPage = "redirect:/notice/list.do";
		}else {
			model.addAttribute("message","서버에러 다시 시도해주세요!");
			goPage = "redirect:/notice/detail.do?boNo="+boNo;
		}
		
		return goPage;
	}
}

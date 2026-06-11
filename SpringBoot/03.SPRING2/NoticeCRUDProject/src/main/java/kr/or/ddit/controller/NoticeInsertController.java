package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.INoticeService;
import kr.or.ddit.vo.NoticeMemberVO;
import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeInsertController {

	@Autowired
	private INoticeService noticeService;
	
	//공지사항 등록 페이지 요청
	@GetMapping("/form.do")
	public String noticeForm() {
		
		return "notice/form";
	}
	
	
	// 공지사항 게시판 등록 요청
	@PostMapping("/insert.do")
	public String noticeInsert(
			NoticeVO noticeVO, Model model, HttpSession session,RedirectAttributes ra
			) {
		String goPage = "";
		
		Map<String, String> errors = new HashMap<>();
		if(StringUtils.isBlank(noticeVO.getBoTitle())) {
			errors.put("boTitle", "제목을 입력해주세요!");
		}
		if(StringUtils.isBlank(noticeVO.getBoContent())) {
			errors.put("boContent", "내용을 입력해주세요!");
		}
		
		if(errors.size()>0) {
			model.addAttribute("errors",errors);
			model.addAttribute("noticeVO",noticeVO);
			goPage = "notice/form";
		}else {
			//세션 정보를 꺼내고 로그인 여부에 따라 등록 처리 
			NoticeMemberVO memberVO = (NoticeMemberVO) session.getAttribute("SessionInfo");
			if(memberVO != null) {
				noticeVO.setBoWriter(memberVO.getMemId());
				ServiceResult result = noticeService.insertNotice(noticeVO);
				if(result.equals(ServiceResult.OK)) {
					ra.addFlashAttribute("message","게시글 등록완료");
					goPage = "redirect:/notice/detail.do?boNo="+noticeVO.getBoNo();
				}else {
					model.addAttribute("message", "서버에러, 다시 시도해주세요!");
					goPage = "notice/form";
				}
			}else {
				ra.addFlashAttribute("message","세션이 만료되었습니다.");
				goPage = "redirect:/notice/login.do";
			}
		}
		
		return goPage;
	}
	
	
}

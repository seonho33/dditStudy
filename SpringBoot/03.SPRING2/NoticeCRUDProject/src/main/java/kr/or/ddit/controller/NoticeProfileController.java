package kr.or.ddit.controller;

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
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeProfileController {

	@Autowired
	private INoticeService noticeService;
	
	
	//공지사항 마이페이지 요청
	@GetMapping("/profile.do")
	public String noticeProfile(
			HttpSession session,
			RedirectAttributes ra,
			Model model) {
		
		String goPage = "";
		
		NoticeMemberVO sessionMember = (NoticeMemberVO)session.getAttribute("SessionInfo");
		
		if(sessionMember == null) {
			ra.addFlashAttribute("message","로그인 후 사용 가능합니다!");
			return "redirect:/notice/login.do";
		}
		
		NoticeMemberVO member = noticeService.selectMember(sessionMember.getMemId());
		
		if(member != null) {
			model.addAttribute("member",member);
			goPage = "notice/profile";
		}else {
			ra.addFlashAttribute("message","로그인 후 이용 가능합니다!");
			goPage = "redirect:/notice/login.do";
		}
		
		return goPage;
	}
	
	@PostMapping("/profileUpdate.do")
	public String noticeProfileUpdate(
			NoticeMemberVO memberVO,
			RedirectAttributes ra,
			Model model) {
		String goPage = "";
		ServiceResult result = noticeService.profileUpdate(memberVO);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message","회원정보 수정이 완료되었습니다.");
			goPage = "redirect:/notice/profile.do";
		}else {
			model.addAttribute("member",memberVO);
			goPage = "notice/profile"; 
		}
		return goPage;
	}


}

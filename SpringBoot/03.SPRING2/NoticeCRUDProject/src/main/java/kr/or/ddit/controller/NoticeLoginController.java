package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import io.micrometer.common.util.StringUtils;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.NoticeCrudProjectApplication;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.INoticeService;
import kr.or.ddit.vo.NoticeMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeLoginController {

    private final NoticeCrudProjectApplication noticeCrudProjectApplication;
	
	
	@Autowired
	private INoticeService noticeService;


    NoticeLoginController(NoticeCrudProjectApplication noticeCrudProjectApplication) {
        this.noticeCrudProjectApplication = noticeCrudProjectApplication;
    }
	

	//공지사항 로그인 페이지 요청
	@GetMapping("/login.do")
	public String noticeLogin(Model model) {
		
		model.addAttribute("bodyText","login-page");
		
		return "notice/login";
	}

	@PostMapping("/loginCheck.do")
	public String noticeLogin(HttpServletRequest req,NoticeMemberVO member,Model model,RedirectAttributes ra) {
		String goPage = "";
		Map<String, String> errors = new HashMap<>();
		
		if(StringUtils.isBlank(member.getMemId())) {
			errors.put("memId","아이디를 입력해주세요!");
		}
		
		if(StringUtils.isBlank(member.getMemPw())) {
			errors.put("memPw","비밀번호를 입력해주세요!");
		}
		
		if(errors.size()>0) {
			model.addAttribute("bodyText","login-page");
			model.addAttribute("errors",errors);
			model.addAttribute("member",member);
			goPage = "notice/login";
		}else {
			NoticeMemberVO memberVO = noticeService.loginCheck(member);
			if(memberVO != null) {	//로그인 성공
				// 세션에 로그인 정보를 기록
				HttpSession session = req.getSession();
				session.setAttribute("SessionInfo", memberVO);
				
				ra.addFlashAttribute("message", member.getMemId()+"님! 반갑습니다!");
				goPage = "redirect:/notice/list.do";
				
			}else {					// 로그인 실패
				model.addAttribute("message","서버에러 로그인 정보를 정확하게 입력해주세요");
				model.addAttribute("member",member);
				model.addAttribute("bodyText","login-page");
				goPage="notice/login";
			}
		}
		return goPage;
	}
	
	//공지사항 회원가입 페이지 요청
	@GetMapping("/signup.do")
	public String noticeSignup(Model model) {
		
		model.addAttribute("bodyText","register-page");

		
		return "notice/register";
	}

	// 아이디 중복 확인 요청
	@PostMapping("/idCheck.do")
	@ResponseBody
	public ResponseEntity<ServiceResult> idCheck(@RequestBody Map<String,String> map){
		
		String memId = map.get("memId");
		log.info("memId : " + map.get("memId"));
		ServiceResult result = noticeService.idCheck(memId);
		
		return new ResponseEntity<ServiceResult>(result,HttpStatus.OK);
	}
	
	@PostMapping("/signup.do")
	public String signup(NoticeMemberVO memberVO, Model model, RedirectAttributes ra) {
		String goPage="";
		
		Map<String,String> errors = new HashMap<>();
		
		if(StringUtils.isBlank(memberVO.getMemId())) {
			errors.put("memId", "아이디를 입력해주세요!");
		}
		
		if(StringUtils.isBlank(memberVO.getMemPw())) {
			errors.put("memId", "비밀번호를 입력해주세요!");
		}
		
		if(StringUtils.isBlank(memberVO.getMemName())) {
			errors.put("memId", "이름을 입력해주세요!");
		}
		
		if(errors.size()>0) {	//입력된 데이터에 문제 발생!
			model.addAttribute("bodyText","register-page");
			model.addAttribute("errors",errors);
			model.addAttribute("member",memberVO);
			goPage = "notice/register";
		}else {					//정상
			ServiceResult result = noticeService.signup(memberVO);
			if(result.equals(ServiceResult.OK)) {	//정상
				ra.addFlashAttribute("message","회원가입 완료!");
				goPage = "redirect:/notice/login.do";
			}else {
				ra.addAttribute("bodyText","register-page");
				ra.addAttribute("message","서버에러, 다시 시도해주세요!");
				ra.addAttribute("member",memberVO);
				goPage = "notice/register";
			}
		}
		
		return goPage;
	}
	
	
	//공지사항 아이디/비밀번호 찾기 페이지 요청
	@GetMapping("/forget.do")
	public String noticeLoginForgetIdAndPw(Model model) {
		
		model.addAttribute("bodyText","login-page");
		
		return "notice/forget";
	}

	//아이디 찾기
	@PostMapping("/idForget.do")
	public ResponseEntity<String> idForgetProcess(
			@RequestBody NoticeMemberVO member
			){
		ResponseEntity<String> entity = null;
		String memId = noticeService.idForgetProcess(member);
		if(memId != null) {
			entity = ResponseEntity.ok(memId);
		}else {
			entity = ResponseEntity.badRequest().build();
		}
		
		return entity;
	}
	
	
	//비밀번호 찾기
	@PostMapping("/pwForget.do")
	public ResponseEntity<String> pwForgetProcess(
			@RequestBody NoticeMemberVO member){
		String memPw = noticeService.pwForgetProcess(member);
		
		return new ResponseEntity<String>(memPw, HttpStatus.OK);
	}
	
	//로그아웃 기능 요청
	@GetMapping("/logout.do")
	public String logout(HttpSession session, RedirectAttributes ra) {
		
		session.invalidate();	//session 초기화
		ra.addFlashAttribute("message","정상적으로 로그아웃 되었습니다!");
		
		return "redirect:/notice/login.do";
	}

	
}

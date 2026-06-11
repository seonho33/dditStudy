package kr.or.ddit.testMember.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.testMember.service.ITTestMemberService;
import kr.or.ddit.vo.crud.CrudMember;

@Controller
@RequestMapping("/ttest")
public class TTestMemberController {

	
	@Autowired
	private ITTestMemberService service;
	
	
	@GetMapping("/register")
	public String registerForm() {
		
		return "ttest/register";
	}
	
	@PostMapping("/register")
	public String registerMember(Model model,CrudMember member) {
		
		service.register(member);
		
		model.addAttribute("msg","등록완료");
		
		return "ttest/success";
		
	}
	
	@GetMapping("/list")
	public String listPage(Model model) {
		
		List<CrudMember> memberList = service.getList();
		
		model.addAttribute("memberList",memberList);
		
		return "ttest/list";
	}
	
	@GetMapping("/read")
	public String read(int userId,Model model) {
		
		CrudMember member = service.read(userId);
		
		model.addAttribute("member",member);
		
		return "ttest/read";
	}
	
}

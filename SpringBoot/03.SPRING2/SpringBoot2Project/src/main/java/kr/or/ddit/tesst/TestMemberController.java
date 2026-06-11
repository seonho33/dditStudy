package kr.or.ddit.tesst;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.tesst.service.ITestMemberService;
import kr.or.ddit.vo.crud.CrudMember;

@Controller
@RequestMapping("/testMember")
public class TestMemberController {

	@Autowired
	private ITestMemberService service;
	
	@GetMapping("/register")
	public String RegisterForm() {
		
		return "TestMember/register";
	}
	
	
	@PostMapping("/register")
	public String Rgister(CrudMember member,Model model) {
		
		service.register(member);
		
		model.addAttribute("msg","등록완료되었습니다");
		
		return "TestMember/success";
	}
	
	@GetMapping("/list")
	public String getList(Model model) {
		
		List<CrudMember> memberList =  service.getList();
		
		model.addAttribute("memberList",memberList);
		
		return "TestMember/list";
	}
	
	@GetMapping("/modify")
	public String modifyForm(int userNo, Model model) {
		CrudMember member = service.getMember(userNo);
		
		model.addAttribute("member",member);
		
		return "TestMember/modify";
	}
	
	
	@PostMapping("/modify")
	public String updateMember(CrudMember member, Model model) {
		
		service.updateMember(member);
		
		CrudMember getMember = service.getMember(member.getUserNo());
		
		model.addAttribute("member",getMember);
		
		return "TestMember/detail";
	}
	
	@GetMapping("/detail")
	public String detailMember(int userNo,Model model) {
		
		CrudMember member = service.getMember(userNo);
		
		model.addAttribute("member",member);
		
		return "TestMember/detail";
	}
	
	@PostMapping("/deleteMember")
	@ResponseBody
	public String deleteMember(int userNo) {
		
		service.deleteMember(userNo);
		
		return "OK";
	}
	
}

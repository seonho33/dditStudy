package kr.or.ddit.controller.chapt08.member;

import java.io.IOException;
import java.util.List;

import org.springframework.aop.support.AopUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.annotation.PostConstruct;
import kr.or.ddit.controller.chapt08.member.service.IMemberService;
import kr.or.ddit.vo.crud.CrudMember;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/crud/member")
public class CrudMemberController {
	
	@Autowired
	private IMemberService service;
	
	@PostConstruct
	public void init() {
		// aopProxy 는 인터페이스 기반의 프록시를 생성한 Dynamic Proxy를 사용하여 위빙을 지정합니다.
		// - 인터페이스를 구현하고 해당 인터페이스를 참조해서 구현한 클래스를 사용하는 형태(service, impl)
		log.info("### aopProxy 상태 (interface 기반) : " + AopUtils.isAopProxy(service));
		
		// 인터페이스 기반이 아닌 클래스 기반의 프록시를 생성한 Cglib Proxy를 사용하여 위빙을 지정합니다.
		// - 인터페이스 구현 없이 클래스로만 사용되는 형태
		log.info("### aopProxy 상태 (class 기반) : " + AopUtils.isCglibProxy(service));
		
		
	}
	
	//등록 페이지 요청
	@GetMapping("/register")
	public String crudmemberRegisterForm() {
	
		return "chapt08/member/register";
	}
	
	
	@PostMapping("/register")
	public String crudMemberRegister(CrudMember member, Model model)throws IOException {
		log.info("crudMemberRegister() 실행...!");
		log.info("userId : " + member.getUserId());
		
		// Controller > Service "회원 등록 진행해줘" 요청
		service.register(member);
		model.addAttribute("msg","회원등록 성공!");
		
		return "chapt08/member/success";
	}
	
	//목록 페이지 요청
	@GetMapping("/list")
	public String crudMemberList(Model model) {
		log.info("crudMemberList() 실..행..");
		
		List<CrudMember> memberList = service.list();
		model.addAttribute("memberList",memberList);
		
		return "chapt08/member/list";
	}
	
	//상세 페이지 요청
	@GetMapping("/read")
	public String crudMemberDetail(int userNo, Model model) {
		log.info("crudMemberDetail ... 실..행..");
		
		CrudMember member = service.read(userNo);
		model.addAttribute("member",member);
		
		return "chapt08/member/detail";
	}
	
	@GetMapping("/modify")
	public String crudMemberModifyForm(int userNo, Model model) {
		log.info("crudModifyForm()...실행...");
		
		CrudMember member = service.read(userNo);
		
		model.addAttribute("member",member);
		
		return "chapt08/member/modify";
	}
	@PostMapping("/modify")
	public String crudMemberModify(CrudMember member, Model model) {
		log.info("crudModify()...실행...");
		
		service.modify(member);
		
		model.addAttribute("msg","수정이 완료되었습니다");
		
		return "chapt08/member/success";
	}
	@PostMapping("/crudRemove")
	public String crudMemberRemove(int userNo, Model model) {
		log.info("crudMemberRemove()...실행...");
		
		service.delete(userNo);
		
		model.addAttribute("msg","삭제가 완료되었습니다");
		
		return "chapt08/member/success";
	}
}

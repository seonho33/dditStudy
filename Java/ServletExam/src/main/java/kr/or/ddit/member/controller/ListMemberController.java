package kr.or.ddit.member.controller;

import java.io.IOException;

import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet(value = "/member/list.do")
public class ListMemberController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		IMemberService memService = 
				MemberServiceImpl.getInstance();
		
		List<MemberVO> memList = memService.displayAllMember();
		
		req.setAttribute("memList", memList);
		
		log.info("memList : {}", memList);
		
		req.getRequestDispatcher("/views/member/list.jsp")
			.forward(req, resp); // JSP에게 요청 전달
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}

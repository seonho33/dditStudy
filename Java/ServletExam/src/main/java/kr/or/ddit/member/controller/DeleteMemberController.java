package kr.or.ddit.member.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;


@WebServlet("/member/delete.do")
public class DeleteMemberController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String memId = req.getParameter("memId");
		
		IMemberService memService = MemberServiceImpl.getInstance();
		
		int cnt = memService.removeMember(memId);
		
		String msg = "";
		if(cnt > 0) {
			msg = "SUCCESS";
		}else {
			msg = "FAIL";
		}
		
		req.getSession().setAttribute("msg", msg);
		
		resp.sendRedirect(req.getContextPath() + "/member/list.do");
		
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	
}

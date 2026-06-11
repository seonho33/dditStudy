package kr.or.ddit.member.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.cmm.service.AtchFileServiceImpl;
import kr.or.ddit.cmm.service.IAtchFileService;
import kr.or.ddit.cmm.vo.AtchFileVO;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

@MultipartConfig
@WebServlet("/member/insert.do")
public class InsertMemberController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.getRequestDispatcher("/views/member/insertForm.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String memId = req.getParameter("memId");
		String memName = req.getParameter("memName");
		String memTel = req.getParameter("memTel");
		String memAddr = req.getParameter("memAddr");
		
		IAtchFileService atchFileService = 
				AtchFileServiceImpl.getInstance();
		
		AtchFileVO atchFileVO = 
				atchFileService.saveAtchFileList(req.getParts());
		
		
		
		IMemberService memServic0e = 
				MemberServiceImpl.getInstance();
		
		MemberVO mv = 
				new MemberVO(memId, memName, memTel, memAddr);

		if(atchFileVO == null) { // 첨부파일이 하나도 추가되지 않은 경우..
			mv.setAtchFileId(-1); // 첨부파일이 없는 경우...
		}else { // 첨부파일이 존재하는 경우(업로드 처리가 진행된 경우...)
			mv.setAtchFileId(atchFileVO.getAtchFileId());
		}
		
		int cnt = memServic0e.registerMember(mv);
		
		String msg = "";
		
		if(cnt > 0) {
			msg = "SUCCESS";
		}else {
			msg = "FAIL";
		}
		
		req.getSession().setAttribute("msg", msg);
		
		// 포워딩 처리...
		//req.getRequestDispatcher("/member/list.do").forward(req, resp);
		
		// 리다이렉트 처리...
		resp.sendRedirect(req.getContextPath() + "/member/list.do");
		
		
		
	}
}

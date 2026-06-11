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
@WebServlet("/member/update.do")
public class UpdateMemberController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String memId = req.getParameter("memId");
		
		IMemberService memService = 
				MemberServiceImpl.getInstance();
		
		MemberVO mv = memService.getMember(memId);
		
		req.setAttribute("mv", mv);
		
		if(mv.getAtchFileId() > 0) {
			IAtchFileService fileService = AtchFileServiceImpl.getInstance();
			
			AtchFileVO atchFileVO = new AtchFileVO();
			atchFileVO.setAtchFileId(mv.getAtchFileId());
			atchFileVO = fileService.getAtchFile(atchFileVO);
			
			req.setAttribute("atchFileVO", atchFileVO);
		}
		
		req.getRequestDispatcher("/views/member/updateForm.jsp")
			.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String memId = req.getParameter("memId");
		String memName = req.getParameter("memName");
		String memTel = req.getParameter("memTel");
		String memAddr = req.getParameter("memAddr");
		
		String atchFileId = req.getParameter("atchFileId");
		
		String delYn = req.getParameter("delYn") == null ? 
				"N" : req.getParameter("delYn");
		
		
		IAtchFileService fileService = 
				AtchFileServiceImpl.getInstance();
		
		AtchFileVO atchFileVO = fileService
				.saveAtchFileList(req.getParts()); 
				
		IMemberService memService = 
				MemberServiceImpl.getInstance();
		MemberVO mv = 
				new MemberVO(memId, memName, memTel, memAddr);
		
		if(atchFileVO == null) { // 신규 첨부파일이 존재하지 않는 경우...
			
			if(delYn.equals("Y")) { // 기존 첨부파일을 삭제 처리...
				mv.setAtchFileId(-1);
			}else {
				// 기존 첨부파일ID 유지...
				mv.setAtchFileId(Long.parseLong(atchFileId));
			}
			
		}else {
			// 신규로 채번된 첨부파일ID로 설정하기
			mv.setAtchFileId(atchFileVO.getAtchFileId());;
		}
		
		int cnt = memService.modifyMember(mv);
		
		String msg = "";
		if(cnt > 0) {
			msg = "SUCCESS";
		}else {
			msg = "FAIL";
		}
		
		req.getSession().setAttribute("msg", msg);
		
		resp.sendRedirect(req.getContextPath() 
				+ "/member/list.do");
		
	}
}

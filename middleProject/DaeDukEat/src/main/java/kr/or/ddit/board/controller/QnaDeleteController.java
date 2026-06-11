package kr.or.ddit.board.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.board.service.IQnaService;
import kr.or.ddit.board.service.QnaServiceImpl;
import kr.or.ddit.board.vo.QnaVO;
import kr.or.ddit.user.vo.UserVO;

/**
 * Q&A 질문 삭제 Controller
 */
@WebServlet("/qna/delete.do")
public class QnaDeleteController extends HttpServlet {
    
    private IQnaService service = QnaServiceImpl.getInstance();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
    	System.out.print("컨트롤러 접근함");
    	
        // 파라미터 수집
        String qnaIdParam = req.getParameter("qnaId");
        
        System.out.print("qna == " + qnaIdParam);
        
        
        if(qnaIdParam == null || qnaIdParam.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/qna/list.do");
            return;
        }
        
        Long qnaId = Long.parseLong(qnaIdParam);
        QnaVO qna = service.getQnaDetail(qnaId);
        
        if(qna == null) {
            resp.sendRedirect(req.getContextPath() + "/qna/list.do");
            return;
        }
        
        // 본인 또는 관리자만 삭제 가능
        HttpSession session = req.getSession();
        UserVO uvo = (UserVO)session.getAttribute("loginUser");
        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();
        
        if(!"ADMIN".equals(userRole) && !qna.getUserId().equals(userId)) {
            resp.sendRedirect(req.getContextPath() + "/qna/list.do");
            return;
        }
        
        // 삭제
        boolean result = service.deleteQna(qnaId);
        
        resp.sendRedirect(req.getContextPath() + "/qna/list.do");
    }
}
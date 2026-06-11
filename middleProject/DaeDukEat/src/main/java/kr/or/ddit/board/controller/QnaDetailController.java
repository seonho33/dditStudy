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
 * Q&A 상세 조회 Controller
 */
@WebServlet("/qna/detail.do")
public class QnaDetailController extends HttpServlet {
    
    private IQnaService service = QnaServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String qnaIdParam = req.getParameter("qnaId");
        
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
        
        // 비밀글 권한 체크
        HttpSession session = req.getSession();
        
        
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        //uvo널처리
        if(uvo==null) {
        	resp.sendRedirect(req.getContextPath() + "/login.do");
        	return;
        }
        
        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();
        
        if ("Y".equals(qna.getSecretYn())) {
            if (!"관리자".equals(userRole) && !qna.getUserId().equals(userId)) {

                session.setAttribute("flashMsg", "비밀글은 작성자와 관리자만 볼 수 있습니다.");
                resp.sendRedirect(req.getContextPath() + "/qna/list.do");
                return;
            }
        }

        // JSP로 전달
        req.setAttribute("qna", qna);
//        req.setAttribute("userId", userId);
        
        req.getRequestDispatcher("/TEST/views/board/qnaDetail.jsp").forward(req, resp);
        
    }
}
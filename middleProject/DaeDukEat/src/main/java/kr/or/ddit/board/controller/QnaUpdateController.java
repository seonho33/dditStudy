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
 * Q&A 질문 수정 Controller
 */
@WebServlet("/qna/update.do")
public class QnaUpdateController extends HttpServlet {
    
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
        
        // 본인만 수정 가능
        HttpSession session = req.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        String userId = uvo.getUserId();
       // String userId = (String) session.getAttribute("userId");
        
        if(!qna.getUserId().equals(userId)) {
            resp.sendRedirect(req.getContextPath() + "/qna/list.do");
            return;
        }
        
        // 수정 폼으로 이동
        req.setAttribute("qna", qna);
        req.getRequestDispatcher("/TEST/views/board/qnaUpdate.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        
        // 파라미터 수집
        String qnaIdParam = req.getParameter("qnaId");
        String qnaTitle = req.getParameter("qnaTitle");
        String qnaContent = req.getParameter("qnaContent");
        String secretYn = req.getParameter("secretYn");
        
        if(qnaIdParam == null || qnaTitle == null || qnaContent == null) {
            resp.sendRedirect(req.getContextPath() + "/qna/list.do");
            return;
        }
        
        // VO 생성
        QnaVO qna = new QnaVO();
        qna.setQnaId(Long.parseLong(qnaIdParam));
        qna.setQnaTitle(qnaTitle);
        qna.setQnaContent(qnaContent);
        qna.setSecretYn(secretYn != null ? secretYn : "N");
        
        // 수정
        boolean result = service.updateQna(qna);
        
        if(result) {
            resp.sendRedirect(req.getContextPath() + "/qna/detail.do?qnaId=" + qna.getQnaId());
        } else {
            req.setAttribute("errorMsg", "질문 수정에 실패했습니다.");
            req.setAttribute("qna", qna);
            req.getRequestDispatcher("/TEST/views/board/qnaUpdate.jsp").forward(req, resp);
        }
    }
}
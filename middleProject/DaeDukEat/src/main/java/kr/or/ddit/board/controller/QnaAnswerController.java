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
 * Q&A 답변 등록 Controller (관리자 전용)
 */
@WebServlet("/qna/answer.do")
public class QnaAnswerController extends HttpServlet {
    
    private IQnaService service = QnaServiceImpl.getInstance();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        
        // 관리자 권한 체크
		/*
		 * HttpSession session = req.getSession(); String userRole = (String)
		 * session.getAttribute("userRole");
		 * 
		 * if(!"관리자".equals(userRole)) { resp.sendRedirect(req.getContextPath() +
		 * "/qna/list.do"); return; }
		 */
        
        
        HttpSession session = req.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");

        // 1. 로그인 여부 확인
        if(uvo == null) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }

        // 2. 권한 확인 (division이 '관리자'인지 체크)
        // uvo.getDivision() 값이 '관리자'인 경우에만 통과
        if(!"관리자".equals(uvo.getDivision())) {
            resp.sendRedirect(req.getContextPath() + "/notice/list.do");
            return;
        }

        // 3. 권한 통과 시 로직 수행
        String userId = uvo.getUserId();
        // ... 이후 수정/등록 로직 진행 ...
        
        // 파라미터 수집
        String qnaIdParam = req.getParameter("qnaId");
        String answerContent = req.getParameter("answerContent");
        
        if(qnaIdParam == null || answerContent == null || answerContent.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/qna/list.do");
            return;
        }
        
        // VO 생성
        QnaVO qna = new QnaVO();
        qna.setQnaId(Long.parseLong(qnaIdParam));
        qna.setAnswerContent(answerContent);
        
        // 답변 등록
        boolean result = service.insertAnswer(qna);
        
        if(result) {
            resp.sendRedirect(req.getContextPath() + "/qna/detail.do?qnaId=" + qna.getQnaId());
        } else {
            resp.sendRedirect(req.getContextPath() + "/qna/detail.do?qnaId=" + qna.getQnaId());
        }
    }
}
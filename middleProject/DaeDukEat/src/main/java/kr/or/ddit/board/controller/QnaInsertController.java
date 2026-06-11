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
 * Q&A 질문 등록 Controller
 */
@WebServlet("/qna/insert.do")
public class QnaInsertController extends HttpServlet {
    
    private IQnaService service = QnaServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // 관리자는 질문 등록 불가
		/*
		 * HttpSession session = req.getSession(); String userRole = (String)
		 * session.getAttribute("userRole");
		 * 
		 * if("ADMIN".equals(userRole)) { resp.sendRedirect(req.getContextPath() +
		 * "/qna/list.do"); return;
		 }*/
    	
    	   HttpSession session = req.getSession();
           String userRole = (String) session.getAttribute("userRole");
           
           if("관리자".equals(userRole)) {
               resp.sendRedirect(req.getContextPath() + "/qna/list.do");
               return;
           }
        
        // 등록 폼으로 이동
        req.getRequestDispatcher("/TEST/views/board/qnaUpdate.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        
        // 세션 체크
        HttpSession session = req.getSession();
        
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();
        
 //       String userId = (String) session.getAttribute("userId");
 //       String userRole = (String) session.getAttribute("userRole");
     
        
        // ★ 여기다 추가: 세션에서 꺼낸 아이디가 진짜 뭔지 확인
        System.out.println("=== QnaInsert Debug ===");
        System.out.println("세션에서 꺼낸 userId: [" + userId + "]");
        System.out.println("세션에서 꺼낸 userRole: [" + userRole + "]");
        
        if(userId == null || "관리자".equals(userRole)) {
            System.out.println("결과: 로그인 안됨 혹은 관리자라 튕김");
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }
        
        if(userId == null || "관리자".equals(userRole)) {
            resp.sendRedirect(req.getContextPath() + "/login.do");
            return;
        }
        
        // 파라미터 수집
        String qnaTitle = req.getParameter("qnaTitle");
        String qnaContent = req.getParameter("qnaContent");
        String secretYn = req.getParameter("secretYn");
        
        // 유효성 검사
        if(qnaTitle == null || qnaTitle.trim().isEmpty() ||
           qnaContent == null || qnaContent.trim().isEmpty()) {
            
            req.setAttribute("errorMsg", "제목과 내용을 입력해주세요.");
            req.getRequestDispatcher("/TEST/views/board/qnaUpdate.jsp").forward(req, resp);
            return;
        }
        
        // VO 생성
        QnaVO qna = new QnaVO();
        qna.setQnaTitle(qnaTitle);
        qna.setQnaContent(qnaContent);
        qna.setSecretYn(secretYn != null ? secretYn : "N");
        qna.setUserId(userId);
        
     // ★ 여기다 추가: DB에 들어가기 직전 최종 값 확인
        System.out.println("DB로 보낼 최종 아이디: " + qna.getUserId());
        System.out.println("=======================");
        
        // 등록
        boolean result = service.insertQna(qna);
        
        if(result) {
            resp.sendRedirect(req.getContextPath() + "/qna/list.do");
        } else {
            req.setAttribute("errorMsg", "질문 등록에 실패했습니다.");
            req.getRequestDispatcher("/TEST/views/board/qnaUpdate.jsp").forward(req, resp);
        }
    }
}
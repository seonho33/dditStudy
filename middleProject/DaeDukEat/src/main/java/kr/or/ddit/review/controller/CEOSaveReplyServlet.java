package kr.or.ddit.review.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.review.service.ICEOReviewService;
import kr.or.ddit.review.service.CEOReviewServiceImpl;
import kr.or.ddit.review.vo.CeoReviewVO;

@WebServlet("/owner/saveReply.do")
public class CEOSaveReplyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        // 1. 설정 및 세션 검증
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8"); // JSON 응답 설정
        
        HttpSession session = req.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        StoreVO loginStore = (StoreVO) session.getAttribute("loginStore");
        
        if (loginUser == null || loginStore == null) {
            resp.getWriter().write("{\"success\": false, \"message\": \"SESSION_EXPIRED\"}");
            return;
        }
        
        // 2. 파라미터 수신 (fetch로 보낼 땐 디코딩 자동처리 되므로 URLDecoder 불필요)
        String reservIdStr = req.getParameter("reservId");
        String replyContent = req.getParameter("content");
        
        if (reservIdStr == null || replyContent == null || replyContent.trim().isEmpty()) {
            resp.getWriter().write("{\"success\": false, \"message\": \"입력값이 누락되었습니다.\"}");
            return;
        }
        
        try {
            Long reservId = Long.parseLong(reservIdStr);
            
            CeoReviewVO ceoReview = new CeoReviewVO();
            ceoReview.setReservId(reservId);
            ceoReview.setReview(replyContent);
            
            ICEOReviewService service = CEOReviewServiceImpl.getInstance();
            boolean result = service.saveCeoReply(ceoReview);
            
            // 3. 결과 반환 (리다이렉트 금지!)
            if (result) {
                resp.getWriter().write("{\"success\": true}");
            } else {
                resp.getWriter().write("{\"success\": false, \"message\": \"DB 저장 실패\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("{\"success\": false, \"message\": \"서버 오류 발생\"}");
        }
    }
}
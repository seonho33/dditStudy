package kr.or.ddit.review.controller;

import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.review.service.IReviewService;
import kr.or.ddit.review.service.ReviewServiceImpl;

/**
 * 리뷰 삭제 서블릿 (AJAX 전용)
 * 
 * @author Legacy Architecture Team
 * @since 2025-01-30
 * @url /review/deletereview.do
 * @method POST
 * @response JSON
 */
@WebServlet("/review/deletereview.do")
public class DeleteReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private IReviewService service;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        service = ReviewServiceImpl.getInstance();
        gson = new Gson();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        // 세션 체크
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        if (uvo == null) {
            sendJsonResponse(response, false, "로그인이 필요합니다.");
            return;
        }
        
        // 파라미터 수집
        String reservIdParam = request.getParameter("reservId");
        
        if (reservIdParam == null) {
            sendJsonResponse(response, false, "예약 ID가 필요합니다.");
            return;
        }
        
        try {
            Long reservId = Long.parseLong(reservIdParam);
            
            // 리뷰 삭제 처리
            boolean isSuccess = service.removeReview(reservId);
            
            if (isSuccess) {
                sendJsonResponse(response, true, "리뷰가 삭제되었습니다.");
            } else {
                sendJsonResponse(response, false, "리뷰 삭제에 실패했습니다.");
            }
            
        } catch (NumberFormatException e) {
            sendJsonResponse(response, false, "잘못된 데이터 형식입니다.");
        }
    }
    
    /**
     * JSON 응답 전송 유틸리티
     */
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) 
            throws IOException {
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(new ResponseVO(success, message)));
        out.flush();
    }
    
    /**
     * 응답 DTO
     */
    private static class ResponseVO {
        private boolean success;
        private String message;
        
        public ResponseVO(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
    }
}
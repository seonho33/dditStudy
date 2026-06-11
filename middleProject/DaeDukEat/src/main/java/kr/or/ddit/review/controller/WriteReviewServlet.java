package kr.or.ddit.review.controller;

import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.Gson; // Gson 추가

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.user.vo.UserVO;
import kr.or.ddit.review.service.IReviewService;
import kr.or.ddit.review.service.ReviewServiceImpl;
import kr.or.ddit.review.vo.UserReviewVO;

@WebServlet("/review/writereview.do")
public class WriteReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IReviewService service;
    private Gson gson; // JSON 변환용

    @Override
    public void init() throws ServletException {
        service = ReviewServiceImpl.getInstance();
        gson = new Gson();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // --- 세션 체크 ---
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        if (uvo == null) {
            sendJsonError(response, "로그인이 필요한 서비스입니다.");
            return;
        }

        // --- 파라미터 수집 ---
        String reservIdParam = request.getParameter("reservId");
        String review = request.getParameter("review");
        String ratingParam = request.getParameter("rating");
        String reviewPicture = request.getParameter("reviewPicture");

        // 검증
        if (reservIdParam == null || review == null || ratingParam == null) {
            sendJsonError(response, "필수 정보가 누락되었습니다.");
            return;
        }

        try {
            Long reservId = Long.parseLong(reservIdParam);
            Integer rating = Integer.parseInt(ratingParam);

            UserReviewVO reviewVO = new UserReviewVO();
            reviewVO.setReservId(reservId);
            reviewVO.setReview(review);
            reviewVO.setRating(rating);
            reviewVO.setReviewPicture(reviewPicture);

            // 리뷰 작성 처리
            boolean isSuccess = service.writeReview(reviewVO);

            if (isSuccess) {
                // 성공 시 JSON 응답 (리다이렉트 안 함!)
                sendJsonSuccess(response, "리뷰가 성공적으로 작성되었습니다.");
            } else {
                sendJsonError(response, "리뷰 작성에 실패했습니다.");
            }

        } catch (NumberFormatException e) {
            sendJsonError(response, "잘못된 데이터 형식입니다.");
        }
    }

    /* ====================================
       AJAX 응답을 위한 유틸리티 메서드
       ==================================== */
    private void sendJsonSuccess(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(new ResponseVO(true, message)));
        out.flush();
    }

    private void sendJsonError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(new ResponseVO(false, message)));
        out.flush();
    }

    // 결과 응답용 내부 클래스
    private static class ResponseVO {
        private boolean success;
        private String message;
        public ResponseVO(boolean success, String message) {
            this.success = success;
            this.message = message;
        }
    }
}
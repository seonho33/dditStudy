package kr.or.ddit.store.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;



import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.store.service.IUserReviewService;
import kr.or.ddit.store.service.UserReviewServiceImpl;
import kr.or.ddit.store.vo.UserReviewVO;
import kr.or.ddit.user.vo.UserVO;

/**
 * 리뷰 관리 Controller (개별 Servlet)
 * 
 * [URL 매핑]
 * - ReviewListController: /review/list.do (리뷰 메인 페이지)
 * - ReviewWriteController: /review/write.do (리뷰 작성)
 * - ReviewDeleteController: /review/delete.do (리뷰 삭제)
 */

// ============================================
// 리뷰 메인 페이지 Controller
// ============================================
@WebServlet("/review/list.do")
class ReviewListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserReviewService service = UserReviewServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            // [1] 세션 체크
            HttpSession session = request.getSession();
            UserVO uvo = (UserVO) session.getAttribute("loginUser");
            String userId = uvo.getUserId();
            String userRole = uvo.getDivision();
            
            if(userId == null || userId.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            
            // [2] Service 호출
            List<UserReviewVO> reviewableList = service.getReviewableReservations(userId);
            List<UserReviewVO> myReviewList = service.getMyReviews(userId);
            
            // [3] Request에 데이터 저장
            request.setAttribute("reviewableList", reviewableList);
            request.setAttribute("myReviewList", myReviewList);
            
            // [4] JSP로 forward
            request.getRequestDispatcher("/TEST/views/review/reviewList.jsp").forward(request, response);
            
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "오류가 발생했습니다: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}


// ============================================
// 리뷰 작성 Controller
// ============================================
@WebServlet("/review/write.do")
class ReviewWriteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserReviewService service = UserReviewServiceImpl.getInstance();
    private Gson gson = new Gson();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // [1] 세션 체크
            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("userId");
            
            if(userId == null || userId.trim().isEmpty()) {
                out.print(gson.toJson(new ResponseVO(false, "로그인이 필요합니다.", null)));
                return;
            }
            
            // [2] 파라미터 파싱
            String reservIdStr = request.getParameter("reservId");
            String reviewContent = request.getParameter("review");
            String ratingStr = request.getParameter("rating");
            String reviewPicture = request.getParameter("reviewPicture");
            
            // [3] 파라미터 검증
            if(reservIdStr == null || reviewContent == null || ratingStr == null) {
                out.print(gson.toJson(new ResponseVO(false, "필수 항목을 모두 입력해주세요.", null)));
                return;
            }
            
            // [4] VO 객체 생성
            UserReviewVO review = new UserReviewVO();
            review.setReservId(Long.parseLong(reservIdStr));
            review.setReview(reviewContent);
            review.setRating(Integer.parseInt(ratingStr));
            review.setReviewPicture(reviewPicture);
            
            // [5] Service 호출
            boolean success = service.writeReview(review, userId);
            
            // [6] JSON 응답
            if(success) {
                out.print(gson.toJson(new ResponseVO(true, "리뷰가 작성되었습니다.", null)));
            } else {
                out.print(gson.toJson(new ResponseVO(false, "리뷰 작성에 실패했습니다.", null)));
            }
            
        } catch(IllegalArgumentException e) {
            // 입력 검증 실패
            out.print(gson.toJson(new ResponseVO(false, e.getMessage(), null)));
        } catch(IllegalStateException e) {
            // 비즈니스 규칙 위반
            out.print(gson.toJson(new ResponseVO(false, e.getMessage(), null)));
        } catch(Exception e) {
            e.printStackTrace();
            out.print(gson.toJson(new ResponseVO(false, "오류가 발생했습니다: " + e.getMessage(), null)));
        } finally {
            out.flush();
        }
    }
}


// ============================================
// 리뷰 삭제 Controller
// ============================================
@WebServlet("/review/delete.do")
class ReviewDeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserReviewService service = UserReviewServiceImpl.getInstance();
    private Gson gson = new Gson();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            // [1] 세션 체크
            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("userId");
            
            if(userId == null || userId.trim().isEmpty()) {
                out.print(gson.toJson(new ResponseVO(false, "로그인이 필요합니다.", null)));
                return;
            }
            
            // [2] 파라미터 파싱
            String reservIdStr = request.getParameter("reservId");
            if(reservIdStr == null || reservIdStr.trim().isEmpty()) {
                out.print(gson.toJson(new ResponseVO(false, "예약 ID가 필요합니다.", null)));
                return;
            }
            
            Long reservId = Long.parseLong(reservIdStr);
            
            // [3] Service 호출
            boolean success = service.removeReview(reservId, userId);
            
            // [4] JSON 응답
            if(success) {
                out.print(gson.toJson(new ResponseVO(true, "리뷰가 삭제되었습니다.", null)));
            } else {
                out.print(gson.toJson(new ResponseVO(false, "리뷰 삭제에 실패했습니다.", null)));
            }
            
        } catch(IllegalStateException e) {
            // 비즈니스 규칙 위반
            out.print(gson.toJson(new ResponseVO(false, e.getMessage(), null)));
        } catch(Exception e) {
            e.printStackTrace();
            out.print(gson.toJson(new ResponseVO(false, "오류가 발생했습니다: " + e.getMessage(), null)));
        } finally {
            out.flush();
        }
    }
}


/**
 * JSON 응답용 VO
 */
class ResponseVO {
    private boolean success;
    private String message;
    private Object data;
    
    public ResponseVO(boolean success, String message, Object data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }
    
    public boolean isSuccess() { return success; }
    public String getMessage() { return message; }
    public Object getData() { return data; }
}
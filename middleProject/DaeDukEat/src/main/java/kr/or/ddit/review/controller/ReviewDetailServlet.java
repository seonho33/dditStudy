package kr.or.ddit.review.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import kr.or.ddit.user.vo.UserVO; // UserVO 패키지 경로 확인 필요
import kr.or.ddit.review.service.IReviewService;
import kr.or.ddit.review.service.ReviewServiceImpl;
import kr.or.ddit.review.vo.ReviewDetailVO;

/**
 * 리뷰 상세 조회 서블릿 (AJAX 전용)
 * * @author Legacy Architecture Team
 * @since 2025-01-23
 * @url /review/detailreview.do
 * @method GET
 * @response JSON
 */
@WebServlet("/review/detailreview.do")
public class ReviewDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /** Service Layer Dependency */
    private IReviewService service;
    
    /** JSON 변환기 (Gson 2.10 사용) */
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        service = ReviewServiceImpl.getInstance();
        gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        // --- 세션 수정 부분 시작 ---
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        // 비로그인 사용자가 AJAX 요청 시 에러 JSON 반환
        if (uvo == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"로그인이 필요합니다.\"}");
            return;
        }
        
        // 유저 정보 추출 (필요 시 로깅이나 보안 검증용으로 활용 가능)
        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();
        // --- 세션 수정 부분 끝 ---
        
        // 파라미터 수집
        String reservIdParam = request.getParameter("reservId");
        
        if (reservIdParam == null) {
            response.getWriter().write("{\"error\":\"예약 ID가 필요합니다.\"}");
            return;
        }
        
        try {
            Long reservId = Long.parseLong(reservIdParam);
            
            // 리뷰 상세 조회
            ReviewDetailVO detail = service.getReviewDetail(reservId);
            
            if (detail == null) {
                response.getWriter().write("{\"error\":\"리뷰를 찾을 수 없습니다.\"}");
                return;
            }
            
            // 본인 리뷰 확인 로직 (필요한 경우 추가)
            // if (!userId.equals(detail.getUserId()) && !"ADMIN".equals(userRole)) {
            //     response.getWriter().write("{\"error\":\"조회 권한이 없습니다.\"}");
            //     return;
            // }
            
            // Gson을 이용한 JSON 변환
            String jsonResponse = gson.toJson(detail);
            response.getWriter().write(jsonResponse);
            
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"error\":\"잘못된 예약 ID 형식입니다.\"}");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
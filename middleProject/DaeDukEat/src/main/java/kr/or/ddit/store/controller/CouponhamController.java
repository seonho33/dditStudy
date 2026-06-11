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
import kr.or.ddit.store.service.CouponhamServiceImpl;
import kr.or.ddit.store.service.ICouponhamService;
import kr.or.ddit.store.vo.CouponhamVO;
import kr.or.ddit.user.vo.UserVO;

/**
 * 쿠폰함 Controller (Servlet)
 * 수정사항: 쿠폰 사용 시 가게 ID(inputStoreId) 검증 로직 추가 및 데이터 타입 최적화
 */
@WebServlet("/couponham/*")
public class CouponhamController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ICouponhamService service;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        this.service = CouponhamServiceImpl.getInstance();
        this.gson = new Gson();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String requestURI = request.getRequestURI();
        String action = requestURI.substring(requestURI.lastIndexOf("/") + 1, requestURI.lastIndexOf(".do"));
        
        try {
            if("list".equals(action)) {
                getCouponList(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "오류 발생: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String requestURI = request.getRequestURI();
        String action = requestURI.substring(requestURI.lastIndexOf("/") + 1, requestURI.lastIndexOf(".do"));
        
        try {
            if("use".equals(action)) {
                useCoupon(request, response);
            } else if("delete".equals(action)) {
                deleteCoupon(request, response);
            } else if("issue".equals(action)) {
                issueCoupon(request, response);
            } else {
                sendJsonError(response, "잘못된 요청입니다.");
            }
        } catch(Exception e) {
            e.printStackTrace();
            sendJsonError(response, "오류 발생: " + e.getMessage());
        }
    }
    
    /* ====================================
       쿠폰 목록 조회 (JSP 렌더링)
       ==================================== */
    private void getCouponList(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        if (uvo == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String userId = uvo.getUserId();
        List<CouponhamVO> couponList = service.getAvailableCoupons(userId);
        int totalCount = service.getCouponCount(userId);
        
        request.setAttribute("couponList", couponList);
        request.setAttribute("totalCount", totalCount);
        
        request.getRequestDispatcher("/TEST/views/store/couponList.jsp").forward(request, response);
    }
    
    /* ====================================
       쿠폰 사용 (AJAX - 가게 ID 검증 포함)
       ==================================== */
    private void useCoupon(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        if(uvo == null) {
            sendJsonError(response, "로그인이 필요합니다.");
            return;
        }
        
        String userId = uvo.getUserId();
        
        // [수정] JSP fetch 바디에서 넘겨준 파라미터들 추출
        String couponBoxIdStr = request.getParameter("couponBoxId");
        String inputStoreId = request.getParameter("inputStoreId"); // prompt 입력값
        
        if(couponBoxIdStr == null || inputStoreId == null || inputStoreId.trim().isEmpty()) {
            sendJsonError(response, "쿠폰 정보 또는 가게 아이디가 누락되었습니다.");
            return;
        }
        
        try {
            // [중요] 숫자로 명확히 변환 (ORA-01722 방지)
            Long couponBoxId = Long.parseLong(couponBoxIdStr);
          
            // [수정] 서비스 호출 시 inputStoreId 전달 (Service 인터페이스 파라미터가 3개여야 함)
            boolean success = service.useCoupon(couponBoxId, userId, inputStoreId);
            
            if(success) {
                sendJsonSuccess(response, "쿠폰이 사용 처리되었습니다.");
            } else {
                sendJsonError(response, "가게 아이디가 일치하지 않거나 이미 사용된 쿠폰입니다.");
            }
        } catch (NumberFormatException e) {
            sendJsonError(response, "유효하지 않은 쿠폰 ID 형식입니다.");
        }
    }
    
    /* ====================================
       쿠폰 삭제 (AJAX JSON 응답)
       ==================================== */
    private void deleteCoupon(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        if(uvo == null) { sendJsonError(response, "로그인이 필요합니다."); return; }
        
        String couponBoxIdStr = request.getParameter("couponBoxId");
        if(couponBoxIdStr == null) { sendJsonError(response, "ID 누락"); return; }
        
        boolean success = service.deleteCoupon(Long.parseLong(couponBoxIdStr), uvo.getUserId());
        if(success) sendJsonSuccess(response, "쿠폰이 삭제되었습니다.");
        else sendJsonError(response, "삭제 실패");
    }
    
    /* ====================================
       쿠폰 발급 (AJAX JSON 응답)
       ==================================== */
    private void issueCoupon(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        
        if (uvo == null) { sendJsonError(response, "로그인이 필요합니다."); return; }
        
        String couponIdStr = request.getParameter("couponId");
        if(couponIdStr == null) { sendJsonError(response, "ID 누락"); return; }
        
        boolean success = service.issueCoupon(uvo.getUserId(), Long.parseLong(couponIdStr));
        if(success) sendJsonSuccess(response, "쿠폰이 발급되었습니다.");
        else sendJsonError(response, "발급 실패");
    }
    
    /* ====================================
       JSON 응답 유틸리티
       ==================================== */
    private void sendJsonSuccess(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().print(gson.toJson(new ResponseVO(true, message, null)));
    }
    
    private void sendJsonError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().print(gson.toJson(new ResponseVO(false, message, null)));
    }
    
    private static class ResponseVO {
        private boolean success; private String message; private Object data;
        public ResponseVO(boolean s, String m, Object d) { this.success = s; this.message = m; this.data = d; }
    }
}
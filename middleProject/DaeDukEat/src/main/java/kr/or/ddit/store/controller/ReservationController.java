package kr.or.ddit.store.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.store.service.IReservationService;
import kr.or.ddit.store.service.ReservationServiceImpl;
import kr.or.ddit.store.vo.ReservationVO;
import kr.or.ddit.user.vo.UserVO;

/**
 * ============================================================
 * [Front Controller] 예약 모듈 단일 진입점
 * ============================================================
 * @author  Senior Architect
 * @since   2025-01-23
 * @purpose *.do 패턴으로 모든 예약 요청을 중앙 처리
 * ============================================================
 * 
 * URL PATTERN EXAMPLES:
 * - /reservation/myReservation.do  → 내 예약 목록
 * - /reservation/cancel.do         → 예약 취소
 * - /reservation/view.do           → 예약 상세
 * 
 * SERVLET MAPPING:
 * - web.xml 또는 @WebServlet 사용
 * - *.do 패턴으로 모든 요청 수신
 */
@WebServlet("/reservation.do")
public class ReservationController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    // ========== Service Layer 의존성 ==========
    
    private final IReservationService service = ReservationServiceImpl.getInstance();
    
    // ========== HTTP Methods ==========
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    /**
     * 중앙 요청 처리 메서드
     * 
     * LOGIC:
     * 1. ServletPath에서 명령어 추출 (예: /reservation/myReservation.do → myReservation)
     * 2. 명령어별 분기 처리
     * 3. Service 호출 → 결과를 request에 저장 → JSP forward
     */
    private void processRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // UTF-8 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // ServletPath에서 명령어 추출
        String servletPath = request.getServletPath(); // 예: /reservation/myReservation.do
        String command = servletPath.substring(servletPath.lastIndexOf("/") + 1, servletPath.lastIndexOf(".do"));
        
        // 세션에서 사용자 ID 추출
        HttpSession session = request.getSession(false);
        UserVO uvo = (UserVO) session.getAttribute("loginUser");
        String userId = uvo.getUserId();
        String userRole = uvo.getDivision();
        userId = null;
        if (session != null) {
            userId = (String) session.getAttribute("userId");
        }
        
        try {
            // ========== 명령어별 분기 처리 ==========
            
            switch (command) {
                case "myReservation":
                    handleMyReservation(request, response, userId);
                    break;
                    
                case "cancel":
                    handleCancelReservation(request, response, userId);
                    break;
                    
                case "view":
                    handleViewReservation(request, response);
                    break;
                    
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Command not found: " + command);
                    break;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
        }
    }
    
    /**
     * [Command] myReservation.do
     * 
     * LOGIC:
     * 1. Service를 통해 활성 예약 목록 조회
     * 2. Service를 통해 알림 목록 조회
     * 3. request에 데이터 저장 후 JSP forward
     * 
     * OUTPUT:
     * - activeReservations (List<ReservationVO>)
     * - notifications (List<ReservationVO>)
     */
    private void handleMyReservation(HttpServletRequest request, HttpServletResponse response, String userId) 
            throws Exception {
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }
        
        // 1. 활성 예약 조회
        List<ReservationVO> activeReservations = service.getActiveReservations(userId);
        
        // 2. 알림 조회
        List<ReservationVO> notifications = service.getNotifications(userId);
        
        // 3. request에 데이터 저장
        request.setAttribute("activeReservations", activeReservations);
        request.setAttribute("notifications", notifications);
        
        // 4. JSP forward
        request.getRequestDispatcher("/TEST/views/store/myReservation.jsp").forward(request, response);
    }
    
    /**
     * [Command] cancel.do
     * 
     * LOGIC:
     * 1. 파라미터에서 reservId 추출
     * 2. Service를 통해 취소 처리
     * 3. 성공 시 목록 페이지로 리다이렉트
     * 
     * PARAMS:
     * - reservId (Long)
     */
    private void handleCancelReservation(HttpServletRequest request, HttpServletResponse response, String userId) 
            throws Exception {
        
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }
        
        // 1. 파라미터 추출
        String reservIdStr = request.getParameter("reservId");
        if (reservIdStr == null || reservIdStr.isEmpty()) {
            throw new IllegalArgumentException("ReservId is required");
        }
        
        Long reservId = Long.parseLong(reservIdStr);
        
        // 2. 취소 처리
        boolean success = service.cancelReservation(reservId, userId);
        
        // 3. 결과 처리
        if (success) {
            request.getSession().setAttribute("message", "예약이 취소되었습니다.");
            response.sendRedirect(request.getContextPath() + "/reservation/myReservation.do");
        } else {
            throw new Exception("Failed to cancel reservation");
        }
    }
    
    /**
     * [Command] view.do
     * 
     * LOGIC:
     * 1. 파라미터에서 reservId 추출 (예: id=R1234 → 1234)
     * 2. Service를 통해 예약 상세 조회
     * 3. JSP에 데이터 전달
     * 
     * PARAMS:
     * - id (String, 형식: R{reservId})
     */
    private void handleViewReservation(HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
        // 1. 파라미터 추출 (예: R1234 → 1234)
        String idParam = request.getParameter("id");
        if (idParam == null || !idParam.startsWith("R")) {
            throw new IllegalArgumentException("Invalid reservation ID format");
        }
        
        Long reservId = Long.parseLong(idParam.substring(1)); // "R" 제거 후 파싱
        
        // 2. 예약 상세 조회
        ReservationVO reservation = service.getReservationDetail(reservId);
        
        if (reservation == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Reservation not found");
            return;
        }
        
        // 3. JSP에 데이터 전달
        request.setAttribute("reservation", reservation);
        request.getRequestDispatcher("/TEST/views/store/reservationDetail.jsp").forward(request, response);
    }
}
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
 * [Controller] 내 예약 목록 조회
 * ============================================================
 * @author  Senior Architect
 * @since   2025-01-23
 * @purpose 사용자의 활성 예약 및 알림 목록 조회
 * ============================================================
 * 
 * URL MAPPING:
 * - /reservation/myReservation.do
 * 
 * HTTP METHOD:
 * - GET: 예약 목록 조회 및 JSP 렌더링
 * 
 * OUTPUT:
 * - activeReservations (List<ReservationVO>): 활성 예약 목록
 * - notifications (List<ReservationVO>): 최근 알림 목록
 * 
 * FORWARD:
 * - /TEST/views/reservation/myReservation.jsp
 */
@WebServlet("/myReservation.do")
public class MyReservationController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    // ========== Service Layer 의존성 ==========
    
    /** 예약 서비스 (Singleton) */
    private final IReservationService service = ReservationServiceImpl.getInstance();
    
    // ========== HTTP Methods ==========
    
    /**
     * GET 요청 처리
     * 
     * LOGIC:
     * 1. 세션에서 사용자 ID 추출
     * 2. 로그인 여부 확인 (미로그인 시 로그인 페이지로 리다이렉트)
     * 3. Service를 통해 활성 예약 목록 조회
     * 4. Service를 통해 알림 목록 조회
     * 5. request에 데이터 저장 후 JSP forward
     * 
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @throws ServletException JSP 처리 오류
     * @throws IOException      I/O 오류
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // 1. 세션 및 유저 정보 추출
            HttpSession session = request.getSession(false);
            UserVO uvo = (session != null) ? (UserVO) session.getAttribute("loginUser") : null;
            
            // 2. 로그인 여부 확인 (uvo 객체가 없으면 바로 리다이렉트)
            if (uvo == null) {
                response.sendRedirect(request.getContextPath() + "/login.do");
                return;
            }
            
            // 유저 정보 사용
            String userId = uvo.getUserId();
            String userRole = uvo.getDivision();
            
            // 3. 활성 예약 목록 조회
            List<ReservationVO> activeReservations = service.getActiveReservations(userId);
            
            // 4. 알림 목록 조회 (최근 10건)
            List<ReservationVO> notifications = service.getNotifications(userId);
            
            // 5. 데이터 저장
            request.setAttribute("activeReservations", activeReservations);
            request.setAttribute("notifications", notifications);
            request.setAttribute("userRole", userRole); // 권한에 따른 버튼 노출을 위해 추가
            
            // 6. JSP forward
            request.getRequestDispatcher("/TEST/views/store/myReservation.jsp")
                   .forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "예약 목록을 불러오는 중 오류 발생: " + e.getMessage());
            request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
        }
    }
    /**
     * POST 요청 처리
     * 
     * NOTE: 이 컨트롤러는 조회 전용이므로 GET으로 리다이렉트
     * 
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @throws ServletException JSP 처리 오류
     * @throws IOException      I/O 오류
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // POST 요청은 GET으로 처리 (조회 기능)
        doGet(request, response);
    }
}
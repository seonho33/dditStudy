package kr.or.ddit.store.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.store.service.IReservationService;
import kr.or.ddit.store.service.ReservationServiceImpl;
import kr.or.ddit.user.vo.UserVO;

/**
 * ============================================================
 * [Controller] 예약 취소 처리
 * ============================================================
 * @author  Senior Architect
 * @since   2025-01-23
 * @purpose 사용자 예약 취소 및 환불 처리
 * ============================================================
 * 
 * URL MAPPING:
 * - /reservation/cancel.do
 * 
 * HTTP METHOD:
 * - GET: 예약 취소 처리 (파라미터: reservId)
 * 
 * PARAMS:
 * - reservId (Long): 취소할 예약 ID
 * 
 * REDIRECT:
 * - 성공: /reservation/myReservation.do (메시지: "예약이 취소되었습니다")
 * - 실패: 에러 페이지
 * 
 * BUSINESS LOGIC:
 * 1. 로그인 여부 확인
 * 2. reservId 파라미터 검증
 * 3. Service를 통해 취소 처리 (권한 검증 포함)
 * 4. 성공 시 목록 페이지로 리다이렉트
 */
@WebServlet("/user/reservation/cancel.do")
public class CancelReservationController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private final IReservationService service = ReservationServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            // 1. 세션에서 UserVO 객체 추출 (핵심 연결 포인트)
            HttpSession session = request.getSession(false);
            UserVO uvo = null;
            if (session != null) {
                uvo = (UserVO) session.getAttribute("loginUser");
            }
            
            // 2. 로그인 여부 확인
            if (uvo == null) {
                response.sendRedirect(request.getContextPath() + "/login.do");
                return;
            }
            
            // UserVO에서 실제 필요한 ID 추출
            String userId = uvo.getUserId();
            
            // 3. reservId 파라미터 추출 및 검증
            String reservIdStr = request.getParameter("reservId");
            if (reservIdStr == null || reservIdStr.trim().isEmpty()) {
                throw new IllegalArgumentException("예약 ID가 필요합니다.");
            }
            
            Long reservId = Long.parseLong(reservIdStr);
            
            // 4. Service를 통해 취소 처리
            // 서비스 내부에서 '현재 로그인한 유저ID'와 '예약의 주인ID'가 같은지 대조할 것
            boolean success = service.cancelReservation(reservId, userId);
            
            // 5. 결과 처리
            if (success) {
                session.setAttribute("message", "예약이 취소되었습니다.");
                session.setAttribute("messageType", "success");
                response.sendRedirect(request.getContextPath() + "/reservation/myReservation.do");
            } else {
                throw new Exception("예약 취소에 실패했습니다. 이미 취소되었거나 권한이 없을 수 있습니다.");
            }
            
        } catch (NumberFormatException e) {
            handleError(request, response, "올바르지 않은 예약 ID 형식입니다.");
        } catch (IllegalArgumentException | SecurityException e) {
            handleError(request, response, e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            handleError(request, response, "예약 취소 중 예상치 못한 오류가 발생했습니다.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }

    // 에러 처리 공통 메서드
    private void handleError(HttpServletRequest req, HttpServletResponse resp, String msg) 
            throws ServletException, IOException {
        req.setAttribute("errorMessage", msg);
        req.getRequestDispatcher("/TEST/views/store/error.jsp").forward(req, resp);
    }
}
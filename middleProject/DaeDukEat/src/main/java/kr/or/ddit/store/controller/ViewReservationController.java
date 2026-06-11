package kr.or.ddit.store.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import kr.or.ddit.store.service.IReservationService;
import kr.or.ddit.store.service.ReservationServiceImpl;
import kr.or.ddit.store.vo.ReservationVO;

/**
 * ============================================================
 * [Controller] 예약 상세 조회 (공유 링크용)
 * ============================================================
 * @author  Senior Architect
 * @since   2025-01-23
 * @purpose 예약 공유 링크를 통한 예약 정보 조회
 * ============================================================
 * 
 * URL MAPPING:
 * - /reservation/view.do
 * 
 * HTTP METHOD:
 * - GET: 예약 상세 정보 조회
 * 
 * PARAMS:
 * - id (String): 예약 ID (형식: R{숫자}, 예: R1234)
 * 
 * OUTPUT:
 * - reservation (ReservationVO): 예약 상세 정보 (STORE, PAYMENT 포함)
 * 
 * FORWARD:
 * - /TEST/views/reservation/reservationDetail.jsp
 * 
 * USE CASE:
 * - 예약 공유 기능에서 생성된 링크를 통해 접근
 * - 로그인 불필요 (공유 링크는 누구나 접근 가능)
 */
@WebServlet("/reservation/view.do")
public class ViewReservationController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    // ========== Service Layer 의존성 ==========
    
    /** 예약 서비스 (Singleton) */
    private final IReservationService service = ReservationServiceImpl.getInstance();
    
    // ========== HTTP Methods ==========
    
    /**
     * GET 요청 처리 (예약 상세 조회)
     * 
     * LOGIC:
     * 1. id 파라미터 추출 (형식: R{숫자})
     * 2. "R" 접두사 제거 후 Long으로 변환
     * 3. Service를 통해 예약 상세 조회
     * 4. 예약 정보가 없으면 404 에러
     * 5. 예약 정보를 request에 저장 후 JSP forward
     * 
     * PARAMS:
     * - id: R1234 형식의 예약 ID
     * 
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @throws ServletException JSP 처리 오류
     * @throws IOException      I/O 오류
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // UTF-8 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // 1. id 파라미터 추출
            String idParam = request.getParameter("id");
            
            // 2. 파라미터 검증
            if (idParam == null || idParam.trim().isEmpty()) {
                throw new IllegalArgumentException("예약 ID가 필요합니다.");
            }
            
            // 3. "R" 접두사 확인 및 제거
            if (!idParam.startsWith("R")) {
                throw new IllegalArgumentException("올바르지 않은 예약 ID 형식입니다. 형식: R{숫자}");
            }
            
            // 4. Long으로 변환
            Long reservId = null;
            try {
                reservId = Long.parseLong(idParam.substring(1)); // "R" 제거 후 파싱
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("올바르지 않은 예약 ID 형식입니다: " + idParam);
            }
            
            // 5. Service를 통해 예약 상세 조회
            ReservationVO reservation = service.getReservationDetail(reservId);
            
            // 6. 예약 정보 존재 여부 확인
            if (reservation == null) {
                response.sendError(
                    HttpServletResponse.SC_NOT_FOUND, 
                    "예약 정보를 찾을 수 없습니다: " + idParam
                );
                return;
            }
            
            // 7. request에 데이터 저장
            request.setAttribute("reservation", reservation);
            
            // 8. JSP forward
            request.getRequestDispatcher("/TEST/views/reservation/reservationDetail.jsp")
                   .forward(request, response);
            
        } catch (IllegalArgumentException e) {
            // 파라미터 검증 오류
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
            
        } catch (Exception e) {
            // 기타 오류
            e.printStackTrace();
            request.setAttribute("errorMessage", "예약 정보를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
            request.getRequestDispatcher("/TEST/views/store/error.jsp").forward(request, response);
        }
    }
    
    /**
     * POST 요청 처리
     * 
     * NOTE: 예약 조회는 GET만 지원 (공유 링크는 GET 방식)
     * 
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @throws ServletException JSP 처리 오류
     * @throws IOException      I/O 오류
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // POST 요청도 GET으로 처리 (조회 기능)
        doGet(request, response);
    }
}
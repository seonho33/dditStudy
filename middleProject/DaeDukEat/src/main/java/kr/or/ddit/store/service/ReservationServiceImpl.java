package kr.or.ddit.store.service;

import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import kr.or.ddit.store.dao.IReservationDAO;
import kr.or.ddit.store.dao.ReservationDAOImpl;
import kr.or.ddit.store.vo.ReservationVO;

/**
 * ============================================================
 * [Service Impl] Thread-safe Singleton 비즈니스 로직
 * ============================================================
 * @author  Senior Architect
 * @since   2025-01-23
 * @purpose 예약 관련 복합 로직 처리 (알림 생성, 시간 계산 등)
 * ============================================================
 */
public class ReservationServiceImpl implements IReservationService {
    
    // ========== Singleton Instance (LazyHolder) ==========
    
    private static class LazyHolder {
        private static final ReservationServiceImpl INSTANCE = new ReservationServiceImpl();
    }
    
    private ReservationServiceImpl() {}
    
    public static ReservationServiceImpl getInstance() {
        return LazyHolder.INSTANCE;
    }
    
    // ========== DAO 의존성 ==========
    
    private final IReservationDAO dao = ReservationDAOImpl.getInstance();

    // ========== Service Methods ==========
    
    /**
     * 활성 예약 목록 조회
     * 
     * BUSINESS LOGIC:
     * - DAO 호출하여 상태='대기' OR '승인' 예약만 조회
     * - 추가 검증 로직 없음 (DAO 레벨에서 필터링)
     */
    @Override
    public List<ReservationVO> getActiveReservations(String userId) throws Exception {
        if (userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("User ID cannot be null or empty");
        }
        
        return dao.selectActiveReservations(userId);
    }

    /**
     * 최근 알림 목록 조회 (예약 히스토리 기반)
     * 
     * BUSINESS LOGIC:
     * 1. DAO에서 최근 10건 예약 조회
     * 2. 각 예약 데이터를 알림 형식으로 변환:
     *    - notificationTitle: "예약 상태 변경: {가게명}"
     *    - notificationContent: "{상태} - {예약시간}"
     *    - relativeTime: 상대적 시간 계산 (예: '3시간 전')
     */
    @Override
    public List<ReservationVO> getNotifications(String userId) throws Exception {
        if (userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("User ID cannot be null or empty");
        }
        
        List<ReservationVO> recentList = dao.selectRecentReservations(userId);
        
        // 알림용 필드 세팅
        for (ReservationVO vo : recentList) {
            vo.setNotificationTitle("예약 상태 변경: " + vo.getStoreName());
            vo.setNotificationContent(vo.getReservStatus() + " - " + vo.getReservTime());
            vo.setRelativeTime(calculateRelativeTime(vo.getCreateDate()));
        }
        
        return recentList;
    }

    /**
     * 예약 취소 처리
     * 
     * BUSINESS LOGIC:
     * 1. 예약 정보 조회 (존재 여부 확인)
     * 2. 권한 검증 (요청자 = 예약자)
     * 3. 취소 가능 상태 확인 ('대기' OR '승인')
     * 4. DAO를 통해 상태를 '취소'로 변경
     * 5. [TODO] REFUND 테이블 연동 (결제 취소 처리)
     * 
     * @return boolean true: 성공, false: 실패
     */
    @Override
    public boolean cancelReservation(Long reservId, String userId) throws Exception {
        if (reservId == null || userId == null) {
            throw new IllegalArgumentException("ReservId and UserId are required");
        }
        
        // 1. 예약 정보 조회
        ReservationVO reservation = dao.selectReservationById(reservId);
        if (reservation == null) {
            throw new Exception("Reservation not found: " + reservId);
        }
        
        // 2. 권한 검증
        if (!reservation.getUserId().equals(userId)) {
            throw new SecurityException("Unauthorized: User does not own this reservation");
        }
        
        // 3. 취소 가능 상태 확인
        String status = reservation.getReservStatus();
        if (!"대기".equals(status) && !"승인".equals(status)) {
            throw new Exception("Cannot cancel reservation in status: " + status);
        }
        
        // 4. 취소 처리
        int result = dao.cancelReservation(reservId);
        
        // 5. [TODO] REFUND 테이블 처리 (결제 취소 API 연동)
        // if (result > 0 && reservation.getPayStatus() != null) {
        //     refundService.processRefund(reservId);
        // }
        
        return result > 0;
    }

    /**
     * 예약 상세 조회
     * 
     * BUSINESS LOGIC:
     * - DAO를 통해 STORE, PAYMENT JOIN 정보까지 조회
     */
    @Override
    public ReservationVO getReservationDetail(Long reservId) throws Exception {
        if (reservId == null) {
            throw new IllegalArgumentException("ReservId cannot be null");
        }
        
        return dao.selectReservationById(reservId);
    }

    // ========== Private Utility Methods ==========
    
    /**
     * 상대적 시간 계산 (예: '3시간 전', '어제', '2일 전')
     * 
     * @param  createDate 예약 생성일자
     * @return String 상대적 시간 표현
     */
    private String calculateRelativeTime(Date createDate) {
        if (createDate == null) {
            return "알 수 없음";
        }
        
        long diffMillis = System.currentTimeMillis() - createDate.getTime();
        long diffMinutes = TimeUnit.MILLISECONDS.toMinutes(diffMillis);
        long diffHours = TimeUnit.MILLISECONDS.toHours(diffMillis);
        long diffDays = TimeUnit.MILLISECONDS.toDays(diffMillis);
        
        if (diffMinutes < 1) {
            return "방금 전";
        } else if (diffMinutes < 60) {
            return diffMinutes + "분 전";
        } else if (diffHours < 24) {
            return diffHours + "시간 전";
        } else if (diffDays == 1) {
            return "어제";
        } else {
            return diffDays + "일 전";
        }
    }
}
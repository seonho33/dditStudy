package kr.or.ddit.reservation.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.store.vo.ReservationVO;
import kr.or.ddit.store.vo.StoreVO;

/**
 * 예약 DAO Interface (완전판)
 */
public interface IReservationDAO {
    
    /* ========================================
       [기존 메서드] 점주 예약 관리용
       ======================================== */
    
    /**
     * 가게별 예약 목록 조회
     */
    List<ReservationVO> selectReservationsByStore(String storeId) throws Exception;
    
    /**
     * 상태별 예약 개수 조회
     */
    int countReservationsByStatus(String storeId, String status) throws Exception;
    
    /**
     * 예약 상태 변경
     */
    int updateReservationStatus(Long reservId, String newStatus) throws Exception;
    
    /* ========================================
       [신규 메서드] 결제 연동용
       ======================================== */
    
    /**
     * 예약 정보 등록
     */
    int insertReservation(ReservationVO reservation) throws Exception;
    
    /**
     * 가게 정보 조회
     */
    StoreVO selectStoreById(String storeId) throws Exception;
    
    /**
     * 예약 ID로 예약 조회
     */
    ReservationVO selectReservationById(Long reservId) throws Exception;
    
    List<ReservationVO> selectActiveReservations(String userId);
    List<ReservationVO> selectRecentReservations(String userId);

    int cancelReservation(long reservId);        // RESERVATION.RESERV_STATUS = '취소'
    int cancelPayment(long reservId);            // PAYMENT.PAY_STATUS = '취소'

    int isMyReservation(Map<String, Object> param); // {reservId, userId} -> 0/1
}
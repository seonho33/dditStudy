package kr.or.ddit.reservation.service;

import java.util.List;
import kr.or.ddit.store.vo.ReservationVO;
import kr.or.ddit.store.vo.StoreVO;

/**
 * [RESERVATION Service Interface - 완전판]
 */
public interface IReservationService {
    
    /* ========================================
       [기존 메서드] 점주 예약 관리
       ======================================== */
    
    /**
     * [READ] 가게별 예약 목록 조회
     * 
     * @param storeId - 가게 ID
     * @return List<ReservationVO>
     */
    List<ReservationVO> getReservationsByStore(String storeId) throws Exception;
    
    /**
     * [READ] 상태별 예약 개수 조회
     * 
     * @param storeId - 가게 ID
     * @param status - 예약 상태
     * @return int
     */
    int countReservationsByStatus(String storeId, String status) throws Exception;
    
    /**
     * [UPDATE] 예약 상태 변경
     * 
     * @param reservId - 예약 ID
     * @param newStatus - 새 상태값
     * @return int
     */
    int updateReservationStatus(Long reservId, String newStatus) throws Exception;
    
    /* ========================================
       [신규 메서드] 결제 연동
       ======================================== */
    
    /**
     * [CREATE] 예약 정보 등록
     * 
     * @param reservation - 예약 정보 VO
     * @return int
     */
    int createReservation(ReservationVO reservation) throws Exception;
    
    /**
     * [READ] 가게 ID로 가게 정보 조회
     * 
     * @param storeId - 가게 ID
     * @return StoreVO
     */
    StoreVO getStoreById(String storeId) throws Exception;
    
    /**
     * [READ] 예약 ID로 예약 정보 조회
     * 
     * @param reservId - 예약 ID
     * @return ReservationVO
     */
    ReservationVO getReservationById(Long reservId) throws Exception;
    
    List<ReservationVO> getActiveReservations(String userId);
    List<ReservationVO> getNotifications(String userId);

    boolean cancelReservationAndPayment(long reservId, String userId);
}
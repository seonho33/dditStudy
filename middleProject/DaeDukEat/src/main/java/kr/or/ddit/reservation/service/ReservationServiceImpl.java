package kr.or.ddit.reservation.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.reservation.dao.IReservationDAO;
import kr.or.ddit.reservation.dao.ReservationDAOImpl;
import kr.or.ddit.store.vo.ReservationVO;
import kr.or.ddit.store.vo.StoreVO;

/**
 * [RESERVATION Service 구현체]
 */
public class ReservationServiceImpl implements IReservationService {
    
    // ✅ ReservationDAO만 사용
    private IReservationDAO reservDao = ReservationDAOImpl.getInstance();
    
    // Singleton Pattern
    private static ReservationServiceImpl instance = new ReservationServiceImpl();
    private ReservationServiceImpl() {}
    public static ReservationServiceImpl getInstance() {
        return instance;
    }
    
    /* ========================================
       [기존 메서드] 점주 예약 관리
       ======================================== */
    
    @Override
    public List<ReservationVO> getReservationsByStore(String storeId) throws Exception {
        return reservDao.selectReservationsByStore(storeId);
    }
    
    @Override
    public int countReservationsByStatus(String storeId, String status) throws Exception {
        return reservDao.countReservationsByStatus(storeId, status);
    }
    
    @Override
    public int updateReservationStatus(Long reservId, String newStatus) throws Exception {
        return reservDao.updateReservationStatus(reservId, newStatus);
    }
    
    /* ========================================
       [신규 메서드] 결제 연동
       ======================================== */
    
    @Override
    public int createReservation(ReservationVO reservation) throws Exception {
        return reservDao.insertReservation(reservation);
    }
    
    @Override
    public StoreVO getStoreById(String storeId) throws Exception {
        // ✅ ReservationDAO에서 직접 조회
        return reservDao.selectStoreById(storeId);
    }
    
    @Override
    public ReservationVO getReservationById(Long reservId) throws Exception {
        return reservDao.selectReservationById(reservId);
    }
    
    @Override
    public List<ReservationVO> getActiveReservations(String userId) {
        return reservDao.selectActiveReservations(userId);
    }

    @Override
    public List<ReservationVO> getNotifications(String userId) {
        return reservDao.selectRecentReservations(userId);
    }

    @Override
    public boolean cancelReservationAndPayment(long reservId, String userId) {

        // 1) 소유권 체크
        Map<String, Object> param = new HashMap<>();
        param.put("reservId", reservId);
        param.put("userId", userId);

        int mine = reservDao.isMyReservation(param);
        if (mine <= 0) return false;

        // 2) 예약 취소 (대기/승인만 취소되도록 mapper에 조건 걸려있음)
        int rCnt = reservDao.cancelReservation(reservId);
        if (rCnt <= 0) return false; // 이미 취소/노쇼/거절/완료 등 상태면 0 나올 수 있음

        // 3) 결제 취소 (결제 row 없으면 0일 수 있으니	 실패로 안 봄)
        reservDao.cancelPayment(reservId);

        return true;
    }
}
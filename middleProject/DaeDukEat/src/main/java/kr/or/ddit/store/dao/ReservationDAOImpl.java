package kr.or.ddit.store.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.ReservationVO;

/**
 * ============================================================
 * [DAO Impl] Thread-safe Singleton 패턴 구현
 * ============================================================
 * @author  Senior Architect
 * @since   2025-01-23
 * @purpose MyBatis 세션 관리 및 트랜잭션 제어
 * ============================================================
 */
public class ReservationDAOImpl implements IReservationDAO {
    
    // ========== Singleton Instance (LazyHolder) ==========
    
    private static class LazyHolder {
        private static final ReservationDAOImpl INSTANCE = new ReservationDAOImpl();
    }
    
    private ReservationDAOImpl() {
        // Private constructor to prevent instantiation
    }
    
    public static ReservationDAOImpl getInstance() {
        return LazyHolder.INSTANCE;
    }

    // ========== DAO Methods ==========
    
    /**
     * 활성 예약 목록 조회
     * 
     * SQL ID: reservation.selectActiveReservations
     * PARAMS: userId (String)
     * RESULT: List<ReservationVO> with STORE JOIN
     */
    @Override
    public List<ReservationVO> selectActiveReservations(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<ReservationVO> list = null;
        
        try {
            list = session.selectList("reservation.selectActiveReservations", userId);
        } finally {
            if (session != null) session.close();
        }
        
        return list;
    }

    /**
     * 최근 예약 이력 조회 (알림용)
     * 
     * SQL ID: reservation.selectRecentReservations
     * PARAMS: userId (String)
     * RESULT: List<ReservationVO> (최대 10건, 최신순)
     */
    @Override
    public List<ReservationVO> selectRecentReservations(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<ReservationVO> list = null;
        
        try {
            list = session.selectList("reservation.selectRecentReservations", userId);
        } finally {
            if (session != null) session.close();
        }
        
        return list;
    }

    /**
     * 예약 상세 조회
     * 
     * SQL ID: reservation.selectReservationById
     * PARAMS: reservId (Long)
     * RESULT: ReservationVO (STORE, PAYMENT JOIN 포함)
     */
    @Override
    public ReservationVO selectReservationById(Long reservId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        ReservationVO vo = null;
        
        try {
            vo = session.selectOne("reservation.selectReservationById", reservId);
        } finally {
            if (session != null) session.close();
        }
        
        return vo;
    }

    /**
     * 예약 상태 업데이트
     * 
     * SQL ID: reservation.updateReservationStatus
     * PARAMS: Map (reservId, newStatus)
     * RESULT: int (영향받은 행 수)
     */
    @Override
    public int updateReservationStatus(Long reservId, String newStatus) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("reservId", reservId);
            params.put("newStatus", newStatus);
            
            result = session.update("reservation.updateReservationStatus", params);
            
            if (result > 0) {
                session.commit();
            }
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return result;
    }

    /**
     * 예약 취소
     * 
     * SQL ID: reservation.cancelReservation
     * PARAMS: reservId (Long)
     * RESULT: int (영향받은 행 수)
     * NOTE  : 상태를 '취소'로 변경하며, REFUND는 Service Layer에서 처리
     */
    @Override
    public int cancelReservation(Long reservId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update("reservation.cancelReservation", reservId);
            
            if (result > 0) {
                session.commit();
            }
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return result;
    }
}
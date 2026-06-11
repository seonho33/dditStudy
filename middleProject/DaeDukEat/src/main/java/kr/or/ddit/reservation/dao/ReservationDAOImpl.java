package kr.or.ddit.reservation.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.ReservationVO;
import kr.or.ddit.store.vo.StoreVO;

/**
 * 예약 DAO 구현체 (완전판)
 */
public class ReservationDAOImpl implements IReservationDAO {
    
    private static ReservationDAOImpl instance = new ReservationDAOImpl();
    
    private ReservationDAOImpl() {}
    
    public static ReservationDAOImpl getInstance() {
        return instance;
    }
    
    /* ========================================
       [기존 메서드] 점주 예약 관리용
       ======================================== */
    
    @Override
    public List<ReservationVO> selectReservationsByStore(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<ReservationVO> list = null;
        
        try {
            list = session.selectList("kr.or.ddit.reservation.dao.IReservationDAO.selectReservationsByStore", storeId);
        } finally {
            if (session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public int countReservationsByStatus(String storeId, String status) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int count = 0;
        
        try {
            Map<String, String> params = new HashMap<>();
            params.put("storeId", storeId);
            params.put("status", status);
            
            count = session.selectOne("kr.or.ddit.reservation.dao.IReservationDAO.countReservationsByStatus", params);
        } finally {
            if (session != null) session.close();
        }
        
        return count;
    }
    
    @Override
    public int updateReservationStatus(Long reservId, String newStatus) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("reservId", reservId);
            params.put("newStatus", newStatus);
            
            result = session.update("kr.or.ddit.reservation.dao.IReservationDAO.updateReservationStatus", params);
            if (result > 0) session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return result;
    }
    
    /* ========================================
       [신규 메서드] 결제 연동용
       ======================================== */
    
    @Override
    public int insertReservation(ReservationVO reservation) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.insert("kr.or.ddit.reservation.dao.IReservationDAO.insertReservation", reservation);
            if (result > 0) session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public StoreVO selectStoreById(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        StoreVO store = null;
        
        try {
            store = session.selectOne("kr.or.ddit.reservation.dao.IReservationDAO.selectStoreById", storeId);
        } finally {
            if (session != null) session.close();
        }
        
        return store;
    }
    
    @Override
    public ReservationVO selectReservationById(Long reservId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        ReservationVO reservation = null;
        
        try {
//            reservation = session.selectOne("kr.or.ddit.reservation.dao.IReservationDAO.selectReservationById", reservId);
            reservation = session.selectOne("reservation.selectReservationById", reservId);
            System.out.println("DAO storeName = " + reservation.getStoreName());
        } finally {
            if (session != null) session.close();
        }
        
        return reservation;
    }
    
    private static final String NS = "reservation.";
    @Override
    public List<ReservationVO> selectActiveReservations(String userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectList(NS + "selectActiveReservations", userId);
        } finally {
            session.close();
        }
    }

    @Override
    public List<ReservationVO> selectRecentReservations(String userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectList(NS + "selectRecentReservations", userId);
        } finally {
            session.close();
        }
    }

    @Override
    public int cancelReservation(long reservId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int cnt = session.update(NS + "cancelReservation", reservId);
            session.commit();
            return cnt;
        } finally {
            session.close();
        }
    }

    @Override
    public int cancelPayment(long reservId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int cnt = session.update(NS + "cancelPayment", reservId);
            session.commit();
            return cnt;
        } finally {
            session.close();
        }
    }

    @Override
    public int isMyReservation(Map<String, Object> param) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            Integer cnt = session.selectOne(NS + "isMyReservation", param);
            return (cnt == null) ? 0 : cnt;
        } finally {
            session.close();
        }
    }
}
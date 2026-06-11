package kr.or.ddit.store.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.OwnerProfileVO;
import kr.or.ddit.store.vo.OwnerStatsVO;
import kr.or.ddit.store.vo.ReservationVO;

/**
 * 사장님 DAO 구현체
 * - Singleton 패턴
 * - MyBatis SqlSession 관리
 * 
 * @author Senior Architect
 * @version 1.0
 */
public class OwnerDAOImpl implements IOwnerDAO {
    
    // ========== Singleton Pattern ==========
    private static OwnerDAOImpl instance = new OwnerDAOImpl();
    private OwnerDAOImpl() {}
    public static OwnerDAOImpl getInstance() {
        return instance;
    }
    
    @Override
    public OwnerStatsVO selectOwnerStats(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        OwnerStatsVO stats = null;
        
        try {
            stats = session.selectOne("owner.selectOwnerStats", userId);
        } finally {
            if(session != null) session.close();
        }
        
        return stats;
    }
    
    @Override
    public OwnerProfileVO selectOwnerProfile(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        OwnerProfileVO profile = null;
        
        try {
            profile = session.selectOne("owner.selectOwnerProfile", userId);
        } finally {
            if(session != null) session.close();
        }
        
        return profile;
    }
    
    @Override
    public int updateStoreInfo(OwnerProfileVO profile) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update("owner.updateStoreInfo", profile);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public OwnerStatsVO selectOwnerStatsByStoreId(String storeId) throws Exception {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectOne(
                "owner.selectOwnerStatsByStoreId",
                storeId
            );
        }
    }
    
    // ✅ 오늘 예약 리스트
    @Override
    public List<ReservationVO> selectTodayReservListByStoreId(String storeId) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            java.util.Map<String, Object> p = new java.util.HashMap<>();
            p.put("storeId", storeId);
            return session.selectList("owner.selectTodayReservListByStoreId", p);
        }
    }
}
package kr.or.ddit.store.service;

import java.util.List;

import kr.or.ddit.store.dao.IOwnerDAO;
import kr.or.ddit.store.dao.OwnerDAOImpl;
import kr.or.ddit.store.vo.OwnerProfileVO;
import kr.or.ddit.store.vo.OwnerStatsVO;
import kr.or.ddit.store.vo.ReservationVO;

/**
 * 사장님 Service 구현체
 * - Singleton 패턴
 * - DAO 위임 처리
 * 
 * @author Senior Architect
 * @version 1.0
 */
public class OwnerServiceImpl implements IOwnerService {
    
    // ========== Singleton Pattern ==========
    private static OwnerServiceImpl instance = new OwnerServiceImpl();
    private OwnerServiceImpl() {}
    public static OwnerServiceImpl getInstance() {
        return instance;
    }
    
    private IOwnerDAO dao = OwnerDAOImpl.getInstance();
    
    @Override
    public OwnerStatsVO getOwnerStats(String userId) throws Exception {
        return dao.selectOwnerStats(userId);
    }
    
    @Override
    public OwnerProfileVO getOwnerProfile(String userId) throws Exception {
        return dao.selectOwnerProfile(userId);
    }
    
    @Override
    public boolean updateStoreInfo(OwnerProfileVO profile) throws Exception {
        int result = dao.updateStoreInfo(profile);
        return result > 0;
    }
    
    @Override
    public OwnerStatsVO getOwnerStatsByStoreId(String storeId) throws Exception {
        return dao.selectOwnerStatsByStoreId(storeId);
    }
    
    // ✅ 오늘 예약 리스트
    @Override
    public List<ReservationVO> getTodayReservationsByStoreId(String storeId) {
        return dao.selectTodayReservListByStoreId(storeId);
    }
}
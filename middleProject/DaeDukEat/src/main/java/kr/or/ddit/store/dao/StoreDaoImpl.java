package kr.or.ddit.store.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.StoreGameVO;
import kr.or.ddit.store.vo.StoreVO;

public class StoreDaoImpl implements IStoreDao {
    
    // ========== 기존 메서드들 ==========
    
	 private static StoreDaoImpl instance;
	    
	    private StoreDaoImpl() {}
	    
	    public static StoreDaoImpl getInstance() {
	        if (instance == null) {
	            instance = new StoreDaoImpl();
	        }
	        return instance;
	    }
	
	
	
	
	
	
    @Override
    public int insertStore(StoreVO store) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int cnt = session.insert("kr.or.ddit.store.dao.IStoreDao.insertStore", store);
            return cnt;
        } finally {
            session.commit();
            session.close();
        }
    }
    
    @Override
    public StoreVO selectStoreById(String storeId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectOne("kr.or.ddit.store.dao.IStoreDao.selectStoreById", storeId);
        } finally {
            session.commit();
            session.close();
        }
    }
    
    @Override
    public int withdrawStoreByUserId(String userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int cnt = session.update("kr.or.ddit.store.dao.IStoreDao.withdrawStoreByUserId", userId);
            session.commit();
            return cnt;
        } finally {
            session.close();
        }
    }
    
    @Override
    public StoreVO selectStoreByUserId(String userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectOne("kr.or.ddit.store.dao.IStoreDao.selectStoreByUserId", userId);
        } finally {
            session.close();
        }
    }

    // ========== ✅ 신규 추가: Update 관련 메서드 ==========
    
    /**
     * 가게 정보 수정
     */
    @Override
    public int updateStore(StoreVO store) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int cnt = session.update("kr.or.ddit.store.dao.IStoreDao.updateStore", store);
            session.commit();
            return cnt;
        } finally {
            session.close();
        }
    }
    
    /**
     * 가게 기존 이미지 삭제
     */
    @Override
    public int deleteStorePicture(String storeId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int cnt = session.delete("kr.or.ddit.store.dao.IStoreDao.deleteStorePicture", storeId);
            session.commit();
            return cnt;
        } catch (Exception e) {
            // 삭제할 이미지가 없는 경우 무시
            return 0;
        } finally {
            session.close();
        }
    }
    
    /**
     * 가게 신규 이미지 등록
     */
    @Override
    public int insertStorePicture(String storeId, String picturePath) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            java.util.Map<String, String> params = new java.util.HashMap<>();
            params.put("storeId", storeId);
            params.put("picturePath", picturePath);
            
            int cnt = session.insert("kr.or.ddit.store.dao.IStoreDao.insertStorePicture", params);
            session.commit();
            return cnt;
        } finally {
            session.close();
        }
    }
    
    /**
     * 가게 대표 이미지 경로 조회
     */
    @Override
    public String selectStorePicture(String storeId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectOne("kr.or.ddit.store.dao.IStoreDao.selectStorePicture", storeId);
        } catch (Exception e) {
            return null;
        } finally {
            session.close();
        }
    }
    @Override
    public List<StoreGameVO> selectActiveStoresForGame() throws Exception {
        SqlSession session = null;
        List<StoreGameVO> stores = null;
        
        try {
            session = MyBatisUtil.getSqlSession();
            // ✅ 중요: namespace + id 확인
            stores = session.selectList("kr.or.ddit.store.dao.IStoreDao.selectActiveStoresForGame");
            
            // ✅ 디버깅 로그 추가
            System.out.println("=== DAO 실행 결과 ===");
            System.out.println("조회된 가게 수: " + (stores != null ? stores.size() : 0));
            
        } catch (Exception e) {
            System.err.println("DAO 오류 발생:");
            e.printStackTrace();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return stores;
    }
}

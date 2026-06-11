package kr.or.ddit.store.service;

import java.util.List;

import kr.or.ddit.store.dao.IStoreDao;
import kr.or.ddit.store.dao.StoreDaoImpl;
import kr.or.ddit.store.vo.StoreGameVO;
import kr.or.ddit.store.vo.StoreVO;

public class StoreServiceImpl implements IStoreService {
	
	
	 private static StoreServiceImpl instance;
    private IStoreDao storeDao;

    // 생성자: DAO 초기화
    public StoreServiceImpl() {
    	 this.storeDao = StoreDaoImpl.getInstance();
    }

    
    public static StoreServiceImpl getInstance() {
        if (instance == null) {
            synchronized (StoreServiceImpl.class) {
                if (instance == null) {
                    instance = new StoreServiceImpl();
                }
            }
        }
        return instance;
    }
    // ========== 기존 메서드들 ==========
    
    @Override
    public int insertStore(StoreVO store) {
        return storeDao.insertStore(store);
    }

    @Override
    public StoreVO selectStoreById(String storeId) {
        return storeDao.selectStoreById(storeId);
    }

    @Override
    public int withdrawStoreByUserId(String userId) {
        return storeDao.withdrawStoreByUserId(userId);
    }

    @Override
    public StoreVO selectStoreByUserId(String userId) {
        return storeDao.selectStoreByUserId(userId);
    }

    // ========== ✅ 신규 추가: Update 관련 메서드 ==========
    
    /**
     * 가게 정보 수정
     */
    @Override
    public int updateStore(StoreVO store) {
        return storeDao.updateStore(store);
    }
    
    /**
     * 가게 대표 이미지 경로 조회
     */
    @Override
    public String getStorePicture(String storeId) {
        return storeDao.selectStorePicture(storeId);
    }
    
    /**
     * 가게 이미지 저장 (기존 삭제 후 신규 등록)
     */
    @Override
    public int saveStorePicture(String storeId, String picturePath) {
        // 1. 기존 이미지 삭제 (있으면)
        storeDao.deleteStorePicture(storeId);
        
        // 2. 신규 이미지 등록
        return storeDao.insertStorePicture(storeId, picturePath);
    }
    

    @Override
    public List<StoreGameVO> getActiveStoresForGame() throws Exception {
        System.out.println("=== Service 호출됨 ===");
        
        List<StoreGameVO> stores = storeDao.selectActiveStoresForGame();
        
        System.out.println("Service에서 받은 가게 수: " + (stores != null ? stores.size() : 0));
        
        if (stores == null || stores.isEmpty()) {
            throw new Exception("게임 진행에 필요한 가게 데이터가 없습니다.");
        }
        
        return stores;
    }
}
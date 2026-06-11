package kr.or.ddit.store.detail.service;

import kr.or.ddit.store.detail.vo.StoreDetailVO;
import java.util.List;
import java.util.Map;


/**
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 * Store Detail Service Interface
 * ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 */
public interface IStoreDetailService {
    
    /**
     * 가게 상세 정보 통합 조회
     */
    StoreDetailVO getStoreWithAllData(String storeId, String userId) throws Exception;
    
    /**
     * 예약 가능 시간대 조회
     */
    List<String> getAvailableTimes(String storeId, String date) throws Exception;
    
    /**
     * 좋아요/찜 토글
     */
    Map<String, Object> toggleAction(String userId, String storeId, 
                                      String type, String action) throws Exception;
    
    
    
}


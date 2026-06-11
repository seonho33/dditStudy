package kr.or.ddit.err.dao;

import java.util.List;
import kr.or.ddit.store.vo.StoreVO;

/**
 * 식당 DAO 인터페이스
 */
public interface IDeadukGameDao {
    
	StoreVO selectRandomStore();
	String selectMainMenuName(String storeId);

    
    /**
     * 특정 식당 조회
     * @param storeId 식당 ID
     * @return 식당 정보
     */
    StoreVO selectStoreById(String storeId);
}

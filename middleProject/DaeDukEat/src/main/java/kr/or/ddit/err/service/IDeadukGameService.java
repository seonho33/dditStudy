package kr.or.ddit.err.service;

import kr.or.ddit.store.vo.StoreVO;

/**
 * 식당 서비스 인터페이스
 */
public interface IDeadukGameService {
    
    /**
     * 특정 식당 조회
     * @param storeId 식당 ID
     * @return 식당 정보
     */
    StoreVO getStoreById(String storeId);
    
    /**
     * 랜덤 식당 1건 조회 (DB에서 ROWNUM=1 랜덤)
     */
    StoreVO getRandomStore();

    /**
     * 대표메뉴 1개 조회 (menu 테이블에서 가장 앞 메뉴 1개)
     */
    String getMainMenuName(String storeId);
}

package kr.or.ddit.store.service;

import java.util.List;

import kr.or.ddit.store.vo.StoreVO;

public interface IDIpsListService {
	
	/**
     * 회원 찜 가게 목록 조회
     */
    List<StoreVO> getDipsStoreList(String userId);
    
    boolean removeDips(String userId, String storeId);

}

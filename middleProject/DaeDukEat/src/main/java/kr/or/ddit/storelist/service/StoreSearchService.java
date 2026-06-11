package kr.or.ddit.storelist.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.store.vo.StoreVO;

public interface StoreSearchService {

	// ✅ tag/keyword 검색 + 정렬
    List<StoreVO> getStoreSearch(String tag, String keyword, String sort);
    
    // 맛집리스트 - ✅ 카테고리별 조회 + 정렬
    List<StoreVO> getStoreListByCategory(String category, String sort);  // 카테고리별 조회
    List<StoreVO> getAllStoreList(String sort);  // 전체 조회
    List<String> getCategoryList();  // 카테고리 목록 조회
    

}

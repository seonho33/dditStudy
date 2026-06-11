package kr.or.ddit.storelist.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.store.vo.StoreVO;

public interface StoreSearchDao {

    // 🔍 메인 / MD 추천 검색
    List<StoreVO> selectStoreSearch(Map<String, Object> param);

    // 카테고리 목록 조회
    List<String> selectCategoryList();    
    // 카테고리별 가게 목록 조회
    List<StoreVO> storeSearchCategory(Map<String, String> paramMap);
    



    
}

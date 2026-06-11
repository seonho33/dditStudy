package kr.or.ddit.storelist.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.storelist.dao.StoreSearchDao;
import kr.or.ddit.storelist.dao.StoreSearchDaoImpl;

public class StoreSearchServiceImpl implements StoreSearchService {

    private static StoreSearchService instance = new StoreSearchServiceImpl();
    private StoreSearchDao dao = StoreSearchDaoImpl.getInstance();

    private StoreSearchServiceImpl() {}

    public static StoreSearchService getInstance() {
        return instance;
    }

    @Override
    public List<StoreVO> getStoreSearch(String tag, String keyword, String sort) {

        // mapper로 넘길 파라미터 묶기
        Map<String, Object> param = new HashMap<>();
        param.put("tag", tag);
        param.put("keyword", keyword);
        param.put("sort", sort);  // ✅ 정렬 기준 추가

        return dao.selectStoreSearch(param);
    }

    
   // 맛집리스트 - 카테고리 조회
    @Override
    public List<StoreVO> getStoreListByCategory(String category, String sort) {
        // 카테고리별 가게 목록 조회
        Map<String, String> param = new HashMap<>();
        param.put("category", category);
        param.put("sort", sort);  // ✅ 정렬 기준 추가
        return dao.storeSearchCategory(param);
    }

    @Override
    public List<StoreVO> getAllStoreList(String sort) {
        // ✅ 전체 조회 + 정렬
        Map<String, String> param = new HashMap<>();
        param.put("sort", sort);  // ✅ 정렬 기준 추가
        
        return dao.storeSearchCategory(param);
    }
    
    @Override
    public List<String> getCategoryList() {
        // 카테고리 목록만 조회
        return dao.selectCategoryList();
    }
    




}

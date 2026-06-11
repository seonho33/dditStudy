package kr.or.ddit.storelist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.StoreVO;

public class StoreSearchDaoImpl implements StoreSearchDao {

    // 싱글톤
    private static StoreSearchDao instance = new StoreSearchDaoImpl();
    private StoreSearchDaoImpl() {}
    public static StoreSearchDao getInstance() {
        return instance;
    }

    @Override
    public List<StoreVO> selectStoreSearch(Map<String, Object> param) {

        // MyBatis 세션 열기
        SqlSession session = MyBatisUtil.getSqlSession();

        // mapper 호출
        List<StoreVO> list =
            session.selectList("storeSearch.selectStoreSearch", param);

        session.close();
        return list;
    }
    
    
    //카테고리 검색
	@Override
	public List<String> selectCategoryList() {   
        // MyBatis 세션 열기
        SqlSession session = MyBatisUtil.getSqlSession();
        // mapper 호출
        List<String> list =
            session.selectList("storeSearch.selectCategoryList");

        	session.close();
        return list;
	}
	

	@Override
	public List<StoreVO> storeSearchCategory(Map<String, String> paramMap) {
		// MyBatis 세션 열기
        SqlSession session = MyBatisUtil.getSqlSession();
        // mapper 호출
        List<StoreVO> list =
            session.selectList("storeSearch.storeSearchCategory",paramMap);

        	session.close();
        return list;
	}

    
   


}

package kr.or.ddit.store.detail.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.detail.vo.*;
import kr.or.ddit.menu.vo.MenuVO;

public class StoreDetailDAOImpl implements IStoreDetailDAO {
    
    private static StoreDetailDAOImpl instance = new StoreDetailDAOImpl();
    private StoreDetailDAOImpl() {}
    public static StoreDetailDAOImpl getInstance() { 
        return instance; 
    }
    
    private static final String NS = "kr.or.ddit.store.detail.dao.IStoreDetailDAO.";
    
    @Override
    public StoreDetailVO selectStoreById(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        StoreDetailVO result = null;
        try {
            result = session.selectOne(NS + "selectStoreById", storeId);
        } finally {
            if(session != null) session.close();
        }
        return result;
    }
    
    
    
    
    @Override
    public List<MenuVO> selectMenuList(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<MenuVO> list = null;  // ✅ kr.or.ddit.menu.vo.MenuVO
        try {
            list = session.selectList(NS + "selectMenuList", storeId);
        } finally {
            if(session != null) session.close();
        }
        return list;
    }
    
    @Override
    public List<ReviewDetailVO> selectReviewsWithCeoReply(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<ReviewDetailVO> list = null;
        try {
            list = session.selectList(NS + "selectReviewsWithCeoReply", storeId);
        } finally {
            if(session != null) session.close();
        }
        return list;
    }
    
    @Override
    public List<String> selectStoreHolidays(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<String> list = null;
        try {
            list = session.selectList(NS + "selectStoreHolidays", storeId);
        } finally {
            if(session != null) session.close();
        }
        return list;
    }
    
    @Override
    public int checkUserLike(String userId, String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int count = 0;
        try {
            Map<String, String> params = new HashMap<>();
            params.put("userId", userId);
            params.put("storeId", storeId);
            count = session.selectOne(NS + "checkUserLike", params);
        } finally {
            if(session != null) session.close();
        }
        return count;
    }
    
    @Override
    public int checkUserBookmark(String userId, String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int count = 0;
        try {
            Map<String, String> params = new HashMap<>();
            params.put("userId", userId);
            params.put("storeId", storeId);
            count = session.selectOne(NS + "checkUserBookmark", params);
        } finally {
            if(session != null) session.close();
        }
        return count;
    }
    
    @Override
    public List<String> getBookedTimes(String storeId, String date) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<String> list = null;
        try {
            Map<String, String> params = new HashMap<>();
            params.put("storeId", storeId);
            params.put("date", date);
            list = session.selectList(NS + "getBookedTimes", params);
        } finally {
            if(session != null) session.close();
        }
        return list != null ? list : new java.util.ArrayList<>();
    }
    
    @Override
    public int insertUserLike(String userId, String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        try {
            Map<String, String> params = new HashMap<>();
            params.put("userId", userId);
            params.put("storeId", storeId);
            result = session.insert(NS + "insertUserLike", params);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        return result;
    }
    
    @Override
    public int deleteUserLike(String userId, String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        try {
            Map<String, String> params = new HashMap<>();
            params.put("userId", userId);
            params.put("storeId", storeId);
            result = session.delete(NS + "deleteUserLike", params);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        return result;
    }
    
    @Override
    public int insertDids(String userId, String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        try {
            Map<String, String> params = new HashMap<>();
            params.put("userId", userId);
            params.put("storeId", storeId);
            result = session.insert(NS + "insertDids", params);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        return result;
    }
    
    @Override
    public int deleteDids(String userId, String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        try {
            Map<String, String> params = new HashMap<>();
            params.put("userId", userId);
            params.put("storeId", storeId);
            result = session.delete(NS + "deleteDids", params);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        return result;
    }
    
    @Override
    public int updateDibsCount(String storeId, int delta) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("storeId", storeId);
            params.put("delta", delta);
            result = session.update(NS + "updateDibsCount", params);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        return result;
    }
	@Override
	public int updateUserLikeCount(String storeId, int delta) throws Exception {
		 SqlSession session = MyBatisUtil.getSqlSession();
		    int result = 0;
		    try {
		        Map<String, Object> params = new HashMap<>();
		        params.put("storeId", storeId);
		        params.put("delta", delta);

		        // ✅ STORE.LIKES_COUNT 업데이트
		        result = session.update(NS + "updateUserLikeCount", params);

		        if (result > 0) session.commit();
		    } catch (Exception e) {
		        session.rollback();
		        throw e;
		    } finally {
		        if (session != null) session.close();
		    }
		    return result;
	}

    
 
}

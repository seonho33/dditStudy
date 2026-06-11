package kr.or.ddit.store.detail.dao;

import java.util.List;
import kr.or.ddit.store.detail.vo.*;
import kr.or.ddit.menu.vo.MenuVO;  // ✅ 올바른 import

public interface IStoreDetailDAO {
    
    StoreDetailVO selectStoreById(String storeId) throws Exception;
    List<MenuVO> selectMenuList(String storeId) throws Exception;  // ✅ kr.or.ddit.menu.vo.MenuVO
    List<ReviewDetailVO> selectReviewsWithCeoReply(String storeId) throws Exception;
    List<String> selectStoreHolidays(String storeId) throws Exception;
    
    int checkUserLike(String userId, String storeId) throws Exception;
    int checkUserBookmark(String userId, String storeId) throws Exception;
    
    List<String> getBookedTimes(String storeId, String date) throws Exception;
    
    int insertUserLike(String userId, String storeId) throws Exception;
    int deleteUserLike(String userId, String storeId) throws Exception;
	int updateUserLikeCount(String storeId, int delta) throws Exception;
	
    int insertDids(String userId, String storeId) throws Exception;
    int deleteDids(String userId, String storeId) throws Exception;
    int updateDibsCount(String storeId, int delta) throws Exception;

    
    
    
}
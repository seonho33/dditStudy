package kr.or.ddit.store.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.store.vo.StoreVO;

public interface IDipsListDao {

	 /**
     * 특정 회원이 찜한 가게 목록 조회
     * @param userId 로그인한 회원 ID
     * @return 찜한 가게 리스트
     */
    List<StoreVO> selectDipsStoreList(String userId);
    
    int deleteDips(SqlSession session, String userId, String storeId);
    
    int decreaseDibsCount(SqlSession session, String storeId);
    
}

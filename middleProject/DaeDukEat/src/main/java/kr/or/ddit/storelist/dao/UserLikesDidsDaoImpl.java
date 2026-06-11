package kr.or.ddit.storelist.dao;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.UserLikesDidsVO;

public class UserLikesDidsDaoImpl implements UserLikesDidsDao {
	
    private static UserLikesDidsDao dao = new UserLikesDidsDaoImpl();
    public static UserLikesDidsDao getInstance() { 
    	return dao; 
    	}
	
    //좋아요
	@Override
	public int insertUserLike(UserLikesDidsVO vo) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
        	int cnt = session.insert("userLikesDids.insertUserLike", vo);
            session.commit();
            return cnt;
        }
	}

	@Override
	public int deleteUserLike(UserLikesDidsVO vo) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
        	int cnt = session.delete("userLikesDids.deleteUserLike", vo);
            session.commit();
            return cnt;
        }
	}
	
    @Override
    public int checkUserLike(UserLikesDidsVO vo) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectOne("userLikesDids.checkUserLike", vo);
        }
    }	
	
    /**
     * ✅ 새로 추가: STORE 테이블의 LIKES_COUNT 업데이트
     * 좋아요 추가/삭제 후 실제 개수를 세어서 STORE 테이블에 반영
     * @param storeId - 업데이트할 가게 ID
     * @return 처리된 행 수
     */
    @Override
    public int updateLikesCount(String storeId) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            // USER_LIKES 테이블의 실제 개수를 세어서 STORE.LIKES_COUNT 업데이트
            int cnt = session.update("userLikesDids.updateLikesCount", storeId);
            session.commit();
            return cnt;
        }
    }    
    
    
    // 찜
	@Override
	public int insertDibs(UserLikesDidsVO vo) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
        	int cnt = session.insert("userLikesDids.insertDibs", vo);
            session.commit();
            return cnt;
        }
	}

	@Override
	public int deleteDibs(UserLikesDidsVO vo) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
        	int cnt = session.delete("userLikesDids.deleteDibs", vo);
            session.commit();
            return cnt;
        }
	}

	@Override
    public int checkDibs(UserLikesDidsVO vo) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            return session.selectOne("userLikesDids.checkDibs", vo);
        }
    }
    
    /**
     * ✅ 새로 추가: STORE 테이블의 DIBS_COUNT 업데이트
     * 찜 추가/삭제 후 실제 개수를 세어서 STORE 테이블에 반영
     * @param storeId - 업데이트할 가게 ID
     * @return 처리된 행 수
     */
    @Override
    public int updateDibsCount(String storeId) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            // DIDS 테이블의 실제 개수를 세어서 STORE.DIBS_COUNT 업데이트
            int cnt = session.update("userLikesDids.updateDibsCount", storeId);
            session.commit();
            return cnt;
        }
    }	

}

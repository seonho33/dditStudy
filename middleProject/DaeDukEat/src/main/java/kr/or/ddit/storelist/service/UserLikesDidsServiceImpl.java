package kr.or.ddit.storelist.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.store.vo.UserLikesDidsVO;
import kr.or.ddit.storelist.dao.UserLikesDidsDao;
import kr.or.ddit.storelist.dao.UserLikesDidsDaoImpl;

public class UserLikesDidsServiceImpl implements UserLikesDidsService {
	
	 private UserLikesDidsDao dao = UserLikesDidsDaoImpl.getInstance();
	 private SqlSession sqlSession;

	 
//	 //좋아요
//	@Override
//	public int like(UserLikesDidsVO vo) {
//		return dao.insertUserLike(vo);
//	}
//	@Override
//	public int unlike(UserLikesDidsVO vo) {
//		return dao.deleteUserLike(vo);
//	}
//	
//	 //찜
//	@Override
//	public int dibs(UserLikesDidsVO vo) {
//		return dao.insertDibs(vo);
//	}
//	@Override
//	public int undibs(UserLikesDidsVO vo) {
//		return dao.deleteDibs(vo);
//	}
//	
//	// ✅ 좋아요 존재 여부 확인 (추가)
//    @Override
//    public int checkUserLike(Map<String, String> params) {
//        return sqlSession.selectOne("userLikesDids.checkUserLike", params);
//    }
//    
//    // ✅ 찜 존재 여부 확인 (추가)
//    @Override
//    public int checkDibs(Map<String, String> params) {
//        return sqlSession.selectOne("userLikesDids.checkDibs", params);
//    }
	
	  // ========================================
	    // ❤️ 좋아요 관련 메서드 구현
	    // ========================================
	    
	    /**
	     * ✅ 수정: 좋아요 토글 + LIKES_COUNT 자동 업데이트
	     * 
	     * 동작 흐름:
	     * 1. 좋아요 존재 여부 확인 (checkUserLike)
	     * 2-A. 이미 좋아요 상태 → DELETE
	     * 2-B. 좋아요 안 한 상태 → INSERT
	     * 3. STORE 테이블의 LIKES_COUNT 업데이트 (핵심!)
	     * 
	     * @param vo - userId, storeId
	     * @return 처리된 행 수 (INSERT/DELETE 성공 시 1, 실패 시 0)
	     */
	    @Override
	    public int like(UserLikesDidsVO vo) {
	        try {
	            // 1️⃣ 좋아요 존재 여부 확인
	            int exists = dao.checkUserLike(vo);
	            
	            int result = 0;
	            
	            if (exists > 0) {
	                // 2️⃣-A 이미 좋아요 상태 → DELETE
	                result = dao.deleteUserLike(vo);
	            } else {
	                // 2️⃣-B 좋아요 안 한 상태 → INSERT
	                result = dao.insertUserLike(vo);
	            }
	            
	            // 3️⃣ ✅ 핵심! STORE 테이블의 LIKES_COUNT 업데이트
	            // INSERT든 DELETE든 상관없이 실제 개수를 세어서 업데이트
	            if (result > 0) {
	                dao.updateLikesCount(vo.getStoreId());
	            }
	            
	            return result;
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            return 0;
	        }
	    }
	    
	    /**
	     * 좋아요 삭제 (단순 삭제, 카운트 업데이트 없음)
	     * @param vo - userId, storeId
	     * @return 처리된 행 수
	     */
	    @Override
	    public int unlike(UserLikesDidsVO vo) {
	        return dao.deleteUserLike(vo);
	    }
	    
	    // ========================================
	    // ⭐ 찜 관련 메서드 구현
	    // ========================================
	    
	    /**
	     * ✅ 수정: 찜 토글 + DIBS_COUNT 자동 업데이트
	     * 
	     * 동작 흐름:
	     * 1. 찜 존재 여부 확인 (checkDibs)
	     * 2-A. 이미 찜 상태 → DELETE
	     * 2-B. 찜 안 한 상태 → INSERT
	     * 3. STORE 테이블의 DIBS_COUNT 업데이트 (핵심!)
	     * 
	     * @param vo - userId, storeId
	     * @return 처리된 행 수 (INSERT/DELETE 성공 시 1, 실패 시 0)
	     */
	    @Override
	    public int dibs(UserLikesDidsVO vo) {
	        try {
	            // 1️⃣ 찜 존재 여부 확인
	            int exists = dao.checkDibs(vo);
	            
	            int result = 0;
	            
	            if (exists > 0) {
	                // 2️⃣-A 이미 찜 상태 → DELETE
	                result = dao.deleteDibs(vo);
	            } else {
	                // 2️⃣-B 찜 안 한 상태 → INSERT
	                result = dao.insertDibs(vo);
	            }
	            
	            // 3️⃣ ✅ 핵심! STORE 테이블의 DIBS_COUNT 업데이트
	            // INSERT든 DELETE든 상관없이 실제 개수를 세어서 업데이트
	            if (result > 0) {
	                dao.updateDibsCount(vo.getStoreId());
	            }
	            
	            return result;
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            return 0;
	        }
	    }
	    
	    /**
	     * 찜 삭제 (단순 삭제, 카운트 업데이트 없음)
	     * @param vo - userId, storeId
	     * @return 처리된 행 수
	     */
	    @Override
	    public int undibs(UserLikesDidsVO vo) {
	        return dao.deleteDibs(vo);
	    }

}

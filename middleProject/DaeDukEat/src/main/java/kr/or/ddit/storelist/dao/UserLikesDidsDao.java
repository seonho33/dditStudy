package kr.or.ddit.storelist.dao;

import kr.or.ddit.store.vo.UserLikesDidsVO;

public interface UserLikesDidsDao {
	
	int insertUserLike(UserLikesDidsVO vo);   // 좋아요
	int deleteUserLike(UserLikesDidsVO vo);
	
	 /**
     * 좋아요 존재 여부 확인
     * @param vo - userId, storeId
     * @return 존재하면 1, 없으면 0
     */
    int checkUserLike(UserLikesDidsVO vo);
    
    /**
     * ✅ 새로 추가: STORE 테이블의 LIKES_COUNT 업데이트
     * USER_LIKES 테이블에서 실제 좋아요 개수를 세어서 STORE 테이블에 반영
     * @param storeId - 업데이트할 가게 ID
     * @return 처리된 행 수
     */
    int updateLikesCount(String storeId);
	

	int insertDibs(UserLikesDidsVO vo);       // 찜
	int deleteDibs(UserLikesDidsVO vo);

	/**
     * 찜 존재 여부 확인
     * @param vo - userId, storeId
     * @return 존재하면 1, 없으면 0
     */
    int checkDibs(UserLikesDidsVO vo);
    
    /**
     * ✅ 새로 추가: STORE 테이블의 DIBS_COUNT 업데이트
     * DIDS 테이블에서 실제 찜 개수를 세어서 STORE 테이블에 반영
     * @param storeId - 업데이트할 가게 ID
     * @return 처리된 행 수
     */
    int updateDibsCount(String storeId);
	
}

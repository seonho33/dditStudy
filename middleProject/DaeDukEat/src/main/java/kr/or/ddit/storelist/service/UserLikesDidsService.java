package kr.or.ddit.storelist.service;

import java.util.Map;

import kr.or.ddit.store.vo.UserLikesDidsVO;

public interface UserLikesDidsService {
	
//	// 좋아요
//	int like(UserLikesDidsVO vo);
//	int unlike(UserLikesDidsVO vo);
//    
//    // 찜
//	int dibs(UserLikesDidsVO vo);
//	int undibs(UserLikesDidsVO vo);
//	
//    // ✅ 좋아요 존재 여부 확인 (추가)
//    public int checkUserLike(Map<String, String> params);
//    
//    // ✅ 찜 존재 여부 확인 (추가)
//    public int checkDibs(Map<String, String> params);
	
	
	  
    // ========================================
    // ❤️ 좋아요 관련 메서드
    // ========================================
    
    /**
     * 좋아요 토글 (이미 있으면 DELETE, 없으면 INSERT)
     * ✅ 수정: 좋아요 추가/삭제 후 LIKES_COUNT 자동 업데이트
     * @param vo - userId, storeId 포함
     * @return 처리된 행 수 (1: 성공, 0: 실패)
     */
    int like(UserLikesDidsVO vo);
    
    /**
     * 좋아요 삭제 (기존 메서드 - 사용하지 않을 수도 있음)
     * @param vo - userId, storeId
     * @return 처리된 행 수
     */
    int unlike(UserLikesDidsVO vo);
    
    // ========================================
    // ⭐ 찜 관련 메서드
    // ========================================
    
    /**
     * 찜 토글 (이미 있으면 DELETE, 없으면 INSERT)
     * ✅ 수정: 찜 추가/삭제 후 DIBS_COUNT 자동 업데이트
     * @param vo - userId, storeId 포함
     * @return 처리된 행 수 (1: 성공, 0: 실패)
     */
    int dibs(UserLikesDidsVO vo);
    
    /**
     * 찜 삭제 (기존 메서드 - 사용하지 않을 수도 있음)
     * @param vo - userId, storeId
     * @return 처리된 행 수
     */
    int undibs(UserLikesDidsVO vo);

}

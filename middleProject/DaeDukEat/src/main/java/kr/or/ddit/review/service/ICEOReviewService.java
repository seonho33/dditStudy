package kr.or.ddit.review.service;

import java.util.List;
import kr.or.ddit.review.vo.CEOReviewDetailVO;
import kr.or.ddit.review.vo.CeoReviewVO;

/**
 * 리뷰 관리 서비스 인터페이스
 */
public interface ICEOReviewService {
    
    /**
     * 특정 가게의 리뷰 목록 조회
     * @param storeId 가게ID
     * @return 리뷰 목록
     */
    List<CEOReviewDetailVO> getReviewsByStore(String storeId) throws Exception;
    
    /**
     * 사장 답글 저장 (신규 등록 또는 수정)
     * @param ceoReview 답글 VO
     * @return 성공 시 true
     */
    boolean saveCeoReply(CeoReviewVO ceoReview) throws Exception;
}
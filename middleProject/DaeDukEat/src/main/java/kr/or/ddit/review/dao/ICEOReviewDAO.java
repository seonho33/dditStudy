package kr.or.ddit.review.dao;

import java.util.List;
import kr.or.ddit.review.vo.CEOReviewDetailVO;
import kr.or.ddit.review.vo.CeoReviewVO;

/**
 * 리뷰 관리 DAO 인터페이스
 * @namespace kr.or.ddit.review.dao.IReviewDAO
 */
public interface ICEOReviewDAO {
    
    /**
     * 특정 가게의 전체 리뷰 목록 조회 (사장 답글 포함)
     * @param storeId 가게ID
     * @return 리뷰 상세 정보 리스트
     */
    List<CEOReviewDetailVO> selectReviewsByStore(String storeId) throws Exception;
    
    /**
     * 사장 답글 존재 여부 확인
     * @param reservId 예약ID
     * @return 답글 개수 (0 또는 1)
     */
    int checkCeoReplyExists(Long reservId) throws Exception;
    
    /**
     * 사장 답글 등록
     * @param ceoReview 답글 VO
     * @return 성공 시 1, 실패 시 0
     */
    int insertCeoReply(CeoReviewVO ceoReview) throws Exception;
    
    /**
     * 사장 답글 수정
     * @param ceoReview 답글 VO
     * @return 성공 시 1, 실패 시 0
     */
    int updateCeoReply(CeoReviewVO ceoReview) throws Exception;
}
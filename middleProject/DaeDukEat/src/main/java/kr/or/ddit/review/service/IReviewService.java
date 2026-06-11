package kr.or.ddit.review.service;

import java.util.List;
import kr.or.ddit.review.vo.UserReviewVO;
import kr.or.ddit.review.vo.ReviewDetailVO;

/**
 * 리뷰 비즈니스 로직 인터페이스
 * 
 * @author Legacy Architecture Team
 * @since 2025-01-23
 * @implNote ReviewServiceImpl (Singleton)
 */
public interface IReviewService {
    
    /**
     * 리뷰 작성
     * @param review 리뷰 정보
     * @return 작성 성공 여부
     */
    boolean writeReview(UserReviewVO review);
    
    /**
     * 미작성 리뷰 목록 조회
     * @param userId 사용자 ID
     * @return 미작성 리뷰 목록
     */
    List<ReviewDetailVO> getUnwrittenReviews(String userId);
    
    /**
     * 내가 작성한 리뷰 목록 조회
     * @param userId 사용자 ID
     * @return 작성한 리뷰 목록
     */
    List<ReviewDetailVO> getMyReviews(String userId);
    
    /**
     * 리뷰 상세 조회
     * @param reservId 예약 ID
     * @return 리뷰 상세 정보
     */
    ReviewDetailVO getReviewDetail(Long reservId);
    
    /**
     * 리뷰 삭제
     * @param reservId 예약 ID
     * @return 삭제 성공 여부
     */
    boolean removeReview(Long reservId);

    
    
}
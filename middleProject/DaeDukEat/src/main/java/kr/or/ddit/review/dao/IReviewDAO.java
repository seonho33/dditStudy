package kr.or.ddit.review.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.review.vo.ReviewDetailVO;
import kr.or.ddit.review.vo.UserReviewVO;

/**
 * 리뷰 데이터 접근 인터페이스
 * 
 * @author Legacy Architecture Team
 * @since 2025-01-23
 * @implNote ReviewDAOImpl (Singleton)
 */
public interface IReviewDAO {
    
    /**
     * 리뷰 작성
     * @param review 리뷰 정보 (reservId, review, rating, reviewPicture 필수)
     * @return 작성 성공 시 1, 실패 시 0
     * @throws Exception DB 처리 실패
     */
    int insertReview(UserReviewVO review) throws Exception;
    
    /**
     * 미작성 리뷰 목록 조회 (예약 완료 + 리뷰 없음)
     * @param userId 사용자 ID
     * @return 미작성 리뷰 대상 예약 목록
     * @throws Exception DB 처리 실패
     */
    List<ReviewDetailVO> selectUnwrittenReviews(String userId) throws Exception;
    
    /**
     * 내가 작성한 리뷰 목록 조회
     * @param userId 사용자 ID
     * @return 작성한 리뷰 목록 (최신순)
     * @throws Exception DB 처리 실패
     */
    List<ReviewDetailVO> selectMyReviews(String userId) throws Exception;
    
    /**
     * 리뷰 상세 조회
     * @param reservId 예약 ID
     * @return 리뷰 상세 정보
     * @throws Exception DB 처리 실패
     */
    ReviewDetailVO selectReviewDetail(Long reservId) throws Exception;
    
    /**
     * 리뷰 삭제 (상태 변경: '삭제')
     * @param reservId 예약 ID
     * @return 삭제 성공 시 1, 실패 시 0
     * @throws Exception DB 처리 실패
     */
    int deleteReview(Long reservId) throws Exception;
    
    /**
     * 가게 평점 업데이트 (트리거 대체용)
     * @param storeId 가게 ID
     * @return 업데이트 성공 시 1, 실패 시 0
     * @throws Exception DB 처리 실패
     */
    int updateStoreRating(String storeId) throws Exception;
    
    Map<String, String> selectUserAndStoreByReservId(Long reservId) throws Exception;

    int countUserReviewsSinceCouponCreate(java.util.Map<String, Object> param) throws Exception;
}
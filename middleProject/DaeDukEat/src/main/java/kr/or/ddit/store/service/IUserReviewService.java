package kr.or.ddit.store.service;

import java.util.List;
import kr.or.ddit.store.vo.UserReviewVO;

/**
 * 사용자 리뷰 Service 인터페이스
 * 
 * [역할]
 * - 비즈니스 로직 및 검증
 * - 예외 처리
 */
public interface IUserReviewService {
    
    /**
     * 리뷰 작성 가능한 예약 목록 조회
     * 
     * @param userId 회원 ID
     * @return 리뷰 미작성 & 예약 완료 목록
     * @throws Exception 조회 실패 시
     */
    List<UserReviewVO> getReviewableReservations(String userId) throws Exception;
    
    /**
     * 내가 쓴 리뷰 목록 조회
     * 
     * @param userId 회원 ID
     * @return 작성한 리뷰 목록 (최신순)
     * @throws Exception 조회 실패 시
     */
    List<UserReviewVO> getMyReviews(String userId) throws Exception;
    
    /**
     * 리뷰 상세 조회
     * 
     * @param reservId 예약 ID
     * @return 리뷰 상세 정보
     * @throws Exception 조회 실패 시
     */
    UserReviewVO getReviewById(Long reservId) throws Exception;
    
    /**
     * 리뷰 작성 (비즈니스 로직 포함)
     * 
     * @param review 리뷰 정보
     * @param userId 사용자 ID (권한 검증용)
     * @return 성공=true, 실패=false
     * @throws Exception 작성 실패 시
     * 
     * [비즈니스 규칙]
     * 1. 리뷰 내용 필수 (최소 10자)
     * 2. 평점 필수 (1-5)
     * 3. 중복 리뷰 작성 방지
     * 4. 본인 예약인지 확인
     */
    boolean writeReview(UserReviewVO review, String userId) throws Exception;
    
    /**
     * 리뷰 수정 (비즈니스 로직 포함)
     * 
     * @param review 수정할 리뷰 정보
     * @param userId 사용자 ID (권한 검증용)
     * @return 성공=true, 실패=false
     * @throws Exception 수정 실패 시
     * 
     * [비즈니스 규칙]
     * 1. 본인 리뷰인지 확인
     * 2. 리뷰 내용 검증
     */
    boolean modifyReview(UserReviewVO review, String userId) throws Exception;
    
    /**
     * 리뷰 삭제 (비즈니스 로직 포함)
     * 
     * @param reservId 예약 ID
     * @param userId 사용자 ID (권한 검증용)
     * @return 성공=true, 실패=false
     * @throws Exception 삭제 실패 시
     * 
     * [비즈니스 규칙]
     * 1. 본인 리뷰인지 확인
     * 2. 이미 삭제된 리뷰는 처리 안 함
     */
    boolean removeReview(Long reservId, String userId) throws Exception;
    
    /**
     * 가게별 리뷰 목록 조회
     * 
     * @param storeId 가게 ID
     * @return 해당 가게의 리뷰 목록
     * @throws Exception 조회 실패 시
     */
    List<UserReviewVO> getStoreReviews(String storeId) throws Exception;
}
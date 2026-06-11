package kr.or.ddit.store.dao;

import java.util.List;
import kr.or.ddit.store.vo.UserReviewVO;

/**
 * 사용자 리뷰 DAO 인터페이스
 * 
 * [주요 기능]
 * 1. 리뷰 작성 가능한 예약 목록 조회
 * 2. 내가 쓴 리뷰 목록 조회
 * 3. 리뷰 작성 (INSERT)
 * 4. 리뷰 수정 (UPDATE)
 * 5. 리뷰 삭제 (논리 삭제)
 * 
 * [MyBatis Mapper 연동]
 * - namespace: "userReview"
 * - 모든 메서드는 UserReviewMapper.xml의 id와 동기화
 */
public interface IUserReviewDAO {
    
    /**
     * 리뷰 작성 가능한 예약 목록 조회
     * 
     * @param userId 회원 ID
     * @return 리뷰 미작성 & 예약 완료 목록
     * @throws Exception DB 조회 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: selectReviewableReservations
     * - 조건: RESERV_STATUS='완료', USER_REVIEW 테이블에 없음
     */
    List<UserReviewVO> selectReviewableReservations(String userId) throws Exception;
    
    /**
     * 내가 쓴 리뷰 목록 조회
     * 
     * @param userId 회원 ID
     * @return 작성한 리뷰 목록 (최신순)
     * @throws Exception DB 조회 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: selectMyReviews
     * - 정렬: CREATE_DATE DESC
     */
    List<UserReviewVO> selectMyReviews(String userId) throws Exception;
    
    /**
     * 리뷰 상세 조회 (단건)
     * 
     * @param reservId 예약 ID
     * @return 리뷰 상세 정보 (없으면 null)
     * @throws Exception DB 조회 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: selectReviewById
     */
    UserReviewVO selectReviewById(Long reservId) throws Exception;
    
    /**
     * 리뷰 작성
     * 
     * @param review 리뷰 정보 (reservId, review, rating 필수)
     * @return 삽입된 행 수 (1=성공, 0=실패)
     * @throws Exception DB 삽입 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: insertReview
     * 
     * [자동 설정 값]
     * - CREATE_DATE: SYSDATE
     * - STATUS: '정상'
     */
    int insertReview(UserReviewVO review) throws Exception;
    
    /**
     * 리뷰 수정
     * 
     * @param review 수정할 리뷰 정보
     * @return 업데이트된 행 수 (1=성공, 0=실패)
     * @throws Exception DB 업데이트 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: updateReview
     * 
     * [자동 설정 값]
     * - UPDATE_DATE: SYSDATE
     */
    int updateReview(UserReviewVO review) throws Exception;
    
    /**
     * 리뷰 논리 삭제
     * 
     * @param reservId 예약 ID
     * @return 업데이트된 행 수 (1=성공, 0=실패)
     * @throws Exception DB 업데이트 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: deleteReview
     * 
     * [처리 방식]
     * - 물리 삭제 대신 STATUS='삭제'로 업데이트
     */
    int deleteReview(Long reservId) throws Exception;
    
    /**
     * 가게별 리뷰 목록 조회
     * 
     * @param storeId 가게 ID
     * @return 해당 가게의 리뷰 목록
     * @throws Exception DB 조회 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: selectReviewsByStore
     */
    List<UserReviewVO> selectReviewsByStore(String storeId) throws Exception;
    
    /**
     * 리뷰 존재 여부 확인
     * 
     * @param reservId 예약 ID
     * @return 존재 여부 (1=존재, 0=미존재)
     * @throws Exception DB 조회 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: checkReviewExists
     * 
     * [사용 목적]
     * - 중복 리뷰 작성 방지
     */
    int checkReviewExists(Long reservId) throws Exception;
}
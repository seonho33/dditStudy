package kr.or.ddit.store.service;

import java.util.List;

import kr.or.ddit.store.dao.IUserReviewDAO;
import kr.or.ddit.store.dao.UserReviewDAOImpl;
import kr.or.ddit.store.vo.UserReviewVO;

/**
 * 사용자 리뷰 Service 구현체
 * 
 * [비즈니스 로직 책임]
 * 1. 입력 데이터 검증
 * 2. 권한 확인
 * 3. 중복 방지
 * 4. 예외 처리
 */
public class UserReviewServiceImpl implements IUserReviewService {
    
    /* ====================================
       Singleton & DAO 인스턴스
       ==================================== */
    private static UserReviewServiceImpl instance = new UserReviewServiceImpl();
    private IUserReviewDAO dao;
    
    private UserReviewServiceImpl() {
        this.dao = UserReviewDAOImpl.getInstance();
    }
    
    public static UserReviewServiceImpl getInstance() {
        return instance;
    }
    
    
    /* ====================================
       조회 메서드
       ==================================== */
    
    @Override
    public List<UserReviewVO> getReviewableReservations(String userId) throws Exception {
        // [입력 검증]
        if(userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 ID가 유효하지 않습니다.");
        }
        
        return dao.selectReviewableReservations(userId);
    }
    
    @Override
    public List<UserReviewVO> getMyReviews(String userId) throws Exception {
        if(userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 ID가 유효하지 않습니다.");
        }
        
        return dao.selectMyReviews(userId);
    }
    
    @Override
    public UserReviewVO getReviewById(Long reservId) throws Exception {
        if(reservId == null || reservId <= 0) {
            throw new IllegalArgumentException("예약 ID가 유효하지 않습니다.");
        }
        
        return dao.selectReviewById(reservId);
    }
    
    @Override
    public List<UserReviewVO> getStoreReviews(String storeId) throws Exception {
        if(storeId == null || storeId.trim().isEmpty()) {
            throw new IllegalArgumentException("가게 ID가 유효하지 않습니다.");
        }
        
        return dao.selectReviewsByStore(storeId);
    }
    
    
    /* ====================================
       리뷰 작성 (비즈니스 로직)
       ==================================== */
    
    @Override
    public boolean writeReview(UserReviewVO review, String userId) throws Exception {
        // [1] 입력 검증
        if(review == null) {
            throw new IllegalArgumentException("리뷰 정보가 없습니다.");
        }
        if(userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 ID가 유효하지 않습니다.");
        }
        if(review.getReservId() == null || review.getReservId() <= 0) {
            throw new IllegalArgumentException("예약 ID가 유효하지 않습니다.");
        }
        
        // [2] 리뷰 내용 검증
        if(review.getReview() == null || review.getReview().trim().length() < 10) {
            throw new IllegalArgumentException("리뷰 내용은 최소 10자 이상 입력해주세요.");
        }
        
        // [3] 평점 검증
        if(review.getRating() == null || review.getRating() < 1 || review.getRating() > 5) {
            throw new IllegalArgumentException("평점은 1~5 사이로 선택해주세요.");
        }
        
        // [4] 중복 리뷰 작성 방지
        int exists = dao.checkReviewExists(review.getReservId());
        if(exists > 0) {
            throw new IllegalStateException("이미 리뷰를 작성한 예약입니다.");
        }
        
        // [5] 본인 예약인지 확인 (추가 검증 필요 시)
        // TODO: RESERVATION 테이블에서 USER_ID 확인
        
        // [6] 모든 검증 통과 → 리뷰 작성
        int result = dao.insertReview(review);
        return result > 0;
    }
    
    
    /* ====================================
       리뷰 수정 (비즈니스 로직)
       ==================================== */
    
    @Override
    public boolean modifyReview(UserReviewVO review, String userId) throws Exception {
        // [1] 입력 검증
        if(review == null) {
            throw new IllegalArgumentException("리뷰 정보가 없습니다.");
        }
        if(userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 ID가 유효하지 않습니다.");
        }
        if(review.getReservId() == null || review.getReservId() <= 0) {
            throw new IllegalArgumentException("예약 ID가 유효하지 않습니다.");
        }
        
        // [2] 리뷰 존재 여부 확인
        UserReviewVO existing = dao.selectReviewById(review.getReservId());
        if(existing == null) {
            throw new IllegalStateException("존재하지 않는 리뷰입니다.");
        }
        
        // [3] 본인 리뷰인지 확인
        if(!userId.equals(existing.getUserId())) {
            throw new IllegalStateException("본인의 리뷰만 수정할 수 있습니다.");
        }
        
        // [4] 리뷰 내용 검증
        if(review.getReview() == null || review.getReview().trim().length() < 10) {
            throw new IllegalArgumentException("리뷰 내용은 최소 10자 이상 입력해주세요.");
        }
        
        // [5] 평점 검증
        if(review.getRating() == null || review.getRating() < 1 || review.getRating() > 5) {
            throw new IllegalArgumentException("평점은 1~5 사이로 선택해주세요.");
        }
        
        // [6] 모든 검증 통과 → 리뷰 수정
        int result = dao.updateReview(review);
        return result > 0;
    }
    
    
    /* ====================================
       리뷰 삭제 (비즈니스 로직)
       ==================================== */
    
    @Override
    public boolean removeReview(Long reservId, String userId) throws Exception {
        // [1] 입력 검증
        if(reservId == null || reservId <= 0) {
            throw new IllegalArgumentException("예약 ID가 유효하지 않습니다.");
        }
        if(userId == null || userId.trim().isEmpty()) {
            throw new IllegalArgumentException("사용자 ID가 유효하지 않습니다.");
        }
        
        // [2] 리뷰 존재 여부 확인
        UserReviewVO existing = dao.selectReviewById(reservId);
        if(existing == null) {
            throw new IllegalStateException("존재하지 않는 리뷰입니다.");
        }
        
        // [3] 본인 리뷰인지 확인
        if(!userId.equals(existing.getUserId())) {
            throw new IllegalStateException("본인의 리뷰만 삭제할 수 있습니다.");
        }
        
        // [4] 이미 삭제된 리뷰인지 확인
        if("삭제".equals(existing.getStatus())) {
            throw new IllegalStateException("이미 삭제된 리뷰입니다.");
        }
        
        // [5] 모든 검증 통과 → 리뷰 삭제 (논리 삭제)
        int result = dao.deleteReview(reservId);
        return result > 0;
    }
}
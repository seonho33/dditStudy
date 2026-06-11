package kr.or.ddit.store.service;

import java.util.List;
import kr.or.ddit.store.vo.CouponhamVO;

/**
 * 쿠폰함 Service 인터페이스
 * 
 * [역할]
 * - DAO와 Controller 사이의 비즈니스 로직 계층
 * - 트랜잭션 관리 및 비즈니스 규칙 검증
 * - 예외 처리 및 로깅
 * 
 * [DAO와의 차이점]
 * - DAO: 단순 DB CRUD
 * - Service: 비즈니스 로직 + 검증 + 예외 처리
 */
public interface ICouponhamService {
    
    /**
     * 사용자의 사용 가능한 쿠폰 목록 조회
     * 
     * @param userId 회원 ID
     * @return 사용 가능한 쿠폰 리스트
     * @throws Exception 조회 실패 시
     */
    List<CouponhamVO> getAvailableCoupons(String userId) throws Exception;
    
    /**
     * 사용자의 전체 쿠폰 목록 조회 (사용 완료 포함)
     * 
     * @param userId 회원 ID
     * @return 전체 쿠폰 리스트
     * @throws Exception 조회 실패 시
     */
    List<CouponhamVO> getAllCouponsByUser(String userId) throws Exception;
    
    /**
     * 쿠폰 상세 정보 조회
     * 
     * @param couponBoxId 쿠폰함 ID
     * @return 쿠폰 상세 정보
     * @throws Exception 조회 실패 시
     */
    CouponhamVO getCouponById(Long couponBoxId) throws Exception;
    
    /**
     * 쿠폰 사용 처리 (비즈니스 로직 포함)
     * 
     * @param couponBoxId 쿠폰함 ID
     * @param userId 사용자 ID (권한 검증용)
     * @return 성공=true, 실패=false
     * @throws Exception 사용 처리 실패 시
     * 
     * [비즈니스 규칙]
     * 1. 쿠폰 존재 여부 확인
     * 2. 본인 쿠폰인지 확인
     * 3. 이미 사용된 쿠폰인지 확인
     * 4. 쿠폰 만료 여부 확인
     * 5. 모든 검증 통과 시 사용 처리
     */
    boolean useCoupon(Long id, String userId, String storeId) throws Exception;
    
    /**
     * 쿠폰 삭제 (비즈니스 로직 포함)
     * 
     * @param couponBoxId 쿠폰함 ID
     * @param userId 사용자 ID (권한 검증용)
     * @return 성공=true, 실패=false
     * @throws Exception 삭제 실패 시
     * 
     * [비즈니스 규칙]
     * 1. 본인 쿠폰인지 확인
     * 2. 사용 완료된 쿠폰은 삭제 불가
     * 3. 모든 검증 통과 시 삭제
     */
    boolean deleteCoupon(Long couponBoxId, String userId) throws Exception;
    
    /**
     * 쿠폰 발급 (비즈니스 로직 포함)
     * 
     * @param userId 회원 ID
     * @param couponId 발급할 쿠폰 ID
     * @return 성공=true, 실패=false
     * @throws Exception 발급 실패 시
     * 
     * [비즈니스 규칙]
     * 1. 쿠폰 존재 여부 확인
     * 2. 쿠폰 수량 확인
     * 3. 중복 발급 방지
     * 4. 모든 검증 통과 시 발급
     */
    boolean issueCoupon(String userId, Long couponId) throws Exception;
    
    /**
     * 사용자의 보유 쿠폰 수 조회
     * 
     * @param userId 회원 ID
     * @return 사용 가능한 쿠폰 개수
     * @throws Exception 조회 실패 시
     */
    int getCouponCount(String userId) throws Exception;
}
package kr.or.ddit.store.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.store.vo.CouponhamVO;
/**
 * 쿠폰함 DAO 인터페이스
 * 
 * [주요 기능]
 * 1. 사용자별 쿠폰 목록 조회 (사용 가능 쿠폰만)
 * 2. 사용자별 전체 쿠폰 목록 조회 (사용 완료 포함)
 * 3. 쿠폰 상세 정보 조회
 * 4. 쿠폰 사용 처리 (UPDATE)
 * 5. 쿠폰 삭제 (논리 삭제 권장)
 * 6. 쿠폰 발급 (INSERT)
 * 
 * [MyBatis Mapper 연동]
 * - namespace: "couponham"
 * - 모든 메서드는 CouponhamMapper.xml의 id와 동기화
 */
public interface ICouponhamDAO {
    
    /**
     * 사용자의 사용 가능한 쿠폰 목록 조회
     * 
     * @param userId 회원 ID
     * @return 사용 가능한 쿠폰 리스트 (만료/사용완료 제외)
     * @throws Exception DB 조회 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: selectAvailableCoupons
     * - 조건: USE_YN='N', EXPIRED_DATE > SYSDATE, STATUS='Y'
     */
    List<CouponhamVO> selectAvailableCoupons(String userId) throws Exception;
    
    /**
     * 사용자의 전체 쿠폰 목록 조회 (사용 완료 포함)
     * 
     * @param userId 회원 ID
     * @return 전체 쿠폰 리스트
     * @throws Exception DB 조회 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: selectAllCouponsByUser
     */
    List<CouponhamVO> selectAllCouponsByUser(String userId) throws Exception;
    
    /**
     * 쿠폰 상세 정보 조회 (단건)
     * 
     * @param couponBoxId 쿠폰함 ID
     * @return 쿠폰 상세 정보 (없으면 null)
     * @throws Exception DB 조회 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: selectCouponById
     */
    CouponhamVO selectCouponById(Long couponBoxId) throws Exception;
    
    /**
     * 쿠폰 사용 처리
     * 
     * @param couponBoxId 쿠폰함 ID
     * @return 업데이트된 행 수 (1=성공, 0=실패)
     * @throws Exception DB 업데이트 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: useCoupon
     * - 처리: USE_YN='Y', USED_DATE=SYSDATE
     * 
     * [비즈니스 규칙]
     * - 이미 사용된 쿠폰은 재사용 불가
     * - 만료된 쿠폰은 사용 불가
     * - Service 레이어에서 검증 선행 필수
     */
    int useCoupon(Map<String, Object> paramMap) throws Exception;
    
    /**
     * 쿠폰 물리 삭제
     * 
     * @param couponBoxId 쿠폰함 ID
     * @return 삭제된 행 수 (1=성공, 0=실패)
     * @throws Exception DB 삭제 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: deleteCoupon
     * 
     * [주의사항]
     * - 물리 삭제 대신 논리 삭제(USE_YN='D') 권장
     * - 결제 이력이 있는 쿠폰은 삭제 금지
     */
    int deleteCoupon(Long couponBoxId) throws Exception;
    
    /**
     * 쿠폰 발급 (쿠폰함에 추가)
     * 
     * @param couponham 발급할 쿠폰 정보 (userId, couponId 필수)
     * @return 삽입된 행 수 (1=성공, 0=실패)
     * @throws Exception DB 삽입 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: insertCoupon
     * - 시퀀스: COUPONHAM_SEQ.NEXTVAL
     * 
     * [자동 설정 값]
     * - ISSUED_DATE: SYSDATE
     * - USE_YN: 'N' (미사용)
     */
    int insertCoupon(CouponhamVO couponham) throws Exception;
    
    /**
     * 사용자의 보유 쿠폰 수 조회
     * 
     * @param userId 회원 ID
     * @return 사용 가능한 쿠폰 개수
     * @throws Exception DB 조회 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: getCouponCount
     */
    int getCouponCount(String userId) throws Exception;
    
    /**
     * 특정 쿠폰의 발급 여부 확인
     * 
     * @param userId 회원 ID
     * @param couponId 쿠폰 ID
     * @return 발급 여부 (1=발급됨, 0=미발급)
     * @throws Exception DB 조회 실패 시
     * 
     * [매핑 정보]
     * - Mapper ID: checkCouponIssued
     * 
     * [사용 목적]
     * - 중복 발급 방지
     */
    int checkCouponIssued(String userId, Long couponId) throws Exception;
}
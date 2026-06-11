package kr.or.ddit.store.service;

import java.util.List;
import kr.or.ddit.store.vo.CouponVO;

/**
 * 쿠폰 서비스 인터페이스
 * - 비즈니스 로직 정의
 */
public interface ICouponService {
    
    /**
     * 특정 가게의 활성 쿠폰 목록 조회
     * @param storeId 가게아이디
     * @return 쿠폰 리스트
     */
    List<CouponVO> getCouponList(String storeId) throws Exception;
    
    /**
     * 쿠폰 등록
     * @param coupon 쿠폰 정보
     * @return 성공 여부
     */
    boolean registerCoupon(CouponVO coupon) throws Exception;
    
    // ✅ 추가: 쿠폰 + 룰(리뷰N) 등록
    boolean registerCouponWithRule(CouponVO coupon, int reviewN) throws Exception;

    /**
     * 쿠폰 삭제 (논리 삭제)
     * @param couponId 쿠폰아이디
     * @return 성공 여부
     */
    boolean removeCoupon(Long couponId) throws Exception;
    
    /**
     * 쿠폰 상세 조회
     * @param couponId 쿠폰아이디
     * @return 쿠폰 VO
     */
    CouponVO getCouponDetail(Long couponId) throws Exception;
}
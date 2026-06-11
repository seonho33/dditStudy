package kr.or.ddit.store.dao;

import java.util.List;

import kr.or.ddit.store.vo.CouponVO;
import kr.or.ddit.store.vo.RewardCouponVO;

/**
 * 쿠폰 DAO 인터페이스
 * - MyBatis Mapper와 1:1 매핑
 */
public interface ICouponDAO {
    
    /**
     * 특정 가게의 쿠폰 목록 조회
     * @param storeId 가게아이디
     * @return 쿠폰 리스트
     */
    List<CouponVO> selectCouponsByStoreId(String storeId) throws Exception;
    
    /**
     * 쿠폰 상세 조회
     * @param couponId 쿠폰아이디
     * @return 쿠폰 VO
     */
    CouponVO selectCouponById(Long couponId) throws Exception;
    
    /**
     * 쿠폰 등록
     * @param coupon 쿠폰 정보
     * @return 성공 시 1
     */
    int insertCoupon(CouponVO coupon) throws Exception;
    
    /**
     * 쿠폰 수정
     * @param coupon 쿠폰 정보
     * @return 성공 시 1
     */
    int updateCoupon(CouponVO coupon) throws Exception;
    
    /**
     * 쿠폰 삭제 (물리 삭제)
     * @param couponId 쿠폰아이디
     * @return 성공 시 1
     */
    int deleteCoupon(Long couponId) throws Exception;
    
    /**
     * 쿠폰 비활성화 (논리 삭제)
     * @param couponId 쿠폰아이디
     * @return 성공 시 1
     */
    int deactivateCoupon(Long couponId) throws Exception;
    
    /**
     * 활성 쿠폰만 조회
     * @param storeId 가게아이디
     * @return 활성 쿠폰 리스트
     */
    List<CouponVO> selectActiveCoupons(String storeId) throws Exception;
    
    // ✅ 추가: 쿠폰 + 룰을 한 트랜잭션으로 저장
    int insertCouponWithRule(CouponVO coupon, int reviewN) throws Exception;
    
    List<RewardCouponVO> selectActiveRewardCouponsByStoreId(String storeId) throws Exception;

}
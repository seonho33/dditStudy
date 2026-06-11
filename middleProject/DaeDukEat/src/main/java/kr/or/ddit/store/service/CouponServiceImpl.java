package kr.or.ddit.store.service;

import java.util.List;
import kr.or.ddit.store.dao.CouponDAOImpl;
import kr.or.ddit.store.dao.ICouponDAO;
import kr.or.ddit.store.vo.CouponVO;

/**
 * 쿠폰 서비스 구현체
 * - Singleton 패턴
 * - DAO 레이어 호출
 */
public class CouponServiceImpl implements ICouponService {
    
    private static CouponServiceImpl instance = new CouponServiceImpl();
    private ICouponDAO dao = CouponDAOImpl.getInstance();
    
    private CouponServiceImpl() {}
    
    public static CouponServiceImpl getInstance() {
        return instance;
    }
    
    @Override
    public List<CouponVO> getCouponList(String storeId) throws Exception {
        // 활성 쿠폰만 조회
        return dao.selectActiveCoupons(storeId);
    }
    
    @Override
    public boolean registerCoupon(CouponVO coupon) throws Exception {
        int result = dao.insertCoupon(coupon);
        return result > 0;
    }
    
    @Override
    public boolean removeCoupon(Long couponId) throws Exception {
        // 논리 삭제 (STATUS='N')
        // FK 제약조건 문제 방지
        int result = dao.deactivateCoupon(couponId);
        return result > 0;
    }
    
    @Override
    public CouponVO getCouponDetail(Long couponId) throws Exception {
        return dao.selectCouponById(couponId);
    }
    
    // ✅ 추가
    @Override
    public boolean registerCouponWithRule(CouponVO coupon, int reviewN) throws Exception {
        if (coupon == null) return false;
        if (reviewN < 1) return false;

        int result = dao.insertCouponWithRule(coupon, reviewN);
        return result > 0;
    }
}
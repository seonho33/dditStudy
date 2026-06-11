package kr.or.ddit.store.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.CouponRuleVO;
import kr.or.ddit.store.vo.CouponVO;
import kr.or.ddit.store.vo.RewardCouponVO;

/**
 * 쿠폰 DAO 구현체
 * - Singleton 패턴 적용
 * - MyBatis SqlSession 사용
 */
public class CouponDAOImpl implements ICouponDAO {
    
    private static CouponDAOImpl instance = new CouponDAOImpl();
    
    private CouponDAOImpl() {}
    
    public static CouponDAOImpl getInstance() {
        return instance;
    }
    
    @Override
    public List<CouponVO> selectCouponsByStoreId(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<CouponVO> list = null;
        
        try {
            // Mapper namespace.id 매핑: coupon.selectCouponsByStoreId
            list = session.selectList("coupon.selectCouponsByStoreId", storeId);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    @Override
    public CouponVO selectCouponById(Long couponId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        CouponVO coupon = null;
        
        try {
            coupon = session.selectOne("coupon.selectCouponById", couponId);
        } finally {
            if(session != null) session.close();
        }
        
        return coupon;
    }
    
    @Override
    public int insertCoupon(CouponVO coupon) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.insert("coupon.insertCoupon", coupon);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int updateCoupon(CouponVO coupon) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update("coupon.updateCoupon", coupon);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int deleteCoupon(Long couponId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            // 물리 삭제: COUPONHAM에서 사용 중인 쿠폰은 FK 제약조건으로 삭제 불가
            // 실제로는 deactivateCoupon() 사용 권장
            result = session.delete("coupon.deleteCoupon", couponId);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int deactivateCoupon(Long couponId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            // 논리 삭제: STATUS를 'N'으로 변경
            result = session.update("coupon.deactivateCoupon", couponId);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public List<CouponVO> selectActiveCoupons(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<CouponVO> list = null;
        
        try {
            list = session.selectList("coupon.selectActiveCoupons", storeId);
        } finally {
            if(session != null) session.close();
        }
        
        return list;
    }
    
    // ✅ 핵심 추가 메서드
    @Override
    public int insertCouponWithRule(CouponVO coupon, int reviewN) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;

        try {
            // 1) 쿠폰 insert (selectKey로 couponId가 coupon 객체에 세팅됨)
            int c1 = session.insert("coupon.insertCoupon", coupon);
            if (c1 <= 0) {
                session.rollback();
                return 0;
            }

            if (coupon.getCouponId() == null) {
                session.rollback();
                throw new IllegalStateException("쿠폰ID 생성 실패: coupon.insertCoupon selectKey 설정 확인 필요");
            }

            // 2) 룰 insert
            CouponRuleVO rule = new CouponRuleVO();
            rule.setCouponId(coupon.getCouponId());
            rule.setReviewN(reviewN);

            int c2 = session.insert("coupon.insertCouponRule", rule);
            if (c2 <= 0) {
                session.rollback();
                return 0;
            }

            // 둘 다 성공
            session.commit();
            result = 1;

        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }

        return result;
    }
    
    @Override
    public List<RewardCouponVO> selectActiveRewardCouponsByStoreId(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            return session.selectList("coupon.selectActiveRewardCouponsByStoreId", storeId);
        } finally {
            if(session != null) session.close();
        }
    }


}
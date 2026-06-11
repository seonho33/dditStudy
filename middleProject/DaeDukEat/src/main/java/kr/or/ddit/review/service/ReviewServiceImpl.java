package kr.or.ddit.review.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.review.dao.IReviewDAO;
import kr.or.ddit.review.dao.ReviewDAOImpl;
import kr.or.ddit.review.vo.UserReviewVO;
import kr.or.ddit.review.vo.ReviewDetailVO;

import kr.or.ddit.store.dao.ICouponDAO;
import kr.or.ddit.store.dao.CouponDAOImpl;
import kr.or.ddit.store.service.ICouponhamService;
import kr.or.ddit.store.service.CouponhamServiceImpl;
import kr.or.ddit.store.vo.RewardCouponVO;

/**
 * 리뷰 서비스 구현체 (Singleton Pattern)
 */
public class ReviewServiceImpl implements IReviewService {

    /** Singleton Instance */
    private static ReviewServiceImpl instance = new ReviewServiceImpl();

    /** DAO */
    private IReviewDAO dao;
    private ICouponDAO couponDao;
    private ICouponhamService couponhamService;

    /** Private Constructor */
    private ReviewServiceImpl() {
        this.dao = ReviewDAOImpl.getInstance();
        this.couponDao = CouponDAOImpl.getInstance();
        this.couponhamService = CouponhamServiceImpl.getInstance();
    }

    public static ReviewServiceImpl getInstance() {
        return instance;
    }

    /* ===============================
       리뷰 작성 + 자동 쿠폰 지급
       =============================== */
    @Override
    public boolean writeReview(UserReviewVO review) {
        try {
            int result = dao.insertReview(review);
            System.out.println("[REVIEW] insertReview result=" + result + ", reservId=" + review.getReservId());

            if (result <= 0) return false;

            // 쿠폰 로직은 실패해도 리뷰는 성공이지만,
            // 지금은 디버깅이 목적이니까 예외를 숨기지 말고 찍자
            issueRewardCouponsAfterReview(review.getReservId());

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /* ===============================
       자동 쿠폰 지급 핵심 로직
       =============================== */
    private void issueRewardCouponsAfterReview(Long reservId) throws Exception {

        Map<String, String> info = dao.selectUserAndStoreByReservId(reservId);
        System.out.println("[COUPON] reservId=" + reservId + ", info=" + info);

        if (info == null) return;

        String storeId = (String) info.get("STOREID");
        String userId  = (String) info.get("USERID");
        System.out.println("[COUPON] info=" + info);
        System.out.println("[COUPON] keys=" + info.keySet());
        System.out.println("[COUPON] storeId(storeId)=" + info.get("storeId"));
        System.out.println("[COUPON] storeId(STOREID)=" + info.get("STOREID"));


        List<RewardCouponVO> rewardCoupons = couponDao.selectActiveRewardCouponsByStoreId(storeId);
        System.out.println("[COUPON] rewardCoupons size=" + (rewardCoupons==null?0:rewardCoupons.size()));

        if (rewardCoupons == null || rewardCoupons.isEmpty()) return;

        for (RewardCouponVO c : rewardCoupons) {
            Map<String, Object> p2 = new HashMap<>();
            p2.put("userId", userId);
            p2.put("storeId", storeId);
            p2.put("startDate", c.getCreateDate());

            int reviewCnt = dao.countUserReviewsSinceCouponCreate(p2);
            System.out.println("[COUPON] couponId=" + c.getCouponId()
                    + ", reviewN=" + c.getReviewN()
                    + ", startDate=" + c.getCreateDate()
                    + ", reviewCnt=" + reviewCnt);

            if (reviewCnt >= c.getReviewN()) {
                boolean issued = couponhamService.issueCoupon(userId, c.getCouponId());
                System.out.println("[COUPON] issueCoupon result=" + issued);
            }
        }
    }


    /* ===============================
       기존 메서드 (그대로 유지)
       =============================== */
    @Override
    public List<ReviewDetailVO> getUnwrittenReviews(String userId) {
        try {
            return dao.selectUnwrittenReviews(userId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<ReviewDetailVO> getMyReviews(String userId) {
        try {
            return dao.selectMyReviews(userId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public ReviewDetailVO getReviewDetail(Long reservId) {
        try {
            return dao.selectReviewDetail(reservId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean removeReview(Long reservId) {
        try {
            int result = dao.deleteReview(reservId);
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
}

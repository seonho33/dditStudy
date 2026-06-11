package kr.or.ddit.store.vo;

public class CouponRuleVO {

    private Long couponId;   // FK (COUPON_ID)
    private Integer reviewN; // 리뷰 n개 달성 조건

    public Long getCouponId() {
        return couponId;
    }
    public void setCouponId(Long couponId) {
        this.couponId = couponId;
    }
    public Integer getReviewN() {
        return reviewN;
    }
    public void setReviewN(Integer reviewN) {
        this.reviewN = reviewN;
    }
}

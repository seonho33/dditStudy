package kr.or.ddit.store.vo;

import java.sql.Date;

public class RewardCouponVO {
    private Long couponId;
    private String storeId;
    private Date createDate;
    private Date expiredDate;
    private Integer reviewN;

    public Long getCouponId() { return couponId; }
    public void setCouponId(Long couponId) { this.couponId = couponId; }

    public String getStoreId() { return storeId; }
    public void setStoreId(String storeId) { this.storeId = storeId; }

    public Date getCreateDate() { return createDate; }
    public void setCreateDate(Date createDate) { this.createDate = createDate; }

    public Date getExpiredDate() { return expiredDate; }
    public void setExpiredDate(Date expiredDate) { this.expiredDate = expiredDate; }

    public Integer getReviewN() { return reviewN; }
    public void setReviewN(Integer reviewN) { this.reviewN = reviewN; }
}

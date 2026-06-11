package kr.or.ddit.store.detail.vo;

import java.util.Date;

public class ReviewDetailVO {
    private Long reservId;
    private String review;
    private String reviewPicture;
    private Date createDate;
    private int rating;
    private String userName;
    private String profileImg;
    private String ceoReview;
    private Date ceoReviewDate;
    
    public ReviewDetailVO() {}
    
    public Long getReservId() { return reservId; }
    public void setReservId(Long reservId) { this.reservId = reservId; }
    
    public String getReview() { return review; }
    public void setReview(String review) { this.review = review; }
    
    public String getReviewPicture() { return reviewPicture; }
    public void setReviewPicture(String reviewPicture) { 
        this.reviewPicture = reviewPicture; 
    }
    
    public Date getCreateDate() { return createDate; }
    public void setCreateDate(Date createDate) { this.createDate = createDate; }
    
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    public String getProfileImg() { return profileImg; }
    public void setProfileImg(String profileImg) { this.profileImg = profileImg; }
    
    public String getCeoReview() { return ceoReview; }
    public void setCeoReview(String ceoReview) { this.ceoReview = ceoReview; }
    
    public Date getCeoReviewDate() { return ceoReviewDate; }
    public void setCeoReviewDate(Date ceoReviewDate) { 
        this.ceoReviewDate = ceoReviewDate; 
    }
}
package kr.or.ddit.store.vo;

import java.io.Serializable;
import java.util.Date;

public class ReservationVO implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    /* ========== 기본 필드 (기존 유지) ========== */
    private Long reservId;
    private Integer guestCount;
    private String reservTime;
    private String reservStatus;
    private String note;
    private Date createDate;
    private Integer amount;
    private String userId;
    private String storeId;
    
    /* ========== JOIN 필드 (기존 유지) ========== */
    private String storeName;
    private String storeAddr;
    private String storePhone;
    private String userName;
    private String storePicture; 	/* 가게 사진 */ 
    private String payStatus;
    
    /* ========== 알림 관련 필드 (기존 유지) ========== */
    private String notificationTitle;
    private String notificationContent;
    private String relativeTime;
    
    /* ========== 🆕 신규 추가 필드 ========== */
    private String userNo;  // 예약자 전화번호 (MEMBER.USER_NO)
    
    /* ========== Constructor ========== */
    public ReservationVO() {
    }
    
    /* ========== Getters & Setters (기존 유지) ========== */
    
    public Long getReservId() {
        return reservId;
    }

	public void setReservId(Long reservId) {
        this.reservId = reservId;
    }
    
    public Integer getGuestCount() {
        return guestCount;
    }
    
    public void setGuestCount(Integer guestCount) {
        this.guestCount = guestCount;
    }
    
    public String getReservTime() {
        return reservTime;
    }
    
    public void setReservTime(String reservTime) {
        this.reservTime = reservTime;
    }
    
    public String getReservStatus() {
        return reservStatus;
    }
    
    public void setReservStatus(String reservStatus) {
        this.reservStatus = reservStatus;
    }
    
    public String getNote() {
        return note;
    }
    
    public void setNote(String note) {
        this.note = note;
    }
    
    public Date getCreateDate() {
        return createDate;
    }
    
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
    public Integer getAmount() {
        return amount;
    }
    
    public void setAmount(Integer amount) {
        this.amount = amount;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getStoreId() {
        return storeId;
    }
    
    public void setStoreId(String storeId) {
        this.storeId = storeId;
    }
    
    public String getStoreName() {
        return storeName;
    }
    
    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }
    
    public String getStoreAddr() {
        return storeAddr;
    }
    
    public void setStoreAddr(String storeAddr) {
        this.storeAddr = storeAddr;
    }
    
    public String getStorePhone() {
        return storePhone;
    }
    
    public void setStorePhone(String storePhone) {
        this.storePhone = storePhone;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public String getStorePicture() {
		return storePicture;
	}

	public void setStorePicture(String storePicture) {
		this.storePicture = storePicture;
	}
    
    public String getPayStatus() {
        return payStatus;
    }
    
    public void setPayStatus(String payStatus) {
        this.payStatus = payStatus;
    }
    
    public String getNotificationTitle() {
        return notificationTitle;
    }
    
    public void setNotificationTitle(String notificationTitle) {
        this.notificationTitle = notificationTitle;
    }
    
    public String getNotificationContent() {
        return notificationContent;
    }
    
    public void setNotificationContent(String notificationContent) {
        this.notificationContent = notificationContent;
    }
    
    public String getRelativeTime() {
        return relativeTime;
    }
    
    public void setRelativeTime(String relativeTime) {
        this.relativeTime = relativeTime;
    }
    
    /* ========== 🆕 신규 추가 Getter/Setter ========== */
    public String getUserNo() {
        return userNo;
    }
    
    public void setUserNo(String userNo) {
        this.userNo = userNo;
    }
    
    /* ========== toString (기존 유지) ========== */
    @Override
    public String toString() {
        return "ReservationVO [reservId=" + reservId 
             + ", storeName=" + storeName 
             + ", reservTime=" + reservTime 
             + ", reservStatus=" + reservStatus + "]";
    }
}
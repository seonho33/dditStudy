package kr.or.ddit.store.vo;

import java.util.Date;

/**
 * 예약 상세 정보 VO (조인 결과 매핑)
 * - 알림 기능은 예약 상태로 대체
 */
public class ReservationDetailVO {
    
    // RESERVATION 기본 정보
    private Long reservId;
    private Integer guestCount;
    private String reservTime;
    private String reservStatus;    // 대기/확정/취소/완료
    private String note;
    private Date createDate;
    private Integer amount;
    private String userId;
    private String storeId;
    
    // STORE 정보 (조인)
    private String storeName;
    private String storeAddr;
    private String storePhone;
    private String category;
    
    // MEMBER 정보 (조인)
    private String userName;
    private String userMail;
    
    // PAYMENT 정보 (조인)
    private Long payNo;
    private String payMethod;
    private String payStatus;
    private String impUid;
    
    // ============================================================
    // JSP 출력용 헬퍼 메서드
    // ============================================================
    
    /**
     * 알림 제목 생성 (예약 상태 기반)
     */
    public String getNotificationTitle() {
        switch(reservStatus) {
            case "확정": return "예약 확정 안내";
            case "취소": return "예약 취소 완료";
            case "대기": return "예약 접수 완료";
            case "완료": return "이용 완료";
            default: return "예약 알림";
        }
    }
    
    /**
     * 알림 내용 생성
     */
    public String getNotificationContent() {
        return storeName + " 예약이 " + reservStatus + "되었습니다. (" + reservTime + ")";
    }
    
    /**
     * 상대 시간 표시 ("1일 전", "3시간 전")
     */
    public String getRelativeTime() {
        if(createDate == null) return "";
        
        long diffMillis = System.currentTimeMillis() - createDate.getTime();
        long diffDays = diffMillis / (24 * 60 * 60 * 1000);
        
        if(diffDays == 0) {
            long diffHours = diffMillis / (60 * 60 * 1000);
            if(diffHours == 0) {
                return "방금 전";
            }
            return diffHours + "시간 전";
        } else if(diffDays < 7) {
            return diffDays + "일 전";
        } else {
            return (diffDays / 7) + "주 전";
        }
    }
    
    /**
     * 활성 예약 여부 (대기, 확정만 true)
     */
    public boolean isActive() {
        return "대기".equals(reservStatus) || "확정".equals(reservStatus);
    }
    
    // ============================================================
    // Getter & Setter
    // ============================================================
    
    public Long getReservId() { return reservId; }
    public void setReservId(Long reservId) { this.reservId = reservId; }
    
    public Integer getGuestCount() { return guestCount; }
    public void setGuestCount(Integer guestCount) { this.guestCount = guestCount; }
    
    public String getReservTime() { return reservTime; }
    public void setReservTime(String reservTime) { this.reservTime = reservTime; }
    
    public String getReservStatus() { return reservStatus; }
    public void setReservStatus(String reservStatus) { this.reservStatus = reservStatus; }
    
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    
    public Date getCreateDate() { return createDate; }
    public void setCreateDate(Date createDate) { this.createDate = createDate; }
    
    public Integer getAmount() { return amount; }
    public void setAmount(Integer amount) { this.amount = amount; }
    
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    
    public String getStoreId() { return storeId; }
    public void setStoreId(String storeId) { this.storeId = storeId; }
    
    public String getStoreName() { return storeName; }
    public void setStoreName(String storeName) { this.storeName = storeName; }
    
    public String getStoreAddr() { return storeAddr; }
    public void setStoreAddr(String storeAddr) { this.storeAddr = storeAddr; }
    
    public String getStorePhone() { return storePhone; }
    public void setStorePhone(String storePhone) { this.storePhone = storePhone; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    public String getUserMail() { return userMail; }
    public void setUserMail(String userMail) { this.userMail = userMail; }
    
    public Long getPayNo() { return payNo; }
    public void setPayNo(Long payNo) { this.payNo = payNo; }
    
    public String getPayMethod() { return payMethod; }
    public void setPayMethod(String payMethod) { this.payMethod = payMethod; }
    
    public String getPayStatus() { return payStatus; }
    public void setPayStatus(String payStatus) { this.payStatus = payStatus; }
    
    public String getImpUid() { return impUid; }
    public void setImpUid(String impUid) { this.impUid = impUid; }
    
    @Override
    public String toString() {
        return "ReservationDetailVO{" +
                "reservId=" + reservId +
                ", storeName='" + storeName + '\'' +
                ", reservTime='" + reservTime + '\'' +
                ", reservStatus='" + reservStatus + '\'' +
                '}';
    }
}
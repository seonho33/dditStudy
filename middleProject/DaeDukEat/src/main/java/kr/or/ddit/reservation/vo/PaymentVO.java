package kr.or.ddit.reservation.vo;

import java.io.Serializable;

/**
 * PAYMENT 테이블 매핑 VO
 * 
 * @author Senior Architect
 * @since 2025-01-26
 * @description 아임포트 결제 정보를 저장하는 데이터 전송 객체.
 *              - imp_uid: 아임포트 고유 결제번호 (환불 시 필수)
 *              - pay_method: "card", "trans", "vbank" 등
 *              - pay_status: "paid", "cancelled", "failed"
 */
public class PaymentVO implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private Long payNo;            // 결제 고유번호 (PK, SEQ_PAYMENT 사용)
    private String payMethod;      // 결제수단 (NOT NULL)
    private String payDate;        // 결제한 날짜 (DEFAULT SYSDATE)
    private String payStatus;      // 결제상태 (NOT NULL)
    private String impUid;         // 아임포트 결제 UID (NOT NULL)
    private Long reservId;         // 예약 ID (FK → RESERVATION)
    
    // ===== Getters & Setters =====
    public Long getPayNo() {
        return payNo;
    }

    public void setPayNo(Long payNo) {
        this.payNo = payNo;
    }

    public String getPayMethod() {
        return payMethod;
    }

    public void setPayMethod(String payMethod) {
        this.payMethod = payMethod;
    }

    public String getPayDate() {
        return payDate;
    }

    public void setPayDate(String payDate) {
        this.payDate = payDate;
    }

    public String getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(String payStatus) {
        this.payStatus = payStatus;
    }

    public String getImpUid() {
        return impUid;
    }

    public void setImpUid(String impUid) {
        this.impUid = impUid;
    }

    public Long getReservId() {
        return reservId;
    }

    public void setReservId(Long reservId) {
        this.reservId = reservId;
    }

    @Override
    public String toString() {
        return "PaymentVO [payNo=" + payNo + ", payMethod=" + payMethod 
             + ", payDate=" + payDate + ", payStatus=" + payStatus 
             + ", impUid=" + impUid + ", reservId=" + reservId + "]";
    }
}
package kr.or.ddit.admin.vo;

import java.time.LocalDate;

public class BanRequestVO {

    private String action;   // BAN | UNBAN
    private String userId;
    private String reason;
    private LocalDate endDate;

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
}

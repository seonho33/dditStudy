package kr.or.ddit.store.vo;

import java.io.Serializable;

/**
 * 사장님 프로필 정보 DTO
 * - USERS + STORE 조인 데이터
 * 
 * @author Senior Architect
 * @version 1.0
 */
public class OwnerProfileVO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    // USERS 테이블
    private String userId;
    private String name;
    private String division;
    
    // STORE 테이블
    private String storeId;
    private String storeName;
    private String storeAddr;
    private String storeAddr2;
    private String storePhone;
    private String category;
    private String storeContent;
    private String operationHours;
    private String bizNo;
    private String ownerEmail;
    private Integer deposit;
    
    // ========== Constructors ==========
    public OwnerProfileVO() {}
    
    // ========== Getters & Setters ==========
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getDivision() { return division; }
    public void setDivision(String division) { this.division = division; }
    
    public String getStoreId() { return storeId; }
    public void setStoreId(String storeId) { this.storeId = storeId; }
    
    public String getStoreName() { return storeName; }
    public void setStoreName(String storeName) { this.storeName = storeName; }
    
    public String getStoreAddr() { return storeAddr; }
    public void setStoreAddr(String storeAddr) { this.storeAddr = storeAddr; }
    
    public String getStoreAddr2() { return storeAddr2; }
    public void setStoreAddr2(String storeAddr2) { this.storeAddr2 = storeAddr2; }
    
    public String getStorePhone() { return storePhone; }
    public void setStorePhone(String storePhone) { this.storePhone = storePhone; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getStoreContent() { return storeContent; }
    public void setStoreContent(String storeContent) { this.storeContent = storeContent; }
    
    public String getOperationHours() { return operationHours; }
    public void setOperationHours(String operationHours) { this.operationHours = operationHours; }
    
    public String getBizNo() { return bizNo; }
    public void setBizNo(String bizNo) { this.bizNo = bizNo; }
    
    public String getOwnerEmail() { return ownerEmail; }
    public void setOwnerEmail(String ownerEmail) { this.ownerEmail = ownerEmail; }
    
    public Integer getDeposit() { return deposit; }
    public void setDeposit(Integer deposit) { this.deposit = deposit; }
}
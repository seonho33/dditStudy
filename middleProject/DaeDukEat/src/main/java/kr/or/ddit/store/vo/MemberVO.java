package kr.or.ddit.store.vo;

import java.util.Date;

/**
 * MEMBER 테이블 매핑 VO
 * - USERS 테이블과 1:1 관계
 */
public class MemberVO {
    private String userId;      // 이용자아이디 (PK, FK)
    private Date userBir;       // 생년월일
    private String userMail;    // 이메일
    private Long userNo;        // 대덕 기수번호
    private String profileImg;  // 프로필 사진
    
    // USERS 테이블 정보 (조인 시 사용)
    private String password;
    private String name;
    private String division;
    private String blockYn;
    private String useYn;
    
    // Getter & Setter
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public Date getUserBir() {
        return userBir;
    }
    
    public void setUserBir(Date userBir) {
        this.userBir = userBir;
    }
    
    public String getUserMail() {
        return userMail;
    }
    
    public void setUserMail(String userMail) {
        this.userMail = userMail;
    }
    
    public Long getUserNo() {
        return userNo;
    }
    
    public void setUserNo(Long userNo) {
        this.userNo = userNo;
    }
    
    public String getProfileImg() {
        return profileImg;
    }
    
    public void setProfileImg(String profileImg) {
        this.profileImg = profileImg;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDivision() {
        return division;
    }
    
    public void setDivision(String division) {
        this.division = division;
    }
    
    public String getBlockYn() {
        return blockYn;
    }
    
    public void setBlockYn(String blockYn) {
        this.blockYn = blockYn;
    }
    
    public String getUseYn() {
        return useYn;
    }
    
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
}
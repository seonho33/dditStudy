package kr.or.ddit.board.vo;

import java.util.Date;

/**
 * NOTICE 테이블 매핑 VO
 * 
 * [테이블 구조]
 * - PK: notice_no (NUMBER)
 * - FK: user_id → ADMIN(user_id)
 * 
 * [주요 기능]
 * - 공지사항 등록/수정/삭제
 * - 조회수 관리
 * - 상단 고정 기능 (top_yn)
 * - 작성일/수정일 자동 관리
 * 
 * [DB 컬럼 → Java 필드 매핑]
 * - notice_no      → noticeNo
 * - notice_title   → noticeTitle
 * - notice_content → noticeContent
 * - hit_count      → hitCount
 * - top_yn         → topYn
 * - create_date    → createDate
 * - update_date    → updateDate
 * - user_id        → userId
 */
public class NoticeVO {
    
    // ========================================
    // 1. Primary Key
    // ========================================
    private Long noticeNo;                 // 공지사항 글번호 (PK, 시퀀스)
    
    
    // ========================================
    // 2. 공지사항 기본 정보
    // ========================================
    private String noticeTitle;            // 공지사항 제목 (최대 200자)
    private String noticeContent;          // 공지사항 내용 (최대 1000자)
    
    
    // ========================================
    // 3. 관리 정보
    // ========================================
    private Long hitCount;                 // 조회수 (기본값 0)
    private String topYn;                  // 상단 고정 여부 ('Y', 'N', 기본값 'N')
    
    
    // ========================================
    // 4. 날짜 정보
    // ========================================
    private Date createDate;               // 작성일시 (기본값 SYSDATE)
    private Date updateDate;               // 수정일시 (NULL 허용)
    
    
    // ========================================
    // 5. Foreign Key
    // ========================================
    private String userId;                 // 작성자 아이디 (FK → ADMIN)
    
    
    // ========================================
    // 6. Constructors
    // ========================================
    
    /**
     * 기본 생성자
     */
    public NoticeVO() {
        super();
    }
    
    /**
     * 전체 필드 생성자
     */
    public NoticeVO(Long noticeNo, String noticeTitle, String noticeContent, 
                    Long hitCount, String topYn, Date createDate, 
                    Date updateDate, String userId) {
        this.noticeNo = noticeNo;
        this.noticeTitle = noticeTitle;
        this.noticeContent = noticeContent;
        this.hitCount = hitCount;
        this.topYn = topYn;
        this.createDate = createDate;
        this.updateDate = updateDate;
        this.userId = userId;
    }
    
    /**
     * 등록용 생성자 (noticeNo, hitCount, createDate 제외)
     */
    public NoticeVO(String noticeTitle, String noticeContent, 
                    String topYn, String userId) {
        this.noticeTitle = noticeTitle;
        this.noticeContent = noticeContent;
        this.topYn = topYn;
        this.userId = userId;
    }
    
    
    // ========================================
    // 7. Getters and Setters
    // ========================================
    
    public Long getNoticeNo() {
        return noticeNo;
    }
    
    public void setNoticeNo(Long noticeNo) {
        this.noticeNo = noticeNo;
    }
    
    public String getNoticeTitle() {
        return noticeTitle;
    }
    
    public void setNoticeTitle(String noticeTitle) {
        this.noticeTitle = noticeTitle;
    }
    
    public String getNoticeContent() {
        return noticeContent;
    }
    
    public void setNoticeContent(String noticeContent) {
        this.noticeContent = noticeContent;
    }
    
    public Long getHitCount() {
        return hitCount;
    }
    
    public void setHitCount(Long hitCount) {
        this.hitCount = hitCount;
    }
    
    public String getTopYn() {
        return topYn;
    }
    
    public void setTopYn(String topYn) {
        this.topYn = topYn;
    }
    
    public Date getCreateDate() {
        return createDate;
    }
    
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
    public Date getUpdateDate() {
        return updateDate;
    }
    
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    
    // ========================================
    // 8. Utility Methods
    // ========================================
    
    /**
     * 상단 고정 여부 체크
     * @return 상단 고정 여부 (true/false)
     */
    public boolean isTop() {
        return "Y".equalsIgnoreCase(this.topYn);
    }
    
    /**
     * 상단 고정 설정
     * @param isTop true → 'Y', false → 'N'
     */
    public void setTop(boolean isTop) {
        this.topYn = isTop ? "Y" : "N";
    }
    
    /**
     * 조회수 증가
     */
    public void increaseHitCount() {
        if (this.hitCount == null) {
            this.hitCount = 0L;
        }
        this.hitCount++;
    }
    
    /**
     * 수정 여부 확인
     * @return 수정된 적 있으면 true
     */
    public boolean isModified() {
        return this.updateDate != null;
    }
    
    /**
     * 내용 미리보기 (100자)
     * @return 공지사항 내용 앞 100자
     */
    public String getContentPreview() {
        if (this.noticeContent == null) {
            return "";
        }
        if (this.noticeContent.length() <= 100) {
            return this.noticeContent;
        }
        return this.noticeContent.substring(0, 100) + "...";
    }
    
    
    // ========================================
    // 9. Object Override Methods
    // ========================================
    
    @Override
    public String toString() {
        return "NoticeVO [" +
                "noticeNo=" + noticeNo +
                ", noticeTitle='" + noticeTitle + '\'' +
                ", noticeContent='" + noticeContent + '\'' +
                ", hitCount=" + hitCount +
                ", topYn='" + topYn + '\'' +
                ", createDate=" + createDate +
                ", updateDate=" + updateDate +
                ", userId='" + userId + '\'' +
                ']';
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        
        NoticeVO noticeVO = (NoticeVO) o;
        
        return noticeNo != null ? noticeNo.equals(noticeVO.noticeNo) : noticeVO.noticeNo == null;
    }
    
    @Override
    public int hashCode() {
        return noticeNo != null ? noticeNo.hashCode() : 0;
    }
}
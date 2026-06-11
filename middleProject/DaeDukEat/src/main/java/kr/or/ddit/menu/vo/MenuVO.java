package kr.or.ddit.menu.vo;

import java.io.Serializable;
import java.util.Date;

/**
 * <pre>
 * MENU 테이블 매핑 DTO
 * 
 * Purpose:
 *   - 가게별 메뉴 정보를 담는 Value Object
 *   - Snake_Case(DB) → CamelCase(Java) 자동 변환 전제
 * 
 * Author: Senior Architect
 * Date: 2025-01-26
 * </pre>
 */
public class MenuVO implements Serializable {
    private static final long serialVersionUID = 1L;

    /** 메뉴 ID (PK, Sequence 자동 생성) */
    private Long menuId;
    
    /** 가게 ID (FK, STORE 테이블 참조) */
    private String storeId;
    
    /** 메뉴명 (필수, 최대 100자) */
    private String menuName;
    
    /** 메뉴 가격 (NULL 허용) */
    private Long menuPrice;
    
    /** 메뉴 이미지 경로 (파일 업로드 시 저장된 경로) */
    private String menuPicture;
    
    /** 생성 일자 (DEFAULT SYSDATE) */
    private Date createDate;
    
    /** 수정 일자 (UPDATE 시 갱신) */
    private Date updateDate;
    
    /** 메뉴 상태 (판매중/품절) - 추가 컬럼일 경우 사용 */
    private String menuStatus;

    // ============================================================
    // Constructors
    // ============================================================
    public MenuVO() {
        super();
    }

    // ============================================================
    // Getters & Setters (Full Implementation)
    // ============================================================
    public Long getMenuId() {
        return menuId;
    }

    public void setMenuId(Long menuId) {
        this.menuId = menuId;
    }

    public String getStoreId() {
        return storeId;
    }

    public void setStoreId(String storeId) {
        this.storeId = storeId;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public Long getMenuPrice() {
        return menuPrice;
    }

    public void setMenuPrice(Long menuPrice) {
        this.menuPrice = menuPrice;
    }

    public String getMenuPicture() {
        return menuPicture;
    }

    public void setMenuPicture(String menuPicture) {
        this.menuPicture = menuPicture;
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

    public String getMenuStatus() {
        return menuStatus;
    }

    public void setMenuStatus(String menuStatus) {
        this.menuStatus = menuStatus;
    }

    @Override
    public String toString() {
        return "MenuVO [menuId=" + menuId + ", storeId=" + storeId 
                + ", menuName=" + menuName + ", menuPrice=" + menuPrice 
                + ", menuPicture=" + menuPicture + ", menuStatus=" + menuStatus + "]";
    }
}
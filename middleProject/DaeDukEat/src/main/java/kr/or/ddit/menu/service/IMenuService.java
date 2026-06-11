package kr.or.ddit.menu.service;

import java.util.List;
import kr.or.ddit.menu.vo.MenuVO;

/**
 * <pre>
 * MENU 비즈니스 로직 Interface
 * 
 * Purpose:
 *   - Controller와 DAO 사이의 비즈니스 로직 계층
 *   - 트랜잭션 경계 설정 및 예외 처리
 * 
 * Author: Senior Architect
 * Date: 2025-01-26
 * </pre>
 */
public interface IMenuService {
    
    /**
     * 특정 가게의 전체 메뉴 조회
     * @param storeId 가게 ID
     * @return 메뉴 목록
     */
    List<MenuVO> getMenusByStoreId(String storeId);
    
    /**
     * 메뉴 상세 조회
     * @param menuId 메뉴 ID
     * @return MenuVO 객체
     */
    MenuVO getMenuById(Long menuId);
    
    /**
     * 메뉴 등록
     * @param menu MenuVO 객체
     * @return 성공 여부 (true/false)
     */
    boolean addMenu(MenuVO menu);
    
    /**
     * 메뉴 수정
     * @param menu MenuVO 객체
     * @return 성공 여부 (true/false)
     */
    boolean modifyMenu(MenuVO menu);
    
    /**
     * 메뉴 삭제
     * @param menuId 메뉴 ID
     * @return 성공 여부 (true/false)
     */
    boolean removeMenu(Long menuId);
    
    /**
     * 메뉴 상태 변경
     * @param menuId 메뉴 ID
     * @param status 변경할 상태값
     * @return 성공 여부 (true/false)
     */
    boolean changeMenuStatus(Long menuId, String status);
    
    // ✅ 추가: 복합키 조회용 (storeId + menuId)
    MenuVO getMenuById(String storeId, Long menuId);
}
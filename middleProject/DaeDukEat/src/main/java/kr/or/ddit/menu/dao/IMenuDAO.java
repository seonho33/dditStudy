package kr.or.ddit.menu.dao;

import java.util.List;
import kr.or.ddit.menu.vo.MenuVO;

/**
 * <pre>
 * MENU 테이블 접근 DAO Interface
 * 
 * Purpose:
 *   - MyBatis Mapper XML과 1:1 매핑되는 메서드 시그니처 정의
 *   - MenuDAOImpl에서 구현
 * 
 * Critical:
 *   - namespace는 반드시 "kr.or.ddit.menu.dao.IMenuDAO"
 *   - id는 메서드명과 완전 일치
 * 
 * Author: Senior Architect
 * Date: 2025-01-26
 * </pre>
 */
public interface IMenuDAO {
    
    /**
     * 특정 가게의 전체 메뉴 조회
     * @param storeId 가게 ID
     * @return 메뉴 목록 (없으면 빈 리스트)
     * @throws Exception DB 접근 오류
     */
    List<MenuVO> selectMenusByStoreId(String storeId) throws Exception;
    
    /**
     * 메뉴 상세 조회 (단건)
     * @param menuId 메뉴 ID (PK)
     * @return MenuVO 객체 (없으면 null)
     * @throws Exception DB 접근 오류
     */
    MenuVO selectMenuById(Long menuId) throws Exception;
    
    /**
     * 메뉴 등록
     * @param menu MenuVO 객체 (menuId는 Sequence로 자동 생성)
     * @return 영향받은 행 수 (1이면 성공)
     * @throws Exception DB 접근 오류
     */
    int insertMenu(MenuVO menu) throws Exception;
    
    /**
     * 메뉴 수정
     * @param menu MenuVO 객체 (menuId 필수)
     * @return 영향받은 행 수 (1이면 성공)
     * @throws Exception DB 접근 오류
     */
    int updateMenu(MenuVO menu) throws Exception;
    
    /**
     * 메뉴 삭제
     * @param menuId 메뉴 ID (PK)
     * @return 영향받은 행 수 (1이면 성공)
     * @throws Exception DB 접근 오류
     */
    int deleteMenu(Long menuId) throws Exception;
    
    /**
     * 메뉴 상태 변경 (판매중/품절)
     * @param menuId 메뉴 ID
     * @param status 변경할 상태값
     * @return 영향받은 행 수 (1이면 성공)
     * @throws Exception DB 접근 오류
     */
    int updateMenuStatus(Long menuId, String status) throws Exception;
    
    MenuVO selectMenuByIdWithStore(MenuVO param);

}
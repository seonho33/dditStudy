package kr.or.ddit.menu.service;

import java.util.ArrayList;
import java.util.List;

import kr.or.ddit.menu.dao.IMenuDAO;
import kr.or.ddit.menu.dao.MenuDAOImpl;
import kr.or.ddit.menu.vo.MenuVO;

/**
 * <pre>
 * MENU Service 구현체 (Singleton Pattern)
 * 
 * Purpose:
 *   - DAO 호출 및 예외 처리
 *   - 비즈니스 검증 로직 추가 가능
 * 
 * Author: Senior Architect
 * Date: 2025-01-26
 * </pre>
 */
public class MenuServiceImpl implements IMenuService {
    
    // ============================================================
    // Singleton Pattern & DAO Dependency
    // ============================================================
    private static MenuServiceImpl instance = new MenuServiceImpl();
    private IMenuDAO menuDAO;
    
    private MenuServiceImpl() {
        this.menuDAO = MenuDAOImpl.getInstance();
    }
    
    public static MenuServiceImpl getInstance() {
        return instance;
    }

    // ============================================================
    // Business Logic Methods
    // ============================================================
    
    @Override
    public List<MenuVO> getMenusByStoreId(String storeId) {
        List<MenuVO> list = new ArrayList<>();
        
        try {
            list = menuDAO.selectMenusByStoreId(storeId);
        } catch (Exception e) {
            e.printStackTrace();
            // 로깅 프레임워크 사용 권장 (Log4j2)
        }
        
        return list;
    }

    @Override
    public MenuVO getMenuById(Long menuId) {
        MenuVO menu = null;
        
        try {
            menu = menuDAO.selectMenuById(menuId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return menu;
    }

    @Override
    public boolean addMenu(MenuVO menu) {
        boolean result = false;
        
        try {
            int cnt = menuDAO.insertMenu(menu);
            result = (cnt > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }

    @Override
    public boolean modifyMenu(MenuVO menu) {
        boolean result = false;
        
        try {
            int cnt = menuDAO.updateMenu(menu);
            result = (cnt > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }

    @Override
    public boolean removeMenu(Long menuId) {
        boolean result = false;
        
        try {
            int cnt = menuDAO.deleteMenu(menuId);
            result = (cnt > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }

    @Override
    public boolean changeMenuStatus(Long menuId, String status) {
        boolean result = false;
        
        try {
            int cnt = menuDAO.updateMenuStatus(menuId, status);
            result = (cnt > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    // ✅ 추가(복합키)
    @Override
    public MenuVO getMenuById(String storeId, Long menuId) {
        MenuVO param = new MenuVO();
        param.setStoreId(storeId);
        param.setMenuId(menuId);
        return menuDAO.selectMenuByIdWithStore(param);
    }
    
}
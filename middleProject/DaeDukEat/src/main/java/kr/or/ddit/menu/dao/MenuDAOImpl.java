package kr.or.ddit.menu.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.menu.vo.MenuVO;

/**
 * <pre>
 * MENU DAO 구현체 (Singleton Pattern)
 * 
 * Purpose:
 *   - MyBatis SqlSession을 통한 CRUD 구현
 *   - 트랜잭션 관리 (commit/rollback)
 * 
 * Critical:
 *   - getInstance()로만 객체 획득 가능
 *   - 모든 메서드는 finally에서 session.close() 필수
 * 
 * Author: Senior Architect
 * Date: 2025-01-26
 * </pre>
 */
public class MenuDAOImpl implements IMenuDAO {
    
    // ============================================================
    // Singleton Pattern Implementation
    // ============================================================
    private static MenuDAOImpl instance = new MenuDAOImpl();
    
    private MenuDAOImpl() {
        // Private Constructor to prevent external instantiation
    }
    
    public static MenuDAOImpl getInstance() {
        return instance;
    }

    // ============================================================
    // CRUD Operations
    // ============================================================
    
    @Override
    public List<MenuVO> selectMenusByStoreId(String storeId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        List<MenuVO> list = null;
        
        try {
            list = session.selectList("kr.or.ddit.menu.dao.IMenuDAO.selectMenusByStoreId", storeId);
        } finally {
            if (session != null) session.close();
        }
        
        return list;
    }

    @Override
    public MenuVO selectMenuById(Long menuId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        MenuVO menu = null;
        
        try {
            menu = session.selectOne("kr.or.ddit.menu.dao.IMenuDAO.selectMenuById", menuId);
        } finally {
            if (session != null) session.close();
        }
        
        return menu;
    }

    @Override
    public int insertMenu(MenuVO menu) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.insert("kr.or.ddit.menu.dao.IMenuDAO.insertMenu", menu);
            if (result > 0) {
                session.commit();
            }
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return result;
    }

    @Override
    public int updateMenu(MenuVO menu) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update("kr.or.ddit.menu.dao.IMenuDAO.updateMenu", menu);
            if (result > 0) {
                session.commit();
            }
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return result;
    }

    @Override
    public int deleteMenu(Long menuId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.delete("kr.or.ddit.menu.dao.IMenuDAO.deleteMenu", menuId);
            if (result > 0) {
                session.commit();
            }
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return result;
    }

    @Override
    public int updateMenuStatus(Long menuId, String status) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("menuId", menuId);
            params.put("status", status);
            
            result = session.update("kr.or.ddit.menu.dao.IMenuDAO.updateMenuStatus", params);
            if (result > 0) {
                session.commit();
            }
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            if (session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public MenuVO selectMenuByIdWithStore(MenuVO param) {
        SqlSession session = null;
        try {
            session = MyBatisUtil.getSqlSession();
            // ✅ namespace.id 맞춰서 호출
            return session.selectOne("kr.or.ddit.menu.dao.IMenuDAO.selectMenuByIdWithStore", param);
        } finally {
            if (session != null) session.close();
        }
    }
}
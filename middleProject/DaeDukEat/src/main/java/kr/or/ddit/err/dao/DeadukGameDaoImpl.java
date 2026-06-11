package kr.or.ddit.err.dao;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.StoreVO;

/**
 * 식당 DAO 구현체 (싱글톤 패턴)
 */
public class DeadukGameDaoImpl implements IDeadukGameDao {

    private static DeadukGameDaoImpl instance;

    private DeadukGameDaoImpl() {}

    public static DeadukGameDaoImpl getInstance() {
        if (instance == null) {
            synchronized (DeadukGameDaoImpl.class) {
                if (instance == null) {
                    instance = new DeadukGameDaoImpl();
                }
            }
        }
        return instance;
    }

    @Override
    public StoreVO selectRandomStore() {
        SqlSession session = null;
        StoreVO store = null;

        try {
            session = MyBatisUtil.getSqlSession();
            store = session.selectOne("deadukGame.selectRandomStore");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }

        return store;
    }

    
    @Override
    public StoreVO selectStoreById(String storeId) {
        SqlSession session = null;
        StoreVO store = null;

        try {
            session = MyBatisUtil.getSqlSession();
            store = session.selectOne("deadukGame.selectStoreById", storeId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }

        return store;
    }

    /**
     * 대표메뉴 1개 조회
     */
    @Override
    public String selectMainMenuName(String storeId) {
        SqlSession session = null;
        String menuName = null;

        try {
            session = MyBatisUtil.getSqlSession();
            menuName = session.selectOne(
                "deadukGame.selectMainMenuName",
                storeId
            );
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }

        return menuName;
    }
}

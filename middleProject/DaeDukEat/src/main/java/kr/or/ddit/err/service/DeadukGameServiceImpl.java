package kr.or.ddit.err.service;

import kr.or.ddit.err.dao.DeadukGameDaoImpl;
import kr.or.ddit.err.dao.IDeadukGameDao;
import kr.or.ddit.store.vo.StoreVO;

/**
 * 식당 서비스 구현체 (싱글톤 패턴)
 */
public class DeadukGameServiceImpl implements IDeadukGameService {
    
    // 싱글톤 인스턴스
    private static DeadukGameServiceImpl instance;
    
    // DAO 인스턴스
    private IDeadukGameDao storeDAO;
    
    // private 생성자
    private DeadukGameServiceImpl() {
        storeDAO = DeadukGameDaoImpl.getInstance();
    }
    
    /**
     * 싱글톤 인스턴스 반환
     */
    public static DeadukGameServiceImpl getInstance() {
        if (instance == null) {
            synchronized (DeadukGameServiceImpl.class) {
                if (instance == null) {
                    instance = new DeadukGameServiceImpl();
                }
            }
        }
        return instance;
    }
    
    @Override
    public StoreVO getRandomStore() {
        return storeDAO.selectRandomStore();
    }
    @Override
    public String getMainMenuName(String storeId) {
        if (storeId == null || storeId.trim().isEmpty()) {
            return null;
        }
        return storeDAO.selectMainMenuName(storeId);
    }
    
    @Override
    public StoreVO getStoreById(String storeId) {
        return storeDAO.selectStoreById(storeId);
    }
    

}

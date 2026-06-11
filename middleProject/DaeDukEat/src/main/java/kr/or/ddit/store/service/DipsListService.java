package kr.or.ddit.store.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.dao.DipsListDaoImpl;
import kr.or.ddit.store.dao.IDipsListDao;
import kr.or.ddit.store.vo.StoreVO;

public class DipsListService implements IDIpsListService {
	
	// ✅ 싱글톤
    private static IDIpsListService service;

    private IDipsListDao dao;

    private DipsListService() {
        dao = DipsListDaoImpl.getInstance();
    }

    public static IDIpsListService getInstance() {
        if (service == null) {
            service = new DipsListService();
        }
        return service;
    }

	
    /**
     * 찜 가게 목록 조회
     */
    @Override
    public List<StoreVO> getDipsStoreList(String userId) {
        return dao.selectDipsStoreList(userId);
    }

    @Override
    public boolean removeDips(String userId, String storeId) {

        SqlSession session = MyBatisUtil.getSqlSession(false);

        try {
            int cnt1 = dao.deleteDips(session, userId, storeId);
            int cnt2 = dao.decreaseDibsCount(session, storeId);

            if (cnt1 > 0 && cnt2 > 0) {
                session.commit();
                return true;
            }
            session.rollback();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return false;
    }
}

package kr.or.ddit.store.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.StoreVO;

public class DipsListDaoImpl implements IDipsListDao {
	
	// ✅ 싱글톤
    private static IDipsListDao dao;

    private DipsListDaoImpl() {}

    public static IDipsListDao getInstance() {
        if (dao == null) {
            dao = new DipsListDaoImpl();
        }
        return dao;
    }


	@Override
	public List<StoreVO> selectDipsStoreList(String userId) {
		SqlSession session = null;
        List<StoreVO> list = null;

        try {
            session = MyBatisUtil.getSqlSession();
            
            // 🔥 mapper namespace + id
            list = session.selectList(
                "kr.or.ddit.store.dao.IStoreDao.selectDipsStoreList",
                userId
            );

        } finally {
            if (session != null) session.close();
        }

        return list;
	}

	@Override
	public int deleteDips(SqlSession session, String userId, String storeId) {
	    Map<String, String> map = new HashMap<>();
	    map.put("userId", userId);
	    map.put("storeId", storeId);
	    return session.delete("kr.or.ddit.store.dao.IStoreDao.deleteDips", map);
	}

	@Override
	public int decreaseDibsCount(SqlSession session, String storeId) {
	    return session.update("kr.or.ddit.store.dao.IStoreDao.decreaseDibsCount", storeId);
	}
	
	

}

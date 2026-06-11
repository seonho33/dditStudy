package kr.or.ddit.admin.service;


import java.util.List;

import kr.or.ddit.admin.dao.GsDaoImpl;
import kr.or.ddit.admin.dao.IGsDao;
import kr.or.ddit.admin.vo.GsVO;

public class GsServiceImpl implements IGSService {

	private static IGSService service;
    private IGsDao dao;

    private GsServiceImpl() {
        dao = GsDaoImpl.getInstance();
    }

    public static IGSService getInstance() {
        if (service == null) service = new GsServiceImpl();
        return service;
    }

    @Override
    public List<GsVO> selectAll() {
        try {
            dao.updateExpiredPromotion();
        } catch (Exception e) {
            // 만료 처리 실패해도 목록 조회는 진행
            e.printStackTrace();
        }
        return dao.selectAll();
    }

    

    @Override
    public int insertGsProduct(GsVO vo) {
        return dao.insertGsProduct(vo);
    }

    
    @Override
    public int deleteGsProduct(int gsId) {
        return dao.deleteGsProduct(gsId);
    }
    
    @Override public GsVO getLatestGodSale() { return dao.selectLatestGodSale(); }
    @Override public GsVO getLatestEndSale() { return dao.selectLatestEndSale(); }
    @Override public GsVO getLatestHotItem() { return dao.selectLatestHotItem(); }
    
    @Override
    public GsVO selectLatestByDivision(String division) {
        return dao.selectLatestByDivision(division);
    }

}

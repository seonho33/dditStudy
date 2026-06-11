package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.dao.GsPromotionDaoImpl;
import kr.or.ddit.board.dao.IGsPromotionDao;
import kr.or.ddit.board.vo.GsPromotionVO;

public class GsPromotionServiceImpl implements IGsPromotionService {

	private IGsPromotionDao dao;
	
	private static IGsPromotionService service;
	
	private GsPromotionServiceImpl() {
		dao = GsPromotionDaoImpl.getDao();
	}
	
	
	public static IGsPromotionService getInstance() {
        if(service == null) {
            service = new GsPromotionServiceImpl();
        }
        return service;
    }
	
	@Override
	public int gsInsert(GsPromotionVO vo) {
		// TODO Auto-generated method stub
		return dao.gsInsert(vo);
	}

	@Override
	public int gsDelete(GsPromotionVO vo) {
		// TODO Auto-generated method stub
		
		return dao.gsDelete(vo);
	}

	@Override
	public int gsUpdate(GsPromotionVO vo) {
		// TODO Auto-generated method stub
		return dao.gsUpdate(vo);
	}

	@Override
	public List<GsPromotionVO> selectGsPromotionList() {
		// TODO Auto-generated method stub
		return dao.selectGsPromotionList();
	}

	@Override
	public GsPromotionVO selectGsPromotion(Long gsId) {
		// TODO Auto-generated method stub
		return dao.selectGsPromotion(gsId);
	}
	
	// 할인율 계산 공통 로직
    private void calcRate(GsPromotionVO vo) {
        if(vo.getOriginalPrice() > 0) {
            long ori = vo.getOriginalPrice();
            long dc = vo.getDiscountPrice();
            long rate = ((ori - dc) * 100) / ori;
            vo.setDiscountRate(rate);
        }
    }

}

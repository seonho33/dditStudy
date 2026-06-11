package kr.or.ddit.admin.service;

import java.util.List;

import kr.or.ddit.admin.dao.IRouletteDao;
import kr.or.ddit.admin.dao.RouletteDaoImpl;
import kr.or.ddit.store.vo.StoreVO;

public class RouletteServiceImpl implements IRouletteService {

	private static IRouletteService service;
	private IRouletteDao dao;
	
	private RouletteServiceImpl() {
		 dao = RouletteDaoImpl.getInstance();
	}
	
	public static IRouletteService getInstance() {
		if(service == null) {
			service = new RouletteServiceImpl();
		}
		return service;
	}
	
	
	
	@Override
	public List<StoreVO> getstoreRoulette() {
		return dao.getstoreRoulette();
	}

	@Override
	public List<StoreVO> getstoreCategory(String category) {
		return dao.getstoreCategory(category);
	}

	@Override
	public List<StoreVO> getstoreRating(int Rating) {
		return dao.getstoreRating(Rating);
	}

}

package kr.or.ddit.admin.service;

import java.util.List;

import kr.or.ddit.admin.dao.ISlideStore;
import kr.or.ddit.admin.dao.SlideStoreImpl;
import kr.or.ddit.store.vo.StoreVO;

public class SlideStoreServiceImpl implements ISlideStoreService {
	
        private static ISlideStoreService service;
        private ISlideStore Slide;
        private SlideStoreServiceImpl() {
        	
        	Slide = SlideStoreImpl.getInstance();   	
        }
        
        public static ISlideStoreService getInstance() {
        	if(service == null) {
        		service = new SlideStoreServiceImpl();   		
        	}
        	
        	return service;
        }
        
	
	@Override
	public List<StoreVO> StoreSlide() {
		
		return Slide.StoreSlide();
	}

}

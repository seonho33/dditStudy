package kr.or.ddit.admin.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.StoreVO;

public class SlideStoreImpl implements ISlideStore {

	private static ISlideStore slide = new SlideStoreImpl();
	private SlideStoreImpl() {		
	}
	public static ISlideStore getInstance() {
		return slide;
	}
	
	@Override
	public List<StoreVO> StoreSlide() {
	    
	    SqlSession session = null;
	    List<StoreVO> list = null;
	    
	    try {
	        session = MyBatisUtil.getSqlSession();
	        
	        System.out.println("===== 슬라이드 조회 시작 =====");
	        
	        // ✅ slideStore.StoreSlide로 호출
	        list = session.selectList("slideStore.StoreSlide");
	        
	        System.out.println("조회 성공! 데이터 개수: " + (list != null ? list.size() : 0));
	        
	        if(list != null && !list.isEmpty()) {
	            System.out.println("📌 TOP 3:");
	            for(int i = 0; i < Math.min(3, list.size()); i++) {
	                System.out.println("  " + (i+1) + ". " + list.get(i).getStoreName() + 
	                        " (좋아요: " + list.get(i).getLikesCount() + ")");
	            }
	        }
	        
	    } catch(Exception e) {
	        System.err.println("슬라이드 조회 에러!");
	        e.printStackTrace();
	    } finally {
	        if (session != null) session.close();
	    }
	    
	    return list;
	}
}
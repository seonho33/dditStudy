package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.board.vo.GsPromotionVO;

public interface IGsPromotionService {

	
		public int gsInsert(GsPromotionVO vo);
		
		public int gsDelete(GsPromotionVO vo);
		
		public int gsUpdate(GsPromotionVO vo);
		
		
		
		/**
	     * 전체 프로모션 목록 조회
	     * @return 프로모션 리스트
	     */
	    public List<GsPromotionVO> selectGsPromotionList();
	    
	    /**
	     * 특정 프로모션 상세 조회
	     * @param gsId 상품 번호 (PK)
	     * @return 프로모션 상세 정보
	     */
	    public GsPromotionVO selectGsPromotion(Long gsId);
	

}

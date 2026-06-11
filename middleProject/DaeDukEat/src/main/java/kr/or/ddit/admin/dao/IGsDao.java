package kr.or.ddit.admin.dao;

import java.util.List;

import kr.or.ddit.admin.vo.GsVO;

public interface IGsDao {
	
    List<GsVO> selectAll();

    int updateExpiredPromotion();

    int insertGsProduct(GsVO vo);

    int deleteGsProduct(int gsId);

    GsVO selectLatestGodSale();
    GsVO selectLatestEndSale();
    GsVO selectLatestHotItem();
    
    GsVO selectLatestByDivision(String division);

    
}

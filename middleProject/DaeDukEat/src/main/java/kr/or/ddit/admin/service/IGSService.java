package kr.or.ddit.admin.service;

import java.util.List;

import kr.or.ddit.admin.vo.GsVO;

public interface IGSService {

    List<GsVO> selectAll();
    
    int insertGsProduct(GsVO vo);

    int deleteGsProduct(int gsId);

    GsVO getLatestGodSale();
    GsVO getLatestEndSale();
    GsVO getLatestHotItem();
    GsVO selectLatestByDivision(String division);

}

package kr.or.ddit.admin.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.admin.vo.BotVO;

public interface IBotDao {
	
	List<BotVO> selectBotList();

	 BotVO selectBotByKeyword(String keyword);
	 
	 int insertBot(BotVO vo);

	 int deleteBot(int botId);

	 int updateBot(BotVO vo);

	 public String selectActiveYnById(int botId);
	 public int updateActiveYn(java.util.Map<String, Object> param);

	    List<BotVO> selectActiveBots();
	    List<Map<String, Object>> searchStoreTop3(String keyword);
	    List<Map<String, Object>> searchMenuTop3(String keyword);
	    List<Map<String, Object>> searchMenuByNameTop3(String keyword);
	    
	    List<Map<String, Object>> searchStoreTop3ByMenuName(String keyword);

	    List<Map<String, Object>> searchStoreByCategoryTop3(String categoryName);
	    List<Map<String, Object>> searchStoreByMenuKeywordTop3(String keyword);
}

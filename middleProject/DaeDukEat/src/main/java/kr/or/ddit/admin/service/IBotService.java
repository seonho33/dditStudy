package kr.or.ddit.admin.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.admin.vo.BotVO;

public interface IBotService {

    List<BotVO> selectBotList();

    BotVO getBotByKeyword(String keyword);
    
    int insertBot(BotVO vo);

    int deleteBot(int botId);

    int updateBot(BotVO vo);

    String toggleActive(int botId);

    BotVO findBestMatch(String userInput);
    List<Map<String, Object>> searchTop3(String categoryName, String keyword);

    List<Map<String, Object>> searchTop3Mixed(String categoryName, String menuKeyword);

}

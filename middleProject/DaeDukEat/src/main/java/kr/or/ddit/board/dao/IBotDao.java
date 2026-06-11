package kr.or.ddit.board.dao;

import java.util.List;

import kr.or.ddit.admin.vo.BotVO;

public interface IBotDao {
	/**
     * 키워드로 봇 답변 검색
     * @param keyword 검색 키워드
     * @return 매칭된 BotVO 객체
     */
    BotVO getBotByKeyword(String keyword);
    
    /**
     * 모든 활성화된 봇 답변 조회
     * @return 봇 답변 리스트
     */
    List<BotVO> getAllActiveBots();
}

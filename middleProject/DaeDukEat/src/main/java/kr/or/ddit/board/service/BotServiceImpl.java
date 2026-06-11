package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.admin.vo.BotVO;
import kr.or.ddit.board.dao.BotDaoImpl;
import kr.or.ddit.board.dao.IBotDao;

public class BotServiceImpl implements IBotService {

	// DAO 객체
    private IBotDao dao;
    
    // 싱글톤 패턴
    private static BotServiceImpl instance;
    
    private BotServiceImpl() {
        dao = BotDaoImpl.getInstance();
    }
    
    public static BotServiceImpl getInstance() {
        if (instance == null) {
            instance = new BotServiceImpl();
        }
        return instance;
    }

    @Override
    public BotVO getBotByKeyword(String keyword) {
        return dao.getBotByKeyword(keyword);
    }

    @Override
    public List<BotVO> getAllActiveBots() {
        return dao.getAllActiveBots();
    }

}

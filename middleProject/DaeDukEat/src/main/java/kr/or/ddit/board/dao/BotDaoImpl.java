package kr.or.ddit.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.admin.vo.BotVO;
import kr.or.ddit.common.util.MyBatisUtil;

public class BotDaoImpl implements IBotDao {

	// 싱글톤 패턴
    private static BotDaoImpl instance;
    
    private BotDaoImpl() {}
    
    public static BotDaoImpl getInstance() {
        if (instance == null) {
            instance = new BotDaoImpl();
        }
        return instance;
    }

    @Override
    public BotVO getBotByKeyword(String keyword) {
        SqlSession session = null;
        BotVO bot = null;
        
        try {
            session = MyBatisUtil.getSqlSession();
            bot = session.selectOne("bot.getBotByKeyword", keyword);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        
        return bot;
    }

    @Override
    public List<BotVO> getAllActiveBots() {
        SqlSession session = null;
        List<BotVO> list = null;
        
        try {
            session = MyBatisUtil.getSqlSession();
            list = session.selectList("bot.getAllActiveBots");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (session != null) session.close();
        }
        
        return list;
    }

}

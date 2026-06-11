package kr.or.ddit.board.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import kr.or.ddit.board.util.MyBatisUtil;
import kr.or.ddit.board.vo.BoardVO;

public class BoardDao implements IBoardDao{
	private static IBoardDao boardDao = new BoardDao();
	private static final Logger SQL_LOGGER = LogManager.getLogger("log4j.sql.Query");
	
	private BoardDao() {
	}
	
	public static IBoardDao getInstance() {
		return boardDao;
	}

	@Override
	public int insertContent(BoardVO bv) {
		SqlSession session = MyBatisUtil.getSqlSession();
		int cnt = 0;
		try {
			cnt = session.insert("board.insertContent",bv);
			SQL_LOGGER.debug("insert SQL 실행 : " +bv);
			if(cnt>0) {
				session.commit();
			}
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return cnt;
	}

	@Override
	public int deleteContent(int no) {
		SqlSession session = MyBatisUtil.getSqlSession();
		int cnt = 0;
		try {
			cnt = session.delete("board.deleteContent",no);
			
			if(cnt>0) {
				session.commit();
			}
			
		}catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return cnt;
	}

	@Override
	public int updateContent(BoardVO bv) {
		SqlSession session = MyBatisUtil.getSqlSession();
		int cnt = 0;
		try {
			cnt = session.update("board.updateContent",bv);
			
			if(cnt>0) {
				session.commit();
			}
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return cnt;
	}
	

	@Override
	public boolean checkBoard(int no) {
		boolean isExist = false;
		SqlSession session = MyBatisUtil.getSqlSession();
		
		try {
			int cnt  = session.selectOne("board.checkBoard",no);
			
			if(cnt>0) {
				isExist = true;
			}
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		return isExist;
	}

	@Override
	public List<BoardVO> searchContent(BoardVO bv) {
		
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		
		SqlSession session = MyBatisUtil.getSqlSession();
		
		try {
			boardList = session.selectList("board.searchContent",bv);
		}catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		return boardList;
	}
	
	@Override
	public List<BoardVO> getAllContent() {
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		
		SqlSession session = MyBatisUtil.getSqlSession();
		
		try {
			boardList = session.selectList("board.getAllContent");
		} catch (PersistenceException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return boardList;
	}
}

package kr.or.ddit.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PageInfo;
import kr.or.ddit.board.vo.ReplyVO;
import kr.or.ddit.mybatis.config.MyBatisUtil;

public class BoardDaoImpl implements IBoardDao {

	private static IBoardDao dao;
	public static IBoardDao getDao() {
		if(dao == null) dao = new BoardDaoImpl();
		
		return dao;
	};
	
	private BoardDaoImpl() {}
	
	
	@Override
	public int getListCount(PageInfo pinfo) {
		SqlSession sql = MyBatisUtil.getSqlSession();
		
		int count = 0;
		
		try {
			count = sql.selectOne("board.getListCount",pinfo);

		} catch (Exception e) {
			e.printStackTrace();
		
		}finally {
			sql.commit();
			sql.close();
		}
		
		return count;
	}

	@Override
	public List<BoardVO> pageByList(PageInfo pinfo) {
		SqlSession sql = MyBatisUtil.getSqlSession();
		
		List<BoardVO> list = null;
		
		try {
			list = sql.selectList("board.pageByList",pinfo);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			sql.commit();
			sql.close();
		}
		
		return list;
	}

	@Override
	public int boardInsert(BoardVO bvo) {
		SqlSession sql = MyBatisUtil.getSqlSession();
		
		int res =0;
		
		try {
			res = sql.insert("board.boardInsert",bvo);
			
		}finally {
			sql.commit();
			sql.close();
		}
		return res;
	}

	@Override
	public int replyInsert(ReplyVO rvo) {
		
		SqlSession sql = MyBatisUtil.getSqlSession();
		
		int count =0;
		
		try {
			count = sql.insert("reply.replyInsert",rvo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
		}
		
		return count;
	}

	@Override
	public List<ReplyVO> replyList(int bonum) {
		SqlSession sql = MyBatisUtil.getSqlSession();
		
		List<ReplyVO> list =null;
		
		try {
			list= sql.selectList("reply.replyList",bonum);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
		}
		
		return list;
	}

	@Override
	public int hitUpdate(int num) {
		SqlSession sql = MyBatisUtil.getSqlSession();
		
		int res = 0;
		
		try {
			
			res = sql.update("board.hitUpdate",num);
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
		}
		
		return res;
	}

	@Override
	public int replyDelete(int renum) {
		SqlSession sql = MyBatisUtil.getSqlSession();
		
		int res = 0;
		
		try {
			
			res = sql.delete("reply.replyDelete",renum);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
		}
		
		return res;
	}


}

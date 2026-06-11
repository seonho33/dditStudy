package kr.or.ddit.board.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.board.dao.BoardDaoImpl;
import kr.or.ddit.board.dao.IBoardDao;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PageInfo;
import kr.or.ddit.board.vo.ReplyVO;
import kr.or.ddit.mybatis.config.MyBatisUtil;

public class BoardServiceImple implements IBoardService {
	
	private static IBoardService service;
	public static IBoardService getService() {
		if(service==null)service = new BoardServiceImple();
		return service;
	}

	private IBoardDao dao;
	private BoardServiceImple() {
		dao = BoardDaoImpl.getDao();
	};
	
	@Override
	public int getListCount(PageInfo pinfo) {
		
		return dao.getListCount(pinfo);
	}

	@Override
	public List<BoardVO> pageByList(PageInfo pinfo) {
		return dao.pageByList(pinfo);
	}

	@Override
	public List<BoardVO> readPaging(PageInfo pinfo) {
		//전체 글 갯수 가져오기
		int count = dao.getListCount(pinfo);	//pinfo : svo.stype, svo.sword
		pinfo.setTotalRecord(count);
		
		//게시글 가져오기
		List<BoardVO> list = dao.pageByList(pinfo);	//pinfo : start,end,svo.stype,svo.sword
		
		return list;
	}

	@Override
	public int boardInsert(BoardVO bvo) {
		return dao.boardInsert(bvo);
	}

	@Override
	public int replyInsert(ReplyVO rvo) {
		// TODO Auto-generated method stub
		return dao.replyInsert(rvo);
	}

	@Override
	public List<ReplyVO> replyList(int bonum) {
		// TODO Auto-generated method stub
		return dao.replyList(bonum);
	}

	@Override
	public int hitUpdate(int num) {
		// TODO Auto-generated method stub
		return dao.hitUpdate(num);
	}

	@Override
	public int replyDelete(int renum) {
		return dao.replyDelete(renum);
	}


}

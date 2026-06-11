package kr.or.ddit.board.Service;

import java.util.List;

import kr.or.ddit.board.dao.BoardDao;
import kr.or.ddit.board.dao.IBoardDao;
import kr.or.ddit.board.vo.BoardVO;

public class BoardService implements IBoardService {

	private IBoardDao boardDao;
	private static IBoardService boardService = new BoardService();
	
	private BoardService() {
		boardDao = BoardDao.getInstance();
	}
	
	public static IBoardService getInstance() {
		return boardService;
	}
	
	@Override
	public int addContent(BoardVO bv) {
		return boardDao.insertContent(bv);
	}

	@Override
	public int removeContent(int no) {
		return boardDao.deleteContent(no);
	}

	@Override
	public int modifyContent(BoardVO bv) {
		return boardDao.updateContent(bv);
	}
	
	@Override
	public boolean checkBoard(int no) {
		return boardDao.checkBoard(no);
	}

	@Override
	public List<BoardVO> searchContent(BoardVO bv) {
		return boardDao.searchContent(bv);
	}

	@Override
	public List<BoardVO> displayAllBoard() {
		return boardDao.getAllContent();
	}

	
}

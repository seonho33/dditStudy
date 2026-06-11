package kr.or.ddit.board.dao;

import java.util.List;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PageInfo;
import kr.or.ddit.board.vo.ReplyVO;

public interface IBoardDao {
	
	
	//전체 글 갯수 메소드
	public int getListCount(PageInfo pinfo);
	
	
	//페이지별 리스트 3개씩 가져오기
	public List<BoardVO> pageByList(PageInfo pinfo);

	//글저장 -글쓰기
	public int boardInsert(BoardVO bvo);
	
	
	//글삭제
	
	//글수정
	
	//조회수 증가
	public int hitUpdate(int num);
	//댓글등록
	public int replyInsert(ReplyVO rvo);
	
	//댓글수정
	
	//댓글삭제
	public int replyDelete(int renum);	
	
	//댓글리스트
	public List<ReplyVO> replyList(int bonum);
	
}

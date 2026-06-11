package kr.or.ddit.ch17.dao;

import java.net.ResponseCache;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import kr.or.ddit.ch17.vo.BoardVO;

public class BoardRepository {
	private static int no = 1;	// 게시글번호
	
	// 게시글 정보를 담을 목록 데이터
	private ArrayList<BoardVO> listOfBoard = new ArrayList<BoardVO>();
	
	// 싱글톤
	private static BoardRepository instance = null;
	public static BoardRepository getInstance(){
		if(instance == null) {
			instance = new BoardRepository();
		}
		
		return instance;
	} 

	// 게시글 전체 가져오기
	public ArrayList<BoardVO> selectBoardList() {
		return listOfBoard;
	}

	// 게시글 번호에 해당하는 게시글 정보 가져오기
	public BoardVO getBoardById(int no) {
		BoardVO boardVO = null;

		for (int i = 0; i < listOfBoard.size(); i++) {
			BoardVO board = listOfBoard.get(i);
			if (board != null && board.getNo() == no) {
				boardVO = new BoardVO();
				boardVO = board;
				break;
			}
		}
		// 게시글 조회수 증가
		boardVO.setHit(boardVO.getHit() + 1);
		return boardVO;
	}
	
	// 조회수를 늘리지 않고 해당 게시글 정보만 가져오기
	public BoardVO getOnlyBoardById(int no) {
		BoardVO boardVO = null;

		for (int i = 0; i < listOfBoard.size(); i++) {
			BoardVO board = listOfBoard.get(i);
			if (board != null && board.getNo() == no) {
				boardVO = new BoardVO();
				boardVO = board;
				break;
			}
		}
		return boardVO;
	}
	
	// 게시글 번호에 해당하는 게시글 삭제
	public void deleteBoard(int no) {
		for (int i = 0; i < listOfBoard.size(); i++) {
			BoardVO board = listOfBoard.get(i);
			if (board != null && board.getNo() == no) {
				listOfBoard.remove(i);
			}
		}
	}
	
	// 게시글 수정
	public void updateBoard(BoardVO board) {
		for (int i = 0; i < listOfBoard.size(); i++) {
			BoardVO gBoard = listOfBoard.get(i);
			if (gBoard != null && gBoard.getNo() == board.getNo()) {
//				gBoard.setNo(board.getNo());
				gBoard.setTitle(board.getTitle());
				gBoard.setContent(board.getContent());
				if(board.getFileVO() != null && board.getFileVO().getFileName() != null && !board.getFileVO().getFileName().equals("")) {
					gBoard.setFileVO(board.getFileVO());
				}
				break;
			}
		}
	}
	
	// 게시글 등록
	public void addBoard(BoardVO board) {
		board.setNo(no);
		board.setRegDate(getCurrentTime());
		listOfBoard.add(board);
		++no;
	}
	
	// 게시글 번호 getter
	public int getNo() {
		return no;
	}
	
	// 현재 시간 가져오기
	public String getCurrentTime() {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(System.currentTimeMillis());
		return formatter.format(calendar.getTime());
	}
}

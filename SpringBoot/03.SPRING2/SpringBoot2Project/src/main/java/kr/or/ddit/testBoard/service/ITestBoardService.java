package kr.or.ddit.testBoard.service;

import java.util.List;

import kr.or.ddit.vo.crud.Board;

public interface ITestBoardService {

	void registerBoard(Board board);

	List<Board> getList();

}

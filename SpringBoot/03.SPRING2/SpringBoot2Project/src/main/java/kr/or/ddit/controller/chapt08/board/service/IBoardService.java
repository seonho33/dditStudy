package kr.or.ddit.controller.chapt08.board.service;

import java.util.List;

import kr.or.ddit.vo.crud.Board;

public interface IBoardService {

	void register(Board board);

	List<Board> list();

	Board read(int boardNo);

	void modify(Board board);

	void Remove(int boardNo);

	List<Board> search(Board board);
}

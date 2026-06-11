package kr.or.ddit.controller.chapt08.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.crud.Board;

@Mapper
public interface IBoardMapper {

	void create(Board board);

	List<Board> getList();

	Board read(int boardNo);

	void modify(Board board);

	void Remove(int boardNo);

	List<Board> search(Board board);

	
}

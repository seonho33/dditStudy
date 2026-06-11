package kr.or.ddit.testBoard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.crud.Board;

@Mapper
public interface ITestBoardMapper {

	void registerBoard(Board board);

	List<Board> getList();

	
}

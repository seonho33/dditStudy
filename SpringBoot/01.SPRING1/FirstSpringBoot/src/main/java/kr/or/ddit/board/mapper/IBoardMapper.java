package kr.or.ddit.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Mapper
public interface IBoardMapper {

	int insertBoard(BoardVO boardVO);

	BoardVO selectBoard(int boNo);

	void incrementHit(int boNo);

	int updateBoard(BoardVO boardVO);

	int deleteBoard(int boNo);

	int selectBoardCount(PaginationInfoVO<BoardVO> pagingVO);

	List<BoardVO> selectBoardList();

	List<BoardVO> selectBoardVOList();

}
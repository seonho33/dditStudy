package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ServiceResult;

public interface IBoardService {

	ServiceResult insertBoard(BoardVO boardVO);

	BoardVO selectBoard(int boNo);

	ServiceResult updateService(BoardVO boardVO);

	ServiceResult deleteBoard(int boNo);

	int selectBoardCount(PaginationInfoVO<BoardVO> pagingVO);

	List<BoardVO> selectBoardList();

	List<BoardVO> selectBoardVOList();
	
}
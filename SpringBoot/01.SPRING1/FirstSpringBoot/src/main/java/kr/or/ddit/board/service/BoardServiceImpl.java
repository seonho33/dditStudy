package kr.or.ddit.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.board.mapper.IBoardMapper;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ServiceResult;

@Service
public class BoardServiceImpl implements IBoardService {

	@Autowired
	private IBoardMapper mapper;
	
	@Override
	public ServiceResult insertBoard(BoardVO boardVO) {
		ServiceResult result = null;
		
		int status = mapper.insertBoard(boardVO);
		if(status>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public BoardVO selectBoard(int boNo) {
		//조회수 증가
		mapper.incrementHit(boNo);
		
		//select 된 boardVO를 리턴
		return mapper.selectBoard(boNo);
	}

	@Override
	public ServiceResult updateService(BoardVO boardVO) {
		ServiceResult result = null;
		
		int status = mapper.updateBoard(boardVO);
		if(status>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult deleteBoard(int boNo) {
		
		ServiceResult result = null;
		
		int status = mapper.deleteBoard(boNo);
		
		if(status >0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public int selectBoardCount(PaginationInfoVO<BoardVO> pagingVO) {
		return mapper.selectBoardCount(pagingVO);
	}

	@Override
	public List<BoardVO> selectBoardList(PaginationInfoVO<BoardVO> pagingVO) {
		return mapper.selectBoardList(pagingVO);
	}

	@Override
	public List<BoardVO> selectBoardList() {
		
		List<BoardVO> boardList = mapper.selectBoardList();
		
		return boardList;
	}

	@Override
	public List<BoardVO> selectBoardVOList() {
		
		List<BoardVO> boardList = mapper.selectBoardVOList();
		
		return null;
	}

}

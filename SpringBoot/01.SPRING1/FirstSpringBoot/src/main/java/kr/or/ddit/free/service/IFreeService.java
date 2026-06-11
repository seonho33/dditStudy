package kr.or.ddit.free.service;

import kr.or.ddit.vo.ServiceResult;

import java.util.List;

import kr.or.ddit.vo.FreeVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IFreeService {

	ServiceResult insertFreeBoard(FreeVO freeVO);

	FreeVO selectFreeBoard(int freeNo);

	ServiceResult updateFreeBoard(FreeVO freeVO);

	List<FreeVO> selectFreeBoardList(PaginationInfoVO<FreeVO> pagingVO);

	int selectFreeBoardCount(PaginationInfoVO<FreeVO> pagingVO);

	ServiceResult deleteFreeBoard(int freeNo);

}

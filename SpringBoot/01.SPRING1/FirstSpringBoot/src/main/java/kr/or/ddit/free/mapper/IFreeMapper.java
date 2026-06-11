package kr.or.ddit.free.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.FreeVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Mapper
public interface IFreeMapper {

	int insertFreeBoard(FreeVO freeVO);

	FreeVO selectFreeBoard(int freeNo);

	int updateFreeBoard(FreeVO freeVO);

	List<FreeVO> selectFreeBoardList(PaginationInfoVO<FreeVO> pagingVO);

	int selectFreeBoardCount(PaginationInfoVO<FreeVO> pagingVO);

	void incrementHit(int freeNo);

	int deleteFreeBoard(int freeNo);

}
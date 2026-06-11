package kr.or.ddit.free.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.free.mapper.IFreeMapper;
import kr.or.ddit.vo.ServiceResult;
import kr.or.ddit.vo.FreeVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class FreeServiceImpl implements IFreeService {
	
	@Autowired
	private IFreeMapper mapper;

	@Override
	public ServiceResult insertFreeBoard(FreeVO freeVO) {
		
		ServiceResult result;
		int res = mapper.insertFreeBoard(freeVO);
		
		if(res>0) {
			result=ServiceResult.OK;
		}else {
			result=ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public FreeVO selectFreeBoard(int freeNo) {
		mapper.incrementHit(freeNo);
		return mapper.selectFreeBoard(freeNo);
	}

	@Override
	public ServiceResult updateFreeBoard(FreeVO freeVO) {
		
		ServiceResult result;
		
		int res = mapper.updateFreeBoard(freeVO);
		
		if(res>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

	@Override
	public List<FreeVO> selectFreeBoardList(PaginationInfoVO<FreeVO> pagingVO) {
		List<FreeVO> freeList = mapper.selectFreeBoardList(pagingVO);
		return freeList;
	}

	@Override
	public int selectFreeBoardCount(PaginationInfoVO<FreeVO> pagingVO) {
		int res = mapper.selectFreeBoardCount(pagingVO);
		return res;
	}

	@Override
	public ServiceResult deleteFreeBoard(int freeNo) {
		ServiceResult result;
		int res = mapper.deleteFreeBoard(freeNo);
		if(res>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

}

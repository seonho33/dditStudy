package kr.or.ddit.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.notice.mapper.INoticeMapper;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ServiceResult;

@Service
public class NoticeServiceImpl implements INoticeService {


	@Autowired
	private INoticeMapper mapper;

	@Override
	public ServiceResult insertNotice(NoticeVO noticeVO) {
		
		ServiceResult result =null;
		
		int res = mapper.insertNotice(noticeVO);
		
		if(res>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public NoticeVO selectNotice(int noticeNo) {
		
		mapper.incrementHit(noticeNo);
		NoticeVO noticeVO = mapper.selectNotice(noticeNo);
		
		return noticeVO;
	}


	@Override
	public ServiceResult deleteNotice(int noticeNo) {
		ServiceResult result;
		int res = mapper.deleteNotice(noticeNo);
		if(res>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO) {
		return mapper.selectNoticeCount(pagingVO);
	}

	@Override
	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO) {
		return mapper.selectNoticeList(pagingVO);
	}

	@Override
	public ServiceResult updateNotice(NoticeVO noticeVO) {
		ServiceResult result;
		int res = mapper.updateNotice(noticeVO); 
		if(res>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}
	
}

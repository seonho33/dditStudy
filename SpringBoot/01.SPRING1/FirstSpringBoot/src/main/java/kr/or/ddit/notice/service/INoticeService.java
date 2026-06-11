package kr.or.ddit.notice.service;

import java.util.List;

import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import kr.or.ddit.vo.ServiceResult;

public interface INoticeService {

	ServiceResult insertNotice(NoticeVO noticeVO);

	NoticeVO selectNotice(int noticeNo);

	List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);

	ServiceResult deleteNotice(int noticeNo);

	int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO);

	ServiceResult updateNotice(NoticeVO noticeVO);

}

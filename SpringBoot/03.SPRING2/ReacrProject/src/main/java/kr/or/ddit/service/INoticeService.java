package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.notice.NoticeVO;

public interface INoticeService {

	List<NoticeVO> selectNoticeList();

}

package kr.or.ddit.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.INoticeMapper;
import kr.or.ddit.vo.notice.NoticeVO;

@Service
public class NoticeServiceImpl implements INoticeService {

	@Autowired
	private INoticeMapper mapper;
	
	@Override
	public List<NoticeVO> selectNoticeList() {
		return mapper.selectNoticeList();
	}
}

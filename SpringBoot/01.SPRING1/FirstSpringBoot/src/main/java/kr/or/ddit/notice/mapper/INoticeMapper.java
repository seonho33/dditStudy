package kr.or.ddit.notice.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Mapper
public interface INoticeMapper {

	int insertNotice(NoticeVO noticeVO);

	NoticeVO selectNotice(int noticeNo);

	void incrementHit(int noticeNo);

	int deleteNotice(int noticeNo);

	int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO);

	List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);

	int updateNotice(NoticeVO noticeVO);

}

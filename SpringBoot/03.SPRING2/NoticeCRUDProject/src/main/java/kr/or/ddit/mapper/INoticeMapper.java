package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.AptVO;
import kr.or.ddit.vo.LawDongVO;
import kr.or.ddit.vo.NoticeFileVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Mapper
public interface INoticeMapper {

	int insertNotice(NoticeVO noticeVO);

	void insertNoticeFile(NoticeFileVO noticeFileVO);

	void incrementHit(int boNo);

	NoticeVO selectNotice(int boNo);

	NoticeFileVO noticeDownload(int fileNo);

	void incrementNoticeDownCount(int fileNo);

	int updateNotice(NoticeVO noticeVO);

	NoticeFileVO selectNoticeFile(Integer integer);

	void deleteNoticeFile(Integer integer);

	void deleteNoticeFileByNo(int boNo);

	void deleteNoticeComment(int boNo);

	int deleteNotice(int boNo);

	int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO);

	List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);

	void mergeLawDong(LawDongVO vo);

	List<String> selectAllDongCodes();

	void mergeApt(AptVO apt);
	
}
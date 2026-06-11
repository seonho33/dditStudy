package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.NoticeCommentVO;
import kr.or.ddit.vo.NoticeFileVO;
import kr.or.ddit.vo.NoticeMemberVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface INoticeService {

	ServiceResult idCheck(String memId);

	ServiceResult signup(NoticeMemberVO memberVO);

	NoticeMemberVO loginCheck(NoticeMemberVO member);

	ServiceResult insertNotice(NoticeVO noticeVO);

	NoticeVO selectNotice(int boNo);

	NoticeFileVO noticeDownload(int fileNo);

	ServiceResult noticeInsertComment(NoticeCommentVO noticeCommentVO);

	List<NoticeCommentVO> selectNoticeCommentList(int integer);

	ServiceResult noticeInsertSubComment(NoticeCommentVO noticeCommentVO);

	ServiceResult noticeUpdateComment(NoticeCommentVO noticeCommentVO);

	ServiceResult noticeDeleteComment(int cmtNo);

	ServiceResult updateNotice(NoticeVO noticeVO);

	ServiceResult deleteNotice(int boNo);

	int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO);

	List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);

	String idForgetProcess(NoticeMemberVO member);

	String pwForgetProcess(NoticeMemberVO member);

	NoticeMemberVO selectMember(String memId);

	ServiceResult profileUpdate(NoticeMemberVO memberVO);

	void collectLawDong() throws Exception;

	void collectAptData();

}

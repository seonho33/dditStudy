package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.NoticeCommentVO;


@Mapper
public interface ICommentMapper {

	int noticeInsertComment(NoticeCommentVO noticeCommentVO);

	List<NoticeCommentVO> selectNoticeCommentList(int integer);

	int noticeInsertSubComment(NoticeCommentVO noticeCommentVO);

	int noticeUpdateComment(NoticeCommentVO noticeCommentVO);

	int noticeDeleteComment(int cmtNo);

}

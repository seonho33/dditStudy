package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.notice.NoticeVO;

@Mapper
public interface INoticeMapper {

	List<NoticeVO> selectNoticeList();

}

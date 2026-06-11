package kr.or.ddit.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.NoticeMemberVO;

@Mapper
public interface IProfileMapper {

	NoticeMemberVO selectMember(String memId);

	int profileUpdate(NoticeMemberVO memberVO);

}

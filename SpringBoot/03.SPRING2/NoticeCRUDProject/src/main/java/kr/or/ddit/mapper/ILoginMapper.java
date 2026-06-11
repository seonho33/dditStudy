package kr.or.ddit.mapper;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.NoticeMemberVO;

@Mapper
public interface ILoginMapper {

	NoticeMemberVO idCheck(String memId);

	int signup(NoticeMemberVO memberVO);

	NoticeMemberVO loginCheck(NoticeMemberVO member);

	String idForgetProcess(NoticeMemberVO member);

	String pwForgetProcess(NoticeMemberVO member);

}
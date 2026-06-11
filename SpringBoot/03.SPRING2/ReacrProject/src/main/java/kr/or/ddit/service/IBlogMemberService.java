package kr.or.ddit.service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.BlogMemberVO;

public interface IBlogMemberService {

	ServiceResult checkId(String memId);

	ServiceResult signup(BlogMemberVO memberVO);

	String signin(BlogMemberVO memberVO);

}

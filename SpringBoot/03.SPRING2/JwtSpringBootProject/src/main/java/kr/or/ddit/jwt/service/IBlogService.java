package kr.or.ddit.jwt.service;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.vo.BlogMemberVO;
import kr.or.ddit.vo.BlogVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface IBlogService {

	ServiceResult idCheck(String memId);

	ServiceResult signup(BlogMemberVO memberVO);

	String signin(BlogMemberVO memberVO);

	ServiceResult insert(BlogVO blogVO);

	int selectBlogCount(PaginationInfoVO<BlogVO> pagingVO);

	List<BlogVO> selectBlogList(PaginationInfoVO<BlogVO> pagingVO);

	BlogVO detail(int blogNo);

}

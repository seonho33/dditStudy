package kr.or.ddit.jwt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.BlogFileVO;
import kr.or.ddit.vo.BlogMemberVO;
import kr.or.ddit.vo.BlogVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Mapper
public interface IBlogMapper {

	BlogMemberVO idCheck(String memId);

	int signup(BlogMemberVO memberVO);

	void addMemberAuth(int memNo);

	BlogMemberVO signin(BlogMemberVO memberVO);

	int insert(BlogVO blogVO);

	void insertBlogFile(BlogFileVO blogFileVO);

	List<BlogVO> selectBlogList(PaginationInfoVO<BlogVO> pagingVO);

	int selectBlogCount(PaginationInfoVO<BlogVO> pagingVO);

	void incrementHit(int blogNo);

	BlogVO detail(int blogNo);

}

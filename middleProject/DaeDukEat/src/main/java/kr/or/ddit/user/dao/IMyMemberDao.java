package kr.or.ddit.user.dao;

import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;

public interface IMyMemberDao {

	public UserVO SelectUser (String uv);
	public MemberVO SelectMember (String mv);
	    
	    // 쿠폰 개수 조회
	    public int getCouponCount(String userId);
	    
	    // 리뷰 개수 조회
	    public int getReviewCount(String userId);
}
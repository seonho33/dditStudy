package kr.or.ddit.user.service;

import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;

public interface IMyMemberService {

	public UserVO SelectUser (String uv);
	
	public MemberVO SelectMember (String mv);
	
	public int getCouponCount(String userId);
	public int getReviewCount(String userId);
}

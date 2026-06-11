package kr.or.ddit.user.dao;

import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserMemberVO;
import kr.or.ddit.user.vo.UserVO;

public interface IUserDao {

	public int insertUser (UserVO uv);
	
	public int insertMember (MemberVO mv);
	
	public boolean checkUser (String uvo);
	
	//로그인
	public UserVO loginUser(UserVO vo);
	
	//아이디 중복검사
	public String idCheck(String id);
	
    public StoreVO selectStoreByUserId(String userId);
    
    public UserMemberVO loginUserMember(UserVO vo);
    
    public MemberVO selectMemberByUserId(String userId);



}

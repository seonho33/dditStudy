package kr.or.ddit.store.dao;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.user.vo.UserVO;


public interface IUserDao {

	public int insertUser(SqlSession session, UserVO user);
	
	public UserVO selectUserById(SqlSession session, String userId);	
	
	public int withdrawUser(SqlSession session, String userId);
	
	// 추가: 사용자 정보 업데이트
    public int updateUser(SqlSession session, UserVO user);
    
    // 추가: 비밀번호 확인
    public UserVO checkPassword(SqlSession session, String userId, String password);
	
    //이메일 주소변경
    public int updateStoreEmail(SqlSession session,String userId,String Email);

}

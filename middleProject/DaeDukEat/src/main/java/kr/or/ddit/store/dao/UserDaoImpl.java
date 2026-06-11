package kr.or.ddit.store.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.user.vo.UserVO;


public class UserDaoImpl implements IUserDao {

	/*
	 * private SqlSession sqlSession;
	 * 
	 * public UserDaoImpl(SqlSession sqlSession) { this.sqlSession = sqlSession; }
	 */

	/*
	 * @Override public int insertUser(UserVO user) {
	 * 
	 * 
	 * int res = sqlSession.insert("User.insertUser", user);
	 * 
	 * sqlSession.commit();
	 * 
	 * return res;
	 * 
	 * 
	 * return session.insert("User.insertUser", user);
	 * 
	 * }
	 * 
	 * @Override public UserVO selectUserById(String userId) {
	 * 
	 * UserVO uvo = sqlSession.selectOne("User.selectUserById", userId);
	 * 
	 * sqlSession.commit();
	 * 
	 * return uvo;
	 * 
	 * 
	 * return session.selectOne("User.selectUserById", userId); }
	 * 
	 * @Override public int withdrawUser(String userId) {
	 * 
	 * 
	 * int res = sqlSession.update("User.withdrawUser", userId);
	 * 
	 * sqlSession.commit();
	 * 
	 * return res;
	 * 
	 * 
	 * return session.delete("user.withdrawUser", userId);
	 * 
	 * }
	 */
	public UserDaoImpl() {
		
	}

	@Override
	public int insertUser(SqlSession session, UserVO user) {
		return session.insert("User.insertUser", user);
	}

	@Override
	public UserVO selectUserById(SqlSession session, String userId) {
		return session.selectOne("User.selectUserById", userId);
	}

	@Override
	public int withdrawUser(SqlSession session, String userId) {
		return session.delete("User.withdrawUser", userId);
	}

	// 추가: 사용자 정보 업데이트
	@Override
	public int updateUser(SqlSession session, UserVO user) {
		 return session.update("User.updateUser", user);
	}

	// 추가: 비밀번호 확인
	@Override
	public UserVO checkPassword(SqlSession session, String userId, String password) {
		 Map<String, String> params = new HashMap<>();
	     params.put("userId", userId);
	     params.put("password", password);
	     return session.selectOne("User.checkPassword", params);
	}

	@Override
	public int updateStoreEmail(SqlSession session, String userId, String userEmail) {
	    Map<String, String> params = new HashMap<>();
	    params.put("userId", userId);

	    // mapper가 ownerEmail을 쓰는 버전이면 이렇게
	    params.put("ownerEmail", userEmail);

	    // 만약 mapper를 userEmail로 바꿨다면 params.put("userEmail", userEmail);
	    return session.update("User.updateStoreEmail", params);
	}
}

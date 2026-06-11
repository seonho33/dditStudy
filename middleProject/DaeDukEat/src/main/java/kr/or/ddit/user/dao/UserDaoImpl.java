package kr.or.ddit.user.dao;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserMemberVO;
import kr.or.ddit.user.vo.UserVO;

public class UserDaoImpl implements IUserDao{

	private static IUserDao userdao = new UserDaoImpl();
	private UserDaoImpl() {
	}
	public static IUserDao getInstance() {
		return userdao;
	}
	
	
	
	@Override
	public int insertUser(UserVO uv) {
		
		SqlSession session = MyBatisUtil.getSqlSession();
		
		int cnt = 0;
		
		try {
			cnt = session.insert("member.insertUser", uv);
			
			if(cnt > 0) {
				session.commit();
			}
					
		} catch (PersistenceException ex) {
			session.rollback();
			ex.printStackTrace();
		}finally {
			session.close();
		}
		
		return cnt;
	}
	
	
	@Override
	public boolean checkUser(String userId) {
		
		boolean isExist = false;
		
		SqlSession session = MyBatisUtil.getSqlSession(true);
		
		try {
			//checkUser->uvo : aa001
			System.out.println("checkUser->uvo : " + userId);
			
			Integer cnt = session.selectOne("member.checkUser", userId);
			//checkUser->cnt : 1(DB에 aa001 사람이 1명 있다.)
			System.out.println("checkUser->cnt : " + cnt);
			
			if(cnt> 0 ) {
				isExist = true;
			}
			
		} catch (PersistenceException ex) {
			ex.printStackTrace();
		}finally {
			session.close();
		}
		
		return isExist;
	}

	
	
	@Override
	public int insertMember(MemberVO mv) {
		
		SqlSession session = MyBatisUtil.getSqlSession();
		
		int cnt = 0;
		
		try {
			cnt = session.insert("member.insertMember", mv);
			
			 if(cnt > 0) {
			    	session.commit();
			    }
			
		} catch (PersistenceException  ex) {
			session.rollback();
			ex.printStackTrace();  
		}finally {
			session.close();
		}
	
		return cnt;
	}

		//이용자 조회 로그인
		@Override
		public UserVO loginUser(UserVO vo) {
			
			SqlSession sql = MyBatisUtil.getSqlSession();
			UserVO uvo = null;
			
			try {
				uvo = sql.selectOne("login.loginSelect",vo);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				sql.commit();
				sql.close();
			}
			return uvo;
		}
		
		//로그인 아이디 중복검사
		@Override
		public String idCheck(String id) {
			
			SqlSession sql = MyBatisUtil.getSqlSession();
			String res = null; 
			
			try {
				res = sql.selectOne("login.idCheck",id);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				sql.commit();
				sql.close();
			}
			return res;
			
		}

		
	    @Override
	    public StoreVO selectStoreByUserId(String userId) {
	        try (SqlSession session = MyBatisUtil.getSqlSession()) {
	            return session.selectOne("login.selectStoreByUserId", userId);
	        }
	    }
	    @Override
	    public UserMemberVO loginUserMember(UserVO vo) {
	        SqlSession session = MyBatisUtil.getSqlSession();
	        UserMemberVO result = null;
	        try {
	            result = session.selectOne("member.loginUserMember", vo);
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        return result;
	    }
	    
	    
	    @Override
	    public MemberVO selectMemberByUserId(String userId) {
	        SqlSession session = null;
	        try {
	            session = MyBatisUtil.getSqlSession();
	            return session.selectOne("User.selectMemberByUserId", userId);
	        } finally {
	            if (session != null) session.close();
	        }
	    }
}

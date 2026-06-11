package kr.or.ddit.store.service;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.dao.IUserDao;
import kr.or.ddit.store.dao.UserDaoImpl;
import kr.or.ddit.user.vo.UserVO;

public class UserServiceImpl implements IUserService {
	
	/*
	 * private IUserDao userDao; private IStoreDao storeDao;
	 * 
	 * public UserServiceImpl(IUserDao userDao) { this.userDao = new UserDaoImpl();
	 * }
	 * 
	 * @Override public int register(UserVO user) { return userDao.insertUser(user);
	 * }
	 * 
	 * @Override public UserVO getUserById(String userId) { return
	 * userDao.selectUserById(userId); }
	 * 
	 * @Override public int withdrawUser(String userId) { SqlSession session =
	 * MyBatisUtil.getSqlSession(); int cnt = 0;
	 * 
	 * try { cnt = userDao.withdrawUser(session, userId); if (cnt > 0) {
	 * session.commit(); } } catch (Exception e) { session.rollback();
	 * e.printStackTrace(); } finally { session.close(); }
	 * 
	 * return cnt; }
	 */
	
	 private IUserDao userDao;
	 
	 	// 🔥 생성자 1: DAO를 주입받는 생성자 (외부에서 DAO 생성)
	    public UserServiceImpl(IUserDao userDao) {
	        this.userDao = userDao;
	    }
	    
	    // 🔥 생성자 2: 기본 생성자 (내부에서 DAO 생성)
	    public UserServiceImpl() {
	        this.userDao = new UserDaoImpl();
	    }
	    
	 
		/*
		 * public UserServiceImpl(IUserDao userDao) { this.userDao = userDao; }
		 */
	    @Override
	    public int register(UserVO user) {

	        SqlSession session = MyBatisUtil.getSqlSession();
	        int cnt = 0;

	        try {
	            cnt = userDao.insertUser(session, user);
	            session.commit();
	        } catch (Exception e) {
	            session.rollback();
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }

	        return cnt;
	    }

	    @Override
	    public UserVO getUserById(String userId) {

	        SqlSession session = MyBatisUtil.getSqlSession();

	        try {
	            return userDao.selectUserById(session, userId);
	        } finally {
	            session.close();
	        }
	    }

	    @Override
	    public int withdrawUser(String userId) {

	        SqlSession session = MyBatisUtil.getSqlSession();
	        int cnt = 0;

	        try {
	            cnt = userDao.withdrawUser(session, userId);
	            session.commit();
	        } catch (Exception e) {
	            session.rollback();
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }

	        return cnt;
	    }

	 // 추가: 사용자 정보 업데이트
	    @Override
	    public int updateUser(UserVO user) {
	        SqlSession session = MyBatisUtil.getSqlSession();
	        int cnt = 0;
	        try {
	            cnt = userDao.updateUser(session, user);
	            session.commit();
	        } catch (Exception e) {
	            session.rollback();
	            e.printStackTrace();
	        } finally {
	            session.close();
	        }
	        return cnt;
	    }

	    
	 // 추가: 비밀번호 확인
	    @Override
	    public boolean checkPassword(String userId, String password) {
	        SqlSession session = MyBatisUtil.getSqlSession();
	        try {
	            UserVO user = userDao.checkPassword(session, userId, password);
	            return user != null;
	        } finally {
	            session.close();
	        }
	    }

	    @Override
	    public int updateOwnerProfile(UserVO user, String ownerEmail) {
	        SqlSession session = MyBatisUtil.getSqlSession();
	        int cntUser = 0;
	        int cntEmail = 0;

	        try {
	            // 1) USERS 업데이트 (name / password)
	            cntUser = userDao.updateUser(session, user);

	            // 2) STORE 이메일 업데이트
	            cntEmail = userDao.updateStoreEmail(session, user.getUserId(), ownerEmail);

	            // 둘 다 성공하면 커밋
	            if (cntUser > 0 && cntEmail > 0) {
	                session.commit();
	                return 1;
	            } else {
	                session.rollback();
	                return 0;
	            }
	        } catch (Exception e) {
	            session.rollback();
	            throw e;
	        } finally {
	            session.close();
	        }
	    }
}

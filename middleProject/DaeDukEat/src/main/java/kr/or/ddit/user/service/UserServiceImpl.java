package kr.or.ddit.user.service;


import kr.or.ddit.user.dao.IUserDao;
import kr.or.ddit.user.dao.UserDaoImpl;
import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserMemberVO;
import kr.or.ddit.user.vo.UserVO;


public class UserServiceImpl implements IUserService{
    
	private IUserDao userDao;
	private static IUserService userservice = new UserServiceImpl();
	public UserServiceImpl() { 	
    	userDao = UserDaoImpl.getInstance();  	
    }
    public static IUserService getInstance() {
    	return userservice;
    }
	
	//싱글톤 - 자기클래스의 객체는 자기클래스 내부에서 생성한다
	private static IUserService service;
	public static IUserService getService() {
		if (service == null) service = new UserServiceImpl();
			return service;
	}
    
    
    @Override
	public int insertUser(UserVO uv) {
		int cnt = userDao.insertUser(uv);
		return cnt;
	}
	@Override
	public boolean checkUser(String userId) {
		
		return userDao.checkUser(userId);
	}

	@Override
	public int insertMember(MemberVO mv) {
		
		int cnt = userDao.insertMember(mv);
		
		return cnt;
	}
	
	//로그인
	@Override
	public UserVO loginUser(UserVO vo) {
		return userDao.loginUser(vo);
	}
	
	//로그인 아이디 체크
	@Override
	public String idCheck(String id) {
		return userDao.idCheck(id);
	}
	
	@Override
	public UserMemberVO loginUserMember(UserVO vo) {
		return userDao.loginUserMember(vo);	
	}
	
    @Override
    public StoreVO getStoreByUserId(String userId) {
        return userDao.selectStoreByUserId(userId);
    }
    
    @Override
    public MemberVO selectMemberByUserId(String userId) {
        return userDao.selectMemberByUserId(userId);
    }
}

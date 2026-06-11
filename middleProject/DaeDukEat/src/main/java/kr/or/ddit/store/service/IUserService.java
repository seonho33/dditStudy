package kr.or.ddit.store.service;

import kr.or.ddit.user.vo.UserVO;

public interface IUserService {

	public int register(UserVO user);
	
	public UserVO getUserById(String userId);
	
	public int withdrawUser(String userId);
	
	// 추가: 사용자 정보 업데이트
    public int updateUser(UserVO user);
    
    // 추가: 비밀번호 확인
    public boolean checkPassword(String userId, String password);
	
    public int updateOwnerProfile(UserVO user, String ownerEmail);

}

package kr.or.ddit.user.service;

public interface IDeleteMemberService {
 
	public int deleteUsers(String userId);
	
	public boolean withdraw(String userId);

}

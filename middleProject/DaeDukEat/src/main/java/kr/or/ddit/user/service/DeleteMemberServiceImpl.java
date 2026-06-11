package kr.or.ddit.user.service;


import kr.or.ddit.user.dao.DeleteMemberImpl;
import kr.or.ddit.user.dao.IDeleteMember;

public class DeleteMemberServiceImpl implements IDeleteMemberService {

	private IDeleteMember  deleteMem;
	private static IDeleteMemberService delmemservice = new  DeleteMemberServiceImpl();
	public DeleteMemberServiceImpl() {

		deleteMem = DeleteMemberImpl.getInstance();
	}
	public static IDeleteMemberService getInstance() {
	      return delmemservice;
		
	}
	
	
	@Override
	public int deleteUsers(String userId) {
	   int cnt = deleteMem.deleteUsers(userId);
		return cnt;
	}

	@Override
	public boolean withdraw(String userId) {


	    int cnt2 = deleteMem.deleteUsers(userId);  // users 테이블

	    return cnt2 > 0;
	}
}

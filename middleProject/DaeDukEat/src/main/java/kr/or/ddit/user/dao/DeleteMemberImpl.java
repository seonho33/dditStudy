package kr.or.ddit.user.dao;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;



public class DeleteMemberImpl implements IDeleteMember {
     
	private static IDeleteMember deletemem = new DeleteMemberImpl();
	private DeleteMemberImpl() {
		
	}
	public static IDeleteMember getInstance() {
		return deletemem;
	}
	
	@Override
	public int deleteUsers(String userId) {
	 SqlSession session = MyBatisUtil.getSqlSession();
	
	 int cnt = 0;
	 
	 try {
	 cnt = session.delete("member.deleteUser", userId);
		 
       if(cnt > 0) {
    	   session.commit();
       }
	
	 } catch (PersistenceException ex) {
		   ex.printStackTrace();
		   	   
	}finally {
		session.close();
	}
	
		return cnt;
	}


}

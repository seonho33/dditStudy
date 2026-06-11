package kr.or.ddit.user.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;



public interface IUpMemberDao {

    int checkPass(SqlSession session, Map<String, Object> paramMap);
    int updateUser(SqlSession session, UserVO user);
    int updateMem(SqlSession session, MemberVO member);
	
}

package kr.or.ddit.user.dao;

import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;



public class UpMemberDaoImpl implements IUpMemberDao {

    private static IUpMemberDao dao = new UpMemberDaoImpl();
    private UpMemberDaoImpl() {}

    public static IUpMemberDao getInstance() {
        return dao;
    }

    @Override
    public int checkPass(SqlSession session, Map<String, Object> paramMap) {
        return session.selectOne("member.checkPass", paramMap);
    }

    @Override
    public int updateUser(SqlSession session, UserVO user) {
        return session.update("member.updateUser", user);
    }

    @Override
    public int updateMem(SqlSession session, MemberVO member) {
        return session.update("member.updateMem", member);
    }
}
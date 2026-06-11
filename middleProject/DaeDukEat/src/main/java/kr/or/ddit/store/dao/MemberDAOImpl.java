package kr.or.ddit.store.dao;

import org.apache.ibatis.session.SqlSession;
import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.vo.MemberVO;

public class MemberDAOImpl implements IMemberDAO {
    
    private static MemberDAOImpl instance = new MemberDAOImpl();
    
    private MemberDAOImpl() {}
    
    public static MemberDAOImpl getInstance() {
        return instance;
    }
    
    @Override
    public MemberVO selectMemberById(String userId) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        MemberVO member = null;
        
        try {
            member = session.selectOne("member.selectMemberById", userId);
        } finally {
            if(session != null) session.close();
        }
        
        return member;
    }
    
    @Override
    public int updateMember(MemberVO member) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            result = session.update("member.updateMember", member);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
    
    @Override
    public int deactivateMember(String userId, String password) throws Exception {
        SqlSession session = MyBatisUtil.getSqlSession();
        int result = 0;
        
        try {
            // TODO: 비밀번호 확인 후 USE_YN = 'N'
            // Map 사용 또는 별도 VO 사용
            result = session.update("member.deactivateMember", userId);
            if(result > 0) session.commit();
        } catch(Exception e) {
            session.rollback();
            throw e;
        } finally {
            if(session != null) session.close();
        }
        
        return result;
    }
}
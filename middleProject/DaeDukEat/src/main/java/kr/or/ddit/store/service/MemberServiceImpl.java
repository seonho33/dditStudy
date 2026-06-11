package kr.or.ddit.store.service;

import kr.or.ddit.store.dao.IMemberDAO;
import kr.or.ddit.store.dao.MemberDAOImpl;
import kr.or.ddit.store.vo.MemberVO;

public class MemberServiceImpl implements IMemberService {
    
    private static MemberServiceImpl instance = new MemberServiceImpl();
    private IMemberDAO dao = MemberDAOImpl.getInstance();
    
    private MemberServiceImpl() {}
    
    public static MemberServiceImpl getInstance() {
        return instance;
    }
    
    @Override
    public MemberVO getMemberInfo(String userId) throws Exception {
        return dao.selectMemberById(userId);
    }
    
    @Override
    public boolean updateMemberInfo(MemberVO member) throws Exception {
        return dao.updateMember(member) > 0;
    }
    
    @Override
    public boolean withdrawMember(String userId, String password) throws Exception {
        // 비밀번호 확인 후 USE_YN = 'N'
        return dao.deactivateMember(userId, password) > 0;
    }
}
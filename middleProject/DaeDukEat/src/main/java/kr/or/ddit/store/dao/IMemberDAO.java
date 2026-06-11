package kr.or.ddit.store.dao;

import kr.or.ddit.store.vo.MemberVO;

public interface IMemberDAO {
    MemberVO selectMemberById(String userId) throws Exception;
    int updateMember(MemberVO member) throws Exception;
    int deactivateMember(String userId, String password) throws Exception;
}
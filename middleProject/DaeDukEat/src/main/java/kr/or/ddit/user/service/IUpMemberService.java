package kr.or.ddit.user.service;

import java.util.Map;

import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;

public interface IUpMemberService {
    boolean checkPass(Map<String, Object> paramMap);
    boolean updateUser(UserVO user);
    boolean updateMem(MemberVO member);

    // ✅ 추천: 둘을 한 번에 커밋하는 메서드(트랜잭션 1개)
    boolean updateAll(UserVO user, MemberVO member);
}

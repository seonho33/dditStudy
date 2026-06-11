package kr.or.ddit.store.service;

import kr.or.ddit.store.vo.MemberVO;

/**
 * 회원 Service 인터페이스
 * 
 * ※ 이 파일은 톰캣 시작 오류를 해결하기 위한 임시 파일입니다.
 * ※ 실제 프로젝트 구조에 맞게 수정이 필요합니다.
 */
public interface IMemberService {
    MemberVO getMemberInfo(String userId) throws Exception;
    boolean updateMemberInfo(MemberVO member) throws Exception;
    boolean withdrawMember(String userId, String password) throws Exception;
}
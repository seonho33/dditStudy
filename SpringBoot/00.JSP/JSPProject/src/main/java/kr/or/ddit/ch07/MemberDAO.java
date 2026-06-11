package kr.or.ddit.ch07;

import java.util.ArrayList;

public class MemberDAO{
	
	// 회원 정보가 담길 List
	private ArrayList<MemberVO> memberList = new ArrayList<MemberVO>();
	// 싱글톤
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {
		return instance;
	}
	
	// 회원 정보 목록 조회
	// 회원가입 시, 추가된 모든 회원 정보가 들어있습니다.
	// 가입된 모든 회원 정보를 가져오려면 아래 메서드를 활용해주세요.
	public ArrayList<MemberVO> getMemberList() {
		return memberList;
	}

	// 회원 id와 일치하는 회원 정보 조회
	// 사용자 id를 파라미터로 던져주면 id와 일치하는 회원 정보를 전체 회원 목록에서 찾아줍니다.
	// 한명의 회원 정보를 가져오려면 아래 메서드를 활용해주세요.
	public MemberVO getMember(String memId) {
		MemberVO mem = new MemberVO();
		for(int i = 0; i < memberList.size(); i++) {
			MemberVO member = memberList.get(i);
			if(member.getMem_id().equals(memId)) {
				mem = member;
				break;
			}
		}
		return mem;
	}
	
	// 회원 정보 등록
	// 새로운 회원을 추가하고 싶을 때 사용합니다.
	public void insertMember(MemberVO member) {
		memberList.add(member);
	}

}

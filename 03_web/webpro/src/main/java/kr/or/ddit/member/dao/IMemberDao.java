package kr.or.ddit.member.dao;

import java.util.List;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public interface IMemberDao {
	
	
	//설계도, 메소드 선언
	
	/**
	 * 멤버리스트를 리턴하는 메서드
	 * @return memberVO객체를 담은 List
	 */
	public List<MemberVO> memberList();
	
	/**
	 * 로그인을 위한 메서드
	 * @param mv 회원정보중 id와 password를 담고있는 객체
	 * @return mv객체정보와 일치하는 회원정보
	 */
	public MemberVO loginMember(MemberVO mv);
	
	/**
	 * 중복검사를 위한 메서드
	 * @param id 회원정보중 id
	 * @return db에서 일치하는 정보가있으면 String 없으면 null 반환
	 */
	public String checkId(String id);
	
	/**
	 * 회원가입을 위한 메서드
	 * @param mv 회원정보를 담은 mv객체
	 * @return 성공시 1반환 실패시 0반환
	 */
	public int insertMember(MemberVO mv);
	
	/**
	 * 주소검색을 위한 메서드
	 * @param dong 회원이 입력한 동 정보
	 * @return 동 정보가 포함된 ZipVO List
	 */
	public List<ZipVO> dongBySelect(String dong);
}

package kr.or.ddit.member.dao;

import java.util.List;

import kr.or.ddit.member.vo.MemberVO;

/**
 * 실제 DB와 연결하여 SQL문을 수행하여 결과를 가져오기 위한 
 * DAO Interface
 */
public interface IMemberDao {
	
	/**
	 * 회원정보를 등록하기 위한 메서드
	 * @param mv 회원정보를 담은 MemberVO객체
	 * @return 회원등록 성공하면 1, 실패하면 0 반환됨.
	 */
	public int insertMember(MemberVO mv);

	/**
	 * 회원정보를 수정하기 위한 메서드
	 * @param mv 회원정보를 담은 MemberVO객체
	 * @return 회원정보수정 성공하면 1, 실패하면 0 반환됨.
	 */
	public int updateMember(MemberVO mv);
	
	/**
	 * 회원정보 존재여부를 체크하기 위한 메서드
	 * @param memId 존재여부 체크를 위한 회원ID
	 * @return 회원정보가 존재하면 true, 존재하지 않으면 false 반환함.
	 */
	public boolean checkMember(String memId);
	
	/**
	 * 회원 상세정보를 가져오기 위한 메서드
	 * @param memId 회원ID
	 * @return 상세정보를 담은 MemberVO객체
	 */
	public MemberVO getMember(String memId);
	
	/**
	 * 회원정보를 삭제하기 위한 메서드
	 * @param memId 회원정보를 삭제할 회원ID
	 * @return 회원정보 삭제 성공하면 1, 실패하면 0 반환됨.
	 */
	public int deleteMember(String memId);
	
	/**
	 * DB에 존재하는 모든 회원정보를 조회하기 위한 메서드
	 * @return 모든 회원정보를 담은 List객체 반환됨.
	 */
	public List<MemberVO> getAllMember();
	
	/**
	 * 검색 조건에 해당하는 회원정보를 검색하기 위한 메서드
	 * @param mv 검색조건을 담은 MemberVO객체
	 * @return 검색된 회원정보를 담은 List객체
	 */
	public List<MemberVO> searchMember(MemberVO mv);
}

package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImplForMyBatis;
import kr.or.ddit.member.vo.MemberVO;

public class MemberServiceImpl implements IMemberService {
	
	private IMemberDao memDao;
	private static IMemberService memService = new MemberServiceImpl();

	private MemberServiceImpl() {
		//memDao = MemberDaoImplForJDBC.getInstance();
		memDao = MemberDaoImplForMyBatis.getInstance();
	}

	public static IMemberService getInstance(){
		return memService;
	}
	
	@Override
	public int registerMember(MemberVO mv) {
		return memDao.insertMember(mv);	//DB에 회원정보 등록
		
		//회원가입 완료 메일 발송 호출
		//회원가입 환영 메시지 전송..
	}

	@Override
	public int modifyMember(MemberVO mv) {
		
		return memDao.updateMember(mv);
	}

	@Override
	public boolean checkMember(String memId) {
		return memDao.checkMember(memId);
	}

	@Override
	public int removeMember(String memId) {
		return memDao.deletMember(memId);
	}

	@Override
	public List<MemberVO> displayAllMember(){
		return memDao.getAllMember();
	}

	@Override
	public List<MemberVO> searchMember(MemberVO mv) {
		return memDao.searchMember(mv);
	}
}
package kr.or.ddit.member.service;


import java.util.List;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public class MemberServiceImpl implements IMemberService {

	private static IMemberService memberService;
	private IMemberDao memberDao;
	
	private MemberServiceImpl() {
		memberDao = MemberDaoImpl.getInstance();
	}
	
	public static IMemberService getInstance() {
		if(memberService==null) {
			memberService = new MemberServiceImpl();
		}
		return memberService;
	}

	@Override
	public List<MemberVO> memberList() {
		/*
		  List<MemberVO> list = null;
		  list = memberDao.memberList();
		  return list;
		 */
		
		return memberDao.memberList();
	}

	@Override
	public MemberVO loginMember(MemberVO mv) {
		
		/*
		  MemberVO mvo = null;
		  mvo = memberDao.loginMember(mv);
		  return mvo;
		 */
		
		return memberDao.loginMember(mv);
	}

	@Override
	public String checkId(String id) {
		/*
		boolean idcheck = false;
		checkId = 
		*/
		return memberDao.checkId(id);
	}

	@Override
	public int insertMember(MemberVO mv) {
		return memberDao.insertMember(mv);
	}

	@Override
	public List<ZipVO> dongBySelect(String dong) {
		return memberDao.dongBySelect(dong);
	}
}
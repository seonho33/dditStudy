package kr.or.ddit.testMember.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.testMember.mapper.ITTestMapper;
import kr.or.ddit.vo.crud.CrudMember;
import kr.or.ddit.vo.crud.CrudMemberAuth;

@Service
public class TTestMemberServiceImpl implements ITTestMemberService {

	
	@Autowired
	private ITTestMapper mapper;

	@Override
	public void register(CrudMember member) {

		mapper.register(member);
		
		CrudMemberAuth memberAuth = new CrudMemberAuth();
		
		memberAuth.setUserNo(member.getUserNo());
		memberAuth.setAuth("USER");
		
		
		mapper.create(memberAuth);
	}

	@Override
	public List<CrudMember> getList() {
		
		return mapper.getList();
		
	}

	@Override
	public CrudMember read(int userId) {
		
		return mapper.read(userId);
	}
	
	
}

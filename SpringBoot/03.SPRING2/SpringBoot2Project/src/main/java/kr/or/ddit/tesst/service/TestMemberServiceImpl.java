package kr.or.ddit.tesst.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.tesst.mapper.ITestMemberMapper;
import kr.or.ddit.vo.crud.CrudMember;
import kr.or.ddit.vo.crud.CrudMemberAuth;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class TestMemberServiceImpl implements ITestMemberService {

	@Autowired
	private ITestMemberMapper mapper;
	
	@Override
	public void register(CrudMember member) {
		mapper.register(member);
		
		CrudMemberAuth memberAuth = new CrudMemberAuth();
		memberAuth.setUserNo(member.getUserNo());
		memberAuth.setAuth("ROLE_USER");
		
		mapper.create(memberAuth);
	}

	@Override
	public List<CrudMember> getList() {
		return mapper.getList();
	}

	@Override
	public CrudMember getMember(int userNo) {
		
		
		return mapper.getMember(userNo);
	}

	@Override
	public void updateMember(CrudMember member) {
		
		List<CrudMemberAuth> memberAuthList = member.getAuthList();
		
		int userNo = member.getUserNo();
		
		mapper.updateDate(member);
		mapper.deleteAuth(userNo);
	
		for(CrudMemberAuth memberAuth : memberAuthList) {
			
			String auth = memberAuth.getAuth();
			
			if(auth != null && auth.trim().length() != 0 ) {
				memberAuth.setUserNo(userNo);
				mapper.create(memberAuth);
			};
			
		};
	}

	@Override
	public void deleteMember(int userNo) {
		
		mapper.deleteAuth(userNo);
		mapper.deleteMember(userNo);
		
	}
	
	
	
}

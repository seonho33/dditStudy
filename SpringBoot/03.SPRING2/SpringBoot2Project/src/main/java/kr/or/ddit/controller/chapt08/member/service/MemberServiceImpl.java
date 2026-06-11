package kr.or.ddit.controller.chapt08.member.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.controller.chapt08.member.mapper.IMemberMapper;
import kr.or.ddit.vo.crud.CrudMember;
import kr.or.ddit.vo.crud.CrudMemberAuth;

@Service
public class MemberServiceImpl implements IMemberService {
	
	@Autowired
	private IMemberMapper mapper;
	
	//@Transactional
	@Transactional(rollbackFor = {IOException.class, SQLException.class})
	@Override
	public void register(CrudMember member) throws IOException {
		
		//member 테이블에 회원정보를 등록
		mapper.create(member);
		
		//에러 발생
		//10 장 트랜잭션 처리를 위한 테스트
//		if(true) {
//			throw new IOException();
//		}
		
		//Member_Auth 테이블에 회원이 가지고있는 권한을 등록(최초 권한:ROLE_USER)
		CrudMemberAuth memberAuth = new CrudMemberAuth();
		memberAuth.setUserNo(member.getUserNo());
		memberAuth.setAuth("ROLE_USER");
		mapper.createAuth(memberAuth);
	}

	@Override
	public List<CrudMember> list() {
		return mapper.list();
	}

	@Override
	public CrudMember read(int userNo) {
		return mapper.read(userNo);
	}

	@Override
	public void modify(CrudMember member) {
		// 회원정보를 수정하기 위한 process
		// 1. 일반적인 회원(member) 정보 수정 - pw, name
		mapper.modify(member);
		
		// 2. 회원 권한을 수정
		// 기존에 등록되어있던 권한들을 모두 삭제 후, 새롭게 수정된 권한으로 데이터를 삽입하는 방식 
		int userNo = member.getUserNo();
		mapper.deleteAuth(userNo);
		
		List<CrudMemberAuth> authList = member.getAuthList();
		
		for(int i=0;i<authList.size();i++) {
			CrudMemberAuth memberAuth = authList.get(i);
			String auth = memberAuth.getAuth();
			if(auth==null||auth.trim().length() == 0) {
				continue;
			}
			memberAuth.setUserNo(userNo);
			mapper.createAuth(memberAuth);
		}
	}

	@Override
	public void delete(int userNo) {
		// 1:N 관계성으로 연결된 Member(부모)와 Member_Auth(자식) 테이블은
		// 삭제시, 자식 테이블의 데이터가 먼저 전부 지워진 후 부모 테이블의 데이터를 지울 수 있다.
		mapper.deleteAuth(userNo);
		mapper.delete(userNo);
	}
}
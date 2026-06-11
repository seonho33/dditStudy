package kr.or.ddit.testMember.service;

import java.util.List;

import kr.or.ddit.vo.crud.CrudMember;

public interface ITTestMemberService {

	void register(CrudMember member);

	List<CrudMember> getList();

	CrudMember read(int userId);

}

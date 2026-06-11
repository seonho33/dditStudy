package kr.or.ddit.tesst.service;

import java.util.List;

import kr.or.ddit.vo.crud.CrudMember;

public interface ITestMemberService {

	void register(CrudMember member);

	List<CrudMember> getList();

	CrudMember getMember(int userNo);

	void updateMember(CrudMember member);

	void deleteMember(int userNo);
}

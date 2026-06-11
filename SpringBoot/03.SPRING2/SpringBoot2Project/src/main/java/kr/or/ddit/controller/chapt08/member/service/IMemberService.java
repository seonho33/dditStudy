package kr.or.ddit.controller.chapt08.member.service;

import java.io.IOException;
import java.util.List;

import kr.or.ddit.vo.crud.CrudMember;

public interface IMemberService {

	void register(CrudMember member) throws IOException;

	List<CrudMember> list();

	CrudMember read(int userNo);

	void modify(CrudMember member);

	void delete(int userNo);

}

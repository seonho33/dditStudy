package kr.or.ddit.controller.chapt08.member.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.crud.CrudMember;
import kr.or.ddit.vo.crud.CrudMemberAuth;

@Mapper
public interface IMemberMapper {

	void create(CrudMember member);

	void createAuth(CrudMemberAuth memberAuth);

	List<CrudMember> list();

	CrudMember read(int userNo);

	void modify(CrudMember member);

	void deleteAuth(int userNo);

	void delete(int userNo);

}

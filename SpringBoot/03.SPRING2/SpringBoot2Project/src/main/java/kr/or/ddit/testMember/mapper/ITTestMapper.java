package kr.or.ddit.testMember.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.crud.CrudMember;
import kr.or.ddit.vo.crud.CrudMemberAuth;

@Mapper
public interface ITTestMapper {

	void register(CrudMember member);

	List<CrudMember> getList();

	void create(CrudMemberAuth memberAuth);

	CrudMember read(int userId);

}

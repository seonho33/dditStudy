package kr.or.ddit.tesst.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.crud.CrudMember;
import kr.or.ddit.vo.crud.CrudMemberAuth;

@Mapper
public interface ITestMemberMapper {

	void register(CrudMember member);

	void create(CrudMemberAuth memberAuth);

	List<CrudMember> getList();

	CrudMember getMember(int userNo);


	void deleteAuth(int userNo);

	void updateDate(CrudMember member);

	void deleteMember(int userNo);

}

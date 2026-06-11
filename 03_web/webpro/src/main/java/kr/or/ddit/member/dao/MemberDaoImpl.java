package kr.or.ddit.member.dao;

import java.util.List;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import config.MyBatisUtil;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public class MemberDaoImpl implements IMemberDao{
	
	private static IMemberDao memberDao;
	private MemberDaoImpl() {
	}

	public static IMemberDao getInstance() {
		if(memberDao == null) memberDao = new MemberDaoImpl();
		return memberDao;
	}
	
	public List<MemberVO> memberList() {
		//sqlSession 필요
		SqlSession sql = MyBatisUtil.getSqlSession();
		//결과값을 저장하고 리턴할 객체를 선언
		List<MemberVO> list = null;
		
		try {
			//mapper의 namespace이름.sql문장의 id이름..
			//mapper 수행하는 SqlSession 객체..sql의 메서드로 db접근
			list = sql.selectList("member.memberList");
		} catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
		}
		
		return list;
	}

	@Override
	public MemberVO loginMember(MemberVO mv) {
		
		SqlSession sql = MyBatisUtil.getSqlSession();
		MemberVO membervo = null;
		
		try {
			membervo = sql.selectOne("member.loginMember",mv);
			
			if(membervo !=null) sql.commit();
		}catch(Exception ex){
			ex.printStackTrace();
		}finally {
			sql.close();
		}
		
		return membervo;
	}
/*
	@Override
	public boolean checkId(String id) {
		boolean isExist = false;
		SqlSession sql = MyBatisUtil.getSqlSession();
		String check = null;
		
		try {
			check = sql.selectOne("member.checkId",id);
			if(check!=null) isExist=true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			sql.close();
		}
		
		return isExist;
	}
*/
	
	@Override
	public int insertMember(MemberVO mv) {
		int result =0;
		SqlSession sql = MyBatisUtil.getSqlSession();
		
		try {
			result = sql.insert("member.insertMember", mv);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
		}
		
		return result;
	}

	@Override
	public String checkId(String id) {
		String result =null;
		SqlSession sql = MyBatisUtil.getSqlSession();
		
		try {
			result = sql.selectOne("member.checkId", id);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.commit();
			sql.close();
		}
		
		return result;
	}

	@Override
	public List<ZipVO> dongBySelect(String dong) {
		SqlSession sql = MyBatisUtil.getSqlSession();
		List<ZipVO> dongList = null;
		
		try {
			dongList = sql.selectList("member.dongBySelect", dong);
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			sql.close();
		}
		
		return dongList;
	}
}

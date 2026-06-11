package kr.or.ddit.user.dao;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;

public class MyMemberDaoImpl implements IMyMemberDao {

    private static IMyMemberDao mymemdao = new MyMemberDaoImpl();
    
    private MyMemberDaoImpl() { }
    
    public static IMyMemberDao getInstance() {
        return mymemdao;
    }

    @Override
    public UserVO SelectUser(String userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        UserVO userVO = null;
        try {
            userVO = session.selectOne("member.SelectUser", userId);
        } catch (PersistenceException ex) {
            ex.printStackTrace();
        } finally {
            session.close();
        }
        return userVO;
    }

    @Override
    public MemberVO SelectMember(String userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        MemberVO memberVO = null;
        try {
            memberVO = session.selectOne("member.SelectMember", userId);
        } catch (PersistenceException ex) {
            ex.printStackTrace();
        } finally {
            session.close();
        }
        return memberVO;
    }

    // --- 새로 추가된 쿠폰 개수 조회 ---
    @Override
    public int getCouponCount(String userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        int count = 0;
        try {
            count = session.selectOne("member.getCouponCount", userId);
        } catch (PersistenceException ex) {
            ex.printStackTrace();
        } finally {
            session.close();
        }
        return count;
    }

    // --- 새로 추가된 리뷰 개수 조회 ---
    @Override
    public int getReviewCount(String userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        int count = 0;
        try {
            count = session.selectOne("member.getReviewCount", userId);
        } catch (PersistenceException ex) {
            ex.printStackTrace();
        } finally {
            session.close();
        }
        return count;
    }
}
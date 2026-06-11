package kr.or.ddit.user.service;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.user.dao.IUpMemberDao;
import kr.or.ddit.user.dao.UpMemberDaoImpl;
import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;

public class UpMemberServiceImpl implements IUpMemberService {

    private static IUpMemberService service = new UpMemberServiceImpl();
    private final IUpMemberDao dao = UpMemberDaoImpl.getInstance();

    private UpMemberServiceImpl() {}

    public static IUpMemberService getInstance() {
        return service;
    }

    @Override
    public boolean checkPass(Map<String, Object> paramMap) {
        try (SqlSession session = MyBatisUtil.getSqlSession()) {
            int cnt = dao.checkPass(session, paramMap);
            return cnt > 0;
        }
    }

    @Override
    public boolean updateUser(UserVO user) {
        // 단독 호출용 (가능하면 updateAll 쓰는 걸 추천)
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int cnt = dao.updateUser(session, user);
            session.commit();
            return cnt > 0;
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public boolean updateMem(MemberVO member) {
        // 단독 호출용 (가능하면 updateAll 쓰는 걸 추천)
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int cnt = dao.updateMem(session, member);
            session.commit();
            return cnt > 0;
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

    @Override
    public boolean updateAll(UserVO user, MemberVO member) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            int a = dao.updateUser(session, user);
            int b = dao.updateMem(session, member);

            if (a > 0 && b > 0) {
                session.commit();
                return true;
            } else {
                session.rollback();
                return false;
            }
        } catch (Exception e) {
            session.rollback();
            throw e;
        } finally {
            session.close();
        }
    }
}

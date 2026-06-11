package kr.or.ddit.user.service;

import kr.or.ddit.user.dao.IMyMemberDao;
import kr.or.ddit.user.dao.MyMemberDaoImpl;
import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;

public class MyMemberServiceImpl implements IMyMemberService {

    private IMyMemberDao memdao; // 변수명을 memdao로 유지합니다.
    private static IMyMemberService mymemservice = new MyMemberServiceImpl();
    
    // 생성자에서 DAO 인스턴스를 가져옵니다.
    private MyMemberServiceImpl() {
        memdao = MyMemberDaoImpl.getInstance();
    }
    
    public static IMyMemberService getInstance() {
        return mymemservice;
    }
    
    @Override
    public UserVO SelectUser(String userId) {
        return memdao.SelectUser(userId);
    }

    @Override
    public MemberVO SelectMember(String userId) {
        // 기존 dao -> memdao로 수정
        return memdao.SelectMember(userId);
    }
    
    @Override
    public int getCouponCount(String userId) {
        // 기존 dao -> memdao로 수정
        return memdao.getCouponCount(userId);
    }

    @Override
    public int getReviewCount(String userId) {
        // 기존 dao -> memdao로 수정
        return memdao.getReviewCount(userId);
    }
}
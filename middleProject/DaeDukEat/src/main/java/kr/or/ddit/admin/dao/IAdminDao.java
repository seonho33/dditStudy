package kr.or.ddit.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.admin.vo.AdminUserBanVO;
import kr.or.ddit.admin.vo.BotVO;
import kr.or.ddit.admin.vo.OwnerApplyVO;
import kr.or.ddit.board.vo.NoticeVO;
import kr.or.ddit.board.vo.QnaVO;
import kr.or.ddit.user.vo.BlackListVO;


public interface IAdminDao {
	public List<AdminUserBanVO> AdminBanlList(SqlSession sql);
	
	public int insertBanUser(SqlSession session, BlackListVO blvo);
	
	public int updateBan(SqlSession session, Map<String, Object> bmap);

	public List<OwnerApplyVO> ownerApplyList(SqlSession session);

	public int updateStoreStatus(SqlSession session, Map<String, Object> map);

	public List<NoticeVO> getNoticeList();
	
	public List<QnaVO> getUnansweredQnaList();
	
    public int insertNotice(Map<String, Object> param);
    
    public int deleteNotice(Map<String, Object> param);

    public int updateNotice(NoticeVO vo);

    public int updateQnaAnswer(Map<String, Object> param);

	public List<BotVO> selectBotList();

	public AdminUserBanVO selectBanInfo(String userId);

}

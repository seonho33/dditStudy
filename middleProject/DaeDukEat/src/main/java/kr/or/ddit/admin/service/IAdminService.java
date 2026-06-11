package kr.or.ddit.admin.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import kr.or.ddit.admin.vo.AdminUserBanVO;
import kr.or.ddit.admin.vo.BotVO;
import kr.or.ddit.admin.vo.OwnerApplyVO;
import kr.or.ddit.board.vo.NoticeVO;
import kr.or.ddit.board.vo.QnaVO;

public interface IAdminService {

	public List<AdminUserBanVO> AdminBanlList();
	
    public boolean banUser(String userId, String reason, LocalDate endDate);

    public boolean unbanUser(String userId);

    public List<OwnerApplyVO> ownerApplyList();
    
    boolean updateOwnerStatus(Map<String, Object> map);
    
    public List<NoticeVO> getNoticeList();
    
    public List<QnaVO> getUnansweredQnaList();
    
    public int insertNotice(Map<String, Object> param);
    
    public int deleteNotice(Map<String, Object> param);

    public int updateNotice(NoticeVO vo);
    
    public int updateQnaAnswer(Map<String, Object> param);

	public List<BotVO> selectBotList();

	public AdminUserBanVO selectBanInfo(String userId);

	
}

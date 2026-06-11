package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
import kr.or.ddit.ServiceResult;
import kr.or.ddit.service.INoticeService;
import kr.or.ddit.vo.NoticeCommentVO;
import kr.or.ddit.vo.NoticeMemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeCommentController {
	
	@Autowired
	private INoticeService noticeService;
	
	// 댓글 작성
	@PostMapping("/insertCmt.do")
	public ResponseEntity<String> noticeInsertComment(
			@RequestBody NoticeCommentVO noticeCommentVO, HttpSession session){
		NoticeMemberVO memberVO = (NoticeMemberVO) session.getAttribute("SessionInfo");
		noticeCommentVO.setCmtWriter(memberVO.getMemId());
		
		ServiceResult result = noticeService.noticeInsertComment(noticeCommentVO);
		return new ResponseEntity<String>(result.toString(), HttpStatus.OK);
	}
	
	//댓글 목록 가져오기
	@PostMapping("/commentList.do")
	public ResponseEntity<List<NoticeCommentVO>> commentList(
			@RequestBody Map<String, Integer> param ){
		List<NoticeCommentVO> commentList = noticeService.selectNoticeCommentList(param.get("boNo"));
		
		return new ResponseEntity<List<NoticeCommentVO>>(commentList,HttpStatus.OK);
	}
	
	// 댓글 작성
	@PostMapping("/insertSubCmt.do")
	public ResponseEntity<String> noticeInsertSubCmt(
			@RequestBody NoticeCommentVO noticeCommentVO, HttpSession session){
		NoticeMemberVO memberVO = (NoticeMemberVO) session.getAttribute("SessionInfo");
		noticeCommentVO.setCmtWriter(memberVO.getMemId());
		
		ServiceResult result = noticeService.noticeInsertSubComment(noticeCommentVO);
		return new ResponseEntity<String>(result.toString(), HttpStatus.OK);
	}
	
	// 댓글 수정
	@PostMapping("/updateSubCmt.do")
	public ResponseEntity<String> noticeUpdateComment(
			@RequestBody NoticeCommentVO noticeCommentVO, HttpSession session){
		ServiceResult result = noticeService.noticeUpdateComment(noticeCommentVO);
		return new ResponseEntity<String>(result.toString(), HttpStatus.OK);
	}
	
	// 댓글 수정
	@PostMapping("/deleteCmt.do")
	public ResponseEntity<String> noticeDeleteComment(
			@RequestBody Map<String, Integer>param){
		log.info("체킁 : ", param);
		int cmtNo = param.get("cmtNo");
		ServiceResult result = noticeService.noticeDeleteComment(cmtNo);
		return new ResponseEntity<String>(result.toString(), HttpStatus.OK);
	}
}

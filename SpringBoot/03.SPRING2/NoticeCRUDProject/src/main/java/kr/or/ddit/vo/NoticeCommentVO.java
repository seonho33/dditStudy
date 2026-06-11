package kr.or.ddit.vo;

import lombok.Data;

@Data
public class NoticeCommentVO {
	 private int cmtNo;				//댓글 번호
	 private int boNo;				//게시 글번호
	 private String cmtWriter;		//댓글 작성자
	 private String cmtContent;		//댓글 내용
	 private int cmtGroup;			//댓글 그룹번호
	 private int cmtOrd;			//댓글 순서
	 private int cmtDepth;			//댓글 깊이
	 private String cmtDate;		//댓글 작성일
	 private String cmtStatus;		//댓글 상태
	 
	 private String memProfileimg;	//작성자 프로필 이미지 설정
}

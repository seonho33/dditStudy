package kr.or.ddit.board.vo;

import java.time.LocalDate;

public class BoardVO {
	/*
	필요한 정보
	번호?
	제목 TITLE, 작성자 WRITER_ID, 작성날짜CREATED_DATE, 내용CONTENTS
	*/
	
	private String title;	//제목
	private String writer;	//작성자
	private String content;	//내용
	
	private int boardNo;	//보드번호(기본키)시퀸스로 자동증가?
	private LocalDate boardDate;	//등록일
	
	public BoardVO(String title, String writer, String content) {
		super();
		this.title = title;
		this.writer = writer;
		this.content = content;
	}
	
	public BoardVO() {
		
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	@Override
	public String toString() {
		return "BoardVO [title=" + title + ", writer=" + writer + ", content=" + content + ", date=" + boardDate + "]";
	}

	public LocalDate getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(LocalDate boardDate) {
		this.boardDate = boardDate;
	}
}
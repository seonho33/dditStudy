package kr.or.ddit.ch17.vo;

public class BoardVO{
	private int no = 0;			// 게시글 번호
	private String title;		// 게시글 제목
	private String content;		// 게시글 내용
	private String writer;		// 게시글 작성자
	private String regDate;		// 게시글 작성일
	private int hit = 0;		// 게시글 조회수
	private BoardFileVO fileVO;	// 게시글 파일객체
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public BoardFileVO getFileVO() {
		return fileVO;
	}
	public void setFileVO(BoardFileVO fileVO) {
		this.fileVO = fileVO;
	}
	
}

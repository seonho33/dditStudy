package kr.or.ddit.index;

import java.util.List;

public class IndexVO {
	private String chapter;				// JSP 챕터
	private String title;				// JSP 챕터 타이틀
	private String chapterMoveUrl;		// JSP 챕터 이동 기본 URL
	private List<String> sourceList;	// JSP 챕터별 소스 목록

	public String getChapter() {
		return chapter;
	}
	public void setChapter(String chapter) {
		this.chapter = chapter;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getChaterMoveUrl() {
		return chapterMoveUrl;
	}
	public void setChapterMoveUrl(String chapterMoveUrl) {
		this.chapterMoveUrl = chapterMoveUrl;
	}
	public List<String> getSourceList() {
		return sourceList;
	}
	public void setSourceList(List<String> sourceList) {
		this.sourceList = sourceList;
	}
	
}

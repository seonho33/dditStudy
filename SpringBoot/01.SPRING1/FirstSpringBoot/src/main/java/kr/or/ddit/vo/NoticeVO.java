package kr.or.ddit.vo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
public class NoticeVO {
	private int 	noticeNo;
	private String 	noticeTitle;
	private String 	noticeContent;
	private String 	noticeWriter;
	private String 	noticeDate;
	private int 	noticeHit;
}

package kr.or.ddit.vo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// @data 는 getter, setter, toString 을 대체하는데 따로 핸들링을 못한다...
// 각각 어노테이션으로 지정해주면 별도로 핸들링이 가능하다
@Data
@Getter
@Setter
@ToString
public class BoardVO {
	private int 	boNo;			//일반 게시판 번호
	private String 	boTitle;		//일반 게시판 제목
	private String 	boContent;		//일반 게시판 내용
	private String 	boWriter;		//일반 게시판 작성자
	private String 	boDate;			//일반 게시판 작성일
	private int 	boHit;			//일반 게시판 조회수
                                                                                 	
}

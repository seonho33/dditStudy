package kr.or.ddit.vo.test;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@ToString
@Setter
public class TestSearchDTO {
	private String searchWord;
	private String searchType;
}
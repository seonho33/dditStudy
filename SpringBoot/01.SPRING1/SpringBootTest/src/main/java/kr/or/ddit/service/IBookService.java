package kr.or.ddit.service;

import java.util.Map;

public interface IBookService {
	public String insertBook(Map<String, Object> param);
	public Map<String, Object> selectBook(int bookId);
}

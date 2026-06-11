package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

public interface IBookService {
	
	public String insertBook(Map<String, Object> param);

	public Map<String, Object> selectBook(int bookId);

	public boolean updateBook(Map<String, Object> map);

	public boolean removeBook(Map<String, Object> map);

	public List<Map<String, Object>> selectBookList(Map<String, Object> map);

}

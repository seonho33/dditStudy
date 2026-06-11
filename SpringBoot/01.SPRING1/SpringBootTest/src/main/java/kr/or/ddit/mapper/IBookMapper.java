package kr.or.ddit.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IBookMapper {
	public int insert(Map<String, Object> param);
	public Map<String, Object> selectBook(int bookId);
}

package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IBookMapper {

	int insert(Map<String, Object> param);

	Map<String, Object> selectBook(int bookId);

	int update(Map<String, Object> map);

	int remove(Map<String, Object> map);

	List<Map<String, Object>> selectBookList(Map<String, Object> map);

}

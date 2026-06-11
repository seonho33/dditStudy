package kr.or.ddit.controller.chapt09.item02.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.Item2;

@Mapper
public interface IItem2Mapper {

	void create(Item2 item);
	void addAttach(String fileName);
	List<Item2> list();
	Item2 read(int itemId);
	List<String> getAttach(int itemId);
	
	void modify(Item2 item);
	void deleteAttach(int itemId);
	void replaceAttach(@Param("fileName") String fileName,@Param("itemId") int itemId);


}

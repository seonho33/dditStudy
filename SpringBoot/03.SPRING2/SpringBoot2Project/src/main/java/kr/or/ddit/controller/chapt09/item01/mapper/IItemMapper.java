package kr.or.ddit.controller.chapt09.item01.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.Item;

@Mapper
public interface IItemMapper {

	void register(Item item);

	List<Item> list();

	Item read(int itemId);
	
	String getPicture(int itemId);

	void modify(Item item);

	void remove(int itemId);
	
}
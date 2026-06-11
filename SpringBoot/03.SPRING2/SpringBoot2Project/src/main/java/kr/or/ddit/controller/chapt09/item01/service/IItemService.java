package kr.or.ddit.controller.chapt09.item01.service;

import java.util.List;

import kr.or.ddit.vo.Item;

public interface IItemService {

	void register(Item item);

	List<Item> list();

	Item read(int itemId);

	String getPicture(int itemId);

	void modify(Item item);

	void remove(int itemId);

}

package kr.or.ddit.controller.chapt09.item02.service;

import java.util.List;


import kr.or.ddit.vo.Item2;

public interface IItem2Service {

	void register(Item2 item);

	List<Item2> list();

	Item2 read(int itemId);

	List<String> getAttach(int itemId);

	void modify(Item2 item);

}
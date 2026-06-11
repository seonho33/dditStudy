package kr.or.ddit.controller.chapt09.item02.service;

import java.util.List;

import org.jspecify.annotations.Nullable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.controller.chapt09.item02.mapper.IItem2Mapper;
import kr.or.ddit.vo.Item2;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class Item2ServiceImpl implements IItem2Service {

	@Autowired
	private IItem2Mapper mapper;

	@Override
	public void register(Item2 item) {
		// Item 테이블에 데이터를 등록
		mapper.create(item);
		
		// 전달받은 파일 목록을 이용한 Item_Attach 테이블에 데이터를 등록
		String[] files = item.getFiles();
		
		if(files == null) {
			return;
		}
		
		for(String fileName : files) {
			mapper.addAttach(fileName);
		}
		
	}

	@Override
	public List<Item2> list() {
		
		return mapper.list();
	}

	@Override
	public Item2 read(int itemId) {
		return mapper.read(itemId);
	}

	@Override
	public @Nullable List<String> getAttach(int itemId) {
		return mapper.getAttach(itemId);
	}

	@Override
	public void modify(Item2 item) {

		mapper.modify(item);
		
		int itemId = item.getItemId();
		mapper.deleteAttach(itemId);
		
		String[] files = item.getFiles();
		if(files == null) {
			return;
		}
		
		for(String fileName : files ) {
			mapper.replaceAttach(fileName, itemId);
		}
	}
}

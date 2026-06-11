package kr.or.ddit.admin.dao;

import java.util.List;

import kr.or.ddit.store.vo.StoreVO;

public interface IRouletteDao {

	 //가게목록
	 List<StoreVO>getstoreRoulette();
	 
	 //카테고리
	 List<StoreVO>getstoreCategory(String category);
	 	 
	 //평점
	 List<StoreVO>getstoreRating(int Rating);
}

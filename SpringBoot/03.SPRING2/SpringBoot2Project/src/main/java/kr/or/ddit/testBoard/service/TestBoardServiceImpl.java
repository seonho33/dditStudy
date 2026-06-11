package kr.or.ddit.testBoard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.testBoard.mapper.ITestBoardMapper;
import kr.or.ddit.vo.crud.Board;

@Service
public class TestBoardServiceImpl implements ITestBoardService {

	@Autowired
	private ITestBoardMapper mapper;

	@Override
	public void registerBoard(Board board) {
		mapper.registerBoard(board);
	}

	@Override
	public List<Board> getList() {
		return mapper.getList();
	}
}

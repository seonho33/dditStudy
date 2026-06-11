package kr.or.ddit.board.web;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Controller
@RequestMapping("/board")
public class BoardRetrieveController {

	@Autowired
	private IBoardService boardService;
	
	//일반 게시판 목록 요청
	@RequestMapping("/list.do")
	public String boardList(
			@RequestParam(name = "page", required = false, defaultValue="1") int currentPage, 
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false)String searchWord,Model model
			){
		PaginationInfoVO<BoardVO> pagingVO = new PaginationInfoVO<>();
		
		//브라우저에서 검색한 검색 유형, 검색 키워드를 이용하여 검색 처리
		//검색 키워드가 있으면 검색을 한거고, 키워드가 없으면 검색을 하지 않음
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType",searchType);
			model.addAttribute("searchWord",searchWord);
		}
		
		
		// startRow,endRow,startPage,endPage를 결정
		pagingVO.setCurrentPage(currentPage);
		// 목록 중 게시글 수 가져오기(totalRecord)
		int totalRecord = boardService.selectBoardCount(pagingVO);
		// totalPage 를 결정
		pagingVO.setTotalRecord(totalRecord);
		List<BoardVO> dataList = boardService.selectBoardList(pagingVO);
		
		List<BoardVO> boardList = boardService.selectBoardVOList();
		
		// 1페이지에 해당하는 screenSize 갯수만큼의 게시글이 목록으로 저장
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO",pagingVO);
		return "board/list";
	}
	
	//일반게시판 상세보기
	@GetMapping({"/detail.do"})
	public String boardDetail(int boNo, Model model){
		
		BoardVO boardVO = boardService.selectBoard(boNo);
		
		model.addAttribute("board",boardVO);
		
		return "board/view";
	}
}
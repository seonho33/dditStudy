package kr.or.ddit.main.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.free.service.IFreeService;
import kr.or.ddit.notice.service.INoticeService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.FreeVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Controller
public class MainController {

	@Autowired
	private IFreeService freeService;
	@Autowired
	private INoticeService noticeService;
	@Autowired
	private IBoardService boardService;
	
	
	//메인 화면 요청
	@GetMapping({"/","/main.do"})
	public String main(
			@RequestParam(required = false, defaultValue="1", name="boardPage") int boardCurrentPage,
			@RequestParam(required = false, defaultValue="1", name="freePage") int freeCurrentPage,
			@RequestParam(required = false, defaultValue="1", name="noticePage") int noticeCurrentPage,
			Model model) {
		
	PaginationInfoVO<FreeVO> freePaging = new PaginationInfoVO<>(5);
	PaginationInfoVO<NoticeVO> noticePaging = new PaginationInfoVO<>(5);
	PaginationInfoVO<BoardVO> boardPaging = new PaginationInfoVO<>(5);
	
	freePaging.setCurrentPage(freeCurrentPage);
	noticePaging.setCurrentPage(noticeCurrentPage);
	boardPaging.setCurrentPage(boardCurrentPage);
	
	int freeTotalRecord		= freeService.selectFreeBoardCount(freePaging);
	int noticeTotalRecord	= noticeService.selectNoticeCount(noticePaging);
	int boardTotalRecord	= boardService.selectBoardCount(boardPaging);
	
	freePaging.setTotalRecord(freeTotalRecord);
	noticePaging.setTotalRecord(noticeTotalRecord);
	boardPaging.setTotalRecord(boardTotalRecord);
	
	List<FreeVO> freeList = freeService.selectFreeBoardList(freePaging);
	List<NoticeVO> noticeList = noticeService.selectNoticeList(noticePaging);
	List<BoardVO> boardList = boardService.selectBoardList(boardPaging);
	
	freePaging.setDataList(freeList);
	noticePaging.setDataList(noticeList);
	boardPaging.setDataList(boardList);
	
	model.addAttribute("freePagingVO",freePaging);
	model.addAttribute("noticePagingVO",noticePaging);
	model.addAttribute("boardPagingVO",boardPaging);
	
		return "main";
	}
}
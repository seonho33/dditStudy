package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import io.micrometer.common.util.StringUtils;
import kr.or.ddit.service.INoticeService;
import kr.or.ddit.service.NoticeServiceImpl;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeRetrieveController {

    private final NoticeServiceImpl noticeServiceImpl;

	
	@Autowired
	private INoticeService noticeService;

    NoticeRetrieveController(NoticeServiceImpl noticeServiceImpl) {
        this.noticeServiceImpl = noticeServiceImpl;
    }
	
	//공지사항 게시판 목록 페이지 요청
	@RequestMapping("/list.do")
	public String noticeList(
			@RequestParam(name="page", required=false, defaultValue="1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord, Model model
			){
		PaginationInfoVO<NoticeVO> pagingVO = new PaginationInfoVO<>();
		// 검색시 추가
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute("searchType",searchType);
			model.addAttribute("searchWord",searchWord);
		}
		
		// start/endRow, start/endPage 필드 설정
		pagingVO.setCurrentPage(currentPage);
		int totalRecord = noticeService.selectNoticeCount(pagingVO);
		// totalPage 설정
		pagingVO.setTotalRecord(totalRecord);
		// 페이지 1에 해당하는 size 만큼의 게시글 목록을 가져온다
		List<NoticeVO> dataList = noticeService.selectNoticeList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("pagingVO",pagingVO);
				
		return "notice/list";
	}

	//공지사항 게시판 상세 페이지 요청
	@GetMapping("/detail.do")
	public String noticeDetail(int boNo, Model model) {
		
		NoticeVO noticeVO = noticeService.selectNotice(boNo);
		model.addAttribute("notice",noticeVO);
		
		return "notice/detail";
	}
	
	
}

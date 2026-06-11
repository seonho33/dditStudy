package kr.or.ddit.notice.web;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.notice.service.INoticeService;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;

@Controller
@RequestMapping("/notice")
public class NoticeRetrieveController {

	@Autowired
	private INoticeService noticeService;
	
	@RequestMapping("/list.do")
	public String noticeList(
		@RequestParam(required = false, defaultValue = "1", name="page") int currentPage,
		@RequestParam(required = false)String searchWord,
		@RequestParam(required = false, defaultValue="title") String searchType,
		Model model){
		
		PaginationInfoVO<NoticeVO> pagingVO = new PaginationInfoVO<>();
		pagingVO.setCurrentPage(currentPage);
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
			model.addAttribute(searchType);
			model.addAttribute(searchWord);
		}
		
		int totalRecord = noticeService.selectNoticeCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<NoticeVO> noticeList = noticeService.selectNoticeList(pagingVO);
		
		pagingVO.setDataList(noticeList);
		
		model.addAttribute("pagingVO",pagingVO);
		
		return "notice/list";
	}
	
	@GetMapping("/detail.do")
	public String noticeDetail(int noticeNo,Model model) {
		
		NoticeVO noticeVO = noticeService.selectNotice(noticeNo);
		
		model.addAttribute("noticeVO",noticeVO);
		
		return "notice/view";
	}
	
}

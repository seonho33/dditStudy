package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.View;

import kr.or.ddit.service.INoticeService;
import kr.or.ddit.vo.NoticeFileVO;

@Controller
public class NoticeDownloadController {
	
	@Autowired
	private INoticeService noticeService;
	
	@GetMapping("/notice/download.do")
	public View noticeProcess(int fileNo, ModelMap model) {
		
		//선택한 파일을 다운로드 하기위한 정보로 파일 번호에 해당하는 파일 정보를 얻어옵니다.
		NoticeFileVO noticeFileVO = noticeService.noticeDownload(fileNo);
		
		Map<String, Object> noticeFileMap = new HashMap<>();
		noticeFileMap.put("fileName", noticeFileVO.getFileName());
		noticeFileMap.put("fileSize", noticeFileVO.getFileSize());
		noticeFileMap.put("fileSavepath", noticeFileVO.getFileSavepath());
		model.addAttribute("noticeFileMap",noticeFileMap);
		
		return new NoticeDownloadView();
	}
}

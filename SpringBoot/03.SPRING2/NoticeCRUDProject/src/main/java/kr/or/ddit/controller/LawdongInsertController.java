package kr.or.ddit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.INoticeService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class LawdongInsertController {

	@Autowired
	private INoticeService noticeService;
	
	@PostMapping("/lawdong/collect.do")
	@ResponseBody
    public String insertLawdong() {

        try {
        	noticeService.collectLawDong();
            return "수집 완료";

        } catch (Exception e) {
            log.error("법정동 수집 실패", e);
            return "수집 실패";
        }
    }
	
	@PostMapping("/collectApt.do")
	@ResponseBody
	public String collectApt() {

	    try {
	        noticeService.collectAptData();
	        return "수집 완료";
	    } catch (Exception e) {
	        log.error("아파트 수집 실패", e);
	        return "수집 실패";
	    }
	}
}

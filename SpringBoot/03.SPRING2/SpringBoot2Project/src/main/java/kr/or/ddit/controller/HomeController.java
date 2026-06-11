package kr.or.ddit.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Slf4j
@Controller
public class HomeController {


	public String getMethodName(@RequestParam String param) {
		return new String();
	}

	@GetMapping("/")
	public String home(Locale locale, Model model) {
		log.info("home 실행!");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG,locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime",formattedDate);
		return "home";
	}
}

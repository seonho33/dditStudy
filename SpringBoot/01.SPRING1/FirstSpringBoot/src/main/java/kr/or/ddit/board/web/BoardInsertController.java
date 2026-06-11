package kr.or.ddit.board.web;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.vo.BoardVO;
import kr.or.ddit.vo.ServiceResult;

@Controller
@RequestMapping("/board")
public class BoardInsertController {

	//DI 적용
	@Autowired
	private IBoardService boardService;
	
	//일반 게시판 목록 요청
	@GetMapping({"/form.do"})
	public String boardList(){
		return "board/form";
	}	
	
	//일반 게시판 등록 기능 요청
	@PostMapping("/insert.do")
	public String boardInsert(BoardVO boardVO, Model model) {
		String goPage ="";
		Map<String,Object> errors = new HashMap<>();
		
		//서버로 전송된 제목과 내용 데이터에 대해서도 유효성 검사를 진항핸다.
		// 클라이언트에서 분명 유효성 검사를 진행 후, 데이터를 전송했지만 혹시나 잘못된 데이터가 넘어오면
		// 바로 뚫려버리는 보안에 취약한 로직이 되지 않도록 한번 더 유효성 검사를 진행한다...
//		if(boardVO == null || boardVO.getBoTitle() ==null || boardVO.getBoTitle().equals("")) {
//		} << 이런식으로 유효성 검사하는것을 pom.xml 에 디펜던시로 추가해 StringUtils.로 간단하게 쓸 수있다
		
		if(StringUtils.isBlank(boardVO.getBoTitle())) {
			errors.put("boTitle", "제목을 입력해 주세요!!");
		}
		if(StringUtils.isBlank(boardVO.getBoContent())) {
			errors.put("boContent", "내용을 입력해 주세요!!");
		}
		
		//전달받은 데이터에 유효성 검사 진행 후, 에러가 발생했을때~ 그렇지 않을때~로 나눠 로직을 분기
		if(errors.size()>0) {   // 에러 발생
			model.addAttribute("error",errors);
			model.addAttribute("board",boardVO);
			goPage = "board/form";
		}else {					// 정상적인 데이터
			boardVO.setBoWriter("a001");	//일단 로그인 사용자 하드코딩
			ServiceResult result =  boardService.insertBoard(boardVO);	//ServiceResult라는 enum 을 생성해서 결과받기
			if(result.equals(ServiceResult.OK)) {	//등록 성공
				goPage = "redirect:/board/detail.do?boNo="+boardVO.getBoNo();
			}else {
				model.addAttribute("board",boardVO);
				goPage="board/form";
			}
		}

		return goPage;
	}
}

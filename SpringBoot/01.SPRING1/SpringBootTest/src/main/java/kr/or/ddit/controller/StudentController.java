package kr.or.ddit.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;


// 로그를 찍기 위한 어노테이션(System.out.println 대신 사용!)
// 이 컨트롤러는 "/student"로 시작하는 주소를 전담합니다.

// 스프링에게 이 클래스가 컨트롤러임을 알려주기
@Slf4j
@RequestMapping("/student")
@Controller
public class StudentController {
	private Logger log = 
			LoggerFactory.getLogger(BookRetrieveController.class);
	
	/**
	 * [1] 폼 화면 보여주기 (단순히 화면만 띄워주는 역할)
	 * 요청 URL : /student/studentForm.do
	 * 방식 : GET(주소창에 직접 쳐서 들어오니까 GET)
	 */
	@GetMapping("/studentForm.do")
	public String studentForm() {
		// /WEB-INF/views/student/studentForm.jsp 파일을 찾아가서 화면에 그려라!
		return "student/studentForm";
	}
	
	/**
     * [2] 폼에서 전송한 데이터 받기 (핵심!)
     * 요청 URL : /student/insert (form의 action 주소와 완벽히 일치해야 함)
     * 방식 : POST (form의 method가 post였으므로 @PostMapping 사용)
     */
    @PostMapping("/insert")
    public ModelAndView studentInsert(StudentVO studentVO, ModelAndView mav) {
        
        // 1. 스프링의 마법: JSP의 name="stuName" 값이 studentVO의 stuName 변수에 자동으로 쏙 들어옵니다! (데이터 바인딩)
        log.info("화면에서 넘어온 학생 데이터: {}", studentVO.toString());

        // --- (이 부분에서 원래는 Service -> MyBatis Mapper를 거쳐 DB에 INSERT 합니다!) ---
        // 예: studentService.insertStudent(studentVO);
        // --------------------------------------------------------------------------------

        // 2. 화면에 결과를 보여주기 위해 Model 이라는 쟁반에 데이터를 담습니다.
        // "std"라는 이름표를 붙여서 studentVO 객체를 담음.
        mav.addObject("std", studentVO);
        mav.setViewName("student/studentResult");

        // 3. 결과를 보여줄 JSP 페이지로 이동합니다.
        // /WEB-INF/views/student/studentResult.jsp
        return mav;
    }
	
}

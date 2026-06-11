package kr.or.ddit.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.ZipVO;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class DongSelect
 */
@WebServlet("/DongSelect.do")
public class DongSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DongSelect() {
        super();
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//전송 데이터 받기
		String dong = request.getParameter("dong");
		
		//service 객체 생성
		IMemberService memberService = MemberServiceImpl.getInstance();
		
		//메소드 호출 - 결과값 받기
		List<ZipVO> result = memberService.dongBySelect(dong);
		
		//request or session 에 결과값 저장
		request.setAttribute("memberDong", result);
		
		//view 페이지로 전송
		request.getRequestDispatcher("/0107/dongSelect.jsp").forward(request, response);
		
	}

}

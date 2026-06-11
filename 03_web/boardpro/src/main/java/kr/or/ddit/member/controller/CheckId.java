package kr.or.ddit.member.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;

import java.io.BufferedReader;
import java.io.IOException;

/**
 * Servlet implementation class CheckId
 */
@WebServlet("/CheckId.do")
public class CheckId extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckId() {
        super();
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//전송 데이터 받기
		String id = request.getParameter("id");
		
		//service 객체 생성
		IMemberService memberService = MemberServiceImpl.getInstance();
		
		//service 메소드 호출 - 결과값 받기 null or not null
		String res = memberService.checkId(id);
		
		//request or session 에 결과값을 저장하고 
		request.setAttribute("memberId", res);
		
		//view 페이지로 전송한다
		request.getRequestDispatcher("/0107/checkId.jsp").forward(request, response);
	}

}

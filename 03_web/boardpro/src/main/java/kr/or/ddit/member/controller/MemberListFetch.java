package kr.or.ddit.member.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

import java.io.IOException;
import java.util.List;

import org.apache.catalina.connector.Request;

/**
 * Servlet implementation class MemberListFetch
 */
@WebServlet("/List_Fetch.do")
public class MemberListFetch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberListFetch() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//서비스 객체 호출하기
		IMemberService memberService = MemberServiceImpl.getInstance();
		
		//서비스 메소드 호출하기, 결과값 얻어오기
		List<MemberVO> list = memberService.memberList();
		
		// 결과값을 request 객체에 저장
		request.setAttribute("responseList", list);
		
		// view 페이지로 이동 - json 형식의 직렬화 데이터 생성
		
		
		RequestDispatcher disp = request.getRequestDispatcher("/0105/list_fetch.jsp");
		disp.forward(request, response);
		// 
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

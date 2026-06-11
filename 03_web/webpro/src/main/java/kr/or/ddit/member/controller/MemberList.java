package kr.or.ddit.member.controller;

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

/**
 * Servlet implementation class MemberList
 */
@WebServlet("/memberList.do")
public class MemberList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberList() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//서비스 -> DAO(util의 Sqlsession생성) -> mapper수행 -> db에서 crud 실행
		IMemberService memberService = MemberServiceImpl.getInstance();
		
		//db에서 수행된 결과값을 얻는다..
		List<MemberVO> list = memberService.memberList();
		
		//request에 저장
		request.setAttribute("responseList", list);
		
		//결과값을 view 페이지로 보낸다.(redirect로 view페이지로 보내거나 forword로 보낸다..)
		request.getRequestDispatcher("/0105/memberList.jsp").forward(request, response);
		
		//view 페이지에서 출력한다.(동기방식)
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

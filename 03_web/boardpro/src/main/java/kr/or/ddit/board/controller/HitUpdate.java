package kr.or.ddit.board.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.BoardServiceImple;
import kr.or.ddit.board.service.IBoardService;

import java.io.IOException;

/**
 * Servlet implementation class HitUpdate
 */
@WebServlet("/HitUpdate.do")
public class HitUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("hit 서블릿 접근함");
		
		//전송 데이터 읽기 - num 
		int num = Integer.parseInt(request.getParameter("num"));
		
		//service 객체 얻기
		IBoardService service = BoardServiceImple.getService();
		
		//service 메소드 실행
		int res = service.hitUpdate(num);
		
		//view 페이지 이동
		request.setAttribute("result", res);
		
		//view 페이지 이동
		request.getRequestDispatcher("/board/result.jsp").forward(request, response);
	}
}
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
 * Servlet implementation class ReplyDete
 */
@WebServlet("/ReplyDete.do")
public class ReplyDete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//전송 데이터 읽기 - renum
		int renum = Integer.parseInt(request.getParameter("renum"));
		
		//service 객체 얻기
		IBoardService service = BoardServiceImple.getService();
		
		//service 메소드 호출 하기
		int res=service.replyDelete(renum);
		
		request.setAttribute("result", res);
		
		request.getRequestDispatcher("/board/result.jsp").forward(request, response);
	}
}

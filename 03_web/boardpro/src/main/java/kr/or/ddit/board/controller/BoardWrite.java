package kr.or.ddit.board.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.BoardServiceImple;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.util.ObjFromJson;
import kr.or.ddit.util.ObjJson;

import java.io.IOException;

import com.google.gson.Gson;

/**
 * Servlet implementation class BoardWrite
 */
@WebServlet("/BoardWrite.do")
public class BoardWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//직렬화된 전송데이터 받기 -writer, subject, maol, password, content
		//역 직렬화 - 자바 객체로 변화
		String result = ObjFromJson.changeData(request);
		Gson gson = new Gson();
		BoardVO bvo = gson.fromJson(result, BoardVO.class);
		bvo.setWip(request.getRemoteAddr());
		//service 객체 생성
		IBoardService service = BoardServiceImple.getService();
		
		//service 메소드 호출 - 결과값 얻기
		int res = service.boardInsert(bvo);
		
		//request에 저장
		request.setAttribute("result", res);
		
		
		//view 페이지 이동
		request.getRequestDispatcher("/board/result.jsp").forward(request, response);
		
	}
}

package kr.or.ddit.board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.BoardServiceImple;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.ReplyVO;

/**
 * Servlet implementation class ReplyList
 */
@WebServlet("/ReplyList.do")
public class ReplyList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//전송 데이터 읽기... - bonum
		int bnum = Integer.parseInt(request.getParameter("bonum"));
		
		//service 객체 얻기
		IBoardService service = BoardServiceImple.getService();
		
		//service메소드 호출 - 결과값 얻기
		List<ReplyVO> list = service.replyList(bnum);
		/*
		 * //request 에 저장 request.setAttribute("replyData", list);
		 * 
		 * //view 페이지 이동
		 * request.getRequestDispatcher("/board/replyList.jsp").forward(request,
		 * response);
		 */
		
		//별도의 view 페이지 없이 hashMap에 결과를 저장
		Map<String, Object> replyMap = new HashMap<String, Object>();
		replyMap.put("replyData", list);
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		PrintWriter out = response.getWriter();
		gson.toJson(replyMap,out);
		//fetch 비동기 전송했던 부분으로 이동
		
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

package kr.or.ddit.board.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.BoardServiceImple;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.ReplyVO;
import kr.or.ddit.util.ObjFromJson;

import java.io.IOException;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class ReplyInsert
 */
@WebServlet("/ReplyInsert.do")
public class ReplyInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//직렬화된 전송데이터 받기{bonum : 22, name : "이쁜이", cont : ㅁㄴㅇㅁㄴㅇ}
	
		String reqData = ObjFromJson.changeData(request);
		System.out.println("replyinsert request =="+reqData);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		ReplyVO vo = gson.fromJson(reqData, ReplyVO.class);
		
		IBoardService service = BoardServiceImple.getService();
		
		int res = service.replyInsert(vo);
		
		request.setAttribute("result", res);
		
		request.getRequestDispatcher("/board/result.jsp").forward(request, response);
	}
}

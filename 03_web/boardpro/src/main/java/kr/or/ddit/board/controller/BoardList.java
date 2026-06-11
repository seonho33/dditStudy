package kr.or.ddit.board.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.board.service.BoardServiceImple;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.util.PageUtil;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PageInfo;
import kr.or.ddit.board.vo.SearchVO;
import kr.or.ddit.util.ObjFromJson;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class BoardList
 */
@WebServlet("/BoardList.do")
public class BoardList extends HttpServlet {

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BoardList() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 처음 게시판 최초 실행시
		int page = 1;
		String stype = "";
		String sword = "";

		// 검색을 위한 vo = searchVO // pageinfo 안에 있다..
		SearchVO svo = new SearchVO();
		svo.setPage(page);
		svo.setStype(stype);
		svo.setSword(sword);

		// proc- get, post 둘다 공통으로 수행할 메소드
		// svo 를 파라메터로 해서 proc() 메소드 실행 - Map 리턴
		// 게시글의 총 갯수 totalRecord, 총 페이지수 totalPage -
		// start, end, startPage, endPage값 구하기

		// PageInfo에 설정 - 설정값으로 service 파라메터로 실행...
		// 게시글 가져오기, pageList만들기

		Map<String, Object> map = proc(svo);
		// ("datas", list)
		// ("pglist",pglist)

		// request에 저장
		request.setAttribute("boardList", map.get("datas"));
		request.setAttribute("pglist", map.get("pglist"));

		// 뷰페이지로 이동
		request.getRequestDispatcher("/board/board.jsp").forward(request, response);

	}

	protected Map<String, Object> proc(SearchVO svo) {

		// 페이지 정보 얻기
		IBoardService service = BoardServiceImple.getService();

		PageInfo pinfo = new PageInfo(4, 3);
		pinfo.setSvo(svo); // svo안에는 page,stype,sword가 있다...
		pinfo.setPage(svo.getPage()); // svo에 있는 page값을 PageInfo에서 사용하기 위헤서 PageInfo의 page값에 넣는다

		// 전체 글 갯수 구하고 pinfo의 setTotalRecord로 넣고 + 게시글 가져오기
		List<BoardVO> list = service.readPaging(pinfo);

		System.out.println("pinfo = " + pinfo);

		// 페이지 번호 출력을 위한 문장 - startPage, endPage, totalPage, page
		String pglist = PageUtil.pageList(pinfo.getStartPage(), pinfo.getEndPage(), pinfo.getTotalPage(),
				pinfo.getPage());

		// 결과 list와 pglist를 dataMap에 저장
		Map<String, Object> dataMap = new HashMap<String, Object>();

		dataMap.put("datas", list); // [{},{},{}]
		dataMap.put("pglist", pglist); // <ul><li>...</li></ul>

		return dataMap;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 전송된 json 데이터 받기

		String reqData = ObjFromJson.changeData(request);
		System.out.println("reqData = " + reqData);

		// 역직렬화
		Gson gson = new Gson();
		SearchVO svo = gson.fromJson(reqData, SearchVO.class);
		// vo.setpage...vo.set~~~

		// proc- get, post 둘다 공통으로 수행할 메소드
		// svo 를 파라메터로 해서 proc() 메소드 실행 - Map 리턴
		// 게시글의 총 갯수 totalRecord, 총 페이지수 totalPage -
		// start, end, startPage, endPage값 구하기

		// PageInfo에 설정 - 설정값으로 service 파라메터로 실행...
		// 게시글 가져오기, pageList만들기

		Map<String, Object> map = proc(svo);
		// ("datas", list)
		// ("pglist",pglist)

		// request 에 값 저장
		// request.setAttribute("mapData", map);

		// view 페이지로 이동
		// request.getRequestDispatcher("/board/boardList.jsp").forward(request,
		// response);

		// boardList.jsp 에서 mapData를 꺼내서 직렬화 한 데이터를 생성 gson,tojson()

		// 별도의 view 페이지 없이 결과 map을 가지고 여기서 json 직렬화 데이터를 생성
		// 비동기 fetch 부분으로 전송된다 String result = gson.toJson(), out.print(result)
		// out.flush
		PrintWriter out = response.getWriter();
		gson.toJson(map, out);

	}

}

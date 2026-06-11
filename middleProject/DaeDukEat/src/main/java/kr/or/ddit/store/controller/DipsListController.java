package kr.or.ddit.store.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import kr.or.ddit.store.service.DipsListService;
import kr.or.ddit.store.service.IDIpsListService;
import kr.or.ddit.store.vo.StoreVO;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/DipsList.do")
public class DipsListController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ✅ Service 싱글톤
    private IDIpsListService service = DipsListService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /* ============================
           1️⃣ 로그인 체크
        ============================ */
        HttpSession session = request.getSession();
        UserVO uvo = (UserVO) session.getAttribute("loginUser");

        // SPA(fetch) 호출이므로 redirect ❌
        if (uvo == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String userId = uvo.getUserId();

        try {
            /* ============================
               2️⃣ 찜한 가게 목록 조회
               - USER_DipsS + STORE 조인
            ============================ */
            List<StoreVO> DipsStoreList = service.getDipsStoreList(userId);

            /* ============================
               3️⃣ JSP에서 쓸 데이터 저장
            ============================ */
            request.setAttribute("DipsStoreList", DipsStoreList);

            /* ============================
               4️⃣ 찜 목록 JSP 조각 반환
               ⚠ main.jsp 안 #main-view에 들어감
            ============================ */
            request.getRequestDispatcher(
                "/TEST/views/store/Dipslist.jsp"
            ).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}

package kr.or.ddit.store.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.store.service.DipsListService;
import kr.or.ddit.store.service.IDIpsListService;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/DipsDelete.do")
public class DipDeleteController extends HttpServlet {
	
	private IDIpsListService service = DipsListService.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json;charset=UTF-8");
        
        UserVO loginUser = (UserVO) req.getSession().getAttribute("loginUser");
        String userId = loginUser.getUserId();
        String storeId = req.getParameter("storeId");

        boolean result = service.removeDips(userId, storeId);

        resp.getWriter().write("{\"success\":" + result + "}");
    }

}

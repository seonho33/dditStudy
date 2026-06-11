package kr.or.ddit.store.controller;

import java.io.IOException;

import org.apache.ibatis.session.SqlSession;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.common.util.MyBatisUtil;
import kr.or.ddit.store.dao.IUserDao;
import kr.or.ddit.store.dao.UserDaoImpl;
import kr.or.ddit.store.service.IStoreService;
import kr.or.ddit.store.service.IUserService;
import kr.or.ddit.store.service.StoreServiceImpl;
import kr.or.ddit.store.service.UserServiceImpl;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/deleteOwner.do")
public class DeleteOwnerController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private IUserService userService;
	private IStoreService storeService;
	
	@Override
	public void init() throws ServletException {
		/*
		 * SqlSession session = MyBatisUtil.getSqlSession(); IUserDao userDao = new
		 * UserDaoImpl(session); userService = new UserServiceImpl(userDao);
		 */
		userService = new UserServiceImpl();
		storeService = new StoreServiceImpl();
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

	    // fetch로 owner-content에 꽂을 "조각"만 내려줘야 함
	    req.getRequestDispatcher("/TEST/views/store/StoreDelete.jsp")
	       .forward(req, resp);
	}

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("접근함");
		
		UserVO loginUser = (UserVO) req.getSession().getAttribute("loginUser");
		if (loginUser == null) {
		    resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
		    return;
		}
		String userId = loginUser.getUserId();

		storeService.withdrawStoreByUserId(userId);
		
		userService.withdrawUser(userId);
		
		req.getSession().invalidate();
		
		resp.sendRedirect(req.getContextPath() + "/TEST/views/user/main.jsp");
		
	}
	
	
}

/*
 * package kr.or.ddit.store.controller;
 * 
 * import java.io.IOException; import java.util.List;
 * 
 * import jakarta.servlet.ServletException; import
 * jakarta.servlet.annotation.WebServlet; import
 * jakarta.servlet.http.HttpServlet; import
 * jakarta.servlet.http.HttpServletRequest; import
 * jakarta.servlet.http.HttpServletResponse; import
 * jakarta.servlet.http.HttpSession;
 * 
 * import kr.or.ddit.review.dao.IReviewDAO; import
 * kr.or.ddit.review.dao.ReviewDAOImpl; import
 * kr.or.ddit.review.vo.ReviewDetailVO; import kr.or.ddit.user.vo.UserVO;
 * 
 * @WebServlet("/review/myReviewContent.do") public class MyReviewController
 * extends HttpServlet {
 * 
 * // 보여주신 ReviewDAOImpl 인스턴스를 사용합니다. private IReviewDAO reviewDao =
 * ReviewDAOImpl.getInstance();
 * 
 * @Override protected void doGet(HttpServletRequest request,
 * HttpServletResponse response) throws ServletException, IOException {
 * 
 * HttpSession session = request.getSession(); UserVO uvo = (UserVO)
 * session.getAttribute("loginUser");
 * 
 * if(uvo == null) { response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
 * return; }
 * 
 * String userId = uvo.getUserId();
 * 
 * try { // DAO를 호출하여 리스트를 가져옵니다. List<ReviewDetailVO> myReviewList =
 * reviewDao.selectMyReviews(userId);
 * 
 * // JSP에서 사용할 이름 "myReviewList"로 데이터를 담습니다.
 * request.setAttribute("myReviewList", myReviewList);
 * 
 * // 리뷰 목록 조각 페이지로 포워딩합니다.
 * request.getRequestDispatcher("/TEST/views/review/myReviewContent.jsp")
 * .forward(request, response);
 * 
 * } catch (Exception e) { e.printStackTrace();
 * response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); } } }
 */
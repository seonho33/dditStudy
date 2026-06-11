package kr.or.ddit.admin.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import kr.or.ddit.admin.service.GsServiceImpl;
import kr.or.ddit.admin.service.IGSService;
import kr.or.ddit.admin.vo.GsVO;
import kr.or.ddit.common.util.FileUploadUtil;
import kr.or.ddit.user.vo.UserVO;   // ✅ 두목님 프로젝트의 UserVO 패키지로 맞춰라

@WebServlet("/gs25/insert.do")
@MultipartConfig
public class GsProductInsertController extends HttpServlet {

    private IGSService service = GsServiceImpl.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json; charset=UTF-8");

        try {
            // ✅ 0) 로그인(관리자) 세션에서 userId 꺼내기
            HttpSession session = req.getSession(false);
            UserVO loginAdmin = (session == null) ? null : (UserVO) session.getAttribute("loginAdmin");

            if (loginAdmin == null || loginAdmin.getUserId() == null || loginAdmin.getUserId().isBlank()) {
                resp.getWriter().print("{\"success\":false,\"message\":\"관리자 로그인 세션이 없습니다.\"}");
                return;
            }
            String userId = loginAdmin.getUserId(); // ✅ FK 부모키로 존재하는 값이어야 함

            // 1️⃣ 파라미터
            String division = req.getParameter("prod_category");
            String name = req.getParameter("prod_name");
            int original = Integer.parseInt(req.getParameter("prod_price"));
            int discount = Integer.parseInt(req.getParameter("prod_discount"));
            String deadline = req.getParameter("prod_deadline");

            // 2️⃣ 할인율 계산
            int rate = (int) Math.round(((original - discount) / (double) original) * 100);

            // 3️⃣ 이미지 저장
            Part imgPart = req.getPart("prod_img");

            String imageName = FileUploadUtil.saveImage(
                req.getServletContext(),
                imgPart,
                "GS"
            );

            // ✅ 이미지 없으면 기본 이미지 세팅
            if (imageName == null || imageName.isBlank()) {
                imageName = "default_profile.png";
            }


            // 4️⃣ VO 세팅
            GsVO vo = new GsVO();
            vo.setProductDivision(division);
            vo.setProductName(name);
            vo.setOriginalPrice(original);
            vo.setDiscountPrice(discount);
            vo.setDiscountRate(rate);
            vo.setProductImageUrl(imageName);
            vo.setUserId(userId);     // ✅ 여기!
            vo.setStatusYn("Y");

            if ("마감할인".equals(division) && deadline != null && !deadline.isBlank()) {
                vo.setEndTime(deadline);
            }

            // 5️⃣ INSERT
            int cnt = service.insertGsProduct(vo);

            if (cnt > 0) {
                resp.getWriter().print("{\"success\":true}");
            } else {
                resp.getWriter().print("{\"success\":false,\"message\":\"등록 실패\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().print("{\"success\":false,\"message\":\"등록 중 오류 발생\"}");
        }
    }
}

package kr.or.ddit.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import kr.or.ddit.common.util.FileUploadUtil;
import kr.or.ddit.user.service.IUpMemberService;
import kr.or.ddit.user.service.UpMemberServiceImpl;
import kr.or.ddit.user.vo.MemberVO;
import kr.or.ddit.user.vo.UserVO;

@WebServlet("/UpdateMember.do")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 20
)
public class UpdateMember extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IUpMemberService service = UpMemberServiceImpl.getInstance();

    /** ✅ 수정 폼 조각 JSP 반환 (GET) */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserVO loginUser = (session == null) ? null : (UserVO) session.getAttribute("loginUser");
        MemberVO loginMember = (session == null) ? null : (MemberVO) session.getAttribute("loginMember");

        if (loginUser == null || loginMember == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        request.setAttribute("loginUser", loginUser);
        request.setAttribute("loginMember", loginMember);

        request.getRequestDispatcher("/TEST/views/user/updateMember.jsp")
               .forward(request, response);
    }

    /** ✅ 저장 (POST) : JSON으로만 응답 */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        HttpSession session = request.getSession(false);
        UserVO loginUser = (session == null) ? null : (UserVO) session.getAttribute("loginUser");
        MemberVO loginMember = (session == null) ? null : (MemberVO) session.getAttribute("loginMember");

        if (loginUser == null || loginMember == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().print("{\"success\":false,\"message\":\"로그인이 필요합니다.\"}");
            return;
        }

        String userId = loginUser.getUserId();

        // 1) 파라미터
        String currentPassword = request.getParameter("current_pass"); // 필수
        String newPassword     = request.getParameter("password");     // 선택
        String name            = request.getParameter("name");
        String mail            = request.getParameter("mail");

        // 2) 현재 비밀번호 검증
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("user_id", userId);
        paramMap.put("password", currentPassword);

        boolean passOk = service.checkPass(paramMap);
        if (!passOk) {
            response.getWriter().print("{\"success\":false,\"message\":\"비밀번호가 일치하지 않습니다.\"}");
            return;
        }

        // 3) 이미지 업로드(선택) - ✅ FileUploadUtil 표준 적용
        //    JSP input name="profile_img" 와 반드시 동일해야 함
        String savedFileName = null;
        Part filePart = request.getPart("profileImg");

        if (filePart != null && filePart.getSize() > 0) {
            savedFileName = FileUploadUtil.saveImage(getServletContext(), filePart, "profile");
            if (savedFileName == null) {
                response.getWriter().print("{\"success\":false,\"message\":\"이미지 파일만 업로드 가능합니다.\"}");
                return;
            }
        }

        // 4) 업데이트 VO
        UserVO updateUserVO = new UserVO();
        updateUserVO.setUserId(userId);
        updateUserVO.setName(name);

        if (newPassword != null && !newPassword.trim().isEmpty()) {
            updateUserVO.setPassword(newPassword.trim());
        }

        MemberVO updateMemberVO = new MemberVO();
        updateMemberVO.setUserId(userId);
        updateMemberVO.setUserMail(mail);

        if (savedFileName != null) {
            updateMemberVO.setProfileImg(savedFileName);
        }

        // 5) DB 업데이트
        boolean ok = service.updateAll(updateUserVO, updateMemberVO);

        if (ok) {
            // ✅ 세션 갱신
            loginUser.setName(name);
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                loginUser.setPassword(newPassword.trim());
            }
            session.setAttribute("loginUser", loginUser);

            loginMember.setUserMail(mail);
            if (savedFileName != null) {
                loginMember.setProfileImg(savedFileName);
            }
            session.setAttribute("loginMember", loginMember); // ✅ 오타 수정

            String nextUrl = request.getContextPath() + "/SelectOne.do";
            response.getWriter().print("{\"success\":true,\"message\":\"수정 완료\",\"nextUrl\":\"" + nextUrl + "\"}");
        } else {
            response.getWriter().print("{\"success\":false,\"message\":\"회원정보 수정 오류가 발생했습니다.\"}");
        }
        
        
        System.out.println("[UPLOAD] part.size=" + (filePart==null? "null" : filePart.getSize()));
        String realPath = getServletContext().getRealPath("/images/upload/profile");
        System.out.println("[UPLOAD] realPath=" + realPath);
        System.out.println("[UPLOAD] savedFileName=" + savedFileName);

    }
}

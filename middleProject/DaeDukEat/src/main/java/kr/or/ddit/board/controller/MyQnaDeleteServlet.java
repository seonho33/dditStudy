package kr.or.ddit.board.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.board.service.IQnaService;
import kr.or.ddit.board.service.QnaServiceImpl;
import kr.or.ddit.board.vo.QnaVO;
import kr.or.ddit.user.vo.UserVO;

/**
 * 마이페이지 QNA 삭제 (AJAX)
 * 
 * @author Legacy Architect
 * @since 2025-01-27
 * 
 * <pre>
 * [URL] /mypage/qna/delete.do
 * [Method] POST
 * [Response] JSON
 * </pre>
 */
@WebServlet("/mypage/qna/delete.do")
public class MyQnaDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 1. 세션 검증
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            out.print("{\"success\": false, \"message\": \"로그인이 필요합니다.\"}");
            out.flush();
            return;
        }
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        String userId = loginUser.getUserId();
        
        try {
            // 2. 파라미터 수집
            String qnaIdParam = request.getParameter("qnaId");
            
            if (qnaIdParam == null || qnaIdParam.trim().isEmpty()) {
                out.print("{\"success\": false, \"message\": \"질문 ID가 필요합니다.\"}");
                out.flush();
                return;
            }
            
            Long qnaId = Long.parseLong(qnaIdParam);
            
            // 3. 권한 검증 (본인 글 확인)
            IQnaService service = QnaServiceImpl.getInstance();
            QnaVO existingQna = service.getQnaDetail(qnaId);
            
            if (existingQna == null) {
                out.print("{\"success\": false, \"message\": \"존재하지 않는 질문입니다.\"}");
                out.flush();
                return;
            }
            
            if (!existingQna.getUserId().equals(userId)) {
                out.print("{\"success\": false, \"message\": \"삭제 권한이 없습니다.\"}");
                out.flush();
                return;
            }
            
            // 4. Service 호출
            boolean result = service.deleteQna(qnaId);  // ✅ boolean 반환
            
            // 5. 응답 생성
            if (result) {
                out.print("{\"success\": true, \"message\": \"삭제가 완료되었습니다.\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"삭제에 실패했습니다.\"}");
            }
            out.flush();
            
        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"잘못된 질문 ID 형식입니다.\"}");
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"삭제 중 오류가 발생했습니다.\"}");
            out.flush();
        }
    }
}
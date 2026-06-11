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
 * 마이페이지 QNA 등록 (AJAX)
 * 
 * @author Legacy Architect
 * @since 2025-01-27
 * 
 * <pre>
 * [URL] /mypage/qna/insert.do
 * [Method] POST
 * [Response] JSON
 * </pre>
 */
@WebServlet("/mypage/qna/insert.do")
public class MyQnaInsertServlet extends HttpServlet {
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
        
        try {
            // 2. 파라미터 수집
            String qnaTitle = request.getParameter("qnaTitle");
            String qnaContent = request.getParameter("qnaContent");
            String secretYn = request.getParameter("secretYn");
            
            // 3. Validation
            if (qnaTitle == null || qnaTitle.trim().isEmpty()) {
                out.print("{\"success\": false, \"message\": \"제목을 입력해주세요.\"}");
                out.flush();
                return;
            }
            
            if (qnaContent == null || qnaContent.trim().isEmpty()) {
                out.print("{\"success\": false, \"message\": \"내용을 입력해주세요.\"}");
                out.flush();
                return;
            }
            
            // 4. VO 생성
            QnaVO qna = new QnaVO();
            qna.setQnaTitle(qnaTitle);
            qna.setQnaContent(qnaContent);
            qna.setSecretYn(secretYn != null && "Y".equals(secretYn) ? "Y" : "N");
            qna.setUserId(loginUser.getUserId());
            
            // 5. Service 호출
            IQnaService service = QnaServiceImpl.getInstance();
            boolean result = service.insertQna(qna);  // ✅ boolean 반환
            
            // 6. 응답 생성
            if (result) {
                out.print("{\"success\": true, \"message\": \"질문이 등록되었습니다.\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"등록에 실패했습니다.\"}");
            }
            out.flush();
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"등록 중 오류가 발생했습니다.\"}");
            out.flush();
        }
    }
}
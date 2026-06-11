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

@WebServlet("/mypage/qna/update.do")
public class MyQnaUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        System.out.println("========================================");
        System.out.println("MyQnaUpdateServlet 호출됨!");
        System.out.println("========================================");
        
        // 1. 세션 검증
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            System.out.println("❌ 세션 없음");
            out.print("{\"success\": false, \"message\": \"로그인이 필요합니다.\"}");
            out.flush();
            return;
        }
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        String userId = loginUser.getUserId();
        System.out.println("✅ 로그인 사용자: " + userId);
        
        try {
            // 2. 파라미터 수집
            String qnaIdParam = request.getParameter("qnaId");
            String qnaTitle = request.getParameter("qnaTitle");
            String qnaContent = request.getParameter("qnaContent");
            String secretYn = request.getParameter("secretYn");
            
            System.out.println("qnaId: [" + qnaIdParam + "]");
            System.out.println("qnaTitle: [" + qnaTitle + "]");
            System.out.println("qnaContent: [" + qnaContent + "]");
            System.out.println("secretYn: [" + secretYn + "]");
            
            // 3. Validation
            if (qnaIdParam == null || qnaIdParam.trim().isEmpty()) {
                System.out.println("❌ qnaId 없음");
                out.print("{\"success\": false, \"message\": \"질문 ID가 필요합니다.\"}");
                out.flush();
                return;
            }
            
            if (qnaTitle == null || qnaTitle.trim().isEmpty()) {
                System.out.println("❌ 제목 없음");
                out.print("{\"success\": false, \"message\": \"제목을 입력해주세요.\"}");
                out.flush();
                return;
            }
            
            if (qnaContent == null || qnaContent.trim().isEmpty()) {
                System.out.println("❌ 내용 없음");
                out.print("{\"success\": false, \"message\": \"내용을 입력해주세요.\"}");
                out.flush();
                return;
            }
            
            Long qnaId = Long.parseLong(qnaIdParam);
            System.out.println("✅ qnaId 파싱 성공: " + qnaId);
            
            // 4. 권한 검증
            IQnaService service = QnaServiceImpl.getInstance();
            QnaVO existingQna = service.getQnaDetail(qnaId);
            
            if (existingQna == null) {
                System.out.println("❌ 질문 없음");
                out.print("{\"success\": false, \"message\": \"존재하지 않는 질문입니다.\"}");
                out.flush();
                return;
            }
            
            System.out.println("기존 작성자: " + existingQna.getUserId());
            System.out.println("현재 사용자: " + userId);
            
            if (!existingQna.getUserId().equals(userId)) {
                System.out.println("❌ 권한 없음");
                out.print("{\"success\": false, \"message\": \"수정 권한이 없습니다.\"}");
                out.flush();
                return;
            }
            
            // 5. VO 생성
            QnaVO qna = new QnaVO();
            qna.setQnaId(qnaId);
            qna.setQnaTitle(qnaTitle);
            qna.setQnaContent(qnaContent);
            qna.setSecretYn("Y".equals(secretYn) ? "Y" : "N");
            
            System.out.println("수정 VO: " + qna);
            
            // 6. Service 호출
            boolean result = service.updateQna(qna);
            
            System.out.println("수정 결과: " + result);
            
            // 7. 응답
            if (result) {
                out.print("{\"success\": true, \"message\": \"수정이 완료되었습니다.\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"수정에 실패했습니다.\"}");
            }
            out.flush();
            
        } catch (NumberFormatException e) {
            System.out.println("❌ 숫자 변환 실패: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"잘못된 질문 ID 형식입니다.\"}");
            out.flush();
        } catch (Exception e) {
            System.out.println("❌ 예외 발생: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"수정 중 오류가 발생했습니다.\"}");
            out.flush();
        }
    }
    
    // ✅ GET 요청 시 405 응답
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().print("{\"error\": \"POST 메서드만 지원합니다.\"}");
    }
}

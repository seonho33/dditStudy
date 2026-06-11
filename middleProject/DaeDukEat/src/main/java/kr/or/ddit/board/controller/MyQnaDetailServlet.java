package kr.or.ddit.board.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

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
 * 마이페이지 QNA 상세 조회 (AJAX)
 * 
 * @author Legacy Architect
 * @since 2025-01-27
 * 
 * <pre>
 * [URL] /mypage/qna/detail.do?qnaId=123
 * [Method] GET
 * [Response] JSON
 * </pre>
 */
@WebServlet("/mypage/qna/detail.do")
public class MyQnaDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 1. 세션 검증
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loginUser") == null) {
            out.print("{\"error\": \"로그인이 필요합니다.\"}");
            out.flush();
            return;
        }
        
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        String userId = loginUser.getUserId();
        
        try {
            // 2. 파라미터 파싱
            String qnaIdParam = request.getParameter("qnaId");
            if (qnaIdParam == null || qnaIdParam.trim().isEmpty()) {
                out.print("{\"error\": \"질문 ID가 필요합니다.\"}");
                out.flush();
                return;
            }
            
            Long qnaId = Long.parseLong(qnaIdParam);
            
            // 3. Service 호출
            IQnaService service = QnaServiceImpl.getInstance();
            QnaVO qna = service.getQnaDetail(qnaId);
            
            if (qna == null) {
                out.print("{\"error\": \"존재하지 않는 질문입니다.\"}");
                out.flush();
                return;
            }
            
            // 4. 권한 검증 (본인 글만 조회 가능)
            if (!qna.getUserId().equals(userId) && !"관리자".equals(loginUser.getDivision())) {
                out.print("{\"error\": \"조회 권한이 없습니다.\"}");
                out.flush();
                return;
            }
            
            // 5. JSON 응답 (Date 포맷 지정)
            Gson gson = new GsonBuilder()
                            .setDateFormat("yyyy-MM-dd HH:mm:ss")
                            .create();
            out.print(gson.toJson(qna));
            out.flush();
            
        } catch (NumberFormatException e) {
            out.print("{\"error\": \"잘못된 질문 ID 형식입니다.\"}");
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"error\": \"상세 조회 중 오류가 발생했습니다.\"}");
            out.flush();
        }
    }
}
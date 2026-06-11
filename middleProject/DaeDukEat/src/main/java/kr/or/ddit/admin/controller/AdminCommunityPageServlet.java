package kr.or.ddit.admin.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.admin.service.AdminServiceImpl;
import kr.or.ddit.admin.service.IAdminService;
import kr.or.ddit.board.vo.NoticeVO;
import kr.or.ddit.board.vo.QnaVO;

@WebServlet("/admin/community.do")
public class AdminCommunityPageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IAdminService service = AdminServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1) 공지사항 목록 (최신순)
        List<NoticeVO> noticeList = service.getNoticeList();
        if (noticeList == null) noticeList = Collections.emptyList();

        // 2) 미답변 QNA 목록 (최신순)
        List<QnaVO> qnaList = service.getUnansweredQnaList();
        if (qnaList == null) qnaList = Collections.emptyList();

        // 3) request에 담기
        request.setAttribute("noticeList", noticeList);
        request.setAttribute("qnaList", qnaList);

        // 4) 조각 JSP로 forward (네 프로젝트 경로에 맞춰 수정)
        request.getRequestDispatcher("/TEST/views/admin/admin_community.jsp")
               .forward(request, response);
    }
}
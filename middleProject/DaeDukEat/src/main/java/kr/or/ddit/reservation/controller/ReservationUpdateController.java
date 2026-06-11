package kr.or.ddit.reservation.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.reservation.service.IReservationService;
import kr.or.ddit.reservation.service.ReservationServiceImpl;
import kr.or.ddit.store.vo.StoreVO;

@WebServlet("/reservation/updateStatus.do")
public class ReservationUpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        
        HttpSession session = request.getSession();
        StoreVO svo = (StoreVO) session.getAttribute("loginStore");
        
        if (svo == null) {
            if (isAjax) {
                sendJsonResponse(response, false, "로그인이 필요합니다.");
            } else {
                response.sendRedirect(request.getContextPath() + "/login.do");
            }
            return;
        }
        
        String idxParam = request.getParameter("idx");
        String statusCode = request.getParameter("status");
        
        if (idxParam == null || statusCode == null) {
            if (isAjax) {
                sendJsonResponse(response, false, "잘못된 요청입니다.");
            } else {
                response.sendRedirect(request.getContextPath() + "/reservation/list.do");
            }
            return;
        }
        
        try {
            Long reservId = Long.parseLong(idxParam);
            
            String newStatus;
            String statusText;
            if ("APPROVE".equals(statusCode)) {
                newStatus = "승인";
                statusText = "승인";
            } else if ("REJECT".equals(statusCode)) {
                newStatus = "거절";
                statusText = "거절";
            } else {
                if (isAjax) {
                    sendJsonResponse(response, false, "잘못된 상태 코드입니다.");
                } else {
                    response.sendRedirect(request.getContextPath() + "/reservation/list.do");
                }
                return;
            }
            
            IReservationService service = ReservationServiceImpl.getInstance();
            int result = service.updateReservationStatus(reservId, newStatus);
            
            if (isAjax) {
                if (result > 0) {
                    sendJsonResponse(response, true, "예약이 " + statusText + " 처리되었습니다.");
                } else {
                    sendJsonResponse(response, false, "예약 상태 변경에 실패했습니다.");
                }
            } else {
                if (result > 0) {
                    session.setAttribute("successMsg", "예약이 " + statusText + " 처리되었습니다.");
                } else {
                    session.setAttribute("errorMsg", "예약 상태 변경에 실패했습니다.");
                }
                response.sendRedirect(request.getContextPath() + "/reservation/list.do");
            }
            
        } catch (NumberFormatException e) {
            if (isAjax) {
                sendJsonResponse(response, false, "잘못된 예약 번호 형식입니다.");
            } else {
                session.setAttribute("errorMsg", "잘못된 예약 번호 형식입니다.");
                response.sendRedirect(request.getContextPath() + "/reservation/list.do");
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (isAjax) {
                sendJsonResponse(response, false, "처리 중 오류가 발생했습니다.");
            } else {
                session.setAttribute("errorMsg", "처리 중 오류가 발생했습니다.");
                response.sendRedirect(request.getContextPath() + "/reservation/list.do");
            }
        }
    }
    
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) 
            throws IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String json = String.format(
            "{\"success\": %b, \"message\": \"%s\"}", 
            success, 
            escapeJson(message)
        );
        
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
    
    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
}
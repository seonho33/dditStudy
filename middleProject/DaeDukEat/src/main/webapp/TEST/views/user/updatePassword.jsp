<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // findpw.jsp에서 전달받은 데이터 가져오기
    String userID = request.getParameter("userID");
    String newPassword = request.getParameter("newPassword");
	
    //업데이트 할 DB정보
    String dbURL = "jdbc:oracle:thin:@112.220.114.131:1521:xe";  // DB URL
    String dbUser = "team2_202511M";  // DB 사용자명
    String dbPassword = "java";  // DB 비밀번호
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        // 드라이버 로드
        Class.forName("oracle.jdbc.driver.OracleDriver");
        
        // DB 연결
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        
        //DB로 새로운 비밀번호 변경 업데이트 쿼리
        String sql = "UPDATE USERS SET password = ? WHERE user_id = ?";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, newPassword);  // 새 비밀번호 대입
        pstmt.setString(2, userID);  // 사용자 ID 대입
        
        // 쿼리 실행 (변경된 행의 개수 반환)
        int result = pstmt.executeUpdate();
        
        if(result > 0) {
            // 업데이트 성공 - JavaScript에 'success' 반환
            out.print("success");
        } else {
            // 업데이트 실패 (해당 ID가 없거나 변경 안됨)
            out.print("fail");
        }
        
    } catch(Exception e) {
        // 에러 발생 시 (DB 연결 실패, SQL 오류 등)
        e.printStackTrace();
        out.print("error: " + e.getMessage());
    } finally {
        // 자원 정리 (메모리 누수 방지)
        if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
        if(conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>
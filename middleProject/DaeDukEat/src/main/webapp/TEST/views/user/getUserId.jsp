<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // findid.jsp에서 전달받은 데이터 가져오기
    String userName = request.getParameter("userName");  // 이름

    String dbURL = "jdbc:oracle:thin:@112.220.114.131:1521:xe";  // Oracle DB URL
    String dbUser = "team2_202511M";  // DB 사용자명
    String dbPassword = "java";  // DB 비밀번호

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Oracle 드라이버 로드
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // DB 연결
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // 이름과 이메일이 일치하는 사용자의 아이디를 조회
		//Oracle 전통 문법 (기존 방식과 유사)
         String sql = "SELECT u.USER_ID " +
                      "FROM USERS u, MEMBER m " +
                      "WHERE u.USER_ID = m.USER_ID " +
                      "AND u.NAME = ? ";

        
        
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userName);  // 첫 번째 ? 에 이름 대입

        // 쿼리 실행 (결과를 ResultSet으로 받음)
        rs = pstmt.executeQuery();

        if(rs.next()) {
            // 조회 결과가 있으면 (이름과 이메일이 일치하는 사용자가 있음)
            String userId = rs.getString("USER_ID");  // 아이디 가져오기
            out.print(userId);  // JavaScript로 아이디 반환
        } else {
            // 조회 결과가 없으면 (일치하는 사용자가 없음)
            out.print("notfound");  // JavaScript로 'notfound' 반환
        }

    } catch(Exception e) {
        // 에러 발생 시 (DB 연결 실패, SQL 오류 등)
        e.printStackTrace();
        out.print("error: " + e.getMessage());  // 에러 메시지 반환
    } finally {
        // 자원 정리 (반드시 해야 함! 메모리 누수 방지)
        if(rs != null) try { rs.close(); } catch(Exception e) {}
        if(pstmt != null) try { pstmt.close(); } catch(Exception e) {}
        if(conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>
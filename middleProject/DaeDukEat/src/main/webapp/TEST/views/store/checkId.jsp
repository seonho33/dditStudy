<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
String userId = request.getParameter("user_id");  // 👈 변경
String result = "unavailable";

		if(userId != null && !userId.trim().isEmpty()) {
		    userId = userId.trim();
		    
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    
		    try {
		        Class.forName("oracle.jdbc.driver.OracleDriver");
		        
		        String url = "jdbc:oracle:thin:@112.220.114.131:1521:xe";
		        String user = "team2_202511M";
		        String password = "java";
		        conn = DriverManager.getConnection(url, user, password);
		        
		        // MEMBER 테이블에서 USER_ID 중복 체크  // 👈 변경
		        String sql = "SELECT 1 FROM USERS WHERE USER_ID = ?";
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setString(1, userId);
		        rs = pstmt.executeQuery();
		        
		        if (!rs.next()) {
		            result = "available";
		        }
		    } catch(Exception e) {
		        System.err.println("오류: " + e.getMessage());
		        e.printStackTrace();
		    } finally {
		        try {
		            if(rs != null) rs.close();
		            if(pstmt != null) pstmt.close();
		            if(conn != null) conn.close();
		        } catch(SQLException se) {
		            se.printStackTrace();
		        }
		    }
		}
		
		out.print(result);
		out.flush();
%>
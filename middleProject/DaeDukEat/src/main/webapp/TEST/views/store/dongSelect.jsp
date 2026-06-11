<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String dong = request.getParameter("dong");
    
    List<Map<String, String>> resultList = new ArrayList<>();
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
    	 // 1. JDBC 드라이버 로드
        Class.forName("oracle.jdbc.OracleDriver");
        
        // 2. 데이터베이스 연결
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // 
        String user = "TEST";   // 오라클 사용자
        String password = "java";  // 오라클 비밀번호
        
        conn = DriverManager.getConnection(url, user, password);
        
        // ⚠️ 테이블명과 컬럼명 확인 필요
        String sql = "SELECT zipcode, sido, gugun, dong, bunji FROM zip_code WHERE dong LIKE ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + dong + "%");
        
        rs = pstmt.executeQuery();
        
        while(rs.next()) {
            Map<String, String> map = new HashMap<>();
            map.put("zipcode", rs.getString("zipcode"));
            map.put("sido", rs.getString("sido"));
            map.put("gugun", rs.getString("gugun"));
            map.put("dong", rs.getString("dong"));
            map.put("bunji", rs.getString("bunji") != null ? rs.getString("bunji") : "");
            resultList.add(map);
        }
        
    } catch(Exception e) {
        e.printStackTrace();
        out.print("[]"); // 에러 시 빈 배열 반환
        return;
    } finally {
        try {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
            if(conn != null) conn.close();
        } catch(SQLException se) {
            se.printStackTrace();
        }
    }
    
    // JSON 형식으로 응답
    out.print("[");
    for(int i = 0; i < resultList.size(); i++) {
        Map<String, String> map = resultList.get(i);
        out.print("{");
        out.print("\"zipcode\":\"" + map.get("zipcode") + "\",");
        out.print("\"sido\":\"" + map.get("sido") + "\",");
        out.print("\"gugun\":\"" + map.get("gugun") + "\",");
        out.print("\"dong\":\"" + map.get("dong") + "\",");
        out.print("\"bunji\":\"" + map.get("bunji") + "\"");
        out.print("}");
        if(i < resultList.size() - 1) out.print(",");
    }
    out.print("]");
%>
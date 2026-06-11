package kr.or.ddit.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCUtil2 {
	static {
		//1.드라이버 로딩(옵션) 확인차 1번만 실행
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		
	}
	
	/**DB에 접속하기
	 * @return Connection 객체 또는 null 반환
	 * 
	 * url, username, password 입력해서 Connection 바꾸기
	 */
	public static Connection getConnection() {
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String username = "DSH9603";
		String password = "java";
		
		
		try {
			return DriverManager.getConnection(
					url,
					username,
					password);
		}catch (SQLException e) {
			e.printStackTrace();
			return null;
		} 
	}

	/**
	 * 종료(사용했던 자원을 반납한다.)
	 * @param conn
	 * @param stmt
	 * @param pstmt
	 * @param rs
	 */
	public static void close(Connection conn, Statement stmt, PreparedStatement pstmt, ResultSet rs) {
		if(rs!=null) try {rs.close();}catch(SQLException ex) {};
		if(stmt!=null) try {stmt.close();}catch(SQLException ex) {};
		if(pstmt!=null) try {pstmt.close();}catch(SQLException ex) {};
		if(conn!=null) try {conn.close();}catch(SQLException ex) {};
	}
}
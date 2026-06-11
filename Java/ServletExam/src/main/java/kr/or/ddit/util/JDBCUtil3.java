package kr.or.ddit.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;


/*
   db.properties 파일의 내용을 가져와서 DB정보로 사용하는 방법
   방법2) ResourceBundle 객체 이용하기
*/
public class JDBCUtil3 {
	
	static ResourceBundle bundle; // 객체변수 선언
	
	static {
		
		// 1. 드라이버 로딩(옵션)
		try {
			// 객체 생성
			bundle = ResourceBundle.getBundle("config/db");
			
			Class.forName(bundle.getString("driver"));
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * DB에 접속하기
	 * @return Connection 객체 또는 null 반환됨.
	 */
	public static Connection getConnection() {
		
		try {
			return DriverManager.getConnection(
					bundle.getString("url"), 
					bundle.getString("username"), 
					bundle.getString("password"));
		} catch (SQLException e) {
			e.printStackTrace();
			
			return null;
		}
	}
	
	/**
	 * 종료(사용했던 모든 자원을 반납한다.)
	 * @param conn
	 * @param stmt
	 * @param pstmt
	 * @param rs
	 */
	public static void close(Connection conn, 
							Statement stmt,
							PreparedStatement pstmt,
							ResultSet rs) {
		if(rs!=null) try {rs.close();}catch(SQLException ex) {};
		if(stmt!=null) try {stmt.close();}catch(SQLException ex) {};
		if(pstmt!=null) try {pstmt.close();}catch(SQLException ex) {};
		if(conn!=null) try {conn.close();}catch(SQLException ex) {};
	}
	
}

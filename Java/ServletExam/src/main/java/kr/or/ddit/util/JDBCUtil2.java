package kr.or.ddit.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;


/*
   db.properties 파일의 내용을 가져와서 DB정보로 사용하는 방법
   방법1) Properties객체 이용하기
*/
public class JDBCUtil2 {
	
	static Properties prop; // 객체변수 선언
	
	static {
		
		// 1. 드라이버 로딩(옵션)
		try {
			// 객체 생성
			prop = new Properties();
			
			prop.load(new FileInputStream("./res/db.properties"));
			
			Class.forName(prop.getProperty("driver"));
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
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
					prop.getProperty("url"), 
					prop.getProperty("username"), 
					prop.getProperty("password"));
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

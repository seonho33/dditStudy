package kr.or.ddit.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class T02JdbcTest {
	/*
		문제1) 사용자로부터 lprod_id 값을 입력받아서 입력한 값보다 lprod_id가 큰 데이터를 출력하시오
	*/	
	public static void main(String[] args) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		Statement stmt =null;
		ResultSet rs = null;
		Scanner scanner = new Scanner(System.in);
		
		
		
		try {
			// 1. 드라이버 로딩(옵션)
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String username = "DSH9603";
			String password = "java";
			conn = DriverManager.getConnection(url,username,password);
			
			stmt = conn.createStatement();
			int lprodId = scanner.nextInt();
			
			String sql = "select * from lprod \n";
			sql += "where lprod_id > "+lprodId;
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				//컬럼의 데이터를 가져오는 방법
				//방법1) rs.get자료형이름("컬럼명")
				//방법2) rs.get자료형이름("컬럼번호") => 컬럼번호는 1부터시작
				System.out.println("lprod_ID : " + rs.getInt("lprod_id"));
				System.out.println("lprod_GU : " + rs.getString(2));
				System.out.println("lprod_NAME : " + rs.getString("lprod_name"));
				System.out.println("==========================================");
			}
			System.out.println("출력 끝");
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			// 6. 종료(사용했던 모든 자원을 반납한다.)
			if(rs!=null) try {rs.close();}catch(SQLException ex) {};
			if(stmt!=null) try {stmt.close();}catch(SQLException ex) {};
			if(pstmt!=null) try {pstmt.close();}catch(SQLException ex) {};
			if(conn!=null) try {conn.close();}catch(SQLException ex) {};
		}
	}
}

package kr.or.ddit.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class T03JdbcTest_Insert {
	public static void main(String[] args) {
		/*		
		lprod_id : 101, lprod_gu : N101, lprod_name : 농산물
		lprod_id : 102, lprod_gu : N102, lprod_name : 수산물
		lprod_id : 103, lprod_gu : N103, lprod_name : 축산물
		
		위 3개의 데이터를 DB에 추가하기
		*/
		
		
		Connection conn = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String username = "DSH9603";
			String password = "java";
			conn = DriverManager.getConnection(url,username,password);
			
			stmt = conn.createStatement();
			
			//삭제하는 쿼리
			String sql = "delete from lprod where lprod_id in (101,102,103)";
			int cnt = stmt.executeUpdate(sql);
			System.out.println("총 " +cnt + "건의 데이터 삭제완료!");
			
			/*
			 * sql = "insert into lprod (lprod_id,lprod_gu,lprod_name) " +
			 * " values(101,'N101','농산물') "; cnt = stmt.executeUpdate(sql);
			 * 
			 * sql = "insert into lprod (lprod_id,lprod_gu,lprod_name) " +
			 * " values(102,'N102','수산물')"; cnt += stmt.executeUpdate(sql);
			 * 
			  sql = "insert into lprod (lprod_id,lprod_gu,lprod_name) " +
			  " values(103,'N103','축산물')"; cnt += stmt.executeUpdate(sql);
			 */			
			
			  sql = "insert into lprod (lprod_id,lprod_gu,lprod_name) " +
			  " values(?,?,?)";
			  pstmt = conn.prepareStatement(sql);
			  pstmt.setInt(1, 101);
			  pstmt.setString(2, "N101");
			  pstmt.setString(3, "농산물");
			  
			  cnt = pstmt.executeUpdate();
			  
			  pstmt = conn.prepareStatement(sql);
			  pstmt.setInt(1, 102);
			  pstmt.setString(2, "N102");
			  pstmt.setString(3, "수산물");
			  
			  cnt += pstmt.executeUpdate();

			  pstmt = conn.prepareStatement(sql);
			  pstmt.setInt(1, 103);
			  pstmt.setString(2, "N103");
			  pstmt.setString(3, "축산물");
			  
			  cnt += pstmt.executeUpdate();
			  
			if(cnt>=0) {
				System.out.println("총 "+cnt+ "건의 등록작업 성공..!");
			}
			
			
		}catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
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

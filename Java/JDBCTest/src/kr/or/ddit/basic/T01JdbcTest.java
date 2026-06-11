package kr.or.ddit.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class T01JdbcTest {
	public static void main(String[] args) {
/*		
	JDBC를 이용한 데이터베이스 처리 순서
	
	JDBC드라이버 로딩 => 해당 DB에 접속하기 => 질의(SQL명령 수행)
	=> 질의 결과를 받아서 처리하기 => 종료(자원반납)
	
	1.JDBC드라이버 로딩(옵션)
	  => JDBC 드라이버는 DB를 만든 회사에서 제공된다.
	  Class.forName("oracle.jdbc.dirver.OracleDriver");
	  
	2.접속하기: 접속이 성공하면 Connection 객체가 반환된다.
	 		 DriverManager.getConnection()메서드를 이용한다..
	3.질의하기: Statement객체 또는 PreparedStatement객체를 생성하여
			  SQL문을 실행한다.
	4.결과처리: 
	 1) SQL문이 select문일 경우 => ResultSet 객체가 반환된다.
	 						   ResultSet 객체를 이용하여 결과데이터를 가져온다.
	 2) SQL문이 insert, update, delete 문일 경우 => 정수값을 반환한다.
	 	(정수값은 실행에 성공한 레코드 수를 의미한다.)
*/		
		//JDBC 작업에 필요한 객체변수 선언
		Connection conn = null;
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			// 1. 드라이버 로딩(옵션)
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// 2. 접속하기
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String username = "DSH9603";
			String password = "java";
			conn = DriverManager.getConnection(url,username,password); 
			
			// 3. Statement 객체 생성하기 => Connection 객체를 이용한다.
			stmt = conn.createStatement();
			
			// 4. SQL문을 Statement 객체를 이용하여 실행하고 실행결과를 
			//    ResultSet 객체를 이용해 가져온다.
			
			String sql = "select * from lprod";
			rs = stmt.executeQuery(sql);
			
			// rs.next() => ResultSet 객체의 데이터를 가리키는 포인터를
			//				다음 레코드로 이동시키고 그 곳에 데이터가 있으면
			//				true, 없으면 false 를 반환한다.
			while(rs.next()) {
				//컬럼의 데이터를 가져오는 방법
				//방법1) rs.get자료형이름("컬럼명")
				//방법2) rs.get자료형이름("컬럼번호") => 컬럼번호는 1부터시작
				System.out.println("lprod_id : " + rs.getInt("lprod_id"));
				System.out.println("lprod_id : " + rs.getString(2));
				System.out.println("lprod_id : " + rs.getString("lprod_name"));
				System.out.println("==========================================");
			}
			System.out.println("출력 끝");
			
		} catch (ClassNotFoundException e) {
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
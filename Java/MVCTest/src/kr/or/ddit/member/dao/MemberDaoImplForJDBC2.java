package kr.or.ddit.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.util.JDBCUtil3;

public class MemberDaoImplForJDBC2 implements IMemberDao {
	
	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	Scanner scan = new Scanner(System.in);
	
	@Override
	public int insertMember(MemberVO mv) {
		int cnt =0;
		try {
			conn = JDBCUtil3.getConnection();
			
			String sql = "INSERT INTO MYMEMBER(MEM_ID,MEM_NAME,MEM_TEL,MEM_ADDR)\n"
					+ " VALUES (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,mv.getMemId());
			pstmt.setString(2,mv.getMemName());
			pstmt.setString(3,mv.getMemTel());
			pstmt.setString(4,mv.getMemAddr());
			
			cnt = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		return cnt;
	}

	@Override
	public int updateMember(MemberVO mv) {
		int cnt = 0;
		
		try {
			conn = JDBCUtil3.getConnection();
			
			String sql = "UPDATE  MYMEMBER\n"
					+ "SET     MEM_NAME    = ?,\n"
					+ "        MEM_TEL     = ?,\n"
					+ "        MEM_ADDR    = ?\n"
					+ "WHERE   MEM_ID  = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mv.getMemName());
			pstmt.setString(2, mv.getMemTel());
			pstmt.setString(3, mv.getMemAddr());
			pstmt.setString(4, mv.getMemId());
			
			 cnt = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		return cnt;
	}

	@Override
	public boolean checkMember(String memId) {
		boolean isExist = false;
		
		try {
			conn = JDBCUtil3.getConnection();
			
			String sql = "SELECT  COUNT(*) AS CNT \n"
						+ "FROM    MYMEMBER\n"
						+ "WHERE   MEM_ID= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memId);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int cnt = rs.getInt("cnt");
				if(cnt >0) {
					isExist = true;
				}
			}
			
		} catch (Exception e) {
		}finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		return isExist;
	}

	@Override
	public int deletMember(String memId) {
		int result =0;
		
		try {
			conn = JDBCUtil3.getConnection();
			
			String sql = "delete from mymember where mem_id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memId);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		
		return result;
	}

	@Override
	public List<MemberVO> getAllMember() {
		
		List<MemberVO> memList = new ArrayList<MemberVO>();
		
		try {
			System.out.println();
			System.out.println("-----------------------------");
			System.out.println(" ID\t생성일\t\t이 름\t전화번호\t주소");
			System.out.println("-----------------------------");
			
			conn = JDBCUtil3.getConnection();
			
			String sql = "select * from mymember"
					+ 	 " order by 1";
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);

			
			while(rs.next()){
				String memId = rs.getString(1);
				String memName = rs.getString("mem_name");
				String memTel = rs.getString("mem_tel");
				String memAddr = rs.getString("mem_addr");
				
				LocalDate regData = rs.getTimestamp("reg_dt").toLocalDateTime().toLocalDate();
				
				MemberVO mv = new MemberVO(memId, memName, memTel, memAddr);
				mv.setRegDt(regData);
				
				memList.add(mv);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		return memList;
	}

	@Override
	public List<MemberVO> searchMember(MemberVO mv) {
		// TODO Auto-generated method stub
		return null;
	}
}

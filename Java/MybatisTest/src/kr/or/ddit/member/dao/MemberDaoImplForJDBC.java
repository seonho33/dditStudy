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

public class MemberDaoImplForJDBC implements IMemberDao{
	
	private static IMemberDao memDao = new MemberDaoImplForJDBC();
	
	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	Scanner scan = new Scanner(System.in);
	
	private MemberDaoImplForJDBC() {

	}

	public static IMemberDao getInstance() {
		return memDao;
	}
	
	@Override
	public int insertMember(MemberVO mv) {
		boolean isExist;
		int cnt =0;
		String memId= "";
		
		do {
		System.out.println();
		System.out.println("추가할 회원정보를 입력해 주세요.");
		System.out.print("회원ID >>");
		memId = scan.next();
		isExist = checkMember(memId);
		if(isExist) {
			System.out.println("회원ID가 " +memId+"인 회원은 이미 존재합니다.");
			System.out.println("다시 입력해 주세요");
		}
		
		}while(isExist);
		
		System.out.print("회원이름 >>");
		String memName = scan.next();
		
		System.out.print("회원 전화번호 >>");
		String memTel = scan.next();
		
		scan.nextLine(); // 입력버퍼에 남아있는 엔터키 제거용
		System.out.print("회원 주소 >>");
		String memAddr = scan.nextLine();
		
		///////////////////////////////////////////
		
		try {
			conn = JDBCUtil3.getConnection();
			
			String sql = "INSERT INTO MYMEMBER(MEM_ID,MEM_NAME,MEM_TEL,MEM_ADDR)\n"
					+ " VALUES (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,memId);
			pstmt.setString(2,memName);
			pstmt.setString(3,memTel);
			pstmt.setString(4,memAddr);
			
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
		
		memId = scan.next();
		int cnt = 0;
		
		try {
			conn = JDBCUtil3.getConnection();
			
			String sql = "delete from mymember where mem_id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memId);
			cnt = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		return cnt;
	}



	@Override
	public List<MemberVO> searchMember(MemberVO mv) {
		List<MemberVO> memList = new ArrayList<MemberVO>();
		
		try {
			conn = JDBCUtil3.getConnection();
		
			String sql = "Select * from mymember where 1=1";
			
			if(mv.getMemId() !=null && !mv.getMemId().equals("")) {		//다이나믹 쿼리 작성
				sql +=" and mem_id = ?";
			}
			if(mv.getMemName() !=null && !mv.getMemName().equals("")) {
				sql +=" and mem_name = ?";
			}
			if(mv.getMemTel() !=null && !mv.getMemTel().equals("")) {
				sql +=" and mem_tel = ?";
			}
			if(mv.getMemAddr() !=null && !mv.getMemAddr().equals("")) {
				sql +=" and mem_addr like '%'||?||'%'";
			}
			pstmt = conn.prepareStatement(sql);
			int index = 1; // 물음표 위치정보
			
			if(mv.getMemId() !=null && !mv.getMemId().equals("")) {
				pstmt.setString(index++, mv.getMemId());
			}
			if(mv.getMemName() !=null && !mv.getMemName().equals("")) {
				pstmt.setString(index++, mv.getMemName());
			}
			if(mv.getMemTel() !=null && !mv.getMemTel().equals("")) {
				pstmt.setString(index++, mv.getMemTel());
			}
			if(mv.getMemAddr() !=null && !mv.getMemAddr().equals("")) {
				pstmt.setString(index++, mv.getMemAddr());
			}
			
			rs = pstmt.executeQuery();
		
			while(rs.next()){
				String memId = rs.getString(1);
				String memName = rs.getString("mem_name");
				String memTel = rs.getString("mem_tel");
				String memAddr = rs.getString("mem_addr");
				
				LocalDate regData = rs.getTimestamp("reg_dt").toLocalDateTime().toLocalDate();
				
				MemberVO mv2 = new MemberVO(memId, memName, memTel, memAddr);
				mv2.setRegDt(regData);
				
				memList.add(mv2);
			}
				
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		
		
		return memList;
	}

	@Override
	public List<MemberVO> getAllMember() {
		
		List<MemberVO> memList = new ArrayList<MemberVO>();
		
		try {
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
}

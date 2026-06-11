package kr.or.ddit.hotel.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import kr.or.ddit.Util.JDBCUtil;
import kr.or.ddit.hotel.Hotel;
import kr.or.ddit.hotel.vo.PeopleVO;

public class HotelDaoImplForJDBC implements IHotelDao {
	
	private static IHotelDao hotDao = new HotelDaoImplForJDBC();
	
	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;

	Scanner scan;
	public HotelDaoImplForJDBC() {
		scan = new Scanner(System.in);
	}
	
	@Override
	public int chackIn(PeopleVO p) {
		
		boolean isExist;
		int cnt=0;
		Integer hotelkey = 0; 
		
		do {
			System.out.println();
			System.out.println("어느방에 체크인 하시겠습니까?");
			System.out.print("방번호 입력 >>");
			hotelkey = scan.nextInt();
			isExist = checkHotel(hotelkey);
			if(isExist) {
				System.out.println("이미 "+hotelkey +"는 체크인된 방입니다");
				System.out.println("다른방을 선택해주십시오");
			}
		}while(isExist);
		
		System.out.print("회원이름 >>");
		String hotelName = scan.next();
		
		try {
			conn =JDBCUtil.getConnection();
			
			String sql = "INSERT INTO MYHOTEL(HOTEL_ID,HOTEL_NAME) "
					+ " VALUES(?,?)";
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, stmt, pstmt, rs);
		}
		
		
		return cnt;
	}

	@Override
	public int chackOut(PeopleVO p) {
		int cnt=0;
		
		return cnt;
	}

	@Override
	public List<Hotel> displayAll() {
		List<Hotel> h = new ArrayList<Hotel>();
		
		return h;
	}
	
	@Override
	public boolean checkHotel(Integer key) {
		boolean isExist = false;
		
		try {
			conn = JDBCUtil.getConnection();
			
			String sql = "SELECT COUNT(*) AS CNT"
					+ "FROM		MYHOTEL"
					+ "WHERE	HOTEM_ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, key);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int cnt = rs.getInt("CNT");
				if(cnt >0) {
					isExist = true;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, stmt, pstmt, rs);
		}
		return isExist;
	}

}


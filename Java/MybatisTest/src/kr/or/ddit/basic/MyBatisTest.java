package kr.or.ddit.basic;

import java.io.IOException;
import java.io.Reader;
import java.nio.charset.Charset;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.or.ddit.member.vo.MemberVO;


public class MyBatisTest {
	public static void main(String[] args) {
		// MyBatis를 이용하여 DB작업 처리하기
		// 1. myBatis의 환경설정 파일을 읽어와 SqlSessionFactory 객체를 생성한다.
		// res의 config 파일들.. connection 에 관련된..
		// mapper SQL문 작성하는곳
		// main Factory로 sqlsession만들어서 sql 읽고 실행하는곳
		
		
		SqlSessionFactory sqlSessionFactory = null;
		
		try {
			//	1-1. xml 설정파일 내용 읽어오기
			
			// 설정파일의 한글깨짐을 방지하기 위해...
			Charset charset = Charset.forName("UTF-8");	
			Resources.setCharset(charset);
			//driver,url,username,password...가져오기?
			Reader rd = Resources.getResourceAsReader("config/mybatis-config.xml");
			
			// 1-2. Reader 객체를 이용하여 가져온 데이터로 SqlSessionFactory 객체 생성하기
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(rd);
			
			rd.close();	// 사용한 스트림객체 닫아주기...
			
		}catch(IOException ex) {
			ex.printStackTrace();
		}
		///////////////////////////////////////
		
		// 2. 실행할 SQL문에 맞는 쿼리문을 호출해서 원하는 직업을 수행한다.
		
		// 2-1 insert 작업 연습
		System.out.println("insert작업 시작");
		
		// 1) 저장할 데이터를 VO에 담는다.
		MemberVO mv = new MemberVO();
		mv.setMemId("A003");
		mv.setMemName("도선호");
		mv.setMemTel("1111-2222");
		mv.setMemAddr("대전");
		
		// 2) SqlSession 객체를 이용하여 해당 쿼리문을 실행한다..
		// 형식) sqlsession객체.insert("namespace값.id값", 파라미터 값);
		// 반환값 : 성공한 메서드 수

		SqlSession session = sqlSessionFactory.openSession(false);
		
		try {
			int cnt = session.insert("member.insertMember", mv);
			
			if(cnt>0) {
				System.out.println("insert 작업 성공!");
				session.commit();
			}else {
				System.out.println("insert 작업 실패!!");
			}
		}catch(PersistenceException ex) {
			ex.printStackTrace();
			session.rollback();
		}finally {
			session.close();
		}
		
		System.out.println("---------------------------------------------");
		
		// 2-2. update 연습
		System.out.println("update작업 시작");
		mv = new MemberVO();
		mv.setMemId("A003");
		mv.setMemName("도");
		mv.setMemTel("123");
		mv.setMemAddr("대전시");
		
		session = sqlSessionFactory.openSession(false);
		
		try {
			// update()메서드의 반환값도 성공한 레코드 수이다.
			int cnt = session.update("member.updateMember",mv);
			
			if(cnt>0) {
				System.out.println("업데이트 작업 성공...");
				session.commit();
			}else {
				System.out.println("업데이트 작업 실패...");
			}
			
		}catch (PersistenceException e) {
			e.printStackTrace();
		}finally {
			session.close();
		}
		
		/*
		 * System.out.println("--------------------------------------------------");
		 * System.out.println("delet 작업 시작");
		 * 
		 * session = sqlSessionFactory.openSession(false); try {
		 * 
		 * int cnt = session.delete("memberTest.deleteMember","A003"); if(cnt>0) {
		 * System.out.println("삭제 작업 성공..."); session.commit(); }else {
		 * System.out.println("삭제 작업 실패..."); } }catch(PersistenceException e) {
		 * e.printStackTrace(); }finally { session.close(); }
		 */
		
		// 2-4 select 연습
		// 1) 응답의 결과가 여러개일 경우 ...
		 System.out.println("-------------------------------------------------");
		 System.out.println("select 작업(결과가 여러개일 경우...)");
		 
		 session = sqlSessionFactory.openSession(false);
		 
		 try {
			 List<MemberVO> memList = session.selectList("member.getAllMember");
			 for(MemberVO mv2 : memList) {
				 System.out.println("회원ID : " + mv2.getMemId());
				 System.out.println("회원Name : " + mv2.getMemName());
				 System.out.println("회원Tel : " + mv2.getMemTel());
				 System.out.println("회원Addr : " + mv2.getMemAddr());
				 System.out.println("등록일 : " + mv2.getRegDt());
				 System.out.println("================================");
			 }
			 System.out.println("전체 회원정보 출력 완료....");
		 } catch (Exception e) {
			e.printStackTrace();
		 }finally {
			session.close();
		 }
		 System.out.println("-----------------------------------------------");
		 System.out.println("select 작업(결과가 1개인 경우..)");
		 
		 session = sqlSessionFactory.openSession();
		 
		 try {
			 Map<String, Object> hmap = session.selectOne("member.getMember","A003");

				  System.out.println("회원ID : " + hmap.get("MEM_ID"));
				  System.out.println("회원Name : " + hmap.get("MEM_NAME"));
				  System.out.println("회원Tel : " + hmap.get("MEM_TEL"));
				  System.out.println("회원Addr : " + hmap.get("MEM_ADDR"));
				  System.out.println("등록일 : " + hmap.get("REG_DT"));
				 
			 System.out.println("================================");
		} catch (Exception e) {
			System.out.println("작업 실패...");
			e.printStackTrace();
		}finally {
			session.close();
		}
		 

	}
}
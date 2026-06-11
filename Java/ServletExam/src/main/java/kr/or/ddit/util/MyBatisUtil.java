package kr.or.ddit.util;

import java.io.IOException;
import java.io.Reader;
import java.nio.charset.Charset;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * SqlSession 객체를 제공하는 팩토리 클래스
 */
public class MyBatisUtil {
	private static SqlSessionFactory sqlSessionFactory;
	
	static {
		
		try {
			// 1-1. xml 설정파일 내용 읽어오기
			
			// 설정파일의 한글깨짐을 방지하기 위해서...
			Charset charset = Charset.forName("UTF-8"); 
			Resources.setCharset(charset);
			
			Reader rd = Resources
					.getResourceAsReader("config/mybatis-config.xml");
			
			// 1-2. Reader객체를 이용하여 SqlSessionFactory객체 생성하기
			sqlSessionFactory = 
					new SqlSessionFactoryBuilder().build(rd);
			
			rd.close(); // 사용한 스트림객체 닫아주기
			
		}catch(IOException ex) {
			ex.printStackTrace();
		}
	}
	
	/**
	 * SqlSession객체를 제공하기 위한 정적 팩토리 메서드
	 * @return SqlSession 객체
	 */
	public static SqlSession getSqlSession() {
		return sqlSessionFactory.openSession();
	}
	
	/**
	 * SqlSession객체를 제공하기 위한 정적 팩토리 메서드
	 * @param autoCommit 오토커밋 여부
	 * @return SqlSession 객체
	 */
	public static SqlSession getSqlSession(boolean autoCommit) {
		return sqlSessionFactory.openSession(autoCommit);
	}
	
}

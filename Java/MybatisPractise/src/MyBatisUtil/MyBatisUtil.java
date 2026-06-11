package MyBatisUtil;

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
	//static으로 sqlSessionFactory 객체 생성
	private static SqlSessionFactory sqlSessionFactory;
	static {
		try {
			// 1-1 xml 설정파일 내용 읽어오기
			//한글 깨짐 방지를 위해
			Charset charset = Charset.forName("UTF-8");
			Resources.setCharset(charset);
			//driver,url,...;
			Reader rd = Resources.getResourceAsReader("config/mybatis-config.xml");
			
			//1-2. Reader 객체를 이용해 가져온 데이터로 sqlsessionFactory 객체 생성
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(rd);
			
			rd.close();
		}catch(IOException ex) {
			ex.printStackTrace();
		}
	}
	
	/**
	 * SqlSession 객체를 제공하기 위한 정적 팩토리 메서드
	 * @return SqlSession 객체
	 */
	public static SqlSession getSqlSession() {
		return sqlSessionFactory.openSession();
	}
	
	/**
 	* SqlSession 객체를 제공하기 위한 정적 팩토리 메서드
 	* SqlSession 객체 오버로딩
 	* @param autoCommit autoCommit 오토커밋 여부
 	* @return SqlSession 객체
 	*/
	public static SqlSession getSqlSession(boolean autoCommit) {
		return sqlSessionFactory.openSession(autoCommit);
	}

}
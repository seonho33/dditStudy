module kr.or.ddit.mybatisTest {
	
	requires org.mybatis;
	requires java.sql;
	/*
		opens : 지정된 패키지를 다른 모듈에서 리플렉션을 통해 접근할 수 있도록 허용한다.
	*/
	opens config; //myBatis가 config 패키지에 접근할 수 있도록 해준다.
	opens mapper; //myBatis가 mapper 패키지에 접근할 수 있도록 해준다.
	opens kr.or.ddit.member.vo;
}
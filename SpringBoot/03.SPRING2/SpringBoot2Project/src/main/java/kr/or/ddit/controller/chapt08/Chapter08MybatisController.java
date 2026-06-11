package kr.or.ddit.controller.chapt08;

public class Chapter08MybatisController {

	/*
		[8장 : 마이바티스]
		
	1. Oracle Database 설치
		- https://junesker.tistory.com/98	// Docker로 Oracle 23c 설치(Oracle-23ai-free 버전)
		- https://junesker.tistory.com/99	// sqlDeveloper 이용하여 Oracle 23c 시스템 계정 접속
		
	2. Oracle SQLDeveloper 설치
	
		# 오라클 SQLDeveloper 설치 참고
		- https://junesker.tistory.com/81
		
	3. 데이터소스 설정
	
	- SpringBoot가 아닌 일반적인 Spring Legacy 설정에서는 xml을 활용하여 dataSource를 설정합니다.
	  dataSource 를 설정하기 위한 여러가지 자원들이 존재하는데, mybatis 설정, db 접속 정보, mapper
	  위치 등을 활용해 SqlSessionFactory 빈 생성을 통해 SqlSessionTemplate 이라는 최종 생산품에 
	  해당하는 객체를 만들 수 있습니다.
	  SqlSessionTemplate 객체는 데이터 베이스 접속 정보, mapper 의 위치 , mybatis 의 설정 정보를 가지고 있기
	  때문에 요청하고자 하는 기능에 따른 쿼리의 결과를 요청 할 수 있습니다.
	  SpringBoot 는 이와 같은 설정 자체가 이미 시스템화 되어있습니다. 우리가 별 다른 설정을 하지 않아도 이미
	  설정이 되어 있기 때문에 설정에 번거로움과 설정에 어려움이 많이 줄었습니다.
	  
	  - application.properties 설정
	  > oracle database 및 mybatis 설정
	  
	4. 마이바티스란?
	
		마이바티스는 자바 퍼시스턴스 프레임워크의 하나로 XML 서술자나 어노테이션을 이용하여 저장, 프로시저나 SQL
		문으로 객체들을 연결시킵니다. 마이바티스는 Apachne 라이센스 2.0으로 배포되는 자유 소프트웨어입니다.
		
		1) 마이바티스를 사용함으로써 얻는 이점
		-SQL의 체계적인 관리
		-자바 객체와 SQL 입출력 값의 투명한 바인딩
		-동적 SQL 조합
		
		2) 마이바티스 설정
		
			# Mybatis 설정
			2-1) pom.xml 설정
			- starter project 생성 시, 추가한 dependency
				> mybatis-spring-boot-starter
				> spring boot-starter-jdbc
			2-2) application-properties 설정
			- datasource, mybatis 설정
			
		3) 마이바티스 플러그인 설정
		
			# Mybatipse 설정
			- Help > Eclipse Marketplace > mybatis 검색 Install
			
		4) 관련 테이블 생성
		
			4-1) board 테이블 생성
			4-2) member, member_auth 테이블 생성
			
		5) log 출력 형태 변경
		
			5-1) pom.xml 설정
			- p6spy-spring -boot-starter 라이브러리 추가
			
			5-2) application.properties 설정
			- 기존 설정했던 logging.level 부분을 info level 로 변경(기존엔 debug)
			- 새롭게 추가한 logging.lebel.p6spy=debug level로 변경
			
		6) Lombok 설정
		
			- lombok.jar 파일을 통한 lombok 설정 진행(응용 프로그램)
			> 응용 프로그램을 통해 설정 변경 시, 경로 길이로 인해 프로그램 사용에 문제가 생긴다면 수동으로 진행
			> [선호 방법] 응용 프로그램 창을 위 아래로 크기를 줄여 원래 형태로 복구 후 진행
			
	5. Mapper 인터페이스
	
		-인터페이스의 구현을 mybatis-spring 에서 자동으로 생성 할 수 있다.
		
		1) 마이바티스 구현
		
			1-1) Mapper 인터페이스
			- kr.or.ddit.controller.chapt08.board.mapper 패키지
			> IBoardMapper.java 생성(인터페이스)
			
			1-2) Mapper 인터페이스와 매핑할 Mapper xml
			- mybatis/mapper/board_Mapper.xml 생성
			
			1-3) 게시판 구현 설명
			- 게시판 컨트롤러 만들기 (CrudBoardController.java)
			- 게시판 등록 화면 컨트롤러 메소드 만들기 (crudRegister:get)
			- 게시판 등록 화면 만들기(crud/register.jsp)
			- 여기까지 확인
	
			- 게시판 등록 기능 컨트롤러 메소드 만들기 (crudRegister:post)
			- 게시판 등록 기능 서비스 인터페이스 메소드 만들기
			- 게시판 등록 기능 서비스 클래스 메소드 만들기
			- 게시판 등록 기능 Mapper 인터페이스 만들기
			- 게시판 등록 기능 Mapper xml 쿼리 만들기
			- 게시판 등록 완료 페이지 만드릭(board/success.jsp)
			- 여기까지 확인
	
			- 게시판 목록 기능 컨트롤러 메소드 만들기 (crudList:get)
			- 게시판 목록 기능 서비스 인터페이스 메소드 만들기
			- 게시판 목록 기능 서비스 클래스 메소드 만들기
			- 게시판 목록 기능 Mapper 인터페이스 만들기
			- 게시판 목록 기능 Mapper xml 쿼리 만들기
			- 게시판 목록 완료 페이지 만드릭(board/list.jsp)
			- 여기까지 확인

			- 게시판 수정 기능 컨트롤러 메소드 만들기 (crudModifyForm:get)
			- 게시판 수정 기능 서비스 인터페이스 메소드 만들기
			- 게시판 수정 기능 서비스 클래스 메소드 만들기
			- 게시판 수정 기능 Mapper 인터페이스 만들기
			- 게시판 수정 기능 Mapper xml 쿼리 만들기
			- 게시판 수정 페이지 만들기
			- 여기까지 확인
			
			+삭제기능
			

			- 게시판 목록 화면 검색 페이지 추가 (board/list.jsp)
			- 게시판 검색 기능 서비스 인터페이스 메소드 만들기
			- 게시판 검색 기능 서비스 클래스 메소드 만들기
			- 게시판 검색 기능 Mapper 인터페이스 만들기
			- 게시판 검색 기능 Mapper xml 쿼리 만들기
			- 게시판 검색 페이지 만들기
			- 여기까지 확인
	*/
}

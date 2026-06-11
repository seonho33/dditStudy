package kr.or.ddit.controller;

public class NoticeCRUD___ {
/*

	######################################
	## NOTICE 테이블을 활용한 CRUD  만들기
	## 1-9장 까지 배운 모든 내용을 사용해 CRUD 게시판 만들기
	######################################
	
	1.NOTICE 게시판 개발을 위한 준비사항
	
		# 라이브러리 설정 (pom.xml)
		- 유효성 검사를 위한 lang3.StringUtils
		- 파일 핸들링을 위한 commons-io,commons-fileupload
		- 데이터 베이스 설정을 위한 jdbc, mybatis
		- jsp 개발을 위한 jstl, jasper
		- VO를 편리하게 핸들링 하기위한 lombok
		- logging 을 좀 더 자세하게 처리하기 위한 p6spy-spring-boot-starter
		- JSON 데이터 핸들링을 위한 gson
		
		# NOTICE 테이블
		- NOTICEMEMBER		-- 회원테이블
		- NOTICE			-- 공지사항 게시판 테이블
		- NOTICEFILE		-- 공지사항 게시판 파일 테이블
		- NOTICECOMMENT		-- 공지사항 게시판 댓글 테이블
		
		# NOTICE 페이지
		- 로그인 페이지 (login.jsp)
		- 회원가입 페이지 (register.jsp)
		- 아이디&비밀번호 찾기 페이지 (forget.jsp)
		- 게시판 목록 페이지 (list.jsp)
		- 게시판 상세보기 페이지 (detail.jsp)
		- 게시판 등록, 수정 페이지 (form.jsp)
		- 게시판 마이페이지 (profile.jsp)
		
		# 페이지 모듈화
		- include 디렉티브 이용
		
		# NOTICE CRUD 추가 기능
		
			1) 회원가입
			- 비동기 요청을 이용한 아이디 중복 확인
			- 카카오 주소 API를 이용한 주소검색
			- 카카오 지도 API를 이용한 주소기반의 지도 출력
			- 클라이언트/서버 기본 유효성 검사를 이용한 데이터 검증
			
			2) 아이디 & 비밀번호 찾기
			- 비동기 요청을 이용한 아이디/비밀번호 찾기

			3) 공지사항 게시판 등록
			- CKEditor4를 활용한 게시글 등록 에디터 설정
			- CKEditor4 easyImage 플러그인을 활용한 게시글 등록 시, 내용에 이미지 추가
			
			4) 공지사항 게시판 상세정보
			- 댓글 및 대댓글 구현
			- AbstractView 를 이용한 클래스 View 및 파일 다운로드
			
			5) 공통
			- sweetAlert2를 활용한 알림 메세지
			- Telegram Bot API를 활용한 실시간 알림
			- 파일 업로드 설정, Class 기반의 LocalPath 빈 설정
			- 파일 크기 초과시, 예외처리로 CutomException 처리
			
*/
	
	
	
}

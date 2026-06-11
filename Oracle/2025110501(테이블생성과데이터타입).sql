2025-1105-01) 테이블 생성과 데이터 타입
1. 테이블 생성
(사용형식)
    CREATE TABLE 테이블명(
        컬럼명 데이터타입[(크기)][NOT NULL][DEFAULT 값][,]
                    :
        컬럼명 데이터타입[(크기)][NOT NULL][DEFAULT 값]
    );
    - 'NOT NULL'로 설정된 컬럼은 데이터 입력 명령인 INSERT INTO 명령 사용시
      생략할 수 없음
    - 'DEFAULT 값' : 사용자가 INSERT INTO 명령 사용시 데이터를 입력하지 않으면
      자동으로 입력되는 값을 기술
    - '[NOT NULL]'과 '[DEFAULT 값]'은 동시에 기술할 수 없음 

2. 데이터 타입
 - 문자열, 숫자, 날짜, 기타(2진)
 1) 문자열
    - 고정길이 = CHAR
    - 가변길이 = VARCHAR2 VARCHAR NUMBER LONG CLOB ...
    
(1) CHAR(n [BYTE|CHAR])
    -고정길이 자료 저장
    -2000 BYTE 자료 저장
    -남는 공간은 공백으로 채워짐 한글은 666글자
    
사용예)
    CREATE TABLE CHAR_TBL(
        COL1 CHAR(20),
        COL2 CHAR(20 BYTE),
        COL3 CHAR(20 CHAR)
    );
        
    INSERT INTO CHAR_TBL(COL1,COL2,COL3) VALUES('대전시 중구',
                                                '대전시 중구',
                                                '대전시 중구 계룡로 846');
                                                
    SELECT * FROM CHAR_TBL;
    SELECT LENGTHB(COL1),
           LENGTHB(COL2),
           LENGTHB(COL3)
           FROM CHAR_TBL;
           
 (2) VARCHAR2 (n [BYTE|CHAR])
    - 가변길이 자료 저장
    - 4000 BYTE 자료 저장
    - 남는 공간은 운영체제에게 반납
    - VARCHAR 와 동일
    - 한글은 3BYTE씩 차지, 1333자 까지 사용가능
    
사용예)
    CREATE TABLE VARCHAR_TBL(
        COL1 VARCHAR2(4000),
        COL2 VARCHAR2(4000 BYTE),
        COL3 VARCHAR2(4000 CHAR)
    );
    
    INSERT INTO VARCHAR_TBL VALUES('대전시 중구 계룡로 846',
                                     '대전시 중구 계룡로 846',
                                     '대전시 중구 계룡로 846');
                                     
    SELECT*FROM VARCHAR_TBL;
                                     
    SELECT LENGTHB(COL1),
           LENGTHB(COL2),
           LENGTHB(COL3)
           FROM VARCHAR_TBL;

    (3) LONG
        - 가변길이 데이터 저장
        - 최대 2GB까지 저장
        - 한 테이블에 하나의 LONG타입만 허용
        - 일반 함수(예:LENGTHB, SUBSTR등)는 사용 할 수 없음
        - 기능 개선이 종료됨
        
 사용예)
    CREATE TABLE LONG_TBL(
        COL1 LONG,
 --       COL2 LONG,
        COL3 VARCHAR2(200));
        
        INSERT INTO LONG_TBL(COL1,COL3) VALUES('대전시 중구 계룡로 486','대전시 중구 계룡로 486');
        
        SELECT *FROM LONG_TBL;
        
        SELECT LENGTH(COL1),LENGTH(COL3)
        FROM LONG_TBL;
        
 (4) CLOB(Character LARGE OBJECT)
    - 가변길이
    - 최대 4GB까지 저장
    - LONG 타입을 개선한 자료타입(사용하는 컬럼의 수가 복수개)
    - 일반 함수(예:LENGTHB, SUBSTR등)중 일부는 DBMS_LOB에 있는 특수함수를 사용해야 함
    - 기능 개선이 진행 중(SUBSTR ..등등 은 개선)
    
 사용예)
    CREATE TABLE CLOB_TBL(
                            COL1 CLOB,
                            COL2 CLOB,
                            COL3 LONG,
                            COL4 VARCHAR2(4000)
                            );
    INSERT INTO CLOB_TBL VALUES('대전시 중구 계룡로 486','대전시 중구 계룡로 486','대전시 중구 계룡로 486','대전시 중구 계룡로 486');
    
    SELECT*FROM CLOB_TBL;
    
    SELECT SUBSTR(COL1,5,2) ,SUBSTR(COL2,5,2),SUBSTR(COL4,5,2)
    FROM CLOB_TBL;
    
    SELECT DBMS_LOB.GETLENGTH(COL1) FROM CLOB_TBL;
    
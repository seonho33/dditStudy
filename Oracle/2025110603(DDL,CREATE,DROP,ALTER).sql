2025-1106-03)   DDL(Data Definition Language : 데이터 정의어)
  - 오라클 객체 생성/수정/삭제를 담당하는 명령
  - CREATE, DROP, ALTER

1. 테이블 생성
    CREATE TABLE 명령을 사용
사용형식)
  CREATE TABLE 테이블명(
    컬럼명 데이터타입[(크기)][NOT NULL][DEFAULT 값] [,]
                    :
    [CONSTRAINT 기본키 설정명(*PK_자기테이블명) PRIMARY KEY(컬럼명 [,컬럼명,...]) [,]
    [CONSTRAINT 외래키 설정명1(*FK_자기테이블명_참조테이블명) FOREIGN KEY(컬럼명) REFERENCES 참조하는 테이블명(컬럼명)][,]
                    :
    );
    . '기본키 설정명' : 생성하는 테이블의 기본키를 설정한 것에 부여하는 이름으로 
                    테이블 스페이스에서 유일한 값이어야 함
    . 'PRIMARY KEY(컬럼명 [,컬럼명,...])' : 기본키를 정의하며 복수개의 컬럼이 기본키로 설정되면
                    해당 컬럼을 ','로 구분하여 모두 기술해야 함
                    
    . '외래키 설정명1' : 생성하는 테이블의 외래키를 설정한 것에 부여하는 이름으로
                     테이블 스페이스에서 유일한 값이어야 함
    . 'FOREIGN KEY(컬럼명)' : 해당 테이블에서 외래키로 사용하는 컬럼명
    . 'REFERENES 테이블명(컬럼명)' : 부모 테이블명과 부모 테이블에 사용된 기본키 컬럼명 기술
    **외래키가 복수개인 경우 'CONSTRAINT 외래키 설정명' 절이 해당 외래키 갯수만큼 기술해야 함
    
 사용예)
 CREATE TABLE CUSTOMERS (CUST_ID VARCHAR2(5),CUST_NAME VARCHAR2(50), CUST_ADDR VARCHAR2(200),
 CONSTRAINT PK_CUST PRIMARY KEY(CUST_ID));
 
 CREATE TABLE ORDERS (ORDER_ID VARCHAR2(13), CUST_ID VARCHAR2(5),
 CONSTRAINT PK_OR PRIMARY KEY(ORDER_ID),
 CONSTRAINT FK_OR_CUST FOREIGN KEY(CUST_ID) REFERENCES CUSTOMERS(CUST_ID));
 
 CREATE TABLE PRODUCTS (PID VARCHAR2(10), PNAME VARCHAR2(50), PRICE NUMBER(8),
 CONSTRAINT PK_PRODUCTS PRIMARY KEY(PID));
 
 CREATE TABLE ORDER_PRODUCT (PID VARCHAR2(10), ORDER_ID VARCHAR2(13), ORDER_QTY NUMBER(4),
 CONSTRAINT PK_ORPD PRIMARY KEY (PID, ORDER_ID),
 CONSTRAINT FK_ORPD_PD FOREIGN KEY(PID) REFERENCES PRODUCTS(PID),
 CONSTRAINT FK_ORPD_OR FOREIGN KEY(ORDER_ID) REFERENCES ORDERS(ORDER_ID));

 ALTER TABLE ORDER_PROD RENAME TO ORDER_PRODUCT ; 
 
 INSERT INTO CUSTOMERS VALUES(
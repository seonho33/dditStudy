2025-1107-02)DML(DATA MANIPULATION LANGUAGE : 데이터 조작어)
    -INSERT, UPDATE, DELETE, SELECT, MERGE 등이 제공
-- INSERT
 - 테이블에 자료를 삽입 할 때 사용.
    INSERT INTO 테이블명[(컬럼명,컬럼명 ...)] VALUES(값,값,값 ... );
    -'테이블명[(컬럼명,컬럼명,...)]' 에서 '(컬럼명,컬럼명,...)' 이 생략되면 VALUES 절에서
    모든 컬럼에 저장된 '값'이 기술되어야 함.
    -'(컬럼명,컬럼명,...)'을 기술할 때 기술 순서는 특별히 규정하지 않음. 단, 넣으려는 '값'의 
    순서와 일치해야함
    -'(컬럼명,컬럼명,...)'을 기술할 때 NOT NULL 컬럼을 생략 할 수 없음.
    -여러 테이블에 데이터가 저장될 때 저장 순서는 부모테이블부터 저장되어야 함.
 
    사용예)
    DROP TABLE ORDER_PRODUCT;
    DROP TABLE ORDERS;
    DROP TABLE PRODUCTS;
    DROP TABLE CUSTOMERS2;
 
 INSERT INTO PRODUCTS(PID,PNAME) VALUES ('P10103','필통');
 INSERT INTO CUSTOMERS(CUST_ID,CUST_NAME) VALUES('A0002','이순신');

-------------------------------------
 PID         PNAME              PRICE 
--------------------------------------
P10101      연필                  1000
P10102      지우개                 
P20110      USB(64GB)            20000
P20111      마우스                 
  
  
  


ALTER TABLE CUSTOMERS MODIFY(CUST_NAME VARCHAR(500) DEFAULT 0);


 SELECT * FROM PRODUCTS;
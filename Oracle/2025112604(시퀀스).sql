2025-11-26-04) SEQUENCE
-   자동으로 증가(감소)하는 값을 반환하는 객체
-   테이블에 독립적
--사용형식)
    CREATE SEQUENCE 시퀸스명
        [STRAT WITH n]
        [INCREMENT BY n]
        [MAXVALUE n|NOMAXVALUE]
        [MINVALU n|NOMINVALUE]
        [CYCLE|NOCYCLE]
        [CACHE n|NOCACHE]
        [ORDER|NOORDER]
        
--사용예)
    CREATE SEQUENCE seq_test
        START WITH 100;
    SELECT seq_test.NEXTVAL FROM DUAL;
    SELECT seq_test.CURRVAL FROM DUAL;
    
사용예) 다음 자료를 LPROD테이블에 삽입하시오. 단,LPROD_ID는 스퀸스로 값을 할당하시오
      --------------------------------------------
             LPROD_GU           LPROD_NAME
      --------------------------------------------  
               P501                농산물
               P502                수산물
               P503                수산가공식품

    CREATE SEQUENCE seq_lprod_id
        START WITH 10;
    CREATE SEQUENCE SEQ_LPROD_GU
        START WITH 504;
    
        
    INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NAME)
    VALUES  (seq_lprod_id.NEXTVAL,'P501','농산물')
    
    INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NAME)
    VALUES  (seq_lprod_id.NEXTVAL,'P503','수산가공식품')    
    
    INSERT INTO LPROD(LPROD_ID,LPROD_GU,LPROD_NAME)
    VALUES (SEQ_LPROD_ID.NEXTVAL,'P'||SEQ_LPROD_GU.NEXTVAL,'가공식품')
    
    SELECT *FROM LPROD
    DROP SEQUENCE seq_TEST
    
    INSERT INTO JDBC_BOARD(BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_DATE,BOARD_CONTENT)
    VALUES (BOARD_SEQ.NEXTVAL, ... , ... , SYSDATE, ...)
    
    
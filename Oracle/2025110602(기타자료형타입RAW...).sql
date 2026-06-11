 2025-1106-02) 기타 자료형(이진 자료)
    - RAW, BFILE, BLOB 타입이 제공됨

1) RAW(n)
  - 최대 2000byte 까지 이진 자료 저장
  - 인덱스처리가 가능
  - 작은 자료 처리에 적합하며, 2진과 16진수 형태로 저장 됨
  - 오라클은 이진자료를 변환하거나 해석하지 않는다
  
사용예)
    CREATE TABLE RAW_TBL(COL1 RAW(100), COL2 RAW(2000));
INSERT INTO RAW_TBL VALUES('1100011110101111', HEXTORAW('C7AF'));

SELECT*FROM RAW_TBL;


2) BFILE
  - 최대 4GB 까지 이진 자료 저장
  - 원본자료가 테이블 밖에 저장됨
  - 테이블에는 경로와 파일명이 저장됨
  - 변경이 자주 발생되는 이진자료처리에 적합
  - 객체사용
  
                    데이터 저장순서
  1. 테이블 생성  
  2. 원본파일이 저장된 폴더와 파일명
  3. DIRECTORY 객체 생성 
  (CREATE OR REPLACE DIRECTORY 디렉토리명 AS '절대경로명';)
  4. 저장
  INSERT INTO 컬럼명 VALUES(BFILENAME('디렉토리명','파일명'));
  
사용예)
 1.   
CREATE TABLE BFILE_TBL1(COL1 BFILE);
 2. 
CREATE OR REPLACE DIRECTORY TEST_DIR1 AS 'D:\d_share\A_TeachingMaterial\02_Oracle\work,sample.jpg' ;  
 3. 
INSERT INTO BFILE_TBL1(COL1) VALUES(BFILENAME('TEST_DIR', 'sample.jpg'));
 4.   
SELECT*FROM BFILE_TBL1;
 
 
 3) BLOB(Binary Large OBject)
   - 최대 4GB까지의 이진 자료 저장
   - 원본자료가 테이블 안에 저장됨
   - 변경발생이 드문 이진자료 처리에 적합(입력과 수정이 복잡함)

 CREATE TABLE BLOB_TBL(NO NUMBER, FILE_NAME BLOB); 
 
 CREATE SEQUENCE seq_blob
    START WITH 1;

CREATE OR REPLACE PROCEDURE proc_insert_blob_image(V_FILE_NAME IN VARCHAR2)
  IS
    V_LOCATOR BLOB;
    V_SOURCE_FILE BFILE := BFILENAME('TEST_DIR',V_FILE_NAME);
    V_SRC_OFFSET NUMBER := 1;
    V_DEST_OFFSET NUMBER := 1; 
  BEGIN
    INSERT INTO BLOB_TBL(NO, FILE_NAME) VALUES(seq_blob.NEXTVAL, EMPTY_BLOB())
      RETURNING FILE_NAME INTO V_LOCATOR;
      
    DBMS_LOB.OPEN(V_SOURCE_FILE, DBMS_LOB.LOB_READONLY);
    DBMS_LOB.LOADBLOBFROMFILE(V_LOCATOR,
                              V_SOURCE_FILE,
                              DBMS_LOB.GETLENGTH(V_SOURCE_FILE),
                              V_DEST_OFFSET,
                              V_SRC_OFFSET);
    DBMS_LOB.CLOSE(V_SOURCE_FILE);
    
    COMMIT;
  END;

[실행]
  EXECUTE proc_insert_blob_image('sample.jpg');
  
 SELECT*FROM BOL
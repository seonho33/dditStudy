2025-11-26-03)VIEW 객체
 - 가상의 테이블
 - SELECT 문의 결과 집합
 사용형식)
    CREATE [OR REPLACE] VIEW [(컬럼명,...)] AS
        SELECT 문
            [WITH CHECK OPTION]
            [WITH READ ONLY]

 사용예) 회원테이블에서 마일리지가 5000이상인 회원의 회원번호, 회원명, 마일리지로 뷰를 생성하시오
    CREATE OR REPLACE VIEW v_mileage(MID,MNAME,MILEAGE)
    AS
    SELECT  MEM_ID AS 회원번호,
            MEM_NAME as 회원명,
            MEM_MILEAGE AS 마일리지
    FROM    MEMBER
    WHERE   MEM_MILEAGE>=5000
    
1)뷰 V_MILEAGE의 'e001' 회원의 마일리지를 1500으로 바꿔보아라...
    UPDATE  V_MILEAGE
    SET     MILEAGE = 1500
    WHERE   MID='e001'
    
2) MEMBER 테이블에서 'e001' 회원의 마일리지를 7300으로 변경
    UPDATE  MEMBER
    SET     MEM_MILEAGE = 7300
    WHERE   MEM_ID='e001'
3)뷰 V_MILEAGE 에 다음 자료를 삽입하시오.
    회원번호    : 'a002'
    회원명     : '홍길동'
    AKDLFFLWL : 7800
    
    INSERT INTO V_MILEAGE VALUES('a002','홍길동',7800);

**WITH CHECK OPTION 사용하여 뷰 생성..
    CREATE OR REPLACE VIEW v_mileage
    AS
    SELECT  MEM_ID AS 회원번호,
            MEM_NAME as 회원명,
            MEM_MILEAGE AS 마일리지
    FROM    MEMBER
    WHERE   MEM_MILEAGE>=5000
    WITH CHECK OPTION;
 1) 뷰 V_MILEAGE 에서 홍길동 회원의 마일리지를 2800으로 변경하라..
    UPDATE  V_MILEAGE
    SET     MILEAGE=6800
    WHERE   MNAME='홍길동';
    
 2) 뷰 V_MILEAGE 에서 이혜나 회원의 마일리지를 6300으로 변경하라
    UPDATE  V_MILEAGE
    SET     마일리지=6300
    WHERE   회원명='이혜나'
    
3) MEMBER 테이블에서 'a002'회원의 마일리지를 2800으로 변경
    UPDATE  MEMBER
    SET     MEM_MILEAGE=2800
    WHERE   MEM_NAME='홍길동'

    CREATE OR REPLACE VIEW V_MILEAGE
    AS
    SELECT  MEM_ID,
            MEM_NAME,
            MEM_MILEAGE
    FROM    MEMBER
    WHERE   MEM_MILEAGE>=5000
    WITH READ ONLY
    
     SELECT*FROM v_mileage

1) MEMBER 테이블에서 'a002' 회원의 마일리지를 5800으로 변경
    UPDATE  MEMBER
    SET     MEM_MILEAGE = 5800
    WHERE   MEM_NAME = '홍길동'
    
2) 뷰 V_MILEAGE 에서 'a002' 회원의 마일리지를 변경해보시오..
    UPDATE  V_MILEAGE
    SET     MEM_MILEAGE = 7800
    WHERE   MEM_ID ='a002'
    
    
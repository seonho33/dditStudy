2025-11-27-04)Stored Procedure(Procedure)
 - 반환값이 없는 모듈
 - DML 수행에 주로 사용
사용형식)
    CREATE |[OR REPLACE] PROCEDURE 프로시져명[(변수명 [IN|OUT|INOUT]
                데이터타입 [:=|DEFAULT 값][,]
                                :
                )]

    IS|AS
        선언영역 --변수 상수 커서... 선언
    BEGIN
        실행영역 --비지니스 로직을 처리하기 위한 SQL명령과 PL/SQL 명령 사용
    END;
    
    -'IN|OUT|INOUT' : 매개변수의 역할 설정(IN : 입력용, OUT : 출력용, INOUT :입출력 공용)
                      생략되면 IN으로 간주함...
    -'데이터타입' : 크기를 지정하지 않고 자료의 타입만 지정...
    -':=|DEFAULT 값' : 사용자가 매개변수 설정 후 값을 배당하지 않은 경우 자동 배정(DEFAULT)하거나
                       직접 배정하는 경우 사용
    [실행]
1) OUT 매개변수가 없는 경우
   EXCUTE|EXEC  프로시져명 [(값,...)];

2) OUT 매개변수가 있는 경우
- BLOCK 에서 실행(변수가 요구됨)
  프로시져명 [(값,...)];

**PROD 테이블에 PROD_MILEAGE 값을 변경
  매출가의 0.5%의 정수값
    SELECT  PROD_ID,
            (PROD_PRICE*0.005)
    FROM    PROD
    UPDATE  PROD
    SET     PROD_MILEAGE=ROUND(PROD_PRICE*0.005)
    
사용예) 오늘이 2020년 7월 28일이라고 가정하고 다음 매출자료를 처리하시오
    회원번호 : 't001'
    구매상품 : 'P201000021'
    구매수량 : 5개
    
    CREATE OR REPLACE PROCEDURE PROD_CART_INSERT(
        P_MID IN MEMBER.MEM_ID%TYPE,
        P_PID IN PROD.PROD_ID%TYPE,
        P_QTY IN NUMBER)
    IS
        L_CART_NO       CART.CART_NO%TYPE;  --장바구니 번호가 저장될 변수
        L_MILEAGE       NUMBER :=0;         --마일리지 값이 저장될 변수
        L_CNT           NUMBER :=0;         --오늘 접속한 회원이 있나없나 확인하는 변수
    BEGIN
--  장바구니 번호 생성
        SELECT  COUNT(*) INTO L_CNT
            FROM    CART
            WHERE   SUBSTR(CART_NO,1,8)=TO_CHAR(SYSDATE,'YYYYMMDD');
        IF  (L_CNT =0)
            THEN
            L_CART_NO := TO_CHAR(SYSDATE,'YYYYMMDD')||TRIM('00001');
        ELSE
            SELECT  MAX(CART_NO)+1 INTO L_CART_NO
            FROM    CART
            WHERE   SUBSTR(CART_NO,1,8) = TO_CHAR(SYSDATE,'YYYYMMDD');
        END IF;
-- CART 테이블에 INSERT 하기
        INSERT INTO CART VALUES(P_MID,L_CART_NO,P_PID,P_QTY);
--  REMAIN UPDATE
        UPDATE  REMAIN A
        SET     A.REMAIN_O=REMAIN_O+P_QTY,
                A.REMAIN_J_99=A.REMAIN_J_99-P_QTY,
                A.REMAIN_DATE=SYSDATE
        WHERE   A.PROD_ID=P_PID;
-- MEMBER TABLE의 MEM_MILEAGE UPDATE하기
        SELECT  PROD_MILEAGE * P_QTY INTO L_MILEAGE
        FROM    PROD
        WHERE   PROD_ID=P_PID;
        
        UPDATE  MEMBER B
        SET     MEM_MILEAGE = MEM_MILEAGE + L_MILEAGE
        WHERE   MEM_ID = P_MID;
    COMMIT;
    END;
[실행]
    EXECUTE PROD_CART_INSERT('t001','P201000021',5);
    
사용예)연도와 월을 입력받아 해당기간에 수량을 기준으로 가장 많은 매입이 발생된 상품의 상품번호를 출력하시오...
    CREATE OR REPLACE PROCEDURE PROC_MAX_QTY(
        P_PERIOD  IN  VARCHAR2,
        P_PID     OUT PROD.PROD_ID%TYPE)
    IS
        L_QTY  NUMBER:=0;
        L_SDATE DATE:=TO_DATE(P_PERIOD||TRIM('01'));
        L_LDATE DATE:=LAST_DAY(L_SDATE);
    BEGIN
        SELECT
            PROD_ID,
            SUM(BUY_QTY) 
        INTO    P_PID,
                L_QTY
        FROM    BUYPROD
        WHERE   BUY_DATE BETWEEN L_SDATE AND L_LDATE
        GROUP BY PROD_ID
        ORDER BY 2 DESC
        FETCH FIRST 1 ROW ONLY;
    END;    
[실행]

    DECLARE
        L_PID PROD.PROD_ID%TYPE;
    BEGIN
        PROC_MAX_QTY('202006',L_PID);
        DBMS_OUTPUT.PUT_LINE('가장 많이 매입된 상품의 상품코드 : '||L_PID);
    END;
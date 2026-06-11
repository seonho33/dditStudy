2025-11-28-01)User Defined Function : Function) 사용자정의함수...
-   특징은 PROCEDURE 와 동일함
-   반환 값이 존재함 
--사용형식)
    CREATE [OR REPLACE] FUNCTION 함수명 [(
        변수명 IN|OUT|INOUT 데이터 타입 [:=|DEFAULT 값][,]
                        :
    )
    RETURN 타입
    IS|AS
        선언부 -- 변수, 상수, 커서 선언하는 부분
    BEGIN
        실행영역 -- 비지니스 로직을 처리하기 위함, 명령 또는 SQL문
                -- 반드시 하나 이상의 RETURN 값; 명령이 기술되어야 함
        [EXCEPTION
            예외처리명령;]
    END;

사용예1)상품코드를 입력받아 현재 재고량을 출력하는 함수를 작성하고 이 함수를 이용하여
      상품코드, 상품명, 분류코드, 매출가, 재고량을 조회하시오...(분류코드는 P202)
     
    SELECT
        PROD_ID AS 상품코드,
        PROD_NAME AS 상품명,
        LPROD_GU AS 분류코드,
        PROD_PRICE AS 매출가,
        FN_REMAIN_QTY(PROD_ID) AS 재고량
    FROM    PROD
    WHERE   LPROD_GU='P202'

--(재고량을 출력하는 함수)
    CREATE OR REPLACE FUNCTION FN_REMAIN_QTY
        (P_PROD_ID IN PROD.PROD_ID%TYPE)
    RETURN NUMBER
    IS
        L_QTY NUMBER:=0;
    BEGIN
        SELECT
            REMAIN_J_99 INTO L_QTY
        FROM    REMAIN
        WHERE   PROD_ID=P_PROD_ID
        AND     REMAIN_YEAR = '2019';
    RETURN L_QTY;
    END;

사용예2)년도와 월, 상품코드를 입력 받아 매입수량과 매출수량을 조회하는 함수를 작성하시오...

    SELECT 
        PROD_ID,
        PROD_NAME,
        NVL(FN_GET_BQTY('202006',PROD_ID),0) AS 매입수량,
        NVL(FN_GET_CQTY('202006',PROD_ID),0) AS 매출수량
    FROM    
        PROD
    ORDER BY 1;
(매입수량을 반환하는 함수)
    CREATE OR REPLACE FUNCTION FN_GET_BQTY
        (P_PERIOD IN VARCHAR2,
         P_PROD_ID PROD.PROD_ID%TYPE)
    RETURN NUMBER
    IS
        L_BQTY  NUMBER:=0;                      --매입수량을 저장할 변수
        L_SDATE DATE:=TO_DATE(P_PERIOD||'01');  --해당 일자를 저장하는 변수
    BEGIN
        SELECT  SUM(BUY_QTY) INTO L_BQTY
        FROM    BUYPROD
        WHERE   BUY_DATE BETWEEN L_SDATE AND LAST_DAY(L_SDATE)
        AND     PROD_ID=P_PROD_ID;
    RETURN  L_BQTY;
    END;
(매출수량을 반환하는 함수)
    CREATE OR REPLACE FUNCTION FN_GET_CQTY
        (P_PERIOD VARCHAR2,
         P_PROD_ID IN PROD.PROD_ID%TYPE)
    RETURN NUMBER
    AS
        L_CQTY  NUMBER:=0;
        L_DATE  CHAR(7):=P_PERIOD||'%';
    BEGIN
        SELECT
            SUM(CART_QTY) INTO L_CQTY
        FROM    CART
        WHERE   CART_NO LIKE L_DATE
        AND     PROD_ID = P_PROD_ID;
    RETURN  L_CQTY;
    END;

예시3) 장바구니 번호 생성) 날짜와 회원번호를 입력받아 장바구니 번호를 생성하여 반환하는 함수
    CREATE OR REPLACE FUNCTION GET_CART_NO(
        P_DATE IN DATE,
        P_MEM_ID IN MEMBER.MEM_ID%TYPE)
    RETURN CART.CART_NO%TYPE
    IS
        L_CART_NO   CART.CART_NO%TYPE;                    --장바구니 번호를 저장할 변수
        L_DATE  VARCHAR2(8):=TO_CHAR(P_DATE,'YYYYMMDD'); --해당 날짜를 저장할 변수
        L_CNT   NUMBER:=0;                               --해당 일자의 자료수
        L_MEM_ID    MEMBER.MEM_ID%TYPE;                  --마지막으로 구매한 회원의 회원번호
    BEGIN
        SELECT
            COUNT(*) INTO L_CNT
        FROM    CART
        WHERE   CART_NO LIKE L_DATE||'%';
    IF  (L_CNT=0)
        THEN
            L_CART_NO:=L_DATE||TRIM('00001');
        ELSE
            SELECT  MAX(CART_NO)    INTO L_CART_NO
            FROM    CART
            WHERE   CART_NO LIKE L_DATE||'%';
            
            SELECT  DISTINCT MEM_ID INTO L_MEM_ID
            FROM    CART
            WHERE   CART_NO=L_CART_NO;
        IF (L_MEM_ID!=P_MEM_ID)
        THEN
            L_CART_NO:=L_CART_NO+1;
        END IF;
    END IF;
    RETURN L_CART_NO;
    END;
----------------------------------------------------------------
    SELECT
        GET_CART_NO(TO_DATE('20200402'),'t001') FROM DUAL;
오늘 회원 'd001' 회원이 'P201000010' 상품 3개를 구매했다 이를 처리하시오.
    INSERT INTO CART VALUES ('d001',GET_CART_NO(SYSDATE,'d001'),'P201000010',3);
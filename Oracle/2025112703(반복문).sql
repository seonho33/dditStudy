2025-11-27-04)반복문
-   LOOP,WHILE,FOR 문이 제공
--1. LOOP
- 가장 기본이 되는 반복문
- 무한 루프기능이 제공됨
사용형식)
    LOOP
        [반복명령문(들)];
        EXIT WHEN 조건
        [반복명령분(들)];
    END LOOP;
    - '조건'이 참일때 반복을 벗어남 
사용예) 구구단의 7단을 출력하시오

    DECLARE
        L_CNT NUMBER :=1;
    BEGIN
        LOOP
        DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT||' = '||7*L_CNT);
        
        EXIT WHEN   L_CNT >= 9;
        
        L_CNT:=L_CNT+1;
        END LOOP;
    END;

커서사용)2020년 6월 상품별 매입현황을 출력하시오 - 상품번호, 상품명, 매입금액...
    
    DECLARE
        L_PROD_ID PROD.PROD_ID%TYPE;    --상품번호가 저장될 변수
        L_PROD_NAME VARCHAR2(100);      --상품이름이 저장될 변수
        L_BUYPROD_SUM NUMBER:=0;         --매입금액이 저장될 변수
        
        CURSOR CUR_BUYPROD(P_PERIOD VARCHAR2) IS
            SELECT  A.PROD_ID,
                    B.PROD_NAME,
                    SUM(A.BUY_QTY*B.PROD_COST)
            FROM    BUYPROD A
            INNER JOIN PROD B
                    ON(A.PROD_ID = B.PROD_ID
                    AND A.BUY_DATE BETWEEN TO_DATE(P_PERIOD||'01')AND LAST_DAY(TO_DATE(P_PERIOD||'01')))
            GROUP BY A.PROD_ID,B.PROD_NAME;
    BEGIN
        OPEN CUR_BUYPROD('202006');        
        LOOP
            FETCH CUR_BUYPROD
            INTO L_PROD_ID, L_PROD_NAME, L_BUYPROD_SUM;
            EXIT WHEN CUR_BUYPROD%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('상품번호 : '||L_PROD_ID);
            DBMS_OUTPUT.PUT_LINE('상품명 : '||L_PROD_NAME);
            DBMS_OUTPUT.PUT_LINE('매입금액 : '||L_BUYPROD_SUM);
            DBMS_OUTPUT.PUT_LINE('---------------------------------');
        END LOOP;
        CLOSE CUR_BUYPROD;
    END;

--2. WHILE 문
 - 조건을 반복수행 전에 판단하여 참이면 반복을 수행하고 거짓이면 반복을 벗어남
사용형식)
    WHILE 조건
    LOOP
        반복 수행해야 할 명령;
    END LOOP;
사용예) 구구단의 7단

    DECLARE
        L_CNT NUMBER:=0;
    BEGIN
        WHILE (L_CNT<9) LOOP
            L_CNT:=L_CNT+1;
            DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT||' = '||7*L_CNT);
        END LOOP;
    END;
        
-----------------------------------------------------------
        
    DECLARE
        L_PROD_ID PROD.PROD_ID%TYPE;    --상품번호가 저장될 변수
        L_PROD_NAME VARCHAR2(100);      --상품이름이 저장될 변수
        L_BUYPROD_SUM NUMBER:=0;         --매입금액이 저장될 변수
        
        CURSOR CUR_BUYPROD(P_PERIOD VARCHAR2) IS
            SELECT  A.PROD_ID,
                    B.PROD_NAME,
                    SUM(A.BUY_QTY*B.PROD_COST)
            FROM    BUYPROD A
            INNER JOIN PROD B
                    ON(A.PROD_ID = B.PROD_ID
                    AND A.BUY_DATE BETWEEN TO_DATE(P_PERIOD||'01')AND LAST_DAY(TO_DATE(P_PERIOD||'01')))
            GROUP BY A.PROD_ID,B.PROD_NAME;
    BEGIN
        OPEN CUR_BUYPROD('202006');
        FETCH CUR_BUYPROD
        INTO L_PROD_ID, L_PROD_NAME, L_BUYPROD_SUM;
        WHILE CUR_BUYPROD%FOUND LOOP
            EXIT WHEN CUR_BUYPROD%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('상품번호 : '||L_PROD_ID);
            DBMS_OUTPUT.PUT_LINE('상품명 : '||L_PROD_NAME);
            DBMS_OUTPUT.PUT_LINE('매입금액 : '||L_BUYPROD_SUM);
            DBMS_OUTPUT.PUT_LINE('---------------------------------');
            FETCH CUR_BUYPROD
            INTO L_PROD_ID, L_PROD_NAME, L_BUYPROD_SUM;
        END LOOP;
        CLOSE CUR_BUYPROD;
    END;
       
--3. FOR 문
-사용형식)
    FOR INDEX IN [REVERSE] 시작값..최종값
    LOOP
        반복처리명령문(들)
    END LOOP;
    . 'INDEX'는 반복제어용 변수로 시스템에서 마련(선언하지 않음)
    . 'REVERSE' : 역순으로 반복시작
    . 1씩 증가 또는 감소하여 INDEX에 할당한 후 최종값과 비교하고 반복 수행을 판단함...
-사용예) 구구단의 7단
    DECLARE
    BEGIN
        FOR IDX IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE('7 * '||IDX||' = '||IDX*7);
        END LOOP;
            DBMS_OUTPUT.PUT_LINE('역순으로');
        FOR IDX IN REVERSE 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE('7 * '||IDX||' = '||IDX*7);
        END LOOP;
    END;
--4. 커서용 FOR문
- 커서용 FOR문을 사용하면 OPEN, FETCH, CLOSE 문을 생략한다...
-사용형식)
    FOR 레코드명 IN 커서명|(커서용 SELECT 문) LOOP
        반복처리명령문(들)
    END LOOP;
     .커서의 열을 참조하는 방법: '레코드명'.커서컬럼명
     .커서용 ,SELECT 문을 기술하면 선언부에서 커서를 선언하지 않아도 됨
     
    DECLARE
        CURSOR CUR_BUYPROD(P_PERIOD VARCHAR2) IS
            SELECT  A.PROD_ID,
                    B.PROD_NAME AS PNAME,
                    SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
            FROM    BUYPROD A
            INNER JOIN PROD B
                    ON(A.PROD_ID = B.PROD_ID
                    AND A.BUY_DATE BETWEEN TO_DATE(P_PERIOD||'01')AND LAST_DAY(TO_DATE(P_PERIOD||'01')))
            GROUP BY A.PROD_ID,B.PROD_NAME;
    BEGIN
        FOR REC IN CUR_BUYPROD('202006') LOOP
            EXIT WHEN CUR_BUYPROD%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('상품번호 : '||REC.PROD_ID);
            DBMS_OUTPUT.PUT_LINE('상품명 : '||REC.PNAME);
            DBMS_OUTPUT.PUT_LINE('매입금액 : '||REC.BSUM);
            DBMS_OUTPUT.PUT_LINE('---------------------------------');
        END LOOP;
    END;
-------------------------------------------------------------------------------
(IN-LINE SUBQUERY 사용)
    DECLARE

    BEGIN
        DBMS_OUTPUT.PUT_LINE('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        FOR REC IN (SELECT  A.PROD_ID,
                            B.PROD_NAME AS PNAME,
                            SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
                    FROM    BUYPROD A
                    INNER JOIN PROD B
                            ON(A.PROD_ID = B.PROD_ID
                            AND A.BUY_DATE BETWEEN TO_DATE('20200601')AND LAST_DAY(TO_DATE('20200601')))
                    GROUP BY A.PROD_ID,B.PROD_NAME)
        LOOP
            DBMS_OUTPUT.PUT_LINE('상품번호 : '||REC.PROD_ID);
            DBMS_OUTPUT.PUT_LINE('상품명 : '||REC.PNAME);
            DBMS_OUTPUT.PUT_LINE('매입금액 : '||REC.BSUM);
            DBMS_OUTPUT.PUT_LINE('---------------------------------');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    END;
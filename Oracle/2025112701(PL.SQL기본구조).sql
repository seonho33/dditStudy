2025-11-27-02)PL/SQL
-   익명블록, 함수, 프로시져, 트리거, 패키지, ...

1.  익명블록
-   PL/SQL에서 제공되는 객체들의 기본구조
--사용형식)
    DECLARE
        [선언영역] -- 변수, 상수, 커서 선언
    BEGIN
        [실행영역] -- 비지니스 로직처리 (SQL과 PL/SQL의 명령을 사용)
                 -- 예외처리
    END;
--사용예)키보드로 부서번호를 입력받아 해당 부서에 소속된 사원의 사원번호, 사원명, 직위, 급여를 출력하는
--      블록을 작성하시오...
    
    ACCEPT P_DEPT_ID PROMPT '부서코드 : '
    DECLARE
        CURSOR CUR_EMP_SEARCH(L_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS
        SELECT
            A.EMPLOYEE_ID,
            A.EMP_NAME,
            B.JOB_TITLE,
            A.SALARY
        FROM    HR.EMPLOYEES A,
                HR.JOBS B
        WHERE   A.JOB_ID=B.JOB_ID
        AND     A.DEPARTMENT_ID = L_DID;
    BEGIN
            DBMS_OUTPUT.PUT_LINE(' ID    NAME                    JOB      SALARY');
        FOR REC IN CUR_EMP_SEARCH(&P_DEPT_ID) LOOP
            DBMS_OUTPUT.PUT(REC.EMPLOYEE_ID||'  ');
            DBMS_OUTPUT.PUT(RPAD(REC.EMP_NAME,25));
            DBMS_OUTPUT.PUT(RPAD(REC.JOB_TITLE,10));
            DBMS_OUTPUT.PUT_LINE(TO_CHAR(REC.SALARY,'999,999'));
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        END LOOP;
        
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('예외발생 : '||SQLERRM);
    END;
    
--변수 사용예) 오늘이 2020년 7월 28일이라고 가정하고 장바구니 번호를 생성하시오...

    DECLARE
        L_CNT   NUMBER  :=0; --장바구니 테이블의 오늘날짜 행의 수
        L_CART_NO CART.CART_NO%TYPE; -- CART_NO 와 같은 타입의 변수 생성...생성되는 장바구니 번호를 보관하는 변수
    BEGIN
        SELECT  COUNT(*) INTO L_CNT
        FROM    CART
        WHERE   SUBSTR(CART_NO,1,8)='20200728';
        IF
            L_CNT = 0 THEN
            L_CART_NO:='20200728'||TRIM('00001');
        ELSE 
            SELECT
                MAX(CART_NO)+1 INTO L_CART_NO
            FROM    CART
            WHERE   SUBSTR(CART_NO,1,8)='20200728';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('장바구니번호 : '||L_CART_NO);
    END;
    물 사용량         단가
  -------------------------
        - 10(톤)     450
     11 - 20(톤)     600
     21 - 30(톤)     950
       그 이상       1500
       
2)  하수도 요금
    톤당 500원
    
3)  수도요금 = 상수도 요금 + 하수도 요금

4)  물 사용량은 키보드로 입력...

    ACCEPT W_AMT PROMPT '물 사용량 : '
    DECLARE
        L_SUM       NUMBER:=0;
        L_AMT       NUMBER:=&W_AMT;
    BEGIN
        IF  (L_AMT<=10)
            THEN
                L_SUM := (L_AMT*450+L_AMT*500);
            ELSIF   (L_AMT<=20)
                THEN
                    L_SUM := ((L_AMT-10)*600+L_AMT*500+4500);
                ELSIF   (L_AMT<=30)
                    THEN
                        L_SUM := ((L_AMT-20)*950+L_AMT*500+4500+6000);
                    ELSE
                        L_SUM := ((L_AMT-30)*1500+L_AMT*500+4500+6000+9500);
    END IF;
    DBMS_OUTPUT.PUT_LINE('물 사용량 :   '||L_AMT||'톤');
    DBMS_OUTPUT.PUT_LINE('수도요금  :   '||L_SUM||'원');
    END;

(CASE WHEN THEN)
    ACCEPT W_AMT PROMPT '물 사용량 : '
    DECLARE
        L_SUM       NUMBER:=0;
        L_AMT       NUMBER:=&W_AMT;
    BEGIN
        CASE WHEN   (L_AMT<=10)
        THEN
            L_SUM := (L_AMT*450+L_AMT*500);
        WHEN   (L_AMT<=20)
        THEN
            L_SUM := ((L_AMT-10)*600+L_AMT*500+4500);
        WHEN   (L_AMT<=30)
        THEN
            L_SUM := ((L_AMT-20)*950+L_AMT*500+4500+6000);
        ELSE
            L_SUM := ((L_AMT-30)*1500+L_AMT*500+4500+6000+9500);
        END CASE;
    DBMS_OUTPUT.PUT_LINE('물 사용량 :   '||L_AMT||'톤');
    DBMS_OUTPUT.PUT_LINE('수도요금  :   '||L_SUM||'원');
    END;


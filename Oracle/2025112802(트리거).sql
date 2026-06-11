2025-11-28-02)TRIGGER
 - 한 테이블에 발생된 이벤트(INSERT, UPDATE, DELETE)가 다른 테이블의 변경을
   유발하여 자동 실행이 되게하는 특수 프로시저
 - DCL 명령(COMMIT, ROLLBACK 등)을 사용 할 수 없음...
 
사용형식)
    CREATE [OF REPLACE] TRIGGER 트리거명
        BEFORE|AFTER    INSERT|UPDATE|DELETE ON 테이블명
        [FOR EACH ROW]
        [WHEN 조건]
    [DECLARE]
        선언영역 --변수, 상수, 커서 선언...
    BEGIN
    
        트리거 본문;
    
    END;
    
 -'BEFORE|AFTER':트리거 본문이 실행되는 시점으로 이벤트발생 전(BEFORE) 또는
      이벤트 발생 후(AFTER)로 나누어 기술
 -'INSERT|UPDATE|DELETE': 발생되는 이벤트 기술
                             OR연산자를 사용하여 복수개의 DML명령 기술가능하다.
 -'FOR EACH ROW' : 이 명령이 기술되면 행단위 트리거(이벤트의 결과 행마다 트리거 본문실행)
   >> 생략되었다면 문장단위 트리거(이벤트 결과 값이 복수개의 행으로 구성되어도 본문은 한번만 실행)
 -'WHEN 조건' : 트리거 발생에 대한 좀더 구체적인 조건 기술. 행단위 트리거에서만 사용 가능
 
**의사레코드(PSEUDO RECORD)
---------------------------------------------------------------------------
    의사레코드                        의미
---------------------------------------------------------------------------
    :NEW                이벤트가 INSERT, UPDATE 인 경우에 사용하며,
                        신규로 들어온 값을 지칭함
                        DELETE 에 사용하면 모든 컬럼이 NULL이 됨
---------------------------------------------------------------------------
    :OLD                이벤트가 DELETE, UPDATE 인 경우에 사용하며,
                        기존에 저장되어 있던 값을 지칭함
                        INSERT에 사용하면 모든 컬럼이 NULL이 됨
---------------------------------------------------------------------------


** 트리거 함수-이벤트 설정에 OR 연산자를 사용한 경우 어느 DML명령령이 사용되어 트리거가
             발생되었는지를 판단하기 위해 사용
---------------------------------------------------------------------------
    함수                              의미
---------------------------------------------------------------------------
    INSERTING           INSERT 이벤트가 발생되었으면 참(TRUE)을 반환
    UPDATING            UPDATE 이벤트가 발생되었으면 참(TRUE)을 반환
    DELETING            DELETE 이벤트가 발생되었으면 참(TRUE)을 반환

사용예)LPROD 테이블에서 분류코드 'P501' 자료를 삭제하시오...
      삭제 후 '데이터 삭제가 성공적으로 수행되었습니다'를 출력하는 트리거를 생성하시오
      
    CREATE OR REPLACE TRIGGER TG_DEL_LPROD
        AFTER   DELETE ON LPROD
    BEGIN
            DBMS_OUTPUT.PUT_LINE('데이터 삭제가 성공적으로 수행되었습니다.');
    END;
    
    DELETE
    FROM    LPROD
    WHERE   LPROD_GU='P501'
    
    DELETE
    FROM    LPROD
    WHERE   LPROD_ID>=11
    
2)  TEMP_EMP 테이블에서 사원번호 130~135번 사원의 자료를 삭제하시오.
    삭제 후 '사원데이터 삭제가 수행되었습니다.'를 출력하는 트리거를 생성하시오
    CREATE OR REPLACE TRIGGER TG_DEL_TEMP
        AFTER   DELETE ON TEMP_EMP
    BEGIN
        DBMS_OUTPUT.PUT_LINE('사원데이터 삭제가 수행되었습니다.');
    END;
    
    DELETE FROM TEMP_EMP WHERE EMPLOYEE_ID IN(130,131,132,133,134,135);
3)  사원테이블에서 2013년 이전에 입사한 사원들을 퇴직처리하시오
    퇴직처리는 해당 사원정보를 RETIRE 테이블에 저장하고 TEMP_EMP 테이블에서는 삭제
    하는 처리과정을 의미함
    
    CREATE OR REPLACE TRIGGER TG_DELETE_TEMPEMP
        BEFORE  DELETE ON TEMP_EMP
        FOR EACH ROW
    BEGIN
        --트리거 본문(2013년 이전 입사자를 RETIRE 에 저장하는것...)
        INSERT INTO RETIRE (EMPLOYEE_ID, DEPARTMENT_ID,JOB_ID,HIRE_DATE)
            VALUES(:OLD.EMPLOYEE_ID, :OLD.DEPARTMENT_ID, :OLD.JOB_ID, :OLD.HIRE_DATE);
    END;
    
    DELETE FROM TEMP_EMP
    WHERE   EXTRACT(YEAR FROM HIRE_DATE)<=2013;
    DELETE FROM RETIRE
    
    
    CREATE TABLE TEMP_EMP AS
    SELECT *
    FROM HR.TEMP_EMP
    
    DROP TABLE TEMP_EMP
**  REMAIN 테이블에서 입고수량(REMAIN_I)와 출고수량(REMAIN_O)을 0으로,
    현재고(REMAIN_J_99)를 기초재고(REMAIN_J_00)로 변경하시오.
    
    UPDATE  REMAIN
    SET     REMAIN_I=0,
            REMAIN_O=0,
            REMAIN_DATE = TO_DATE('20200101'),
            REMAIN_J_99=REMAIN_J_00;
    COMMIT;
    
매입이 발생된 후 재고수불테이블을 갱신하시오

    CREATE OR REPLACE   TRIGGER TG_CHANGE_BUYQTY
        AFTER   INSERT ON BUYPROD
        FOR EACH ROW
    BEGIN
        UPDATE  REMAIN
        SET     REMAIN_I=REMAIN_I + (:NEW.BUY_QTY),
                REMAIN_J_99=REMAIN_J_00+(:NEW.BUY_QTY),
                REMAIN_DATE=(:NEW.BUY_DATE)
        WHERE   PROD_ID = (:NEW.PROD_ID);
    END;
오늘 날짜로 상품 'P201000007'상품 30개를 매입
    INSERT INTO BUYPROD VALUES (SYSDATE,'P201000007',30);

사용예)고객의 상품 구매 활동에 대한 처리를 수행하는 트리거를 작성하시오
      구매활동은 신규구매, 일부취소 또는 일부추가 구매, 전체취소가 있음
장바구니데이터 INSERT,UPDATE,DELETE
    
    CREATE OR REPLACE TRIGGER TG_CHANGE_CART
        AFTER   INSERT OR UPDATE OR DELETE ON CART
        FOR EACH ROW
    DECLARE
        L_MEM_ID    MEMBER.MEM_ID%TYPE;
        L_DATE      DATE;
        L_PROD_ID   CART.PROD_ID%TYPE;
        L_QTY       NUMBER:=0;
        L_MILEAGE   NUMBER:=0;
    BEGIN
        IF (INSERTING) 
            THEN
                L_MEM_ID:=(:NEW.MEM_ID);
                L_PROD_ID:=(:NEW.PROD_ID);
                L_QTY:=(:NEW.CART_QTY);
                L_DATE:=TO_DATE(:NEW.CART_NO,1,8);
        ELSIF (UPDATING)
            THEN
                L_MEM_ID:=(:OLD.MEM_ID);
                L_PROD_ID:=(:OLD.PROD_ID);
                L_QTY:=(:NEW.CART_QTY)-(:OLD.CART_QTY);
                L_DATE:=TO_DATE(:NEW.CART_NO,1,8);
        ELSIF (DELETING)
            THEN
                L_MEM_ID:=(:OLD.MEM_ID);
                L_PROD_ID:=(:OLD.PROD_ID);
                L_QTY:= -(:OLD.CART_QTY);
                L_DATE:=TO_DATE(:OLD.CART_NO,1,8);
        END IF;
        
        --UPDATE REMAIN
        UPDATE  REMAIN
        SET     REMAIN_O=REMAIN_O+L_QTY,
                REMAIN_J_99=REMAIN_J_99-L_QTY,
                REMAIN_DATE=L_DATE
        WHERE   PROD_ID=L_PROD_ID;
        
        --UPDATE MEMBER
        SELECT  PROD_MILEAGE*L_QTY INTO L_MILEAGE
        FROM    PROD
        WHERE   PROD_ID=L_PROD_ID;
        
        UPDATE  MEMBER
        SET     MEM_MILEAGE=MEM_MILEAGE+L_MILEAGE
        WHERE   MEM_ID=L_MEM_ID;
    END;
    
    CREATE OR REPLACE TRIGGER tg_change_cart
    AFTER INSERT OR UPDATE OR DELETE ON CART
    FOR EACH ROW
  DECLARE
    L_DATE      DATE;
    L_MEM_ID    MEMBER.MEM_ID%TYPE;
    L_PROD_ID   PROD.PROD_ID%TYPE;
    L_QTY       NUMBER:=0;
    L_MILEAGE   NUMBER:=0;
  BEGIN
    IF INSERTING THEN
       L_MEM_ID:=(:NEW.MEM_ID);
       L_PROD_ID:=(:NEW.PROD_ID);
       L_QTY:=(:NEW.CART_QTY);
       L_DATE:=TO_DATE(:NEW.CART_NO,1,8);
    ELSIF UPDATING   THEN
       L_MEM_ID:=(:NEW.MEM_ID);
       L_PROD_ID:=(:NEW.PROD_ID);
       L_QTY:=(:NEW.CART_QTY)-(:OLD.CART_QTY);
       L_DATE:=TO_DATE(:NEW.CART_NO,1,8);
    ELSIF DELETING  THEN
       L_MEM_ID:=(:OLD.MEM_ID);
       L_PROD_ID:=(:OLD.PROD_ID);
       L_QTY:= -(:OLD.CART_QTY);
       L_DATE:=TO_DATE(:OLD.CART_NO,1,8);
    END IF;
    
    --UPDATE REMAIN
      UPDATE REMAIN
         SET REMAIN_O=REMAIN_O+L_QTY,
             REMAIN_J_99=REMAIN_J_99+L_QTY, 
             REMAIN_DATE=L_DATE
       WHERE PROD_ID=L_PROD_ID;
       
    --UPDATE MEMBER
       SELECT PROD_MILEAGE*L_QTY INTO L_MILEAGE
         FROM PROD
        WHERE PROD_ID=L_PROD_ID;
       
       UPDATE MEMBER
          SET MEM_MILEAGE=MEM_MILEAGE+L_MILEAGE
        WHERE MEM_ID=L_MEM_ID;  
  END;  